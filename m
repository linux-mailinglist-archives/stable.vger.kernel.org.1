Return-Path: <stable+bounces-140900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA03AAAC68
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC661BA63F1
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2017C2FD1A7;
	Mon,  5 May 2025 23:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6M5T5rV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E99D38AF47;
	Mon,  5 May 2025 23:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486781; cv=none; b=eqaFRbDajvKw0jH93NCS1gfAaCL2XMQ5LSQwzjXA4Hyq0DRpIm5aoJssDQLDR6aZVXJoFQhB0NPXGAoN8igmeVUFRMoYI5ayhqYZJQNf2QjIdHLmr3ZxB6ZkTHjGj07l6pndAoNDEpxrADcU5VjrKGBLFlHEZcvGhwTOaFy7SEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486781; c=relaxed/simple;
	bh=xnvKQSgmz6+WJmoTJIO0JKQ6WIu8i0r+uXotJHnnevk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eml5TqufsFOUR6FG3GtMp2sLYkSbgdsY2Oje1LXSRxUT3XImRVVuEzhdlxcUrPxJwEnjy2pPEbwUssIPDVswFkceufWlBddi8eRUyRTJ51AQDy9RAgvDcJ42J1t4suxdqaS6LX1qHkhMeY4SjJHslrpOz2JqU8l8Hqn5eJEebdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6M5T5rV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2A0C4CEE4;
	Mon,  5 May 2025 23:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486781;
	bh=xnvKQSgmz6+WJmoTJIO0JKQ6WIu8i0r+uXotJHnnevk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H6M5T5rVB+PoESIleVi7WQKxJrDz7yCKPSICfRP5mgweneRQ5kGIWJce+wuvU0syW
	 yEMfX0YgpThWZplgSCGjwmmtD434X8UjLHNGDE7Sg+ny27NYKesrQ73SwOKn/Btwau
	 +y0qasYisuimPS5vK7wLWLnwfDqEd7Pck9gxLmWaCTDbHM1KdHxJTyRZBwDzgDJ6bf
	 YFCaZ3FidvkWXYYIHo1bkLKSYJSLXPT/Vd42UAZHsB++aS7FIa2tyniPq/hdxg8JqR
	 mOfxs9h/zuT6MXN0172BK1MGau6yI5BN8DKGsLrAhbiPDEaUquPeUwu2Wl4bsbo52t
	 Vi5ThCD3E8QOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 200/212] ASoC: codecs: pcm3168a: Allow for 24-bit in provider mode
Date: Mon,  5 May 2025 19:06:12 -0400
Message-Id: <20250505230624.2692522-200-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit 7d92a38d67e5d937b64b20aa4fd14451ee1772f3 ]

As per codec device specification, 24-bit is allowed in provider mode.
Update the code to reflect that.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://patch.msgid.link/20250203141051.2361323-4-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/pcm3168a.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 9d6431338fb71..329549936bd5c 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -494,9 +494,9 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 		}
 		break;
 	case 24:
-		if (provider_mode || (format == SND_SOC_DAIFMT_DSP_A) ||
-		    		     (format == SND_SOC_DAIFMT_DSP_B)) {
-			dev_err(component->dev, "24-bit slots not supported in provider mode, or consumer mode using DSP\n");
+		if (!provider_mode && ((format == SND_SOC_DAIFMT_DSP_A) ||
+				       (format == SND_SOC_DAIFMT_DSP_B))) {
+			dev_err(component->dev, "24-bit slots not supported in consumer mode using DSP\n");
 			return -EINVAL;
 		}
 		break;
-- 
2.39.5


