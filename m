Return-Path: <stable+bounces-6689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB088123D8
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 01:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52F91F218B9
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 00:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6025937E;
	Thu, 14 Dec 2023 00:26:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEF8D0;
	Wed, 13 Dec 2023 16:26:50 -0800 (PST)
Received: from fedori.lan (51b690cd.dsl.pool.telekom.hu [::ffff:81.182.144.205])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000071EA5.00000000657A4BC8.001285B7; Thu, 14 Dec 2023 01:26:48 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
  Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
  Gergo Koteles <soyer@irl.hu>, stable@vger.kernel.org
Subject: [PATCH] ASoC: tas2781: add support for FW version 0x0503
Date: Thu, 14 Dec 2023 01:25:39 +0100
Message-ID: <98d4ee4e01e834af72a1a0bea6736facf43582e0.1702513517.git.soyer@irl.hu>
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

Layout of FW version 0x0503 is compatible with 0x0502.
Already supported by TI's tas2781-linux-driver tree.
https://git.ti.com/cgit/tas2781-linux-drivers/tas2781-linux-driver/

Fixes: 915f5eadebd2 ("ASoC: tas2781: firmware lib")
CC: stable@vger.kernel.org
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/soc/codecs/tas2781-fmwlib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
index eb55abae0d7b..20dc2df034e9 100644
--- a/sound/soc/codecs/tas2781-fmwlib.c
+++ b/sound/soc/codecs/tas2781-fmwlib.c
@@ -2012,6 +2012,7 @@ static int tasdevice_dspfw_ready(const struct firmware *fmw,
 	case 0x301:
 	case 0x302:
 	case 0x502:
+	case 0x503:
 		tas_priv->fw_parse_variable_header =
 			fw_parse_variable_header_kernel;
 		tas_priv->fw_parse_program_data =

base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.43.0


