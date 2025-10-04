Return-Path: <stable+bounces-183342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80E6BB8722
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 02:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8223D4C0E61
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 00:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A87E611E;
	Sat,  4 Oct 2025 00:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpLUXoPW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA83234BA3C
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759537321; cv=none; b=kP4sEuem/Qg+nX9aOMCRnujX/pgqB/E83uewpe6vDMpio7Zi+YJz/exXQLMcSmCHP/XAuoZjnNv2uOh/1N0xePSqGUFgj+ipKsVgMJ3Umq8AbbatyXElmurFilRyUDoXc6SE4bqPjMaVyFBEyIpqujmy9MtEoMTZc9QBHV0LDUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759537321; c=relaxed/simple;
	bh=AUBIFMN0oL9q60EaetitQwhQca5lqAfJFQq3y+UmHXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVr10kNKIqEvKplQ60J5Gv/kIGdt69mFzhGNvkIY+AoF5lPv1FOG6rpYjOPy9pTTNv2iB8sbUbPI8tXjwbWu+UzSFvypAHR2BLVUu5Kusci+onvEfvDIhR8u1ar9DObORXypPFuY47rrnbeagX/zmK3/iqhh+BiW3rdjK9DCGTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpLUXoPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CABC4CEF5;
	Sat,  4 Oct 2025 00:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759537320;
	bh=AUBIFMN0oL9q60EaetitQwhQca5lqAfJFQq3y+UmHXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VpLUXoPWy6Pa8pnnR/AZePBoLVnKBK84S6sB9WMTWQ+IRF6WgqLTXALHb/7n4DXav
	 BDKwefssJ126LarEyaESkCJWEu2fqg/aoAW/5BhtUWmzOZhoedORZJevT6MuRyp5/0
	 IwSOWCfh50p7UVUA/SqAm3o40O+5NB7cUX01tPEIDrfrnqOO+47KI4JVLD6N0+WYoG
	 6Jz9zFyk7gtrvZGGgiyYu81mVUywspMnSt7TgO85n8nJ+xt42sDo7hQ9QJua47szC8
	 SXcYllfGWJaqijGQUI3LsG8scd1tSBSh5ZJaMYxUA9n6os7xzJ7R3X6muhPEb4DBoM
	 p1sB4wXNICI6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Shuah Khan <shuah.kh@samsung.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] media: tunner: xc5000: Refactor firmware load
Date: Fri,  3 Oct 2025 20:21:56 -0400
Message-ID: <20251004002158.4023173-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025100341-cobbler-alabaster-748a@gregkh>
References: <2025100341-cobbler-alabaster-748a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ricardo Ribalda <ribalda@chromium.org>

[ Upstream commit 8e1f5da59dd4a1966f859639860b803a7e8b8bfb ]

Make sure the firmware is released when we leave
xc_load_fw_and_init_tuner()

This change makes smatch happy:
drivers/media/tuners/xc5000.c:1213 xc_load_fw_and_init_tuner() warn: 'fw' from request_firmware() not released on lines: 1213.

Cc: Shuah Khan <shuah.kh@samsung.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: 40b7a19f321e ("media: tuner: xc5000: Fix use-after-free in xc5000_release")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/tuners/xc5000.c | 39 +++++++++++++++--------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/media/tuners/xc5000.c b/drivers/media/tuners/xc5000.c
index 2182e5b7b6064..30aa4ee958bde 100644
--- a/drivers/media/tuners/xc5000.c
+++ b/drivers/media/tuners/xc5000.c
@@ -58,7 +58,7 @@ struct xc5000_priv {
 	struct dvb_frontend *fe;
 	struct delayed_work timer_sleep;
 
-	const struct firmware   *firmware;
+	bool inited;
 };
 
 /* Misc Defines */
@@ -1110,23 +1110,19 @@ static int xc_load_fw_and_init_tuner(struct dvb_frontend *fe, int force)
 	if (!force && xc5000_is_firmware_loaded(fe) == 0)
 		return 0;
 
-	if (!priv->firmware) {
-		ret = request_firmware(&fw, desired_fw->name,
-					priv->i2c_props.adap->dev.parent);
-		if (ret) {
-			pr_err("xc5000: Upload failed. rc %d\n", ret);
-			return ret;
-		}
-		dprintk(1, "firmware read %zu bytes.\n", fw->size);
+	ret = request_firmware(&fw, desired_fw->name,
+			       priv->i2c_props.adap->dev.parent);
+	if (ret) {
+		pr_err("xc5000: Upload failed. rc %d\n", ret);
+		return ret;
+	}
+	dprintk(1, "firmware read %zu bytes.\n", fw->size);
 
-		if (fw->size != desired_fw->size) {
-			pr_err("xc5000: Firmware file with incorrect size\n");
-			release_firmware(fw);
-			return -EINVAL;
-		}
-		priv->firmware = fw;
-	} else
-		fw = priv->firmware;
+	if (fw->size != desired_fw->size) {
+		pr_err("xc5000: Firmware file with incorrect size\n");
+		release_firmware(fw);
+		return -EINVAL;
+	}
 
 	/* Try up to 5 times to load firmware */
 	for (i = 0; i < 5; i++) {
@@ -1204,6 +1200,7 @@ static int xc_load_fw_and_init_tuner(struct dvb_frontend *fe, int force)
 	}
 
 err:
+	release_firmware(fw);
 	if (!ret)
 		printk(KERN_INFO "xc5000: Firmware %s loaded and running.\n",
 		       desired_fw->name);
@@ -1274,7 +1271,7 @@ static int xc5000_resume(struct dvb_frontend *fe)
 
 	/* suspended before firmware is loaded.
 	   Avoid firmware load in resume path. */
-	if (!priv->firmware)
+	if (!priv->inited)
 		return 0;
 
 	return xc5000_set_params(fe);
@@ -1293,6 +1290,8 @@ static int xc5000_init(struct dvb_frontend *fe)
 	if (debug)
 		xc_debug_dump(priv);
 
+	priv->inited = true;
+
 	return 0;
 }
 
@@ -1306,10 +1305,6 @@ static void xc5000_release(struct dvb_frontend *fe)
 
 	if (priv) {
 		cancel_delayed_work(&priv->timer_sleep);
-		if (priv->firmware) {
-			release_firmware(priv->firmware);
-			priv->firmware = NULL;
-		}
 		hybrid_tuner_release_state(priv);
 	}
 
-- 
2.51.0


