Return-Path: <stable+bounces-45480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BED928CA8E3
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 09:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35356B20E60
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 07:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4277A4F5FA;
	Tue, 21 May 2024 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ij25vDrc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4920D179BD;
	Tue, 21 May 2024 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716276318; cv=none; b=AoLiCCb6hAKL1o3cLKkA2YAq+taYJqt8MBidW/5Z++Qfi45J1JesIce5rBgYaUENd98avjphkcv3xRbJLmNmGMfb0if1LYqabwxmdVh2XqjvH+ct4We+9sVjIPhunlKnVVrob3/+umv5GJ6YuCcDpdLr4tq+CLfdQy+5nKFHtOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716276318; c=relaxed/simple;
	bh=jqM095M6+Edbzw24nBXIVOknonf78KLa0bStsMqkV8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s/VecuuW9Ku9Xebi8WsUD8il7ZjnFew/wjw3T5qS5RBeuMOddy+r1UlfrjmojQDOtimlXQmDZmgeXcKYGikkjnOEm5UfTgdXEPfUx6/H1Hy/5d2iZ3zzND4WU84UbUz1JS2Bjzhq+GAYhU7NxBqs2ZhHvkg+SnkD5/5YEJMFp9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ij25vDrc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716276316; x=1747812316;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jqM095M6+Edbzw24nBXIVOknonf78KLa0bStsMqkV8s=;
  b=ij25vDrcHR4It4aAn72T8GcCuqdk0bzsYOMbkb6VP3tzoesFGWhclLsJ
   mX+7AVcIvIxKZYzU+NtBAPLzHQgzFkiXR/cC0xFOF3l4zTZSm380Qu2B+
   Irq/ouUdkIvKutkj9EtiexJzrkP8UZSmT1xFWAKTpLMc50yOTfJ5Tkyxv
   LtTf/dh0NkogHABehT6CBm/r+wHcUpJgy2eBg+qE+ORlFLzWkqdsN/lSp
   SEUUUGP/QmjHGOQ45aTogOaklA+RtqWuQLypRSBWdDKH9DEH7EdCWtypk
   40KapsPY/gCHEjxk6IA9U2Xomhqa9jDaDXwGV6AyDkM141P841rurtL6u
   w==;
X-CSE-ConnectionGUID: 744fxm9SRqCMCOKBXMrbrw==
X-CSE-MsgGUID: +CHzUe+PTP2BZF9Lf5lUTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12241960"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="12241960"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 00:24:34 -0700
X-CSE-ConnectionGUID: 3JS4VM4TR567zAfiYiRP4A==
X-CSE-MsgGUID: K00pAaa7SjClJz7omPwjvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="64041139"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.250])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 00:24:31 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org,
	yung-chuan.liao@linux.intel.com
Subject: [PATCH stable-6.9.y] ASoC: Intel: sof_sdw: use generic rtd_init function for Realtek SDW DMICs
Date: Tue, 21 May 2024 10:24:51 +0300
Message-ID: <20240521072451.5488-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bard Liao <yung-chuan.liao@linux.intel.com>

commit bee2fe44679f1e6a5332d7f78587ccca4109919f upstream.

The only thing that the rt_xxx_rtd_init() functions do is to set
card->components. And we can set card->components with name_prefix
as rt712_sdca_dmic_rtd_init() does.
And sof_sdw_rtd_init() will always select the first dai with the
given dai->name from codec_info_list[]. Unfortunately, we have
different codecs with the same dai name. For example, dai name of
rt715 and rt715-sdca are both "rt715-aif2". Using a generic rtd_init
allow sof_sdw_rtd_init() run the rtd_init() callback from a similar
codec dai.

Fixes: 8266c73126b7 ("ASoC: Intel: sof_sdw: add common sdw dai link init")
Reviewed-by: Chao Song <chao.song@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://msgid.link/r/20240326160429.13560-25-pierre-louis.bossart@linux.intel.com
Link: https://github.com/thesofproject/linux/issues/4999 # 6.9.y stable report
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org # 6.9
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
Hi,

Regression reported in 6.9 by a user:
https://github.com/thesofproject/linux/issues/4999

The fix for the issue somehow dodged the 6.9 cycle and only landed mainline
for 6.10, before -rc1 tag.

Our trust in machines shaken a bit, so just to make sure that this patch is
picked for stable 6.9, I have cherry-picked it and tested on a device that
it is working without any side-effect.

Regards,
Peter

 sound/soc/intel/boards/Makefile          |  1 +
 sound/soc/intel/boards/sof_sdw.c         | 12 +++---
 sound/soc/intel/boards/sof_sdw_common.h  |  1 +
 sound/soc/intel/boards/sof_sdw_rt_dmic.c | 52 ++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 6 deletions(-)
 create mode 100644 sound/soc/intel/boards/sof_sdw_rt_dmic.c

diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index bbf796a5f7ba..08cfd4baecdd 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -42,6 +42,7 @@ snd-soc-sof-sdw-objs += sof_sdw.o				\
 			sof_sdw_rt711.o sof_sdw_rt_sdca_jack_common.o	\
 			sof_sdw_rt712_sdca.o sof_sdw_rt715.o	\
 			sof_sdw_rt715_sdca.o sof_sdw_rt722_sdca.o	\
+			sof_sdw_rt_dmic.o			\
 			sof_sdw_cs42l42.o sof_sdw_cs42l43.o	\
 			sof_sdw_cs_amp.o			\
 			sof_sdw_dmic.o				\
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 08f330ed5c2e..a90b43162a54 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -730,7 +730,7 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 				.dai_name = "rt712-sdca-dmic-aif1",
 				.dai_type = SOF_SDW_DAI_TYPE_MIC,
 				.dailink = {SDW_UNUSED_DAI_ID, SDW_DMIC_DAI_ID},
-				.rtd_init = rt712_sdca_dmic_rtd_init,
+				.rtd_init = rt_dmic_rtd_init,
 			},
 		},
 		.dai_num = 1,
@@ -760,7 +760,7 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 				.dai_name = "rt712-sdca-dmic-aif1",
 				.dai_type = SOF_SDW_DAI_TYPE_MIC,
 				.dailink = {SDW_UNUSED_DAI_ID, SDW_DMIC_DAI_ID},
-				.rtd_init = rt712_sdca_dmic_rtd_init,
+				.rtd_init = rt_dmic_rtd_init,
 			},
 		},
 		.dai_num = 1,
@@ -822,7 +822,7 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 				.dai_name = "rt715-aif2",
 				.dai_type = SOF_SDW_DAI_TYPE_MIC,
 				.dailink = {SDW_UNUSED_DAI_ID, SDW_DMIC_DAI_ID},
-				.rtd_init = rt715_sdca_rtd_init,
+				.rtd_init = rt_dmic_rtd_init,
 			},
 		},
 		.dai_num = 1,
@@ -837,7 +837,7 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 				.dai_name = "rt715-aif2",
 				.dai_type = SOF_SDW_DAI_TYPE_MIC,
 				.dailink = {SDW_UNUSED_DAI_ID, SDW_DMIC_DAI_ID},
-				.rtd_init = rt715_sdca_rtd_init,
+				.rtd_init = rt_dmic_rtd_init,
 			},
 		},
 		.dai_num = 1,
@@ -852,7 +852,7 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 				.dai_name = "rt715-aif2",
 				.dai_type = SOF_SDW_DAI_TYPE_MIC,
 				.dailink = {SDW_UNUSED_DAI_ID, SDW_DMIC_DAI_ID},
-				.rtd_init = rt715_rtd_init,
+				.rtd_init = rt_dmic_rtd_init,
 			},
 		},
 		.dai_num = 1,
@@ -867,7 +867,7 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 				.dai_name = "rt715-aif2",
 				.dai_type = SOF_SDW_DAI_TYPE_MIC,
 				.dailink = {SDW_UNUSED_DAI_ID, SDW_DMIC_DAI_ID},
-				.rtd_init = rt715_rtd_init,
+				.rtd_init = rt_dmic_rtd_init,
 			},
 		},
 		.dai_num = 1,
diff --git a/sound/soc/intel/boards/sof_sdw_common.h b/sound/soc/intel/boards/sof_sdw_common.h
index b1d57034361c..8a541b6bb0ac 100644
--- a/sound/soc/intel/boards/sof_sdw_common.h
+++ b/sound/soc/intel/boards/sof_sdw_common.h
@@ -190,6 +190,7 @@ int rt712_sdca_dmic_rtd_init(struct snd_soc_pcm_runtime *rtd);
 int rt712_spk_rtd_init(struct snd_soc_pcm_runtime *rtd);
 int rt715_rtd_init(struct snd_soc_pcm_runtime *rtd);
 int rt715_sdca_rtd_init(struct snd_soc_pcm_runtime *rtd);
+int rt_dmic_rtd_init(struct snd_soc_pcm_runtime *rtd);
 int rt_amp_spk_rtd_init(struct snd_soc_pcm_runtime *rtd);
 int rt_sdca_jack_rtd_init(struct snd_soc_pcm_runtime *rtd);
 
diff --git a/sound/soc/intel/boards/sof_sdw_rt_dmic.c b/sound/soc/intel/boards/sof_sdw_rt_dmic.c
new file mode 100644
index 000000000000..9091f5b5c648
--- /dev/null
+++ b/sound/soc/intel/boards/sof_sdw_rt_dmic.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2024 Intel Corporation
+
+/*
+ * sof_sdw_rt_dmic - Helpers to handle Realtek SDW DMIC from generic machine driver
+ */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <sound/soc.h>
+#include <sound/soc-acpi.h>
+#include "sof_board_helpers.h"
+#include "sof_sdw_common.h"
+
+static const char * const dmics[] = {
+	"rt715",
+	"rt712-sdca-dmic",
+};
+
+int rt_dmic_rtd_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_component *component;
+	struct snd_soc_dai *codec_dai;
+	char *mic_name;
+
+	codec_dai = get_codec_dai_by_name(rtd, dmics, ARRAY_SIZE(dmics));
+	if (!codec_dai)
+		return -EINVAL;
+
+	component = codec_dai->component;
+
+	/*
+	 * rt715-sdca (aka rt714) is a special case that uses different name in card->components
+	 * and component->name_prefix.
+	 */
+	if (!strcmp(component->name_prefix, "rt714"))
+		mic_name = devm_kasprintf(card->dev, GFP_KERNEL, "rt715-sdca");
+	else
+		mic_name = devm_kasprintf(card->dev, GFP_KERNEL, "%s", component->name_prefix);
+
+	card->components = devm_kasprintf(card->dev, GFP_KERNEL,
+					  "%s mic:%s", card->components,
+					  mic_name);
+	if (!card->components)
+		return -ENOMEM;
+
+	dev_dbg(card->dev, "card->components: %s\n", card->components);
+
+	return 0;
+}
+MODULE_IMPORT_NS(SND_SOC_INTEL_SOF_BOARD_HELPERS);
-- 
2.45.1


