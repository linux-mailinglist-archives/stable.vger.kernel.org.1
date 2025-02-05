Return-Path: <stable+bounces-113361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD9FA291DA
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CE13AC12E
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8DA1DC9AF;
	Wed,  5 Feb 2025 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KzJsaYUw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48934189528;
	Wed,  5 Feb 2025 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766701; cv=none; b=S9K6pGEHagvdydZ0pOHASP9P+XvSc45G2+jpkI+TIBMAHfGudx2h6hkeE9qa1GycnLOSyZkLS7tqpDhTT1QdLggo3D6sCPrHQY2Gck5ua4+8/Wuusf6COz0IGymthP+jZJNjJUTb4DYIfssmpIX8hncG3heoTFaCIXgbSMl2xNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766701; c=relaxed/simple;
	bh=+6HmkGxil15eMDITp0VL/oR6W4uV+rKkGQhlv+Cq0gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1RKaWfT/6m313CqN4zzTYbRysffz7bDEig/p4SS2u5qZJwmMgpH0qOfeyGkR0+hS6VvzcjRVgknovFEiPPxNYSXCAzQh27EY07dDdi/D5/AYgkc1ka3r+h+/8QY+38/0FYWj8Djf05CoIyY6spMK09PeqrLLO8MWV4qPwJDLQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KzJsaYUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34095C4CED1;
	Wed,  5 Feb 2025 14:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738766701;
	bh=+6HmkGxil15eMDITp0VL/oR6W4uV+rKkGQhlv+Cq0gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KzJsaYUwF69NvPwvJ44UlCvte0VCQjeYZDPC2oI4LINwky92daCFpM66xofITJ8ce
	 RtYYDyP5OGyR2dYVYTOoKe37elmUq5/D2PjaxdZw8V8pXxpwUTjOks3R7L3+fV2MjO
	 zr40BsorLC1Ce/XHZIRzdryWZMzdJ0QcwGaWZ4A8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 299/623] ALSA: hda: Fix compilation of snd_hdac_adsp_xxx() helpers
Date: Wed,  5 Feb 2025 14:40:41 +0100
Message-ID: <20250205134507.667703310@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit 7579790915387396e26041ceafbc07348658edef ]

The snd_hdac_adsp_xxx() wrap snd_hdac_reg_xxx() helpers to simplify
register access for AudioDSP drivers e.g.: the avs-driver. Byte- and
word-variants of said helps do not expand to bare readx/writex()
operations but functions instead and, due to pointer type
incompatibility, cause compilation to fail.

As the macros are utilized by the avs-driver alone, relocate the code
introduced with commit c19bd02e9029 ("ALSA: hda: Add helper macros for
DSP capable devices") into the avs/ directory and update it to operate
on 'adev' i.e.: the avs-driver-context directly to fix the issue.

Fixes: c19bd02e9029 ("ALSA: hda: Add helper macros for DSP capable devices")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20250110113326.3809897-2-cezary.rojewski@intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/hdaudio_ext.h     | 45 ---------------------------------
 sound/soc/intel/avs/apl.c       |  1 +
 sound/soc/intel/avs/cnl.c       |  1 +
 sound/soc/intel/avs/registers.h | 45 +++++++++++++++++++++++++++++++++
 sound/soc/intel/avs/skl.c       |  1 +
 5 files changed, 48 insertions(+), 45 deletions(-)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 957295364a5e3..4c7a40e149a59 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -2,8 +2,6 @@
 #ifndef __SOUND_HDAUDIO_EXT_H
 #define __SOUND_HDAUDIO_EXT_H
 
-#include <linux/io-64-nonatomic-lo-hi.h>
-#include <linux/iopoll.h>
 #include <sound/hdaudio.h>
 
 int snd_hdac_ext_bus_init(struct hdac_bus *bus, struct device *dev,
@@ -119,49 +117,6 @@ int snd_hdac_ext_bus_link_put(struct hdac_bus *bus, struct hdac_ext_link *hlink)
 
 void snd_hdac_ext_bus_link_power(struct hdac_device *codec, bool enable);
 
-#define snd_hdac_adsp_writeb(chip, reg, value) \
-	snd_hdac_reg_writeb(chip, (chip)->dsp_ba + (reg), value)
-#define snd_hdac_adsp_readb(chip, reg) \
-	snd_hdac_reg_readb(chip, (chip)->dsp_ba + (reg))
-#define snd_hdac_adsp_writew(chip, reg, value) \
-	snd_hdac_reg_writew(chip, (chip)->dsp_ba + (reg), value)
-#define snd_hdac_adsp_readw(chip, reg) \
-	snd_hdac_reg_readw(chip, (chip)->dsp_ba + (reg))
-#define snd_hdac_adsp_writel(chip, reg, value) \
-	snd_hdac_reg_writel(chip, (chip)->dsp_ba + (reg), value)
-#define snd_hdac_adsp_readl(chip, reg) \
-	snd_hdac_reg_readl(chip, (chip)->dsp_ba + (reg))
-#define snd_hdac_adsp_writeq(chip, reg, value) \
-	snd_hdac_reg_writeq(chip, (chip)->dsp_ba + (reg), value)
-#define snd_hdac_adsp_readq(chip, reg) \
-	snd_hdac_reg_readq(chip, (chip)->dsp_ba + (reg))
-
-#define snd_hdac_adsp_updateb(chip, reg, mask, val) \
-	snd_hdac_adsp_writeb(chip, reg, \
-			(snd_hdac_adsp_readb(chip, reg) & ~(mask)) | (val))
-#define snd_hdac_adsp_updatew(chip, reg, mask, val) \
-	snd_hdac_adsp_writew(chip, reg, \
-			(snd_hdac_adsp_readw(chip, reg) & ~(mask)) | (val))
-#define snd_hdac_adsp_updatel(chip, reg, mask, val) \
-	snd_hdac_adsp_writel(chip, reg, \
-			(snd_hdac_adsp_readl(chip, reg) & ~(mask)) | (val))
-#define snd_hdac_adsp_updateq(chip, reg, mask, val) \
-	snd_hdac_adsp_writeq(chip, reg, \
-			(snd_hdac_adsp_readq(chip, reg) & ~(mask)) | (val))
-
-#define snd_hdac_adsp_readb_poll(chip, reg, val, cond, delay_us, timeout_us) \
-	readb_poll_timeout((chip)->dsp_ba + (reg), val, cond, \
-			   delay_us, timeout_us)
-#define snd_hdac_adsp_readw_poll(chip, reg, val, cond, delay_us, timeout_us) \
-	readw_poll_timeout((chip)->dsp_ba + (reg), val, cond, \
-			   delay_us, timeout_us)
-#define snd_hdac_adsp_readl_poll(chip, reg, val, cond, delay_us, timeout_us) \
-	readl_poll_timeout((chip)->dsp_ba + (reg), val, cond, \
-			   delay_us, timeout_us)
-#define snd_hdac_adsp_readq_poll(chip, reg, val, cond, delay_us, timeout_us) \
-	readq_poll_timeout((chip)->dsp_ba + (reg), val, cond, \
-			   delay_us, timeout_us)
-
 struct hdac_ext_device;
 
 /* ops common to all codec drivers */
diff --git a/sound/soc/intel/avs/apl.c b/sound/soc/intel/avs/apl.c
index d443fe8d51aee..3dccf0a57a3a1 100644
--- a/sound/soc/intel/avs/apl.c
+++ b/sound/soc/intel/avs/apl.c
@@ -12,6 +12,7 @@
 #include "avs.h"
 #include "messages.h"
 #include "path.h"
+#include "registers.h"
 #include "topology.h"
 
 static irqreturn_t avs_apl_dsp_interrupt(struct avs_dev *adev)
diff --git a/sound/soc/intel/avs/cnl.c b/sound/soc/intel/avs/cnl.c
index bd3c4bb8bf5a1..03f8fb0dc187f 100644
--- a/sound/soc/intel/avs/cnl.c
+++ b/sound/soc/intel/avs/cnl.c
@@ -9,6 +9,7 @@
 #include <sound/hdaudio_ext.h>
 #include "avs.h"
 #include "messages.h"
+#include "registers.h"
 
 static void avs_cnl_ipc_interrupt(struct avs_dev *adev)
 {
diff --git a/sound/soc/intel/avs/registers.h b/sound/soc/intel/avs/registers.h
index f76e91cff2a9a..5b6d60eb3c18b 100644
--- a/sound/soc/intel/avs/registers.h
+++ b/sound/soc/intel/avs/registers.h
@@ -9,6 +9,8 @@
 #ifndef __SOUND_SOC_INTEL_AVS_REGS_H
 #define __SOUND_SOC_INTEL_AVS_REGS_H
 
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/iopoll.h>
 #include <linux/sizes.h>
 
 #define AZX_PCIREG_PGCTL		0x44
@@ -98,4 +100,47 @@
 #define avs_downlink_addr(adev) \
 	avs_sram_addr(adev, AVS_DOWNLINK_WINDOW)
 
+#define snd_hdac_adsp_writeb(adev, reg, value) \
+	snd_hdac_reg_writeb(&(adev)->base.core, (adev)->dsp_ba + (reg), value)
+#define snd_hdac_adsp_readb(adev, reg) \
+	snd_hdac_reg_readb(&(adev)->base.core, (adev)->dsp_ba + (reg))
+#define snd_hdac_adsp_writew(adev, reg, value) \
+	snd_hdac_reg_writew(&(adev)->base.core, (adev)->dsp_ba + (reg), value)
+#define snd_hdac_adsp_readw(adev, reg) \
+	snd_hdac_reg_readw(&(adev)->base.core, (adev)->dsp_ba + (reg))
+#define snd_hdac_adsp_writel(adev, reg, value) \
+	snd_hdac_reg_writel(&(adev)->base.core, (adev)->dsp_ba + (reg), value)
+#define snd_hdac_adsp_readl(adev, reg) \
+	snd_hdac_reg_readl(&(adev)->base.core, (adev)->dsp_ba + (reg))
+#define snd_hdac_adsp_writeq(adev, reg, value) \
+	snd_hdac_reg_writeq(&(adev)->base.core, (adev)->dsp_ba + (reg), value)
+#define snd_hdac_adsp_readq(adev, reg) \
+	snd_hdac_reg_readq(&(adev)->base.core, (adev)->dsp_ba + (reg))
+
+#define snd_hdac_adsp_updateb(adev, reg, mask, val) \
+	snd_hdac_adsp_writeb(adev, reg, \
+			(snd_hdac_adsp_readb(adev, reg) & ~(mask)) | (val))
+#define snd_hdac_adsp_updatew(adev, reg, mask, val) \
+	snd_hdac_adsp_writew(adev, reg, \
+			(snd_hdac_adsp_readw(adev, reg) & ~(mask)) | (val))
+#define snd_hdac_adsp_updatel(adev, reg, mask, val) \
+	snd_hdac_adsp_writel(adev, reg, \
+			(snd_hdac_adsp_readl(adev, reg) & ~(mask)) | (val))
+#define snd_hdac_adsp_updateq(adev, reg, mask, val) \
+	snd_hdac_adsp_writeq(adev, reg, \
+			(snd_hdac_adsp_readq(adev, reg) & ~(mask)) | (val))
+
+#define snd_hdac_adsp_readb_poll(adev, reg, val, cond, delay_us, timeout_us) \
+	readb_poll_timeout((adev)->dsp_ba + (reg), val, cond, \
+			   delay_us, timeout_us)
+#define snd_hdac_adsp_readw_poll(adev, reg, val, cond, delay_us, timeout_us) \
+	readw_poll_timeout((adev)->dsp_ba + (reg), val, cond, \
+			   delay_us, timeout_us)
+#define snd_hdac_adsp_readl_poll(adev, reg, val, cond, delay_us, timeout_us) \
+	readl_poll_timeout((adev)->dsp_ba + (reg), val, cond, \
+			   delay_us, timeout_us)
+#define snd_hdac_adsp_readq_poll(adev, reg, val, cond, delay_us, timeout_us) \
+	readq_poll_timeout((adev)->dsp_ba + (reg), val, cond, \
+			   delay_us, timeout_us)
+
 #endif /* __SOUND_SOC_INTEL_AVS_REGS_H */
diff --git a/sound/soc/intel/avs/skl.c b/sound/soc/intel/avs/skl.c
index 34f859d6e5a49..d66ef000de9ee 100644
--- a/sound/soc/intel/avs/skl.c
+++ b/sound/soc/intel/avs/skl.c
@@ -12,6 +12,7 @@
 #include "avs.h"
 #include "cldma.h"
 #include "messages.h"
+#include "registers.h"
 
 void avs_skl_ipc_interrupt(struct avs_dev *adev)
 {
-- 
2.39.5




