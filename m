Return-Path: <stable+bounces-60504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D63934519
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 01:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F951F22396
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 23:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05AA6A8BE;
	Wed, 17 Jul 2024 23:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZxRf+ku"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FA948CCD;
	Wed, 17 Jul 2024 23:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721259801; cv=none; b=QidCxD26tq7FkcxyXPShDRBBpMX3QcaC18+teAbxRaKsQKlgUg/aQKTzrZt+J7IM6jImZckRNdSEDPqpkV47ruo+M9dypgkwCcJBCOlPtwvoU56nIsrKC858Pxknml6yuj61pCACKE6PqUMnLgb+Y8tDQY5B2IfFYTLl9vsReHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721259801; c=relaxed/simple;
	bh=0SzqE6acgChptScakbVHZAGE65kPCaxYYa36nc5MtF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iu7T/CbVIMRQhESD5GcCXqTLf9vSI/mD2Ng5kR37guxFnsLniEK+Q677mD3nb0pju9ERd1uRCCdkr/su45PVtbVi6yhf43wyn2kQc/XZP5VxhR/leGCdIl24/ECcmfNdg1qRswLhRZrZ60nhAirv009WS6AY9TiI+pTChCA29ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZxRf+ku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B61C2BD10;
	Wed, 17 Jul 2024 23:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721259800;
	bh=0SzqE6acgChptScakbVHZAGE65kPCaxYYa36nc5MtF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mZxRf+ku72/5+0Ss1CsbzU8f5+EnZcYo6kPyRsA/FGKPCLlWx1rTjlXcSORXsYDEU
	 P/PUC94hPfK56AdsaJjpjrDaO4ZivMqyMadaOWjNJ8TzAIUO03AOT+br3Ouey1SmYm
	 Pcvpz+lB1qA9sg2x/kS/Wa+cowo16YAiaXdrSxBL463HjEMsUETerp4GeLdnOjvh2x
	 ensqj+AlNzia/H0EuHrW4/2xe/U4ZaS3zO97TIY5oS0fI4WsyjX09dYND8NhlXM6iA
	 7hP3gXlCGsqiG7IA3nSkgLECVluZ26aci+26ic9oEu8byJUkfVDNxEZGj8IedDzp6n
	 alTWHeegfaaNg==
Message-ID: <daf86dec-9c35-49a5-ab81-ee667074f503@kernel.org>
Date: Thu, 18 Jul 2024 08:43:16 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] ata: ahci_imx: Enlarge RX water mark for i.MX8QM
 SATA
To: Niklas Cassel <cassel@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>
Cc: tj@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
 linux-ide@vger.kernel.org, stable@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 kernel@pengutronix.de
References: <1721099895-26098-1-git-send-email-hongxing.zhu@nxp.com>
 <1721099895-26098-4-git-send-email-hongxing.zhu@nxp.com>
 <ZpgKxwziGXqNYLfc@ryzen.lan>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZpgKxwziGXqNYLfc@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/18/24 3:17 AM, Niklas Cassel wrote:
> Hello Richard,
> 
> On Tue, Jul 16, 2024 at 11:18:14AM +0800, Richard Zhu wrote:
>> The RXWM(RxWaterMark) sets the minimum number of free location within
>> the RX FIFO before the watermark is exceeded which in turn will cause
>> the Transport Layer to instruct the Link Layer to transmit HOLDS to
>> the transmitting end.
>>
>> Based on the default RXWM value 0x20, RX FIFO overflow might be
>> observed on i.MX8QM MEK board, when some Gen3 SATA disks are used.
>>
>> The FIFO overflow will result in CRC error, internal error and protocol
>> error, then the SATA link is not stable anymore.
>>
>> To fix this issue, enlarge RX water mark setting from 0x20 to 0x29.
>>
>> Fixes: 027fa4dee935 ("ahci: imx: add the imx8qm ahci sata support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
>> ---
> 
> Looking at the title of this patch:
> "ahci_imx: Enlarge RX water mark for i.MX8QM SATA"
> 
> This suggests that this fix is only needed for i.MX8QM.
> 
> Support for i.MX8QM was added to the device tree binding in patch 1/4 in
> this series.
> 
> Doing a git grep in linux-next gives the following result:
> 
> $ git grep fsl,imx8qm-ahci linux-next/master
> linux-next/master:drivers/ata/ahci_imx.c:       { .compatible = "fsl,imx8qm-ahci", .data = (void *)AHCI_IMX8QM },
> 
> 
> This is interesting for two reasons:
> 1) drivers/ata/ahci_imx.c already has support for this compatible string,
> even though this compatible string does not exist in any DT binding
> (in linux-next).
> 
> 2) There is not a single in-tree device tree (DTS) that uses this compatible
> string ....and we do not care about out of tree device trees.
> 
> 
> Considering 2) I do NOT think that we should have
> Cc: stable@vger.kernel.org on this... we shouldn't just backport random driver
> fixes is there are no in-tree users of this compatible string.
> 
> So I suggest that:
> -Drop the CC: stable.
> -I actually think that it is better that you drop the Fixes tag too, because if
> you keep it, the stable bots will automatically select this for backporting,
> and then we will need to reply and say that this should not be backported, so
> better to avoid adding the Fixes tag in the first place.
> (Since there are no users of this compatible string, there is nothing that is
> broken, so there is nothing to fix.)
> 
> 
> Damien, when applying this patch, I suggest that we apply it to for-6.12
> together with the rest of the series (instead of applying it to
> for-6.11-fixes).

It was me who asked for the Fixes and Cc-stable tags, but I had not checked
that the compatible is not being used in any DT. So good catch.
I will apply everything to for-6.12.

> 
> 
> Kind regards,
> Niklas

-- 
Damien Le Moal
Western Digital Research


