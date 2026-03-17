Return-Path: <stable+bounces-225900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCSGLmRHuWmK+QEAu9opvQ
	(envelope-from <stable+bounces-225900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:21:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C712A9BFC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6DFD3029678
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CB43BED67;
	Tue, 17 Mar 2026 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLMpWcjG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4628E00
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749840; cv=none; b=aU4NjC3B1kwYlxFTAGAKW4gW/hOxsmmZYG2xrkKxPbIAyOTITfC1zKzf3N/KqzsKzN+Bsk692Wl8UTvzyjv8ri4C8EKe0/K1TPuxJc+6jGMa/GXOHGW+xSSfMLJV1iV0vCA4b7hPCappVqvfb53/7yl5zAqnFSQDMlH105uao0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749840; c=relaxed/simple;
	bh=O+X8J6DMztZStHc2CcCU7r/Vne9fsdqBLfTN269irZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMGuPZ9AxwuJCv4gG2c+IOWenlnD4HYtzBEeKn0sVxTd2wIieXLA7N1Oui6Ht9mBLc2UcM9zar9z1KcsBCx4XQDiKlHuBhuGP32le3OE4EUeoE2uX5jjwJuNy0QViTXkqa1HUw0Ot7F4PNC+XV26oowH2mMv1GIOpN8Tvuq1RdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLMpWcjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C31C4CEF7;
	Tue, 17 Mar 2026 12:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773749840;
	bh=O+X8J6DMztZStHc2CcCU7r/Vne9fsdqBLfTN269irZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLMpWcjG0XtLcRzJxA/mjQYnTOLE3vgVAsJjNqxrLz2nUwhCeVIhrKVX2UBmg/INb
	 aCpaOOxyEa+q+TJYHgmDCWv+ACN0Qp9/zZCpW0KbZuWHhZKNpTbOgn99zLjHVCtBSy
	 opw3ST3Z5QkOeyg0yvpm26W4D26LPt7f+je9MRNatajPhhhNxNU+i7Qnl3W/4LBFnu
	 XSTwlpkQkoEK/MxycgJFormFxn5EBlhMB30+FCkHZAVSIU74HwnpaXZ+ajEPG+Jd/L
	 iydZJI/Mi/v1ey/+t1hym7nlb75ztyQiC//c4YA6UXL3r51JfYFFYODkcKfJ8x1j9+
	 UgRVuOJXe7weA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] mmc: dw_mmc-rockchip: use modern PM macros
Date: Tue, 17 Mar 2026 08:17:16 -0400
Message-ID: <20260317121718.140381-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031758-blob-blot-0711@gregkh>
References: <2026031758-blob-blot-0711@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225900-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8C712A9BFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jisheng Zhang <jszhang@kernel.org>

[ Upstream commit 4b43f2bcc84dd550c1a847318db02165d2829573 ]

Use the modern PM macros for the suspend and resume functions to be
automatically dropped by the compiler when CONFIG_PM or
CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Link: https://lore.kernel.org/r/20250815013413.28641-39-jszhang@kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: 6465a8bbb0f6 ("mmc: dw_mmc-rockchip: Fix runtime PM support for internal phase support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 26d86d5642490..9b17490554d7d 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -568,11 +568,8 @@ static void dw_mci_rockchip_remove(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops dw_mci_rockchip_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(dw_mci_runtime_suspend,
-			   dw_mci_runtime_resume,
-			   NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(dw_mci_runtime_suspend, dw_mci_runtime_resume, NULL)
 };
 
 static struct platform_driver dw_mci_rockchip_pltfm_driver = {
@@ -582,7 +579,7 @@ static struct platform_driver dw_mci_rockchip_pltfm_driver = {
 		.name		= "dwmmc_rockchip",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= dw_mci_rockchip_match,
-		.pm		= &dw_mci_rockchip_dev_pm_ops,
+		.pm		= pm_ptr(&dw_mci_rockchip_dev_pm_ops),
 	},
 };
 
-- 
2.51.0


