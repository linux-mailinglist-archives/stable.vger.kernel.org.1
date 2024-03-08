Return-Path: <stable+bounces-27146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD86876452
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 13:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846531F21E88
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 12:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887FA57335;
	Fri,  8 Mar 2024 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="F79ItZ//"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D4B56456
	for <stable@vger.kernel.org>; Fri,  8 Mar 2024 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709900958; cv=none; b=BEa+W+ImCSHz5kqzhHXLtW5PB3SnmR72cXX8cPjRYPzTlrtR6GSe2+Dcj63b8J0+COw8BPoxoCxHhwKtIOeI9IbsNEX8jReGTNcNOTYakhC0CVZ9iRXf38d0rV+Uq/+jcoX1YlPNyMP/MOwqn1PYlblTOGrmlaSJV5k4P0bMwBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709900958; c=relaxed/simple;
	bh=r98TWa6jKn7SWqaCQEQXXY3/2dDHD6OyWFAqsZz5p8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k0+aOKDDYGjeKkwc9uEeX+ndy/s7gOCbiY/XwE3vM535jtAADrchXPLDz0OokakL6Yk46T9ku6QCRkfFJ/WWLxakPmUvTRCiuZW0ieodwF5zMdMAiG5NKhfIbYoIjDB0WDC0PTI8dmNSer2KxUL0HjTAUvlfxFkSgCxeGHWyXsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=F79ItZ//; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428Ab1A9022424;
	Fri, 8 Mar 2024 13:28:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=XKGlTKcB76WSjtXRqXEchAI0+D7g3eog2GfYhv6SP0w=; b=F7
	9ItZ//pH3XOIFsfaA5nfafDjMMKeb+f1J2VeEjrkzBsgTmpM4VW2YfA4ffeqsa5f
	KF8DAmuqgBpfbp+bSWBrf6XIAsZyLzDfVNADg+SUTdEZtlcqT7Ky3YpnebQ20RnX
	t5orRYdY0thEwv9V85y6oJycWkA/41SkqKp3FzwdMhqZo1JX7msQmtxtC5v6C/2F
	xsap+lYLs7qzeQ7fze4DuiwjtkBv+UTHk2QFldxQr+5E12nlDQ2DXlQLrPZyk9Vw
	klCxcmFMm1teU4oFK/vkmnV3Yrn7xWT7RLEUAV3EShzf7Wk6fyLOlwhk6ClBI9VU
	Ycd0KgbE1VGr+xjhy84w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wkuvj4mv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 13:28:21 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3577C4002D;
	Fri,  8 Mar 2024 13:28:14 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 60B4A26C463;
	Fri,  8 Mar 2024 13:27:01 +0100 (CET)
Received: from [10.201.21.177] (10.201.21.177) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Mar
 2024 13:27:00 +0100
Message-ID: <5f1a8a9f-0f35-4028-9d5e-d5ff624124b8@foss.st.com>
Date: Fri, 8 Mar 2024 13:26:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mtd: rawnand: Constrain even more when continuous
 reads are enabled
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger
	<richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus
	<tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael
 Walle <michael@walle.cc>, <linux-mtd@lists.infradead.org>
CC: Julien Su <juliensu@mxic.com.tw>, Jaime Liao <jaimeliao@mxic.com.tw>,
        Jaime Liao <jaimeliao.tw@gmail.com>,
        Alvin Zhou <alvinzhou@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <eagle.alexander923@gmail.com>, <mans@mansr.com>, <martin@geanix.com>,
        =?UTF-8?Q?Sean_Nyekj=C3=A6r?= <sean@geanix.com>,
        <stable@vger.kernel.org>
References: <20240307115315.1942678-1-miquel.raynal@bootlin.com>
From: Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <20240307115315.1942678-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02

Hi Miquel,

On 3/7/24 12:53, Miquel Raynal wrote:
> As a matter of fact, continuous reads require additional handling at the
> operation level in order for them to work properly. The core helpers do
> have this additional logic now, but any time a controller implements its
> own page helper, this extra logic is "lost". This means we need another
> level of per-controller driver checks to ensure they can leverage
> continuous reads. This is for now unsupported, so in order to ensure
> continuous reads are enabled only when fully using the core page
> helpers, we need to add more initial checks.
> 
> Also, as performance is not relevant during raw accesses, we also
> prevent these from enabling the feature.
> 
> This should solve the issue seen with controllers such as the STM32 FMC2
> when in sequencer mode. In this case, the continuous read feature would
> be enabled but not leveraged, and most importantly not disabled, leading
> to further operations to fail.
> 
> Reported-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache reads")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Tested-by: Christophe Kerello <christophe.kerello@foss.st.com>

Regards,
Christophe Kerello.

> ---
>   drivers/mtd/nand/raw/nand_base.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 4d5a663e4e05..2479fa98f991 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -3594,7 +3594,8 @@ static int nand_do_read_ops(struct nand_chip *chip, loff_t from,
>   	oob = ops->oobbuf;
>   	oob_required = oob ? 1 : 0;
>   
> -	rawnand_enable_cont_reads(chip, page, readlen, col);
> +	if (likely(ops->mode != MTD_OPS_RAW))
> +		rawnand_enable_cont_reads(chip, page, readlen, col);
>   
>   	while (1) {
>   		struct mtd_ecc_stats ecc_stats = mtd->ecc_stats;
> @@ -5212,6 +5213,15 @@ static void rawnand_late_check_supported_ops(struct nand_chip *chip)
>   	if (!nand_has_exec_op(chip))
>   		return;
>   
> +	/*
> +	 * For now, continuous reads can only be used with the core page helpers.
> +	 * This can be extended later.
> +	 */
> +	if (!(chip->ecc.read_page == nand_read_page_hwecc ||
> +	      chip->ecc.read_page == nand_read_page_syndrome ||
> +	      chip->ecc.read_page == nand_read_page_swecc))
> +		return;
> +
>   	rawnand_check_cont_read_support(chip);
>   }
>   

