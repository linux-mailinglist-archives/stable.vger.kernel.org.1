Return-Path: <stable+bounces-11336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B06D182EDF9
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 12:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6538D1F221ED
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 11:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFA21B970;
	Tue, 16 Jan 2024 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wSWDTRc4"
X-Original-To: stable@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BC31B96E;
	Tue, 16 Jan 2024 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705405257;
	bh=JKcdI+6P90fzqtpbJwc/MyIDVFU621xlChEVwvQpcvI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wSWDTRc4h3RoB6aJb9JkaUIubPW/l0F42k4R5nN4o/NVfLkFhUkjTU2CWYkdv1UYd
	 aNNArXMmjXE1brz7QPPqh1+TSFXVjaQmD2aVRJ3MgD+A4oADo3FomOfvzK04I2eB64
	 IhBKT7FZeHDsed2y7loi5DmrFA9XcxX0mYpoppHf2XTKZkZUc7vTPWPgGRKP6fDAr4
	 sJn/UUry0qtVzW0fCnjegZx/NjgDvSObzlLiDo+iSrhz0rMRsAaz/PPwkrs7brD9fQ
	 tBxV4zrc6S+vINifwMu9eiSD9oaerEWzP35JFcLv9u26n5IaKYb8gakkOyN2DDyDlX
	 mnONfMKYjt4mw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7290437802F2;
	Tue, 16 Jan 2024 11:40:56 +0000 (UTC)
Message-ID: <71af3837-d1a9-478d-82fa-1b52fddd5aa2@collabora.com>
Date: Tue, 16 Jan 2024 12:40:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "ASoC: SOF: mediatek: mt8186: Add Google Steelix topology
 compatible" has been added to the 6.1-stable tree
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
 stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>
References: <20240116105221.235358-1-sashal@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240116105221.235358-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/01/24 11:52, Sasha Levin ha scritto:
> This is a note to let you know that I've just added the patch titled
> 
>      ASoC: SOF: mediatek: mt8186: Add Google Steelix topology compatible
> 
> to the 6.1-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       asoc-sof-mediatek-mt8186-add-google-steelix-topology.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 

This commit got reverted afterwards, please don't backport.

Ref.: 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=d20d36755a605a21e737b6b16c566658589b1811

Thanks,
Angelo

> 
> 
> commit 152629176282853223e1768c312539ee0d847384
> Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Date:   Thu Nov 23 09:44:54 2023 +0100
> 
>      ASoC: SOF: mediatek: mt8186: Add Google Steelix topology compatible
>      
>      [ Upstream commit 505c83212da5bfca95109421b8f5d9f8c6cdfef2 ]
>      
>      Add the machine compatible and topology filename for the Google Steelix
>      MT8186 Chromebook to load the correct SOF topology file.
>      
>      Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>      Link: https://lore.kernel.org/r/20231123084454.20471-1-angelogioacchino.delregno@collabora.com
>      Signed-off-by: Mark Brown <broonie@kernel.org>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/sound/soc/sof/mediatek/mt8186/mt8186.c b/sound/soc/sof/mediatek/mt8186/mt8186.c
> index 181189e00e02..76ce90e1f103 100644
> --- a/sound/soc/sof/mediatek/mt8186/mt8186.c
> +++ b/sound/soc/sof/mediatek/mt8186/mt8186.c
> @@ -596,6 +596,9 @@ static struct snd_sof_dsp_ops sof_mt8186_ops = {
>   
>   static struct snd_sof_of_mach sof_mt8186_machs[] = {
>   	{
> +		.compatible = "google,steelix",
> +		.sof_tplg_filename = "sof-mt8186-google-steelix.tplg"
> +	}, {
>   		.compatible = "mediatek,mt8186",
>   		.sof_tplg_filename = "sof-mt8186.tplg",
>   	},



