Return-Path: <stable+bounces-133939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 590F6A928B0
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D66F3B6E2F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3E02586FB;
	Thu, 17 Apr 2025 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KEoivC6M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258E6255E34;
	Thu, 17 Apr 2025 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914605; cv=none; b=XNqgqFCTKyU8oDVRRuG2vLWyXLHwqqu7SPkNH0AmagUAAoV2GZLvEn483kET1Rshv86hQMW1/nSgGVe9Hp2POPeCKbxSUrNcLUNPkSmBUc2o3fFxS8otDi/pNCvIBU4YnviGL/NBu4biPB2lm6gW4u+J2BjqvwvkJXDxMFKTtOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914605; c=relaxed/simple;
	bh=xSQR6p6N/D2jnEB9gUMe5Tkpqoc7SkrBDKdJ7rKoNm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2V7FBL4KB02EWMlD0O54ZdxTRoO4VXYJMzSUlEax04gW/rEU8P3vyAN3p9D94QP2qy+rsc++Tiv85Ob4i/4cG+nFt8DADMICS2M6HDNGwBE9f3nDppNkUAu64Cn/CZBBZDbUr1C7z4rbEgD1TZOCC4KGdeU/6WzAQokPkVzzqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KEoivC6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A2BC4CEE4;
	Thu, 17 Apr 2025 18:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914605;
	bh=xSQR6p6N/D2jnEB9gUMe5Tkpqoc7SkrBDKdJ7rKoNm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KEoivC6MmLKXMDVAXfVzGO4TCvSoI6f4wbE8rFB6zf/k36g9ZX7Q74skU6vmuAfrh
	 5pmwCrpxHPWUx+jhSeAkVHSqKkQX3tuvkRd91o9f3Zvj+hhqtBIjETZB6ufTwl53mu
	 H7VYujkkk5q/Jx+M6aeMjrFQiLmr9v2j7pKUfPUA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.13 270/414] ASoC: qdsp6: q6apm-dai: set 10 ms period and buffer alignment.
Date: Thu, 17 Apr 2025 19:50:28 +0200
Message-ID: <20250417175122.286292350@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
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

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

commit 3107019501842c27334554ba9d6583b1f200f61f upstream.

DSP expects the periods to be aligned to fragment sizes, currently
setting up to hw constriants on periods bytes is not going to work
correctly as we can endup with periods sizes aligned to 32 bytes however
not aligned to fragment size.

Update the constriants to use fragment size, and also set at step of
10ms for period size to accommodate DSP requirements of 10ms latency.

Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://patch.msgid.link/20250314174800.10142-5-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -385,13 +385,14 @@ static int q6apm_dai_open(struct snd_soc
 		}
 	}
 
-	ret = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
+	/* setup 10ms latency to accommodate DSP restrictions */
+	ret = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 480);
 	if (ret < 0) {
 		dev_err(dev, "constraint for period bytes step ret = %d\n", ret);
 		goto err;
 	}
 
-	ret = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
+	ret = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 480);
 	if (ret < 0) {
 		dev_err(dev, "constraint for buffer bytes step ret = %d\n", ret);
 		goto err;



