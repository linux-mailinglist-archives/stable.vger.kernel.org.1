Return-Path: <stable+bounces-26-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD597F5BA6
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 10:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0236B21034
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC4722307;
	Thu, 23 Nov 2023 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxK873z9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D4A2136F;
	Thu, 23 Nov 2023 09:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289A2C433C7;
	Thu, 23 Nov 2023 09:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700732904;
	bh=pELa/XBC4kyNB8u1kflNMwjk+/SZYf22SC/MJTU/Rms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bxK873z9MGKN+nmq7GNaEn6JO+vbS23uhNOuHBYtn5pW+6Zhvxue4XVghRVMlLP2c
	 TYPorzPHbuwejVJeh9Zlm92q3PPrbn6NZAn/GmRWHh5CGzFp0xRLLL11TqD2H1Mplc
	 FTxpxigrVZaO7MA4/NwxA55dNd1LNTNxeCUONavU7TQjsOx8/ZJr2OHF/KPNP10jgB
	 fmCdrxQ7EFo9TnZGBPPC/jRYcKw5bCa4FInNkZ/d4HQAWqiOtd+fOEnior3W9kqeBo
	 BUDGFjZY1WJU5YMgmU7OblNhy9tGz0b+joEyoOuzH9BoZECYM1ADMdqX7tpX88YiqN
	 m0jFhTOvHKJwA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1r66K9-0005KS-2V;
	Thu, 23 Nov 2023 10:48:41 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH stable-6.6 2/2] ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag
Date: Thu, 23 Nov 2023 10:47:49 +0100
Message-ID: <20231123094749.20462-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123094749.20462-1-johan+linaro@kernel.org>
References: <20231123094749.20462-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

commit 805ce81826c896dd3c351a32814b28557f9edf54 upstream.

In the current setup the PA is left unmuted even when the
Soundwire ports are not started streaming. This can lead to click
and pop sounds during start.
There is a same issue in the reverse order where in the PA is
left unmute even after the data stream is stopped, the time
between data stream stopping and port closing is long enough
to accumulate DC on the line resulting in Click/Pop noise
during end of stream.

making use of new mute_unmute_on_trigger flag is helping a
lot with this Click/Pop issues reported on this Codec

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231027105747.32450-3-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wsa883x.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 197fae23762f..cb83c569e18d 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1203,9 +1203,6 @@ static int wsa883x_spkr_event(struct snd_soc_dapm_widget *w,
 			break;
 		}
 
-		snd_soc_component_write_field(component, WSA883X_DRE_CTL_1,
-					      WSA883X_DRE_GAIN_EN_MASK,
-					      WSA883X_DRE_GAIN_FROM_CSR);
 		if (wsa883x->port_enable[WSA883X_PORT_COMP])
 			snd_soc_component_write_field(component, WSA883X_DRE_CTL_0,
 						      WSA883X_DRE_OFFSET_MASK,
@@ -1218,9 +1215,6 @@ static int wsa883x_spkr_event(struct snd_soc_dapm_widget *w,
 		snd_soc_component_write_field(component, WSA883X_PDM_WD_CTL,
 					      WSA883X_PDM_EN_MASK,
 					      WSA883X_PDM_ENABLE);
-		snd_soc_component_write_field(component, WSA883X_PA_FSM_CTL,
-					      WSA883X_GLOBAL_PA_EN_MASK,
-					      WSA883X_GLOBAL_PA_ENABLE);
 
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
@@ -1346,6 +1340,7 @@ static const struct snd_soc_dai_ops wsa883x_dai_ops = {
 	.hw_free = wsa883x_hw_free,
 	.mute_stream = wsa883x_digital_mute,
 	.set_stream = wsa883x_set_sdw_stream,
+	.mute_unmute_on_trigger = true,
 };
 
 static struct snd_soc_dai_driver wsa883x_dais[] = {
-- 
2.41.0


