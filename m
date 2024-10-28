Return-Path: <stable+bounces-88984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49C49B2D57
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835A0280C17
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16841D63F1;
	Mon, 28 Oct 2024 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCsNYuTF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE9E1D416B;
	Mon, 28 Oct 2024 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112661; cv=none; b=DLJkaw2UuoScqR2iGMgjFT11tnx/5s6jUX9d551Ld9DH+CkjuDJoBPK44H0x8PqlY3hWqykJaeUvZPbYoXY7oWq8vL1A4RPLdsKx6NxpY7CHomOYXmPLaas0uIFbUsvQFUbDhO/lE9eBBLoNuKveAcNj4U9rf9yd6dYvHHTLYxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112661; c=relaxed/simple;
	bh=91spth+89hX9NWQTzxllOHTaSA39IxMZ803Aq/41CTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u27s4zv8w1lyZmQIyBellyuHbsDrCSQdgTTAXViouWbz4VUWLA05RVwJiLuN+/qTfH+5lzAUqQFje9oOTfKffBzoKmvhD5mXjlxEGPuHrrZ5eyJwE3m7hi1a25rCOQ4mZEHGH8aRTRVBD10tBtCkv6i9IUvzSvNlg2dfQNjToaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCsNYuTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8A9C4CEE3;
	Mon, 28 Oct 2024 10:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112661;
	bh=91spth+89hX9NWQTzxllOHTaSA39IxMZ803Aq/41CTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NCsNYuTFee6RWjw4+13D0zdzbDWgIAogl9Ka5Zoz7EMWbIIhiPmA0OSdi0onVKgXm
	 QMclzYG4gqiITdnihldXIfAewusGhuRXnkz8vYNRYhZ7ARmXm3wwhT+6Fxd+W9e+bn
	 YB1bdv/tr0wtb1QBVRe3Djna6S54ttbw+wchJ8aMtJpo4vFin0V0N0EwnBnjnR4foC
	 kIWFkVMEWiyeMyGffaCNxTzAHUz5fGzPRPU/7OKLQJi3kt4KuYNGFzJ9KadFs5FBAs
	 TDXybt6DOWLY762ZGB4sbWNpRON1P6U49iuna7YEd96qmdsOn1gKEGoMmyjY7oTjaz
	 I3JQ/YSDYJYXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	bhelgaas@google.com,
	pierre-louis.bossart@linux.dev,
	dlemoal@kernel.org,
	krzysztof.kozlowski@linaro.org,
	jbrunet@baylibre.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 02/32] ASoC: Intel: avs: Update stream status in a separate thread
Date: Mon, 28 Oct 2024 06:49:44 -0400
Message-ID: <20241028105050.3559169-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105050.3559169-1-sashal@kernel.org>
References: <20241028105050.3559169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit 0dbb186c3510cad4e9f443e801bf2e6ab5770c00 ]

Function snd_pcm_period_elapsed() is part of sequence servicing HDAudio
stream IRQs. It's called under Global Interrupt Enable (GIE) disabled -
no HDAudio interrupts will be raised. At the same time, the function may
end up calling __snd_pcm_xrun() or snd_pcm_drain_done(). On the
avs-driver side, this translates to IPCs and as GIE is disabled, these
will never complete successfully.

Improve system stability by scheduling stream-IRQ handling in a separate
thread.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://patch.msgid.link/20241008083758.756578-1-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/avs/core.c |  3 ++-
 sound/soc/intel/avs/pcm.c  | 19 +++++++++++++++++++
 sound/soc/intel/avs/pcm.h  | 16 ++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/intel/avs/pcm.h

diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
index f2dc82a2abc71..4d1e6c84918c6 100644
--- a/sound/soc/intel/avs/core.c
+++ b/sound/soc/intel/avs/core.c
@@ -28,6 +28,7 @@
 #include "avs.h"
 #include "cldma.h"
 #include "messages.h"
+#include "pcm.h"
 
 static u32 pgctl_mask = AZX_PGCTL_LSRMD_MASK;
 module_param(pgctl_mask, uint, 0444);
@@ -247,7 +248,7 @@ static void hdac_stream_update_pos(struct hdac_stream *stream, u64 buffer_size)
 static void hdac_update_stream(struct hdac_bus *bus, struct hdac_stream *stream)
 {
 	if (stream->substream) {
-		snd_pcm_period_elapsed(stream->substream);
+		avs_period_elapsed(stream->substream);
 	} else if (stream->cstream) {
 		u64 buffer_size = stream->cstream->runtime->buffer_size;
 
diff --git a/sound/soc/intel/avs/pcm.c b/sound/soc/intel/avs/pcm.c
index c76b86254a8b4..37b1880c81141 100644
--- a/sound/soc/intel/avs/pcm.c
+++ b/sound/soc/intel/avs/pcm.c
@@ -16,6 +16,7 @@
 #include <sound/soc-component.h>
 #include "avs.h"
 #include "path.h"
+#include "pcm.h"
 #include "topology.h"
 #include "../../codecs/hda.h"
 
@@ -30,6 +31,7 @@ struct avs_dma_data {
 		struct hdac_ext_stream *host_stream;
 	};
 
+	struct work_struct period_elapsed_work;
 	struct snd_pcm_substream *substream;
 };
 
@@ -56,6 +58,22 @@ avs_dai_find_path_template(struct snd_soc_dai *dai, bool is_fe, int direction)
 	return dw->priv;
 }
 
+static void avs_period_elapsed_work(struct work_struct *work)
+{
+	struct avs_dma_data *data = container_of(work, struct avs_dma_data, period_elapsed_work);
+
+	snd_pcm_period_elapsed(data->substream);
+}
+
+void avs_period_elapsed(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_dai *dai = snd_soc_rtd_to_cpu(rtd, 0);
+	struct avs_dma_data *data = snd_soc_dai_get_dma_data(dai, substream);
+
+	schedule_work(&data->period_elapsed_work);
+}
+
 static int avs_dai_startup(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
@@ -77,6 +95,7 @@ static int avs_dai_startup(struct snd_pcm_substream *substream, struct snd_soc_d
 	data->substream = substream;
 	data->template = template;
 	data->adev = adev;
+	INIT_WORK(&data->period_elapsed_work, avs_period_elapsed_work);
 	snd_soc_dai_set_dma_data(dai, substream, data);
 
 	if (rtd->dai_link->ignore_suspend)
diff --git a/sound/soc/intel/avs/pcm.h b/sound/soc/intel/avs/pcm.h
new file mode 100644
index 0000000000000..0f3615c903982
--- /dev/null
+++ b/sound/soc/intel/avs/pcm.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright(c) 2024 Intel Corporation
+ *
+ * Authors: Cezary Rojewski <cezary.rojewski@intel.com>
+ *          Amadeusz Slawinski <amadeuszx.slawinski@linux.intel.com>
+ */
+
+#ifndef __SOUND_SOC_INTEL_AVS_PCM_H
+#define __SOUND_SOC_INTEL_AVS_PCM_H
+
+#include <sound/pcm.h>
+
+void avs_period_elapsed(struct snd_pcm_substream *substream);
+
+#endif
-- 
2.43.0


