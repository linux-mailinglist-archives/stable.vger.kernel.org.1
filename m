Return-Path: <stable+bounces-136847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B0BA9EDBC
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 12:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1ED174759
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 10:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1AC25F7A2;
	Mon, 28 Apr 2025 10:20:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FD61AC44D;
	Mon, 28 Apr 2025 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745835636; cv=none; b=q60TGXVeFhf2llCatX0hsLvJcQK7BZe5VqSLKQVq/nv6ShMiX2i+Wa3kof/q4ZyQHokGmWbg4ZGawqgPIB8pRGYR4UooEwttIgAaD1ZrHrjpfmkCPsXIh3nKQJE31UFKfGsY/Sd31l5NQt6sC2PEwkJjJPg+XjEj0usmC5DhBSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745835636; c=relaxed/simple;
	bh=awsLbnE+lM4r/IQKorSBx0YVy7B01bk3OUhbrujOP+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szaDd1b+NQOUb3TybwMTPMkLeduiAhPx2F/k5R8nv27kFIp8tHQR7TQgAZ46yQlMXe0xANQnw5bMtqylg/ynrl1fsBl0g6MwoL/i8idhlee2yXXBAOFvEP+MFMTRS5eBwpOUoDp1SbfzmsKzP1MltkNarb4/YFjdn7FuaThEWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4ZmHx70jzTz9s2l;
	Mon, 28 Apr 2025 11:20:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vzOENPXM0yv2; Mon, 28 Apr 2025 11:20:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4ZmHx6757fz9s28;
	Mon, 28 Apr 2025 11:20:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id ED06D8B766;
	Mon, 28 Apr 2025 11:20:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id txsmwIS9nDw7; Mon, 28 Apr 2025 11:20:42 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7E6FD8B763;
	Mon, 28 Apr 2025 11:20:42 +0200 (CEST)
Message-ID: <4b42c00a-0ef5-4121-9e40-9214bf9a1197@csgroup.eu>
Date: Mon, 28 Apr 2025 11:20:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: fsl: fsl_qmc_audio: Reset audio data pointers on
 TRIGGER_START event
To: Mark Brown <broonie@kernel.org>, Shengjiu Wang <shengjiu.wang@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Herve Codina <herve.codina@bootlin.com>
Cc: linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
References: <20250410091643.535627-1-herve.codina@bootlin.com>
 <174429282080.80887.6648935549042489213.b4-ty@kernel.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <174429282080.80887.6648935549042489213.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mark,


Le 10/04/2025 à 15:47, Mark Brown a écrit :
> On Thu, 10 Apr 2025 11:16:43 +0200, Herve Codina wrote:
>> On SNDRV_PCM_TRIGGER_START event, audio data pointers are not reset.
>>
>> This leads to wrong data buffer usage when multiple TRIGGER_START are
>> received and ends to incorrect buffer usage between the user-space and
>> the driver. Indeed, the driver can read data that are not already set by
>> the user-space or the user-space and the driver are writing and reading
>> the same area.
>>
>> [...]
> 
> Applied to
> 
>     https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fbroonie%2Fsound.git&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C438de093b4c04d4c0a8f08dd78362e30%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638798896267382068%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=d%2FuL%2FFAOcpRY2v9YtxTMdiX%2B3GgHKDE7y5TMTc9cK94%3D&reserved=0 for-next

Would it be possible to get this patch into one of the v6.15 rc as it is 
a bug fix ?

Thanks
Christophe

> 
> Thanks!
> 
> [1/1] ASoC: fsl: fsl_qmc_audio: Reset audio data pointers on TRIGGER_START event
>        commit: 9aa33d5b4a53a1945dd2aee45c09282248d3c98b
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 


