Return-Path: <stable+bounces-118798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E47DCA41C6F
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22CC87A9CAC
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B68625EFB9;
	Mon, 24 Feb 2025 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6PeN0c9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B5E25EFB4;
	Mon, 24 Feb 2025 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395839; cv=none; b=RoFfy6/7kkzkeWlwYBeaRCdX+sloQ2pCj/C4ZgT1e68I7G0EPkDJAVvEgML1geUDf2CGSWSby0oFR988gy0MRfLGTBzadsoqxnx0Vx3btq4jL4FNRKPcMG4wGrsju9pOKwJifozz0rji2w/OAsGlRAexxdiUUJljgYy0OuhBmMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395839; c=relaxed/simple;
	bh=2nhtH0H8AIroL5FXjfMPwHjzqT4ySWaNy6Dvnhg90BU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFxsZnHuSeJp6/VDQmJC87CSAbjBMlM8IRPRCRa+fDFl9OKcDY7nKRgHUDex8V2xx7MDuanPVDN/dWblBTDtMh6HXriZOrFTWY2C5ssWi1/SL3K/BHZPLWVONmSgsu3127sJL29GZZwbV1tHwExgUDDbaECaRW0DDa52BDY5paA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6PeN0c9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37038C4CED6;
	Mon, 24 Feb 2025 11:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395838;
	bh=2nhtH0H8AIroL5FXjfMPwHjzqT4ySWaNy6Dvnhg90BU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6PeN0c9Z1q+yjUF94Z7Bn9ezPYjDnRrNCyH2hZculOvByGbyDCTHRNHzTAS3B2Hd
	 9PKTDhKVj0Y8beYQQSwkAPuuQd6Sx70xcohTSK9vpSIkkUpNEoxYVI73I/9/J9sApn
	 dq1/CkCtGwQa10X/CAHjrFt2dy5e7WcEcBndOiNcCnDNNZI9RA8ofLd2P46rTBND1P
	 DwigvLJej0k/Rt+j6VtEOJVTxani6QvS+3je53DNrKMUCI8x+IadwSX9f3UeWbjECw
	 QJqFasqViTHHVZso+2mYnr5FZmk/xn5fMv/B7F45Ye8IWkswqcn9/XYAAbHZ8bwc0Q
	 JcTIF/zJR4hiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Terry Cheong <htcheong@chromium.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Johny Lin <lpg76627@gmail.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	peterz@infradead.org,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 14/32] ASoC: SOF: Intel: hda: add softdep pre to snd-hda-codec-hdmi module
Date: Mon, 24 Feb 2025 06:16:20 -0500
Message-Id: <20250224111638.2212832-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111638.2212832-1-sashal@kernel.org>
References: <20250224111638.2212832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.4
Content-Transfer-Encoding: 8bit

From: Terry Cheong <htcheong@chromium.org>

[ Upstream commit 33b7dc7843dbdc9b90c91d11ba30b107f9138ffd ]

In enviornment without KMOD requesting module may fail to load
snd-hda-codec-hdmi, resulting in HDMI audio not usable.
Add softdep to loading HDMI codec module first to ensure we can load it
correctly.

Signed-off-by: Terry Cheong <htcheong@chromium.org>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Johny Lin <lpg76627@gmail.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20250206094723.18013-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 568f3dfe822f5..2f9925830d1d5 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -454,6 +454,7 @@ int hda_codec_i915_exit(struct snd_sof_dev *sdev)
 }
 EXPORT_SYMBOL_NS_GPL(hda_codec_i915_exit, "SND_SOC_SOF_HDA_AUDIO_CODEC_I915");
 
+MODULE_SOFTDEP("pre: snd-hda-codec-hdmi");
 #endif
 
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.39.5


