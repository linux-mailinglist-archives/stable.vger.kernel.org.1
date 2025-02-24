Return-Path: <stable+bounces-118870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF80A41D1D
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C76067A7CDA
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4FF272920;
	Mon, 24 Feb 2025 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvKnDLGD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0A225EFB4;
	Mon, 24 Feb 2025 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396021; cv=none; b=WiC/dVkcqAGkkvUoIUunADR3N0Y5n4RRHbSFUiXdSVX0VOe/gAYieLnKWhH2+G30iNURGrQQnv1MR9eZ2vV4I3C25Zc66weo0dJG5d3ZLMto6SJ/rZzbhkCB1+Nedvyi7StykjriRVOA4L8qxnbzInIFCZQSmSl+8aKHbeHvZK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396021; c=relaxed/simple;
	bh=yDkZsLp6sk8ixW0j67bxaHGejfeKd6K1T7p1WADkGFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+v59Do5a+hFLv5V+u4TpCVFXgYJpKpk/TOKm6alEmKHnhXwV7KcKR3mOyGjT74vNe/A2aQG0VFzLbrCAns/RlcvPYmjEt8jLqcuHZqNv+QnX4o+V4cGzx+/rmmBpmFThTm+q6r32T49vnOrkM2NyiP1ZGc79q77AGzzca0/ZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvKnDLGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67539C4CEE6;
	Mon, 24 Feb 2025 11:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396021;
	bh=yDkZsLp6sk8ixW0j67bxaHGejfeKd6K1T7p1WADkGFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SvKnDLGDVQYalHRCAPjUbHSwZedyxUo2dTTM43CrC+BdlCoFEQ6s1gQSfLxVn8k4R
	 eaSHulyapgox2/fKKoiyZ5nIB9HUZqgQXPNEUEacGuQWJNouUCI80c/PX1m5xJSez2
	 AEqYCoA48t7ngM1x5ub7F15/4oK9COZzIM1A0zoSwzNuNnTBWgmu3AAVmQwgTeYIDZ
	 y5jkSHA5qKsmTA1lW2IvzM6NRQeppc1wegiZmbIKM7LXwrYlnqGYqh95AN/NS7KVWc
	 ttsPSiibYeEUY8JotVR+7KLc7Sanhcwwti19eYBw2Q8NJvdpVdMIycvQPqtcOwnoim
	 Z+pCxFabxYB3g==
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
	keqiao.zhang@intel.com,
	peterz@infradead.org,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/12] ASoC: SOF: Intel: hda: add softdep pre to snd-hda-codec-hdmi module
Date: Mon, 24 Feb 2025 06:19:54 -0500
Message-Id: <20250224112002.2214613-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112002.2214613-1-sashal@kernel.org>
References: <20250224112002.2214613-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.129
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
index a0dfd7de431fe..a75f81116643b 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -282,6 +282,7 @@ int hda_codec_i915_exit(struct snd_sof_dev *sdev)
 }
 EXPORT_SYMBOL_NS(hda_codec_i915_exit, SND_SOC_SOF_HDA_AUDIO_CODEC_I915);
 
+MODULE_SOFTDEP("pre: snd-hda-codec-hdmi");
 #endif
 
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.39.5


