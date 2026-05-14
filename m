Return-Path: <stable+bounces-247229-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLn4OnTmBWoAdQIAu9opvQ
	(envelope-from <stable+bounces-247229-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:12:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A23543C8C
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57A9B3070382
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 15:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF05426EA7;
	Thu, 14 May 2026 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/C+oJIy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB3426EA0
	for <stable@vger.kernel.org>; Thu, 14 May 2026 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771310; cv=none; b=ngE/aBUTRTIW3il1VDGO+afQfWkcf4ualB5uIrG9cflvzHC5y+C1j/gIS8zJHLw87Ff298gkjEXRB6mVSOZyQOlMICdgm/yCkELIgxHc0397CuKvil78I4x0D8nbAU3+py4WdhvtGP/8I5A9mxvpXJv7dQUsLHnLEyYCN91Pl5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771310; c=relaxed/simple;
	bh=aQinG1VTDSuwr5QDZ0xan53ycK6Bg9KfEALPyxyvdNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXIkgNL7DPnnpSuJXZh1ztSf5hVzb6jmiH69c2Sp+umHwm1VIkDKGcwPMt7mlii/97XOYt9qeqXeGXquq5bOECHu6wJO5IbM6qVPNYsmBtt0Zh3wAIkRFPWJxSAPeQfKdLqR22T4PJowCQg5x/KlANuoC+BG0uqcoflU8K+ubE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/C+oJIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6DDC2BCB3;
	Thu, 14 May 2026 15:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778771308;
	bh=aQinG1VTDSuwr5QDZ0xan53ycK6Bg9KfEALPyxyvdNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P/C+oJIyDOXF8tgWT3cFX0SS18WCLjXLCAapwtFu6yX82dtIS+KesQ8sdY8/9VRfx
	 9TfJiBh2Q2CgswSqNV/decKGU1SbZT2MQ6yIkKwBNx6Yu0sUvMUGHGwAG1AZrTiUL3
	 v6U8byzYUF75mnRPYDRxSXddWvaogUSXwx2tqyxqobjZjIaRR700Hwb+8MfXtJbNTP
	 BW24IwHzq5LOUmRp6AUz/7nX8QYx5YrXV8o0gk+vQx+wOHWSAcVtvo5ok/w0Wkvq0L
	 oWeTQj/XvYbgKwS1KXhLzF6smgVVF8pRlvGvA1HH2StKjN2gyJEi2rj8gWJ4prlnLR
	 QOdec2EA8wYqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 1/2] EDAC/versalnet: Refactor memory controller initialization and cleanup
Date: Thu, 14 May 2026 11:08:24 -0400
Message-ID: <20260514150825.274588-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051202-poise-recoil-ab09@gregkh>
References: <2026051202-poise-recoil-ab09@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 76A23543C8C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247229-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,alien8.de:email,amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

[ Upstream commit 62a9fc50e8d947601ea3484e732b1a65a0a54b96 ]

Simplify the initialization and cleanup flow for Versal Net DDRMC
controllers in the EDAC driver by carving out the single controller init
into a separate function which allows for a much better and more
readable error handling and unwinding.

  [ bp:
	- do the kzalloc allocations first
	- "publish" the structures only after they've been initialized
	  properly so that you don't need to unwind unnecessarily when
	  it fails later
	- remove_versalnet() is now trivial
   ]

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20251104093932.3838876-1-shubhrajyoti.datta@amd.com
Stable-dep-of: 8cf5dd235eff ("EDAC/versalnet: Fix device name memory leak")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/versalnet_edac.c | 174 +++++++++++++++++++---------------
 1 file changed, 97 insertions(+), 77 deletions(-)

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index 162fb1736f55f..ec13155824141 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -70,6 +70,8 @@
 #define XDDR5_BUS_WIDTH_32		1
 #define XDDR5_BUS_WIDTH_16		2
 
+#define MC_NAME_LEN			32
+
 /**
  * struct ecc_error_info - ECC error log information.
  * @burstpos:		Burst position.
@@ -760,7 +762,17 @@ static void versal_edac_release(struct device *dev)
 	kfree(dev);
 }
 
-static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
+static void remove_one_mc(struct mc_priv *priv, int i)
+{
+	struct mem_ctl_info *mci;
+
+	mci = priv->mci[i];
+	device_unregister(mci->pdev);
+	edac_mc_del_mc(mci->pdev);
+	edac_mc_free(mci);
+}
+
+static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i)
 {
 	u32 num_chans, rank, dwidth, config;
 	struct edac_mc_layer layers[2];
@@ -768,102 +780,110 @@ static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
 	struct device *dev;
 	enum dev_type dt;
 	char *name;
-	int rc, i;
-
-	for (i = 0; i < NUM_CONTROLLERS; i++) {
-		config = priv->adec[CONF + i * ADEC_NUM];
-		num_chans = FIELD_GET(MC5_NUM_CHANS_MASK, config);
-		rank = 1 << FIELD_GET(MC5_RANK_MASK, config);
-		dwidth = FIELD_GET(MC5_BUS_WIDTH_MASK, config);
-
-		switch (dwidth) {
-		case XDDR5_BUS_WIDTH_16:
-			dt = DEV_X16;
-			break;
-		case XDDR5_BUS_WIDTH_32:
-			dt = DEV_X32;
-			break;
-		case XDDR5_BUS_WIDTH_64:
-			dt = DEV_X64;
-			break;
-		default:
-			dt = DEV_UNKNOWN;
-		}
+	int rc;
 
-		if (dt == DEV_UNKNOWN)
-			continue;
+	config = priv->adec[CONF + i * ADEC_NUM];
+	num_chans = FIELD_GET(MC5_NUM_CHANS_MASK, config);
+	rank = 1 << FIELD_GET(MC5_RANK_MASK, config);
+	dwidth = FIELD_GET(MC5_BUS_WIDTH_MASK, config);
+
+	switch (dwidth) {
+	case XDDR5_BUS_WIDTH_16:
+		dt = DEV_X16;
+		break;
+	case XDDR5_BUS_WIDTH_32:
+		dt = DEV_X32;
+		break;
+	case XDDR5_BUS_WIDTH_64:
+		dt = DEV_X64;
+		break;
+	default:
+		dt = DEV_UNKNOWN;
+	}
 
-		/* Find the first enabled device and register that one. */
-		layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-		layers[0].size = rank;
-		layers[0].is_virt_csrow = true;
-		layers[1].type = EDAC_MC_LAYER_CHANNEL;
-		layers[1].size = num_chans;
-		layers[1].is_virt_csrow = false;
+	if (dt == DEV_UNKNOWN)
+		return 0;
 
-		rc = -ENOMEM;
-		mci = edac_mc_alloc(i, ARRAY_SIZE(layers), layers,
-				    sizeof(struct mc_priv));
-		if (!mci) {
-			edac_printk(KERN_ERR, EDAC_MC, "Failed memory allocation for MC%d\n", i);
-			goto err_alloc;
-		}
+	/* Find the first enabled device and register that one. */
+	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+	layers[0].size = rank;
+	layers[0].is_virt_csrow = true;
+	layers[1].type = EDAC_MC_LAYER_CHANNEL;
+	layers[1].size = num_chans;
+	layers[1].is_virt_csrow = false;
+
+	rc = -ENOMEM;
+	name = kzalloc(MC_NAME_LEN, GFP_KERNEL);
+	if (!name)
+		return rc;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		goto err_name_free;
+
+	mci = edac_mc_alloc(i, ARRAY_SIZE(layers), layers, sizeof(struct mc_priv));
+	if (!mci) {
+		edac_printk(KERN_ERR, EDAC_MC, "Failed memory allocation for MC%d\n", i);
+		goto err_dev_free;
+	}
 
-		priv->mci[i] = mci;
-		priv->dwidth = dt;
+	sprintf(name, "versal-net-ddrmc5-edac-%d", i);
 
-		dev = kzalloc_obj(*dev);
-		dev->release = versal_edac_release;
-		name = kmalloc(32, GFP_KERNEL);
-		sprintf(name, "versal-net-ddrmc5-edac-%d", i);
-		dev->init_name = name;
-		rc = device_register(dev);
-		if (rc)
-			goto err_alloc;
+	dev->init_name = name;
+	dev->release = versal_edac_release;
 
-		mci->pdev = dev;
+	rc = device_register(dev);
+	if (rc)
+		goto err_mc_free;
 
-		platform_set_drvdata(pdev, priv);
+	mci->pdev = dev;
+	mc_init(mci, dev);
 
-		mc_init(mci, dev);
-		rc = edac_mc_add_mc(mci);
-		if (rc) {
-			edac_printk(KERN_ERR, EDAC_MC, "Failed to register MC%d with EDAC core\n", i);
-			goto err_alloc;
-		}
+	rc = edac_mc_add_mc(mci);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_MC, "Failed to register MC%d with EDAC core\n", i);
+		goto err_unreg;
 	}
-	return 0;
 
-err_alloc:
-	while (i--) {
-		mci = priv->mci[i];
-		if (!mci)
-			continue;
-
-		if (mci->pdev) {
-			device_unregister(mci->pdev);
-			edac_mc_del_mc(mci->pdev);
-		}
+	priv->mci[i] = mci;
+	priv->dwidth = dt;
 
-		edac_mc_free(mci);
-	}
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+
+err_unreg:
+	device_unregister(mci->pdev);
+err_mc_free:
+	edac_mc_free(mci);
+err_dev_free:
+	kfree(dev);
+err_name_free:
+	kfree(name);
 
 	return rc;
 }
 
-static void remove_versalnet(struct mc_priv *priv)
+static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
 {
-	struct mem_ctl_info *mci;
-	int i;
+	int rc, i;
 
 	for (i = 0; i < NUM_CONTROLLERS; i++) {
-		device_unregister(priv->mci[i]->pdev);
-		mci = edac_mc_del_mc(priv->mci[i]->pdev);
-		if (!mci)
-			return;
+		rc = init_one_mc(priv, pdev, i);
+		if (rc) {
+			while (i--)
+				remove_one_mc(priv, i);
 
-		edac_mc_free(mci);
+			return rc;
+		}
 	}
+	return 0;
+}
+
+static void remove_versalnet(struct mc_priv *priv)
+{
+	for (int i = 0; i < NUM_CONTROLLERS; i++)
+		remove_one_mc(priv, i);
 }
 
 static int mc_probe(struct platform_device *pdev)
-- 
2.53.0


