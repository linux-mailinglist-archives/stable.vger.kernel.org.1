Return-Path: <stable+bounces-118828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45582A41CC4
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FDA23BB767
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9E1266B59;
	Mon, 24 Feb 2025 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iecviivd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5898266B54;
	Mon, 24 Feb 2025 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395917; cv=none; b=HMcLPXK6446Soo20l2r7jrmbPFvdO6fjgw7M1BdBPV/JHPbVBAW2sf+V+c8jrnuh9GiqO6XFPHfezXyUZlcYO2OMvd4nRj1k1hOUlnmbCRjWu6ybj515qh3XIOJE3sR+wBSbqc1jH8U3gR1dSTDFxMKSzy0LFuu61/cDQdITiNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395917; c=relaxed/simple;
	bh=+HAC7k6YZOCVFJ979Fgkq7mKAvX7xlTKHXw3uyvmlRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SV++i8VAJ/K363PcsOJtWw+Bn7/ntPjQZz/Sy3GySZOE/KQtule3HGAOUhtMwi+53qlQ5RIL0tnkEpprqzKUtY8CNgDxqJKA2BNLdcx+KKXhUznu2m/d1FPCSujZtM7BwwTPuttfrUDqiqajDyhESCys3viEL0WCc9v/fhhmRbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iecviivd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC674C4CED6;
	Mon, 24 Feb 2025 11:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395917;
	bh=+HAC7k6YZOCVFJ979Fgkq7mKAvX7xlTKHXw3uyvmlRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iecviivdPp28m4HAkiU1LjHGnSsDZmBCRAPmQKiLiNvFGWbmU+JDzPatRRb1WpiUZ
	 NxrgXAfzuY2aWIIZemwcoFBrYQC0ECsNZwhkTNCFy1rXAuB4Z7HYi7ZQpbFPzXOYep
	 saoZy+Qab1f2LkXXUuy94EpDYEIkWIAuw1gRNykc0S8B4BM6L2NnDHCDtc4OuvjKSA
	 L7hG35USzagR0vOweaK7T7JOoF3ET4Vgep//+8JNCaJaKyWy1ZvyWmoWHMz1lDd0uI
	 115V3cNAXWarE/Bw1dv6GxO16039dhHEHYZVhMPy9A8179tbn5PJVWE76vKsJkb3Yx
	 QpmEweaytF1dA==
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
Subject: [PATCH AUTOSEL 6.12 12/28] ASoC: SOF: Intel: hda: add softdep pre to snd-hda-codec-hdmi module
Date: Mon, 24 Feb 2025 06:17:43 -0500
Message-Id: <20250224111759.2213772-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111759.2213772-1-sashal@kernel.org>
References: <20250224111759.2213772-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.16
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
index dc46888faa0dc..c0c58b4297155 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -454,6 +454,7 @@ int hda_codec_i915_exit(struct snd_sof_dev *sdev)
 }
 EXPORT_SYMBOL_NS_GPL(hda_codec_i915_exit, SND_SOC_SOF_HDA_AUDIO_CODEC_I915);
 
+MODULE_SOFTDEP("pre: snd-hda-codec-hdmi");
 #endif
 
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.39.5


