Return-Path: <stable+bounces-167671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED38EB23149
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E60E162FF3
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB932FF143;
	Tue, 12 Aug 2025 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PgqddMpz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD8C2FF170;
	Tue, 12 Aug 2025 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021604; cv=none; b=Vm3Vf/C9ovkSnAq7balGO6UGP1DRmRyV3pvLxD1/Kl8tGapyoQI9u4NL4B+hoSvojTjbN6bQ7gzjJOMtj/4TIaWOhFcSqBDgUvxz/IDVsDQqPVwuNYdoGgZ7XJcMC/g1AF6BZbk1UZGy0y+sUEfYn3d4WN+nr72VTSFdM6heOzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021604; c=relaxed/simple;
	bh=6znvt6g8ib4SqPpoa989RHLGmgEXPx5f++McUMKV2hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6icqlXTfHVu4jfwgBudvrQQsDM+2z6aI7WlTIKNP4ROkVh19hGuUgsLxk0KX++5AsqGpv8u0clVXav3ey2ysfYzz4qEUc3B+AbSt1JcK20SPyyAEhJfkd66jNk8SJK08LF5L+Xzt6QutG555wJedgGaYPyGhwiWFSgCihGjiIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PgqddMpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D02C4CEF0;
	Tue, 12 Aug 2025 18:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021603;
	bh=6znvt6g8ib4SqPpoa989RHLGmgEXPx5f++McUMKV2hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PgqddMpzXOB+Ez3AoCTPd+X8D6DY6PDp6vkDIPMVrT0nS73KAe7gkhNAIptiTw0PD
	 4JvuBCRV4Vlg7EdsPS/cEOB4XeSDoK1GN8wfEiVz9sB1+sXKGyordaArnT9wOROR1X
	 bOp6lfoNPgMiPb30ZCSmgXqZuI6Wk12VfGfgMjuw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brian Masney <bmasney@redhat.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 171/262] rtc: rv3028: fix incorrect maximum clock rate handling
Date: Tue, 12 Aug 2025 19:29:19 +0200
Message-ID: <20250812173000.386452364@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
References: <20250812172952.959106058@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 2f001c59c61d..86b7f821e937 100644
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




