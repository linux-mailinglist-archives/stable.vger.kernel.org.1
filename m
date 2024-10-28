Return-Path: <stable+bounces-88990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA719B2D6F
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A856FB22395
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04891DA305;
	Mon, 28 Oct 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7zMHIbh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E251D9A5F;
	Mon, 28 Oct 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112676; cv=none; b=qYbvnkhvaEoMt/IgWfXLm+B5RxfITz7GDAt8kVUAcaoa8QVmDgCpfDv8LFxko9q893RlCs//Zv3NsoH4rou9yldFfI4H+vrDa2WsRvEhP9PBBKMkZjCp8sy755MfvnHgTJCsGJ07nJPU8jwr3Pfv/VJZYmp5gjk92dUtC6Pva8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112676; c=relaxed/simple;
	bh=q/7B5UkUwxsKSAS5zNbEG6EmvpsAzJMXESkMUEaYKGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOakMQTsMNHNaYO/utpNilVQZSfJ8H+WK1+EjhyQDuDqUgzQJ1x5Ed11D4/rw1bjkSMNc2xD7eFZW6h6WGpH3KgXRi22MbtP2lAOtmiDGkbPA5OnoEoPcZyYigptGD558dSfL5YlZ7Ml5ZeTmHoF4GwGEgXp29OX6BjVhpdUJnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7zMHIbh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FEAC4CEE4;
	Mon, 28 Oct 2024 10:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112676;
	bh=q/7B5UkUwxsKSAS5zNbEG6EmvpsAzJMXESkMUEaYKGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m7zMHIbhFBdktIVaaS4aKJC9CULSJYyaQQvnOL00QguChn6FO0Kn4RAibaQ+dU/uS
	 n7x1eqg5DO8KMez9d9qnstAWJKNpxummdJHDT2PLTVrzuJ+Qc6tHEnIBIWtcCbJ0LK
	 BeHXQa+6yClUraQJVwdRS0HX3Is0gfNr0NCSzl+nsoNM7FTQ4LJCqK7m8IBFsW9+Be
	 VKZKfi7HdFgSfwLgXaYfVhsgirlHNrxnmo5Op7WqkJA7hU6qNBoF9O90uq8rKyGWGm
	 +xGlfV1z9u2yFt3uTbC+AJp+YLq7r5lFC2524/VAiz66zDDxRESGobpDhL6uOlox7L
	 X858WJFCnatrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 08/32] soundwire: intel_ace2x: Send PDI stream number during prepare
Date: Mon, 28 Oct 2024 06:49:50 -0400
Message-ID: <20241028105050.3559169-8-sashal@kernel.org>
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

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

[ Upstream commit c78f1e15e46ac82607eed593b22992fd08644d96 ]

In the case of a prepare callback after an xrun or when the PCM is
restarted after a call to snd_pcm_drain/snd_pcm_drop, avoid
reprogramming the SHIM registers but send the PDI stream number so that
the link DMA data can be set. This is needed for the case that the DMA
data is cleared when the PCM is stopped and restarted without being
closed.

Link: https://github.com/thesofproject/sof/issues/9502
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
All: stable@vger.kernel.org # 6.10.x 6.11.x
Link: https://patch.msgid.link/20241016032910.14601-4-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/intel_ace2x.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 781fe0aefa68f..655766af2ea56 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -376,11 +376,12 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 static int intel_prepare(struct snd_pcm_substream *substream,
 			 struct snd_soc_dai *dai)
 {
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_cdns_dai_runtime *dai_runtime;
+	struct snd_pcm_hw_params *hw_params;
 	int ch, dir;
-	int ret = 0;
 
 	dai_runtime = cdns->dai_runtime_array[dai->id];
 	if (!dai_runtime) {
@@ -389,12 +390,8 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 		return -EIO;
 	}
 
+	hw_params = &rtd->dpcm[substream->stream].hw_params;
 	if (dai_runtime->suspended) {
-		struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
-		struct snd_pcm_hw_params *hw_params;
-
-		hw_params = &rtd->dpcm[substream->stream].hw_params;
-
 		dai_runtime->suspended = false;
 
 		/*
@@ -415,15 +412,11 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 		/* the SHIM will be configured in the callback functions */
 
 		sdw_cdns_config_stream(cdns, ch, dir, dai_runtime->pdi);
-
-		/* Inform DSP about PDI stream number */
-		ret = intel_params_stream(sdw, substream, dai,
-					  hw_params,
-					  sdw->instance,
-					  dai_runtime->pdi->intel_alh_id);
 	}
 
-	return ret;
+	/* Inform DSP about PDI stream number */
+	return intel_params_stream(sdw, substream, dai, hw_params, sdw->instance,
+				   dai_runtime->pdi->intel_alh_id);
 }
 
 static int
-- 
2.43.0


