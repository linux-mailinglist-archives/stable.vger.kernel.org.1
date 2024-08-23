Return-Path: <stable+bounces-69949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 011EB95C740
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 10:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F24BB239E9
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 08:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4359C13D601;
	Fri, 23 Aug 2024 08:04:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533913C683;
	Fri, 23 Aug 2024 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400253; cv=none; b=ntBCCWNMYZdcHL7dmenPyCLikuQGZR+ShjaI/BNURNO5XDWX0c1VXulf19MbQDIjzbYXasnmh6eEGs/Y4D6kOR13hHn/EDm2xeyKQmc3iM2pJzsMCwdPmt5L6wmDSE3karAprRtHp6rWjPObv8NTy5UjQ3hcdhi0t6jf0Q5t/bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400253; c=relaxed/simple;
	bh=9cf3gET/7b41IkUTS9pTFcIP8YDqiVeze2KYnwg/Wd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiHmpxr8kidI52L2bOujrbsEobIPCkxqNdM1un0tY5my3QulPDdb5DFe+pLPf47aZTjCk7M+jCiuD1B6dY2Wkm8RXjWFKCDIF4J6HQchPMf9Qf4Nkf4HKiB0kDQH0hov68pid08mt/p0+tc8eZB17ZcBbWhZPunz3fNv7zTimms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqszF3y1Tz9sRy;
	Fri, 23 Aug 2024 10:04:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yk1GffMRyqAy; Fri, 23 Aug 2024 10:04:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqszF38N7z9sRs;
	Fri, 23 Aug 2024 10:04:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5B77A8B77D;
	Fri, 23 Aug 2024 10:04:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id hrfneOf7_t5k; Fri, 23 Aug 2024 10:04:09 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C759E8B763;
	Fri, 23 Aug 2024 10:04:08 +0200 (CEST)
Message-ID: <6aa6c9e7-9db7-4fbc-8e0b-72f83efaab06@csgroup.eu>
Date: Fri, 23 Aug 2024 10:04:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/36] soc: fsl: cpm1: tsa: Fix tsa_write8()
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-4-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-4-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:10, Herve Codina a écrit :
> The tsa_write8() parameter is an u32 value. This is not consistent with
> the function itself. Indeed, tsa_write8() writes an 8bits value.
> 
> Be consistent and use an u8 parameter value.
> 
> Fixes: 1d4ba0b81c1c ("soc: fsl: cpm1: Add support for TSA")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>


> ---
>   drivers/soc/fsl/qe/tsa.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
> index 6c5741cf5e9d..53968ea84c88 100644
> --- a/drivers/soc/fsl/qe/tsa.c
> +++ b/drivers/soc/fsl/qe/tsa.c
> @@ -140,7 +140,7 @@ static inline void tsa_write32(void __iomem *addr, u32 val)
>   	iowrite32be(val, addr);
>   }
>   
> -static inline void tsa_write8(void __iomem *addr, u32 val)
> +static inline void tsa_write8(void __iomem *addr, u8 val)
>   {
>   	iowrite8(val, addr);
>   }

