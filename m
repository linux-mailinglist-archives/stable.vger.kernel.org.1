Return-Path: <stable+bounces-46038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9BC8CE136
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 08:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5441F223D4
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 06:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AE8487BF;
	Fri, 24 May 2024 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kiaxh2qa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9533D575
	for <stable@vger.kernel.org>; Fri, 24 May 2024 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716533722; cv=none; b=uM2DPeHDHIDWljbZrgi+WTKjVCHYEGPdhNR2ygYVfBsIDT5/+qNYBCt9gca7kdlUbp/DfJeEJjxqVRr29F+4how7g3ukgLYw6RrsL28EBZZ8NTQWG30aVWoLsZwPL6B40g42SYFWXatuzkXaOaz1WDu2IrspI91BOGHf0azh9Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716533722; c=relaxed/simple;
	bh=0xZaG+Cu8CdTPrdPG9S8emzjSoBkqO+EwpoFEVSGHXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VppWnE/Yk0tmzhPikOD4OrSMaVv7vjfL6jPHrgqckhWkcHkpNnVr47PQn1Gq4KxKWjHlrS+Q9tZFtPvO6OpfmZ+1ezpbRrHjRdSm1RJIxjs7/l475Tqubq99yt878ldv5hGFzCq8/oezV/Use76pWTjvDEJIMu/MRkhNvVfFKE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kiaxh2qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C32C2BD11;
	Fri, 24 May 2024 06:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716533721;
	bh=0xZaG+Cu8CdTPrdPG9S8emzjSoBkqO+EwpoFEVSGHXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kiaxh2qa6Yb6Pj9hyp3UCvPwlSnR5UXXVQOkUQ+Yx5FhfUD8rmD8+PEtrcs+Jyjj3
	 tMUXPwptn5vfaGqTRoRUuyEGjQ2AcPgGfQYEEOzLDCXfuU8hNfCoqJBzaJHQCsTSDB
	 Kb2FIOJHb+b2fmXrZS6KweKOchOQbM9GAU7/nky8=
Date: Fri, 24 May 2024 08:55:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lin Gui =?utf-8?B?KOahguaelyk=?= <Lin.Gui@mediatek.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Yongdong Zhang =?utf-8?B?KOW8oOawuOS4nCk=?= <Yongdong.Zhang@mediatek.com>,
	Bo Ye =?utf-8?B?KOWPtuazoik=?= <Bo.Ye@mediatek.com>,
	Qilin Tan =?utf-8?B?KOiwrem6kum6nyk=?= <Qilin.Tan@mediatek.com>,
	Wenbin Mei =?utf-8?B?KOaiheaWh+W9rCk=?= <Wenbin.Mei@mediatek.com>,
	Mengqi Zhang =?utf-8?B?KOW8oOaipueQpik=?= <Mengqi.Zhang@mediatek.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbng==?=
 =?utf-8?B?5aSNOiDlm57lpI06IGJhY2twb3J0IA==?= =?utf-8?Q?a?= patch for Linux
 kernel-5.15 kernel-6.1 kenrel-6.6 stable tree
Message-ID: <2024052432-ashamed-carport-c4a0@gregkh>
References: <PSAPR03MB565326FF3D69B95B7A5897D7952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <PSAPR03MB56531563C88DFF85F963CA3295F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052333-parasitic-impure-6d69@gregkh>
 <PSAPR03MB565389D72939161224B110CE95F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052329-sadden-disallow-a982@gregkh>
 <PSAPR03MB5653135ABCAF08A979BCCE0295F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052313-taste-diner-2d78@gregkh>
 <PSAPR03MB5653638EEC15BE49B2E03E9495F52@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052426-recognize-luxurious-bda8@gregkh>
 <PSAPR03MB56537E5242876A4EE9E910A495F52@PSAPR03MB5653.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PSAPR03MB56537E5242876A4EE9E910A495F52@PSAPR03MB5653.apcprd03.prod.outlook.com>

On Fri, May 24, 2024 at 05:58:32AM +0000, Lin Gui (桂林) wrote:
> Dear  gregkh@linuxfoundation.org,
> 
> Sorry, update the format:
> This patch has been tested on Mediatek Phone, the test passed,
> Thank you
> 
> 
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index a569066..d656964 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1800,7 +1800,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  		if (err)
>  			goto free_card;
>  
> -	} else if (!mmc_card_hs400es(card)) {
> +	} else if (mmc_card_hs400es(card)){
> +		if (host->ops->execute_hs400_tuning) {
> +			err = host->ops->execute_hs400_tuning(host, card);
> +			if (err)
> +			goto free_card;
> +		}
> +	} else {
>  		/* Select the desired bus width optionally */
>  		err = mmc_select_bus_width(card);
>  		if (err > 0 && mmc_card_hs(card)) {
> 
> 

Again, please apply this to the latest 5.15.y kernel and see what
happens.  I do not know what kernel you are using, but you know what
kernel we are using :)

thanks,

greg k-h

