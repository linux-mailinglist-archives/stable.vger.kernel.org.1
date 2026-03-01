Return-Path: <stable+bounces-221314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGX/EDGUo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:19:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 642BF1CA336
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA0353009813
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563D3264A97;
	Sun,  1 Mar 2026 01:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggc64fzM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194B818E02A;
	Sun,  1 Mar 2026 01:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772327960; cv=none; b=KMjw5dfElOdq0SKz4pM0W5fPxtN/up6Cc2HMkVxFBdq3hv/D6NgT+5rKoSnaBouR+06i91rkeTDufnLc2vOjIeYSDNxEkCoiV94xCG9ob4jhuPshM8mhvtZWOiIWCzNqXAWcyWK5PMQspSM23sevqhZmbSrkZkMOFhdnVSEbYR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772327960; c=relaxed/simple;
	bh=KSlzvPMcPdroCRP7Ne2TmImOphnHGVDI27z0Kahl+9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dEV3lhFipuZAHFIuZfyu7pS/rQobo3nHMNp/Guj4gvCHgV/xouN6FJ89Ph4vxP3FTtb+WJv6QuLnnk2fqhE3O0I9qEEVCQqdLUdZFDq/j5LDAZt9Dls+0qUJs1uCIa+WefweJFhzQGkmJHOEQL1ihdgNVHy1k5uiw7mC9eLXG/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggc64fzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6C9C19421;
	Sun,  1 Mar 2026 01:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772327960;
	bh=KSlzvPMcPdroCRP7Ne2TmImOphnHGVDI27z0Kahl+9A=;
	h=From:To:Cc:Subject:Date:From;
	b=ggc64fzMGsuekE/SfKhDa/bqLNNTNq9trPciRySyaTnuxcQYhJLWq9hxg2AP/5ZvH
	 3GU1I1l1eURupXzgzT7khO1kMUxLuifQfwVyx8ks/bgRIMAhdFvu5JCeIz9kd5kQ/6
	 VAzwHMJx5KY83JZRqJRJa5BmNEMFm78SAOyenxEAmzWUsw3gOtBuXj6QgEq6cHsp+p
	 /22ooXH/gSY3pjbi40YpJZ8/t1P4XssupEZudH3sOJeZAH+uGi4YpABHkX/tZScGcN
	 kIoIxWEWEf5D4q9l2rryF1KF778MSw8VGQ4tiiRQ94dnqbHut4eU88BJ0AcgSp3JYf
	 cxmmYBbUt176g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	haoxiang_li2024@163.com
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: FAILED: Patch "media: mtk-mdp: Fix error handling in probe function" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:19:17 -0500
Message-ID: <20260301011918.1674237-1-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221314-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,collabora.com:email]
X-Rspamd-Queue-Id: 642BF1CA336
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8a8a3232abac5b972058a5f2cb3e33199d2a8648 Mon Sep 17 00:00:00 2001
From: Haoxiang Li <haoxiang_li2024@163.com>
Date: Wed, 8 Oct 2025 16:55:03 +0800
Subject: [PATCH] media: mtk-mdp: Fix error handling in probe function

Add mtk_mdp_unregister_m2m_device() on the error handling path to prevent
resource leak.

Add check for the return value of vpu_get_plat_device() to prevent null
pointer dereference. And vpu_get_plat_device() increases the reference
count of the returned platform device. Add platform_device_put() to
prevent reference leak.

Fixes: c8eb2d7e8202 ("[media] media: Add Mediatek MDP Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 .../media/platform/mediatek/mdp/mtk_mdp_core.c   | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp/mtk_mdp_core.c b/drivers/media/platform/mediatek/mdp/mtk_mdp_core.c
index 80fdc6ff57e0e..f78fa30f18648 100644
--- a/drivers/media/platform/mediatek/mdp/mtk_mdp_core.c
+++ b/drivers/media/platform/mediatek/mdp/mtk_mdp_core.c
@@ -194,11 +194,17 @@ static int mtk_mdp_probe(struct platform_device *pdev)
 	}
 
 	mdp->vpu_dev = vpu_get_plat_device(pdev);
+	if (!mdp->vpu_dev) {
+		dev_err(&pdev->dev, "Failed to get vpu device\n");
+		ret = -ENODEV;
+		goto err_vpu_get_dev;
+	}
+
 	ret = vpu_wdt_reg_handler(mdp->vpu_dev, mtk_mdp_reset_handler, mdp,
 				  VPU_RST_MDP);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register reset handler\n");
-		goto err_m2m_register;
+		goto err_reg_handler;
 	}
 
 	platform_set_drvdata(pdev, mdp);
@@ -206,7 +212,7 @@ static int mtk_mdp_probe(struct platform_device *pdev)
 	ret = vb2_dma_contig_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to set vb2 dma mag seg size\n");
-		goto err_m2m_register;
+		goto err_reg_handler;
 	}
 
 	pm_runtime_enable(dev);
@@ -214,6 +220,12 @@ static int mtk_mdp_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_reg_handler:
+	platform_device_put(mdp->vpu_dev);
+
+err_vpu_get_dev:
+	mtk_mdp_unregister_m2m_device(mdp);
+
 err_m2m_register:
 	v4l2_device_unregister(&mdp->v4l2_dev);
 
-- 
2.51.0





