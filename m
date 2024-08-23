Return-Path: <stable+bounces-69948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 527F695C739
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 10:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D548DB22A5E
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 08:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C7D13CA99;
	Fri, 23 Aug 2024 08:03:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD9E2AE95;
	Fri, 23 Aug 2024 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400220; cv=none; b=D1lNVG+p9pTK8l+RfaBbJ6UzvCr3e5JzdNZiC/K9o1imHZbCcb+9n3S/B0PAs/UMkTjZ6OPnBtDIObJTrsinelPWcIRnGjJ6oqKrtLnE7G/iOsp4mQ8kCPTGAjqWQoxvhTmGlFGn1k8b8QWJTk2aOhGuFn/RVlVysBxGpo/jW34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400220; c=relaxed/simple;
	bh=iF8iUihmF2dJh3FkshOnChMP04Ma/3/oZnTUDTsXBCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSgWeP2DkTobLFts4RKOht04ve2lYTk/ygyJihsZkcwz/SQtss5eScO2bHY/8c6CuMoewJdzqw+0XqCNAwipZguwdRBIAHZoWrRuk25CBoYQXcYOBe3jvHgTzUH7ztXix8hhew9w423BHsltpxSrJKVt/I//pPHIRh1U5oHOJWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqsyV5TkTz9sRr;
	Fri, 23 Aug 2024 10:03:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s4XLifoY12ly; Fri, 23 Aug 2024 10:03:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqsyV4NkMz9rvV;
	Fri, 23 Aug 2024 10:03:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8447F8B77D;
	Fri, 23 Aug 2024 10:03:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Ca1iEuO7cMiA; Fri, 23 Aug 2024 10:03:30 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E4AE58B763;
	Fri, 23 Aug 2024 10:03:29 +0200 (CEST)
Message-ID: <834e0fdd-bc87-481d-bed1-1c8295d5a2be@csgroup.eu>
Date: Fri, 23 Aug 2024 10:03:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/36] soc: fsl: cpm1: qmc: Update TRNSYNC only in
 transparent mode
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-2-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:10, Herve Codina a écrit :
> The TRNSYNC feature is available (and enabled) only in transparent mode.
> 
> Since commit 7cc9bda9c163 ("soc: fsl: cpm1: qmc: Handle timeslot entries
> at channel start() and stop()") TRNSYNC register is updated in
> transparent and hdlc mode. In hdlc mode, the address of the TRNSYNC
> register is used by the QMC for other internal purpose. Even if no weird
> results were observed in hdlc mode, touching this register in this mode
> is wrong.
> 
> Update TRNSYNC only in transparent mode.
> 
> Fixes: 7cc9bda9c163 ("soc: fsl: cpm1: qmc: Handle timeslot entries at channel start() and stop()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   drivers/soc/fsl/qe/qmc.c | 24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> index 76bb496305a0..bacabf731dcb 100644
> --- a/drivers/soc/fsl/qe/qmc.c
> +++ b/drivers/soc/fsl/qe/qmc.c
> @@ -940,11 +940,13 @@ static int qmc_chan_start_rx(struct qmc_chan *chan)
>   		goto end;
>   	}
>   
> -	ret = qmc_setup_chan_trnsync(chan->qmc, chan);
> -	if (ret) {
> -		dev_err(chan->qmc->dev, "chan %u: setup TRNSYNC failed (%d)\n",
> -			chan->id, ret);
> -		goto end;
> +	if (chan->mode == QMC_TRANSPARENT) {
> +		ret = qmc_setup_chan_trnsync(chan->qmc, chan);
> +		if (ret) {
> +			dev_err(chan->qmc->dev, "chan %u: setup TRNSYNC failed (%d)\n",
> +				chan->id, ret);
> +			goto end;
> +		}
>   	}
>   
>   	/* Restart the receiver */
> @@ -982,11 +984,13 @@ static int qmc_chan_start_tx(struct qmc_chan *chan)
>   		goto end;
>   	}
>   
> -	ret = qmc_setup_chan_trnsync(chan->qmc, chan);
> -	if (ret) {
> -		dev_err(chan->qmc->dev, "chan %u: setup TRNSYNC failed (%d)\n",
> -			chan->id, ret);
> -		goto end;
> +	if (chan->mode == QMC_TRANSPARENT) {
> +		ret = qmc_setup_chan_trnsync(chan->qmc, chan);
> +		if (ret) {
> +			dev_err(chan->qmc->dev, "chan %u: setup TRNSYNC failed (%d)\n",
> +				chan->id, ret);
> +			goto end;
> +		}
>   	}
>   
>   	/*

