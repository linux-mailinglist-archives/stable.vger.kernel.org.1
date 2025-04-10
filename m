Return-Path: <stable+bounces-132096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB15A843B3
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 14:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790CD442A14
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 12:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA212857D6;
	Thu, 10 Apr 2025 12:50:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E4E2857E1;
	Thu, 10 Apr 2025 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744289436; cv=none; b=IogDotDpCkZRvqqUEXtuqCoKiUAGRiOIiTN0IssNqs1rmWV5HGaDnk18pBEg7sZlWGd3guBRAsCdERWU4dh9klSO6HB1rQLKEuBAFHTqVgoPHvOJoEtoqCykEaOBTQnePe91yf6Fd8mvBKEIQTU8+GvOaTHKVBrOfvePau5ZUJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744289436; c=relaxed/simple;
	bh=JZTtl48+x7XX/RdiGVmTjwgBC0HZ67XGcxpWFr/A1pU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dipjSH5Lu/ewkb+dqGvHi9FoS0gyP6W67V6+sUxwi4r0jTw2gdtnCRfBtp8f/jeJAS8Zrz4ojHBfWj0UUWdnVH59np/eFEippdMQJUeTXOxZpgyfGUOXhHII//oKjwURz6y2Effa7A+oJ4qdnJUDZqCrcCHPaY/Se0jbVr32q20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4ZYJsP6tlKz9vL4;
	Thu, 10 Apr 2025 14:24:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W6XqfgGmjU73; Thu, 10 Apr 2025 14:24:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4ZYJsP68B3z9s2l;
	Thu, 10 Apr 2025 14:24:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CD0BE8B764;
	Thu, 10 Apr 2025 14:24:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id q8ya75z2-d-G; Thu, 10 Apr 2025 14:24:25 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 382C08B763;
	Thu, 10 Apr 2025 14:24:25 +0200 (CEST)
Message-ID: <66bccfab-66f0-4e67-8c81-24de09b85a81@csgroup.eu>
Date: Thu, 10 Apr 2025 14:24:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: fsl: fsl_qmc_audio: Reset audio data pointers on
 TRIGGER_START event
To: Herve Codina <herve.codina@bootlin.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
References: <20250410091643.535627-1-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250410091643.535627-1-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 10/04/2025 à 11:16, Herve Codina a écrit :
> On SNDRV_PCM_TRIGGER_START event, audio data pointers are not reset.
> 
> This leads to wrong data buffer usage when multiple TRIGGER_START are
> received and ends to incorrect buffer usage between the user-space and
> the driver. Indeed, the driver can read data that are not already set by
> the user-space or the user-space and the driver are writing and reading
> the same area.
> 
> Fix that resetting data pointers on each SNDRV_PCM_TRIGGER_START events.
> 
> Fixes: 075c7125b11c ("ASoC: fsl: Add support for QMC audio")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>


Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>


Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>



> ---
>   sound/soc/fsl/fsl_qmc_audio.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_qmc_audio.c b/sound/soc/fsl/fsl_qmc_audio.c
> index b2979290c973..5614a8b909ed 100644
> --- a/sound/soc/fsl/fsl_qmc_audio.c
> +++ b/sound/soc/fsl/fsl_qmc_audio.c
> @@ -250,6 +250,9 @@ static int qmc_audio_pcm_trigger(struct snd_soc_component *component,
>   	switch (cmd) {
>   	case SNDRV_PCM_TRIGGER_START:
>   		bitmap_zero(prtd->chans_pending, 64);
> +		prtd->buffer_ended = 0;
> +		prtd->ch_dma_addr_current = prtd->ch_dma_addr_start;
> +
>   		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>   			for (i = 0; i < prtd->channels; i++)
>   				prtd->qmc_dai->chans[i].prtd_tx = prtd;


