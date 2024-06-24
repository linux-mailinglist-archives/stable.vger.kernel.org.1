Return-Path: <stable+bounces-55111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6652A91593E
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 23:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237D028489D
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 21:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5897B1A257F;
	Mon, 24 Jun 2024 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnehprYu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1509A1A0B1B;
	Mon, 24 Jun 2024 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719265655; cv=none; b=vGKg5kBuMN0p1rarfwL1IAciM+NSKd9qqT9DA5CN7oH1AENd0z7nt+lcxDLhp38lwJrQqRHYMA2oPkJq6Bdqdublh5VCUGHcSvVETGpK8ts5xmKrsOIw8mAmXI8QdnLWiOaxgwC2e4ep6pbqbpx1X00WvJ011D6JEnlQmjxf/nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719265655; c=relaxed/simple;
	bh=72bDHby4Hq6icji7BLqTJP6R3mRRo9GTA2z64XlDV8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CD1q9zPsXfVufFL0tFhChTRX8Y+L/ZAL58cGKm9N75ct3HgYXAdVP9Y6C4h/kWrfn78Qzlcpk4D4O5xR2SMcjjQ4amL3vBLMCSUen4/4+SNenLHRLvev+dFs+y8bCOT2Pi95caX9tVJsOE4R/w1xXpgxUX/WoQU2ZsOQbJDad4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnehprYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCB8C2BBFC;
	Mon, 24 Jun 2024 21:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719265654;
	bh=72bDHby4Hq6icji7BLqTJP6R3mRRo9GTA2z64XlDV8s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cnehprYuwdGqAo2Y2nT8nNKqruU2QxwxxNd9UFr3wQ+4blGBvQR8kTsRdM/vcMGgZ
	 ntkAkMPJ2La9uS4UdrcgJMVUscaUXEzLtHL8Zm+0icQTRSnc9ED5G1QTEnnMXeZDZw
	 1R4erDBSqPWkvj4Nz3i3cM2t5zIsVs674mjTHEFStBwcC8sYOKC6nJMpAhdm2QEiB4
	 h2pfEG8zRCYmx1/5hfGV5M/AU+7QJEBJG2N0acxwP2u0B02FMDANJPIVXf0myEedKN
	 0KjEIQBsdsl2VAjJiKZfRw2p0fEDUbH27l/6L1Aa53a5fZ0UUWAMOgHKO6e59WpSnc
	 lZ391zr69c8ww==
Message-ID: <82e310a4-5668-4edf-b3a8-2c7898a7c4cb@kernel.org>
Date: Tue, 25 Jun 2024 06:47:32 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Add ATA_HORKAGE_NOLPM for all Crucial
 BX SSD1 models
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, lp610mh@gmail.com, stable@vger.kernel.org,
 Tkd-Alex <alex.tkd.alex@gmail.com>
References: <20240624132729.3001688-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240624132729.3001688-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/24 22:27, Niklas Cassel wrote:
> We got another report that CT1000BX500SSD1 does not work with LPM.
> 
> If you look in libata-core.c, we have six different Crucial devices that
> are marked with ATA_HORKAGE_NOLPM. This model would have been the seventh.
> (This quirk is used on Crucial models starting with both CT* and
> Crucial_CT*)
> 
> It is obvious that this vendor does not have a great history of supporting
> LPM properly, therefore, add the ATA_HORKAGE_NOLPM quirk for all Crucial
> BX SSD1 models.
> 
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Cc: stable@vger.kernel.org
> Reported-by: Tkd-Alex <alex.tkd.alex@gmail.com>

We need a real full name here, not a user name... So if Alex is not willing to
send his full name, please remove this.

Other than that, looks good. That was strike 3 for this series of SSDs, so I
agree that taking the big hammer and disabling LPM for all of them is the right
thing to do. If the device vendor wants to help with this, we can refine this later.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218832
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/libata-core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index e1bf8a19b3c8..efb5195da60c 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4137,8 +4137,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ "PIONEER BD-RW   BDR-205",	NULL,	ATA_HORKAGE_NOLPM },
>  
>  	/* Crucial devices with broken LPM support */
> -	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
> -	{ "CT240BX500SSD1",		NULL,	ATA_HORKAGE_NOLPM },
> +	{ "CT*0BX*00SSD1",		NULL,	ATA_HORKAGE_NOLPM },
>  
>  	/* 512GB MX100 with MU01 firmware has both queued TRIM and LPM issues */
>  	{ "Crucial_CT512MX100*",	"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |

-- 
Damien Le Moal
Western Digital Research


