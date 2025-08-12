Return-Path: <stable+bounces-168054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4625B23325
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C30217F952
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DC91FF7C5;
	Tue, 12 Aug 2025 18:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oLzXxeGh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD392192F4;
	Tue, 12 Aug 2025 18:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022887; cv=none; b=O/qZfB2FRpWYBSw/36aiY9WFoN2lUgi0eNHiMCYNiOdmDfpXNJjacx5nBTqeiDyk1zL5kvMsxx52BG+yi3XXcI3nhCVlspmsZcH97j2s/gbI2o0b0rExiSPgXHfCk5fj9L2c2tqBZXZDEcJIl/tuovKDiE4+zqrIzRu+hurEkVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022887; c=relaxed/simple;
	bh=MfEWqKZZPZVu6Vkp4EArGaz2Aqk83jM+5LY7wKR7AfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0yjKl5VKlbWb/WPsOUj7xnPD2MUMSSLOiqkP2ydW0e8r5FwdiWut8k9HFu9HiPVlQnDtLqxwxulctwj2gfPZph4k8WT5ZcbO9D+x8uYi6yovxEZlR+QKqwj8pWNRkokwxADZPnmRa2YNBAl3b0inesPif6jQ4gTe33eGV8CZdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oLzXxeGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FC6C4CEF8;
	Tue, 12 Aug 2025 18:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755022887;
	bh=MfEWqKZZPZVu6Vkp4EArGaz2Aqk83jM+5LY7wKR7AfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oLzXxeGh4QUoynq/z7o+zgWPL8gFfk0LbIO4tiwKlolozQBqmzZjG9Xq3cmutk/Fd
	 egXGO5G7ugJ6eiv8m032Q1DqL/4qy90avDQPMgtKpMx1b/1lwaeSLMymXiWJkSqxtT
	 4Axo/1zjCPuMbyzWJhVIxxiF5gkam55Nx1aiTyIk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brian Masney <bmasney@redhat.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 246/369] rtc: pcf85063: fix incorrect maximum clock rate handling
Date: Tue, 12 Aug 2025 19:29:03 +0200
Message-ID: <20250812173024.020766933@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Masney <bmasney@redhat.com>

[ Upstream commit 186ae1869880e58bb3f142d222abdb35ecb4df0f ]

When pcf85063_clkout_round_rate() is called with a requested rate higher
than the highest supported rate, it currently returns 0, which disables
the clock. According to the clk API, round_rate() should instead return
the highest supported rate. Update the function to return the maximum
supported rate in this case.

Fixes: 8c229ab6048b7 ("rtc: pcf85063: Add pcf85063 clkout control to common clock framework")
Signed-off-by: Brian Masney <bmasney@redhat.com>
Link: https://lore.kernel.org/r/20250710-rtc-clk-round-rate-v1-4-33140bb2278e@redhat.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-pcf85063.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 73848f764559..2b4921c23467 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -410,7 +410,7 @@ static long pcf85063_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
 		if (clkout_rates[i] <= rate)
 			return clkout_rates[i];
 
-	return 0;
+	return clkout_rates[0];
 }
 
 static int pcf85063_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
-- 
2.39.5




