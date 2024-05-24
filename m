Return-Path: <stable+bounces-46025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 108AD8CE02E
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 06:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1194283B8E
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 04:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EB3364CD;
	Fri, 24 May 2024 04:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qiCb4dv6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376CF2231F
	for <stable@vger.kernel.org>; Fri, 24 May 2024 04:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716523731; cv=none; b=ASwywdCMsQxD1LMioVZGR8VeIp1/VLvNiXHVndw/0nxyjMIDGlhnqaFenwv9u1nVTKIFlnVMwplFTtP8rtK9ijgq1EOPWiHbZkIagcUZLz6ol1oYWuD9AGHJHCGtIv7JhLAhFvKonJITIHTMYSE2D3GokAfY7IuaxqN24K1nzDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716523731; c=relaxed/simple;
	bh=LttComLx0+BJsTYa65HP2O9WrEe+BygAQKCASvI735k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpMNX600xFB7lrKSx1v4Xm1LVyN9ykF7uMLvs/Qw08ViZm7BkUvW8BqAITPFIYjZfpcDMtHEbVy2wXsWJj6mHUkG/8x1YAh0SXcZIV3v41jGswEO5Vqx7Hz6y8luzfVT2yjy4Ieh3vZYvo+uP2Gmd6Bt6ud4PyV9+UgYDSg0g6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qiCb4dv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498EEC2BBFC;
	Fri, 24 May 2024 04:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716523730;
	bh=LttComLx0+BJsTYa65HP2O9WrEe+BygAQKCASvI735k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qiCb4dv6/0lCNBl0vsSZ9ccCU4geQdANDoJBmjlIrI6olxPnvzY1ETDHRSIpplBZw
	 h4lU0SLaPXGdwvK/xMAWQPVGFhsb3/bzryJbbWPF1afqFahmKbbCf3b2TUWKrcAR4Q
	 K4qpo1nq1tiqHY3vb/2VdybjGwRvaVmRDHrfHMQE=
Date: Fri, 24 May 2024 06:08:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lin Gui =?utf-8?B?KOahguaelyk=?= <Lin.Gui@mediatek.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Yongdong Zhang =?utf-8?B?KOW8oOawuOS4nCk=?= <Yongdong.Zhang@mediatek.com>,
	Bo Ye =?utf-8?B?KOWPtuazoik=?= <Bo.Ye@mediatek.com>,
	Qilin Tan =?utf-8?B?KOiwrem6kum6nyk=?= <Qilin.Tan@mediatek.com>,
	Wenbin Mei =?utf-8?B?KOaiheaWh+W9rCk=?= <Wenbin.Mei@mediatek.com>,
	Mengqi Zhang =?utf-8?B?KOW8oOaipueQpik=?= <Mengqi.Zhang@mediatek.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbng==?=
 =?utf-8?B?5aSNOiBiYWNrcG9ydCA=?= =?utf-8?Q?a?= patch for Linux kernel-5.15
 kernel-6.1 kenrel-6.6 stable tree
Message-ID: <2024052426-recognize-luxurious-bda8@gregkh>
References: <PSAPR03MB5653FFA63E972A80A6A2F4AF952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <PSAPR03MB565326FF3D69B95B7A5897D7952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <PSAPR03MB56531563C88DFF85F963CA3295F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052333-parasitic-impure-6d69@gregkh>
 <PSAPR03MB565389D72939161224B110CE95F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052329-sadden-disallow-a982@gregkh>
 <PSAPR03MB5653135ABCAF08A979BCCE0295F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052313-taste-diner-2d78@gregkh>
 <PSAPR03MB5653638EEC15BE49B2E03E9495F52@PSAPR03MB5653.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PSAPR03MB5653638EEC15BE49B2E03E9495F52@PSAPR03MB5653.apcprd03.prod.outlook.com>

On Fri, May 24, 2024 at 01:07:18AM +0000, Lin Gui (桂林) wrote:
> Dear @Greg KH<mailto:gregkh@linuxfoundation.org>,
> 
> Base : kernel-5.15.159
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index a569066..d656964 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1800,7 +1800,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>               if (err)
>                      goto free_card;
> 
> -      } else if (!mmc_card_hs400es(card)) {
> +     } else if (mmc_card_hs400es(card)){
> +            if (host->ops->execute_hs400_tuning) {
> +                   err = host->ops->execute_hs400_tuning(host, card);
> +                   if (err)
> +                   goto free_card;
> +            }
> +     } else {
>               /* Select the desired bus width optionally */
>               err = mmc_select_bus_width(card);
>               if (err > 0 && mmc_card_hs(card)) {
> 

Also, please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.


