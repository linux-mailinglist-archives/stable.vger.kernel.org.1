Return-Path: <stable+bounces-6681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9CD8122CF
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 00:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 160E41C2127B
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 23:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFF777B38;
	Wed, 13 Dec 2023 23:28:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E36A3;
	Wed, 13 Dec 2023 15:28:31 -0800 (PST)
Received: from fedori.lan (51b690cd.dsl.pool.telekom.hu [::ffff:81.182.144.205])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000070634.00000000657A3E1D.0012846C; Thu, 14 Dec 2023 00:28:29 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
  Gergo Koteles <soyer@irl.hu>, stable@vger.kernel.org
Subject: [PATCH v2] ALSA: hda/tas2781: call cleanup functions only once
Date: Thu, 14 Dec 2023 00:28:16 +0100
Message-ID: <1a0885c424bb21172702d254655882b59ef6477a.1702510018.git.soyer@irl.hu>
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

If the module can load the RCA but not the firmware binary, it will call
the cleanup functions. Then unloading the module causes general
protection fault due to double free.

Do not call the cleanup functions in tasdev_fw_ready.

general protection fault, probably for non-canonical address
0x6f2b8a2bff4c8fec: 0000 [#1] PREEMPT SMP NOPTI
Call Trace:
 <TASK>
 ? die_addr+0x36/0x90
 ? exc_general_protection+0x1c5/0x430
 ? asm_exc_general_protection+0x26/0x30
 ? tasdevice_config_info_remove+0x6d/0xd0 [snd_soc_tas2781_fmwlib]
 tas2781_hda_unbind+0xaa/0x100 [snd_hda_scodec_tas2781_i2c]
 component_unbind+0x2e/0x50
 component_unbind_all+0x92/0xa0
 component_del+0xa8/0x140
 tas2781_hda_remove.isra.0+0x32/0x60 [snd_hda_scodec_tas2781_i2c]
 i2c_device_remove+0x26/0xb0

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
CC: stable@vger.kernel.org
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/tas2781_hda_i2c.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index fb802802939e..c6b292606dfa 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -550,11 +550,6 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	tas2781_save_calibration(tas_priv);
 
 out:
-	if (tas_priv->fw_state == TASDEVICE_DSP_FW_FAIL) {
-		/*If DSP FW fail, kcontrol won't be created */
-		tasdevice_config_info_remove(tas_priv);
-		tasdevice_dsp_remove(tas_priv);
-	}
 	mutex_unlock(&tas_priv->codec_lock);
 	if (fmw)
 		release_firmware(fmw);

base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.43.0


