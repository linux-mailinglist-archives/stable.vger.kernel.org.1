Return-Path: <stable+bounces-167529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E937B2307C
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308BF5668F5
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3059E2FABF8;
	Tue, 12 Aug 2025 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iULmt3fJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4181268C73;
	Tue, 12 Aug 2025 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021125; cv=none; b=Je2cOvX7mJM7MtcKbm8yZqcb8i9YOIm7KNz7+qtmpiR3Y8mZooTNZh8tuOdB0QlxdS2RwehKWXNW32cMF84beJiY29uOG3rH3tMlgZwyo9+2yFWBCanF2tZrE5tKEM/Blp45ULOAhsvAM9nvBvUSoz4eovQFKfpbHYH68Qv+EoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021125; c=relaxed/simple;
	bh=pRUaHSbaZLv+6sntz9LdJjDAEU6h+VOKUHkc60ILV4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGfjnKhPuV5R+b8Yxt4WvBoAvCHlRbItZufhTBliw4kXWyOyQZHjQV59Nd2uw+F2UkrwCZN/fdjfKXdm7/MMpEtJUzxUVyMMY/41l6cZ1T4JaYaf9k/q4huysX0tORlpI3ta874um+ENc5mUnwaewO3iUOzlGANcZJsqpOeDFss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iULmt3fJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52163C4CEF0;
	Tue, 12 Aug 2025 17:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021124;
	bh=pRUaHSbaZLv+6sntz9LdJjDAEU6h+VOKUHkc60ILV4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iULmt3fJ42/3AJ27YwFoYmEBx2XEDJ3vtgrFe4FnPcmSoAyk6b+n3/8NGQ6fsVRXF
	 XkhAC+WhB/ukGeSTSr96owwoHzFufoOCqkTeFINRulj1FfT14qGufrrj+E92Zc4Y3A
	 m/Ieah8Ri+L+jY6WB0ip89QQxmOa0FR/P2vlrC/8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brian Masney <bmasney@redhat.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 191/253] rtc: rv3028: fix incorrect maximum clock rate handling
Date: Tue, 12 Aug 2025 19:29:39 +0200
Message-ID: <20250812172956.924437465@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Masney <bmasney@redhat.com>

[ Upstream commit b574acb3cf7591d2513a9f29f8c2021ad55fb881 ]

When rv3028_clkout_round_rate() is called with a requested rate higher
than the highest supported rate, it currently returns 0, which disables
the clock. According to the clk API, round_rate() should instead return
the highest supported rate. Update the function to return the maximum
supported rate in this case.

Fixes: f583c341a515f ("rtc: rv3028: add clkout support")
Signed-off-by: Brian Masney <bmasney@redhat.com>
Link: https://lore.kernel.org/r/20250710-rtc-clk-round-rate-v1-6-33140bb2278e@redhat.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-rv3028.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index dd170e3efd83..436523605f8f 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -738,7 +738,7 @@ static long rv3028_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
 		if (clkout_rates[i] <= rate)
 			return clkout_rates[i];
 
-	return 0;
+	return clkout_rates[0];
 }
 
 static int rv3028_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
-- 
2.39.5




