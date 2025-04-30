Return-Path: <stable+bounces-139170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4D1AA4D4F
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 15:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2826C7A8E9F
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 13:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BD225C6E9;
	Wed, 30 Apr 2025 13:20:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A1521CC59;
	Wed, 30 Apr 2025 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746019237; cv=none; b=bwRopQB5TAfAOUhvgL+3nFC3kU88Uejuk2uLUNwsATuKC8n7a8iFdoFk8h4Gq9+7nr9QTO4IBOHllmqFxI9RLLH8R5FINIdSVnTbKb0CiOBf9WzYMstLZj8N/yCPtYLMDAsQ2cYFx2CaopdBMS0WNapEfZq6M6H+tm8X/S8V3vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746019237; c=relaxed/simple;
	bh=79XUsZ/BIwKk5GC3r6tDR3/gZAMPX9a2Nwp8/vj5tHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3q4Z1TXvO9t2rIVKomwX+DBh1gaoYH59L8jYWu3nbqHmuOJKsJqNIczSHFThVlQaHR2CmeXM3i856B+RrwdolxfSSccQNQx1u9imxAWV0JTZ/n10MMhoLJbz0H/sokAOD5ignM78+IBdb5o02cJvt89IzdBWTDk6Uq4zvVIM6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Zncb14Cgcz9sCk;
	Wed, 30 Apr 2025 14:54:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jv9ioGE5cEZR; Wed, 30 Apr 2025 14:54:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Zncb13TLtz9sB2;
	Wed, 30 Apr 2025 14:54:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6CB2C8B765;
	Wed, 30 Apr 2025 14:54:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id x3PWoPD_y1-d; Wed, 30 Apr 2025 14:54:37 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C33508B763;
	Wed, 30 Apr 2025 14:54:36 +0200 (CEST)
Message-ID: <1ada639a-8dc0-4553-899f-265e6bc5e44f@csgroup.eu>
Date: Wed, 30 Apr 2025 14:54:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: fsl: fsl_qmc_audio: Reset audio data pointers on
 TRIGGER_START event
To: Mark Brown <broonie@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Herve Codina <herve.codina@bootlin.com>,
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
References: <20250410091643.535627-1-herve.codina@bootlin.com>
 <174429282080.80887.6648935549042489213.b4-ty@kernel.org>
 <4b42c00a-0ef5-4121-9e40-9214bf9a1197@csgroup.eu>
 <aBFtesqln2Xeab-d@finisterre.sirena.org.uk>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <aBFtesqln2Xeab-d@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 30/04/2025 à 02:23, Mark Brown a écrit :
> On Mon, Apr 28, 2025 at 11:20:42AM +0200, Christophe Leroy wrote:
>> Le 10/04/2025 à 15:47, Mark Brown a écrit :
> 
>> Would it be possible to get this patch into one of the v6.15 rc as it is a
>> bug fix ?
> 
> It appears to be queued as a fix, could you be more specific please?
> 


Maybe I misunderstood. You said applied to ... for-next, so I thought it 
was for v6.16.
If it goes into one of v6.15rc as a fix it is fine for me.

Thanks
Christophe

