Return-Path: <stable+bounces-125075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9006FA68FBA
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D541E3BF52F
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0E11A4F0A;
	Wed, 19 Mar 2025 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eAa8ypDz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C96C1D6DBF;
	Wed, 19 Mar 2025 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394938; cv=none; b=ZGmpTOlnyAr4SKE2wArVkEsRIC75qQJAa0vxavjl1A292iWQctYPYW6B9Q8mYa4HwU0Jh0mvoCySE+m+LT8Ow2zV+0PFAjx66wRwS3IYmx84okokGBDNGXHJTR9AjA6dTjighbjTvV0np3f353GMiwTC1TsLJmEVMiNa+T1A7kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394938; c=relaxed/simple;
	bh=CvWICiI/YEW2d+jCav7w5ECqH+m9QhEJTFdSXibiZUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8muJOwiUTaRunZw3/GMgrCzTw+OyhhiDm/KGOixlvf0E1jMb1A79xe8CEdUSWcl719KMboidf+IPePqv1KlP2w4+POotUAXyTa266OLuINXM6reVpo9em7TOCl6SPxkMSfu4cJM6DGyOMf/4TiDTK8hgWNsK6I08KPbGcWT108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eAa8ypDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AF3C4CEE4;
	Wed, 19 Mar 2025 14:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742394937;
	bh=CvWICiI/YEW2d+jCav7w5ECqH+m9QhEJTFdSXibiZUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eAa8ypDzgEVu2ykAbxk7K71arPIh08Gym2zrNbyG9J00VMLRClpHSa7URLjO7OjAq
	 zWsqOoJJe4lCuwYCozqexwvQHZXYOBxH6pkQ1Mfkkahe1HTg0IytcmOEVVqO8yte9f
	 +syhh2UmL857JjyrQ5n3fuPkcXgNhidVVcCd5uJg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Terry Cheong <htcheong@chromium.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Johny Lin <lpg76627@gmail.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 116/241] ASoC: SOF: Intel: hda: add softdep pre to snd-hda-codec-hdmi module
Date: Wed, 19 Mar 2025 07:29:46 -0700
Message-ID: <20250319143030.592278235@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
References: <20250319143027.685727358@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

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




