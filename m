Return-Path: <stable+bounces-6686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D9F81238A
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 00:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A881C20B1A
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 23:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDC179E13;
	Wed, 13 Dec 2023 23:49:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10414F5;
	Wed, 13 Dec 2023 15:49:23 -0800 (PST)
Received: from fedori.lan (51b690cd.dsl.pool.telekom.hu [::ffff:81.182.144.205])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000071EA1.00000000657A4302.001284F3; Thu, 14 Dec 2023 00:49:22 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
  Gergo Koteles <soyer@irl.hu>, stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/tas2781: reset the amp before component_add
Date: Thu, 14 Dec 2023 00:49:20 +0100
Message-ID: <4d23bf58558e23ee8097de01f70f1eb8d9de2d15.1702511246.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Calling component_add starts loading the firmware, the callback function
writes the program to the amplifiers. If the module resets the
amplifiers after component_add, it happens that one of the amplifiers
does not work because the reset and program writing are interleaving.

Call tas2781_reset before component_add to ensure reliable
initialization.

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
CC: stable@vger.kernel.org
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/tas2781_hda_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index fb802802939e..0baaaff94c6f 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -675,14 +675,14 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 
 	pm_runtime_put_autosuspend(tas_priv->dev);
 
+	tas2781_reset(tas_priv);
+
 	ret = component_add(tas_priv->dev, &tas2781_hda_comp_ops);
 	if (ret) {
 		dev_err(tas_priv->dev, "Register component failed: %d\n", ret);
 		pm_runtime_disable(tas_priv->dev);
-		goto err;
 	}
 
-	tas2781_reset(tas_priv);
 err:
 	if (ret)
 		tas2781_hda_remove(&clt->dev);

base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.43.0


