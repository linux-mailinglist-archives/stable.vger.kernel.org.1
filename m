Return-Path: <stable+bounces-154434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 886E8ADD9F2
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6904A7C86
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE017285060;
	Tue, 17 Jun 2025 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nPQt9+rM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CB22FA65C;
	Tue, 17 Jun 2025 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179179; cv=none; b=FvAVEcFEQkL85AY4C36MMFQAtVI5W9c8MiEhyUgl5I1JmFZLC01QlV//67k1pYUOsyoVZ63BJG8D8XslFQS34mXe15zConm5UXIamKXs2QMVbEnj5T4s7kBUKhTpC0FEj/yZuIkIpGz6Hx6J/Hok3wL2Y9JoAn9+LLqBJNeqm2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179179; c=relaxed/simple;
	bh=u8F0mFhHl0Kus2PCIer0L6aBTwhf+dx8rDbhUZFU+co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkVvqBNwqceDWT22bbLRlLNSQFoErJGyf3Xm84ByaBma3EEygDb3qRez2UxvdOl4e0VCxd4y65MqcTwAihuZ1C2sjJIEyFt0Ei4yy7YqCZ0N6rPWqTfVdqBn5A4EtmQ7NAnqV9QKPxBvyeZ9gSu6y6BGey3sFsxz+BdIoApH9k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nPQt9+rM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA6DC4CEE3;
	Tue, 17 Jun 2025 16:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750179179;
	bh=u8F0mFhHl0Kus2PCIer0L6aBTwhf+dx8rDbhUZFU+co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nPQt9+rMw+EBXssXGCd5Vlr+LuaKaYPVRG9haO9tQ2J8Vu2SxoCaxH9JZ5u8ynSU5
	 Fuk87f0NOvapjhmua2KAcUhY4jjkuqKY2eVG8vYWxzKujcZ0qytdhLYk3gmPtBTSLm
	 A41FfGFFbUCJemlKCH00mZcwQS2Oj9gKalZqttz8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 642/780] ASoC: Intel: avs: Read HW capabilities when possible
Date: Tue, 17 Jun 2025 17:25:50 +0200
Message-ID: <20250617152517.624743248@linuxfoundation.org>
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

[ Upstream commit b9a3ec604993074eb6f5d08b14fb7913d1fae48b ]

Starting with LunarLake (LNL) and onward, some hardware capabilities are
visible to the sound driver directly. At the same time, these may no
longer be visible to the AudioDSP firmware. Update resource allocation
function to rely on the registers when possible.

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Link: https://patch.msgid.link/20250407112352.3720779-4-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 9e3285be55e6 ("ASoC: Intel: avs: Fix paths in MODULE_FIRMWARE hints")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/hdaudio_ext.h         | 1 +
 sound/hda/ext/hdac_ext_controller.c | 1 +
 sound/soc/intel/avs/avs.h           | 1 +
 sound/soc/intel/avs/loader.c        | 9 +++++++++
 4 files changed, 12 insertions(+)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 60ec12e3b72f8..7de390022ac26 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -99,6 +99,7 @@ struct hdac_ext_link {
 	u32 lcaps;   /* link capablities */
 	u16 lsdiid;  /* link sdi identifier */
 	u32 id;
+	u8 slcount;
 
 	int ref_count;
 
diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index 2ec1531d1c1b5..c84754434d162 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -98,6 +98,7 @@ int snd_hdac_ext_bus_get_ml_capabilities(struct hdac_bus *bus)
 					(AZX_ML_INTERVAL * idx);
 		hlink->lcaps  = readl(hlink->ml_addr + AZX_REG_ML_LCAP);
 		hlink->lsdiid = readw(hlink->ml_addr + AZX_REG_ML_LSDIID);
+		hlink->slcount = FIELD_GET(AZX_ML_HDA_LCAP_SLCOUNT, hlink->lcaps) + 1;
 
 		if (hdac_ext_link_alt(hlink)) {
 			leptr = readl(hlink->ml_addr + AZX_REG_ML_LEPTR);
diff --git a/sound/soc/intel/avs/avs.h b/sound/soc/intel/avs/avs.h
index 91872d1df97a5..201897c5bdc04 100644
--- a/sound/soc/intel/avs/avs.h
+++ b/sound/soc/intel/avs/avs.h
@@ -73,6 +73,7 @@ extern const struct avs_dsp_ops avs_tgl_dsp_ops;
 #define AVS_PLATATTR_CLDMA		BIT_ULL(0)
 #define AVS_PLATATTR_IMR		BIT_ULL(1)
 #define AVS_PLATATTR_ACE		BIT_ULL(2)
+#define AVS_PLATATTR_ALTHDA		BIT_ULL(3)
 
 #define avs_platattr_test(adev, attr) \
 	((adev)->spec->attributes & AVS_PLATATTR_##attr)
diff --git a/sound/soc/intel/avs/loader.c b/sound/soc/intel/avs/loader.c
index 0b29941feb0ef..ecf050c2c0c7f 100644
--- a/sound/soc/intel/avs/loader.c
+++ b/sound/soc/intel/avs/loader.c
@@ -683,6 +683,7 @@ int avs_dsp_boot_firmware(struct avs_dev *adev, bool purge)
 
 static int avs_dsp_alloc_resources(struct avs_dev *adev)
 {
+	struct hdac_ext_link *link;
 	int ret, i;
 
 	ret = avs_ipc_get_hw_config(adev, &adev->hw_cfg);
@@ -693,6 +694,14 @@ static int avs_dsp_alloc_resources(struct avs_dev *adev)
 	if (ret)
 		return AVS_IPC_RET(ret);
 
+	/* If hw allows, read capabilities directly from it. */
+	if (avs_platattr_test(adev, ALTHDA)) {
+		link = snd_hdac_ext_bus_get_hlink_by_id(&adev->base.core,
+							AZX_REG_ML_LEPTR_ID_INTEL_SSP);
+		if (link)
+			adev->hw_cfg.i2s_caps.ctrl_count = link->slcount;
+	}
+
 	adev->core_refs = devm_kcalloc(adev->dev, adev->hw_cfg.dsp_cores,
 				       sizeof(*adev->core_refs), GFP_KERNEL);
 	adev->lib_names = devm_kcalloc(adev->dev, adev->fw_cfg.max_libs_count,
-- 
2.39.5




