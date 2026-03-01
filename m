Return-Path: <stable+bounces-221436-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI8MDZiVo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221436-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:25:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6221CA8B9
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A852302DE46
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72119280CD5;
	Sun,  1 Mar 2026 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGiMgIWe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D58C8F0;
	Sun,  1 Mar 2026 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328261; cv=none; b=mGt9TDCWdC6xSf4oetq7uILZy/YbobZEnxTYR0b+Vd1kJBDUM7uD5OkzYNLtPktxWoLs8Aj6oOrMVC63cAhPKz3iXo8uvus/ApoElhnyy91t9+Og3Sbm+zlXR8IBqdePFNF6lq2jMJZNmQwK4mKcvM9lh3oSB/68FhAVnO/Klps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328261; c=relaxed/simple;
	bh=TvgroZ0sZYDxi0fQhh2y5kq3EdgNaJE6ljx3Qly1Qng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rVwe72MTmm0U4lMt+vzf7zTktmj+m3SyKOdFmgNv3XYwgAOx+0qJQIUGRKOaRvEvR0SI6GySyi0ACLXH9/lA/1Hf3uwCE5WQWT7N9UD6EktXAk3qtn5W0ZtvCsCGJCj+YVTQLl3Xua0W0pu40nHirdc2M6f1T7xKFgus/ibYosY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGiMgIWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58137C19421;
	Sun,  1 Mar 2026 01:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328261;
	bh=TvgroZ0sZYDxi0fQhh2y5kq3EdgNaJE6ljx3Qly1Qng=;
	h=From:To:Cc:Subject:Date:From;
	b=uGiMgIWezquotecvuX4vqLfBDDqN9odvjI/tCPU6qii6jqq/NdgX94pt6FL252bId
	 6cjIJ5R9ttTUfM/bXjwHevO8DmhJq9RogN8t3zc1TRKdWqwL9bulNVAZ2LfrgYEtOI
	 Ah3aDmIrQ1Nx/z5rEmbyrhMIPbOCQewGOwcvh0kPvmQ8LnJeuuK/FV0x7LEyddqATZ
	 3e4uDLI1UswfJb1RNUDef7ai1jUjyKA9DZUp75zoCADgpoCf5aYLbhU0D9w/2CnF0y
	 b8N6OxYMxUjRKHympxA+0pXrUxm1FIsmxdCzlYljbuzxLGd9CVW00Bgd9XKGiCw9Ck
	 Opg9MnjD4Q3GQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	haotienh@nvidia.com
Cc: stable <stable@kernel.org>,
	Wayne Chang <waynec@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: FAILED: Patch "usb: gadget: tegra-xudc: Add handling for BLCG_COREPLL_PWRDN" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:24:18 -0500
Message-ID: <20260301012419.1681142-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221436-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA6221CA8B9
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1132e90840abf3e7db11f1d28199e9fbc0b0e69e Mon Sep 17 00:00:00 2001
From: Haotien Hsu <haotienh@nvidia.com>
Date: Sat, 24 Jan 2026 01:31:21 +0800
Subject: [PATCH] usb: gadget: tegra-xudc: Add handling for BLCG_COREPLL_PWRDN

The COREPLL_PWRDN bit in the BLCG register must be set when the XUSB
device controller is powergated and cleared when it is unpowergated.
If this bit is not explicitly controlled, the core PLL may remain in an
incorrect power state across suspend/resume or ELPG transitions.
Therefore, update the driver to explicitly control this bit during
powergate transitions.

Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB device mode controller")
Cc: stable <stable@kernel.org>
Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
Signed-off-by: Wayne Chang <waynec@nvidia.com>
Link: https://patch.msgid.link/20260123173121.4093902-1-waynec@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/tegra-xudc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 9d2007f448c04..7f7251c10e952 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -3392,17 +3392,18 @@ static void tegra_xudc_device_params_init(struct tegra_xudc *xudc)
 {
 	u32 val, imod;
 
+	val = xudc_readl(xudc, BLCG);
 	if (xudc->soc->has_ipfs) {
-		val = xudc_readl(xudc, BLCG);
 		val |= BLCG_ALL;
 		val &= ~(BLCG_DFPCI | BLCG_UFPCI | BLCG_FE |
 				BLCG_COREPLL_PWRDN);
 		val |= BLCG_IOPLL_0_PWRDN;
 		val |= BLCG_IOPLL_1_PWRDN;
 		val |= BLCG_IOPLL_2_PWRDN;
-
-		xudc_writel(xudc, val, BLCG);
+	} else {
+		val &= ~BLCG_COREPLL_PWRDN;
 	}
+	xudc_writel(xudc, val, BLCG);
 
 	if (xudc->soc->port_speed_quirk)
 		tegra_xudc_limit_port_speed(xudc);
@@ -3953,6 +3954,7 @@ static void tegra_xudc_remove(struct platform_device *pdev)
 static int __maybe_unused tegra_xudc_powergate(struct tegra_xudc *xudc)
 {
 	unsigned long flags;
+	u32 val;
 
 	dev_dbg(xudc->dev, "entering ELPG\n");
 
@@ -3965,6 +3967,10 @@ static int __maybe_unused tegra_xudc_powergate(struct tegra_xudc *xudc)
 
 	spin_unlock_irqrestore(&xudc->lock, flags);
 
+	val = xudc_readl(xudc, BLCG);
+	val |= BLCG_COREPLL_PWRDN;
+	xudc_writel(xudc, val, BLCG);
+
 	clk_bulk_disable_unprepare(xudc->soc->num_clks, xudc->clks);
 
 	regulator_bulk_disable(xudc->soc->num_supplies, xudc->supplies);
-- 
2.51.0





