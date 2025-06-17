Return-Path: <stable+bounces-154435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4205ADDA38
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735DD19E0BFF
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4103285041;
	Tue, 17 Jun 2025 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C6pfljjy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CE72FA65C;
	Tue, 17 Jun 2025 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179182; cv=none; b=MUB93R3bwjv5tOxRhbunO6DbQ17pjE+f/cHx9X7khpGU1QLejXIPWvxMoZaLlYilZXujswytNBZvWQYpYzaCB9VF3LqytMk/7GuKn74jVyD8ek1gJgMAUOqiqgxYLd5w6a/L8DjD28Qx97HxEJO0RuDWlRWYD7WUsK1z1Mdd6RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179182; c=relaxed/simple;
	bh=Qr+RkGxFyVzgtzcnqg4lx9l01oBcZAIvrM75smWdCIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ed5kDTKVJw5/eS+VmieUssoVuSM3XAdQ3ydyrQYruFXYmIzUImrdXhv+YT+2zHW7fJ/stmX1+Kk7em4PPArRgghY+h80/pnfebhW5pK9U6TDbE0AwaE+2rvu5bsK010lharQF4mG96TcIz0QKk9wwfD3gs2RZk0PUmU2TmjdQb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C6pfljjy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7B1C4CEE3;
	Tue, 17 Jun 2025 16:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750179182;
	bh=Qr+RkGxFyVzgtzcnqg4lx9l01oBcZAIvrM75smWdCIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C6pfljjyoIFV4okvZVYsaw1z8iGa3tpcPGlBaqUw2Sw4rOohm9CkCkJ1taLXNYXRj
	 iEckrtW1eHJnxmssgQln0WCstpvYlLy01AyOsaqX5nKxZNBcS4fcnNbd+sbPyoMdON
	 YfSsMQI+Jq4ib+/LSlTnfdrJR2keJ67IzXfqoclI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 643/780] ASoC: Intel: avs: Relocate DSP status registers
Date: Tue, 17 Jun 2025 17:25:51 +0200
Message-ID: <20250617152517.664692948@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit 75f3c607b1fa1f4d42cde8377cd2276ab01e287d ]

The firmware status and error registers are not part of SRAM on ACE
platforms. As these registers take part in IPC on ACE and cAVS platforms
both, relocate the field denoting their offset to Host-IPC descriptor.

In consequence, code remains cohesive with the ACE specs while still
maintaining high readability for the cAVS platforms.

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Link: https://patch.msgid.link/20250407112352.3720779-5-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 9e3285be55e6 ("ASoC: Intel: avs: Fix paths in MODULE_FIRMWARE hints")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/avs/avs.h       |  2 +-
 sound/soc/intel/avs/core.c      | 18 +++++++++++++++---
 sound/soc/intel/avs/loader.c    |  2 +-
 sound/soc/intel/avs/registers.h |  2 +-
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/avs/avs.h b/sound/soc/intel/avs/avs.h
index 201897c5bdc04..ec5502f9d5cb1 100644
--- a/sound/soc/intel/avs/avs.h
+++ b/sound/soc/intel/avs/avs.h
@@ -81,7 +81,6 @@ extern const struct avs_dsp_ops avs_tgl_dsp_ops;
 struct avs_sram_spec {
 	const u32 base_offset;
 	const u32 window_size;
-	const u32 rom_status_offset;
 };
 
 struct avs_hipc_spec {
@@ -93,6 +92,7 @@ struct avs_hipc_spec {
 	const u32 rsp_offset;
 	const u32 rsp_busy_mask;
 	const u32 ctl_offset;
+	const u32 sts_offset;
 };
 
 /* Platform specific descriptor */
diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
index 72a14dca1a1ed..1495e163d47ef 100644
--- a/sound/soc/intel/avs/core.c
+++ b/sound/soc/intel/avs/core.c
@@ -755,13 +755,11 @@ static const struct dev_pm_ops avs_dev_pm = {
 static const struct avs_sram_spec skl_sram_spec = {
 	.base_offset = SKL_ADSP_SRAM_BASE_OFFSET,
 	.window_size = SKL_ADSP_SRAM_WINDOW_SIZE,
-	.rom_status_offset = SKL_ADSP_SRAM_BASE_OFFSET,
 };
 
 static const struct avs_sram_spec apl_sram_spec = {
 	.base_offset = APL_ADSP_SRAM_BASE_OFFSET,
 	.window_size = APL_ADSP_SRAM_WINDOW_SIZE,
-	.rom_status_offset = APL_ADSP_SRAM_BASE_OFFSET,
 };
 
 static const struct avs_hipc_spec skl_hipc_spec = {
@@ -773,6 +771,19 @@ static const struct avs_hipc_spec skl_hipc_spec = {
 	.rsp_offset = SKL_ADSP_REG_HIPCT,
 	.rsp_busy_mask = SKL_ADSP_HIPCT_BUSY,
 	.ctl_offset = SKL_ADSP_REG_HIPCCTL,
+	.sts_offset = SKL_ADSP_SRAM_BASE_OFFSET,
+};
+
+static const struct avs_hipc_spec apl_hipc_spec = {
+	.req_offset = SKL_ADSP_REG_HIPCI,
+	.req_ext_offset = SKL_ADSP_REG_HIPCIE,
+	.req_busy_mask = SKL_ADSP_HIPCI_BUSY,
+	.ack_offset = SKL_ADSP_REG_HIPCIE,
+	.ack_done_mask = SKL_ADSP_HIPCIE_DONE,
+	.rsp_offset = SKL_ADSP_REG_HIPCT,
+	.rsp_busy_mask = SKL_ADSP_HIPCT_BUSY,
+	.ctl_offset = SKL_ADSP_REG_HIPCCTL,
+	.sts_offset = APL_ADSP_SRAM_BASE_OFFSET,
 };
 
 static const struct avs_hipc_spec cnl_hipc_spec = {
@@ -784,6 +795,7 @@ static const struct avs_hipc_spec cnl_hipc_spec = {
 	.rsp_offset = CNL_ADSP_REG_HIPCTDR,
 	.rsp_busy_mask = CNL_ADSP_HIPCTDR_BUSY,
 	.ctl_offset = CNL_ADSP_REG_HIPCCTL,
+	.sts_offset = APL_ADSP_SRAM_BASE_OFFSET,
 };
 
 static const struct avs_spec skl_desc = {
@@ -803,7 +815,7 @@ static const struct avs_spec apl_desc = {
 	.core_init_mask = 3,
 	.attributes = AVS_PLATATTR_IMR,
 	.sram = &apl_sram_spec,
-	.hipc = &skl_hipc_spec,
+	.hipc = &apl_hipc_spec,
 };
 
 static const struct avs_spec cnl_desc = {
diff --git a/sound/soc/intel/avs/loader.c b/sound/soc/intel/avs/loader.c
index ecf050c2c0c7f..138e4e9de5e30 100644
--- a/sound/soc/intel/avs/loader.c
+++ b/sound/soc/intel/avs/loader.c
@@ -310,7 +310,7 @@ avs_hda_init_rom(struct avs_dev *adev, unsigned int dma_id, bool purge)
 	}
 
 	/* await ROM init */
-	ret = snd_hdac_adsp_readl_poll(adev, spec->sram->rom_status_offset, reg,
+	ret = snd_hdac_adsp_readl_poll(adev, spec->hipc->sts_offset, reg,
 				       (reg & 0xF) == AVS_ROM_INIT_DONE ||
 				       (reg & 0xF) == APL_ROM_FW_ENTERED,
 				       AVS_ROM_INIT_POLLING_US, APL_ROM_INIT_TIMEOUT_US);
diff --git a/sound/soc/intel/avs/registers.h b/sound/soc/intel/avs/registers.h
index 368ede05f2cda..4db0cdf68ffc7 100644
--- a/sound/soc/intel/avs/registers.h
+++ b/sound/soc/intel/avs/registers.h
@@ -74,7 +74,7 @@
 #define APL_ADSP_SRAM_WINDOW_SIZE	0x20000
 
 /* Constants used when accessing SRAM, space shared with firmware */
-#define AVS_FW_REG_BASE(adev)		((adev)->spec->sram->base_offset)
+#define AVS_FW_REG_BASE(adev)		((adev)->spec->hipc->sts_offset)
 #define AVS_FW_REG_STATUS(adev)		(AVS_FW_REG_BASE(adev) + 0x0)
 #define AVS_FW_REG_ERROR(adev)		(AVS_FW_REG_BASE(adev) + 0x4)
 
-- 
2.39.5




