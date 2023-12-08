Return-Path: <stable+bounces-5050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEA980AB09
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 18:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082E01C2042E
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 17:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F89E3B2BB;
	Fri,  8 Dec 2023 17:45:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Dec 2023 09:45:14 PST
Received: from irl.hu (irl.hu [95.85.9.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B23CF4;
	Fri,  8 Dec 2023 09:45:13 -0800 (PST)
Received: from fedori.lan (51b690cd.dsl.pool.telekom.hu [::ffff:81.182.144.205])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000719DB.00000000657354F6.0011CADC; Fri, 08 Dec 2023 18:40:06 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
  Gergo Koteles <soyer@irl.hu>, stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/tas2781: leave hda_component in usable state
Date: Fri,  8 Dec 2023 18:38:19 +0100
Message-ID: <052224ccd9d24dac777c468d2ef94d5fabe619a0.1702056528.git.soyer@irl.hu>
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

Unloading then loading the module causes a NULL ponter dereference.

The hda_unbind zeroes the hda_component, later the hda_bind tries
to dereference the codec field.

The hda_component is only initialized once by tas2781_generic_fixup.

Set only previously modified fields to NULL.

BUG: kernel NULL pointer dereference, address: 0000000000000322
Call Trace:
 <TASK>
 ? __die+0x23/0x70
 ? page_fault_oops+0x171/0x4e0
 ? exc_page_fault+0x7f/0x180
 ? asm_exc_page_fault+0x26/0x30
 ? tas2781_hda_bind+0x59/0x140 [snd_hda_scodec_tas2781_i2c]
 component_bind_all+0xf3/0x240
 try_to_bring_up_aggregate_device+0x1c3/0x270
 __component_add+0xbc/0x1a0
 tas2781_hda_i2c_probe+0x289/0x3a0 [snd_hda_scodec_tas2781_i2c]
 i2c_device_probe+0x136/0x2e0

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
CC: stable@vger.kernel.org
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/tas2781_hda_i2c.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index fb802802939e..ba4fdae8ec9b 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -612,9 +612,13 @@ static void tas2781_hda_unbind(struct device *dev,
 {
 	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
 	struct hda_component *comps = master_data;
+	comps = &comps[tas_priv->index];
 
-	if (comps[tas_priv->index].dev == dev)
-		memset(&comps[tas_priv->index], 0, sizeof(*comps));
+	if (comps[tas_priv->index].dev == dev) {
+		comps->dev = NULL;
+		strscpy(comps->name, "", sizeof(comps->name));
+		comps->playback_hook = NULL;
+	}
 
 	tasdevice_config_info_remove(tas_priv);
 	tasdevice_dsp_remove(tas_priv);

base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.43.0


