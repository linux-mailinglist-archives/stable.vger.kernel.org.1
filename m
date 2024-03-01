Return-Path: <stable+bounces-25756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E57486E7B9
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 18:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5634FB25A69
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 17:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53A9C2C7;
	Fri,  1 Mar 2024 17:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="KAL1IhSb"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B2F16FF5F
	for <stable@vger.kernel.org>; Fri,  1 Mar 2024 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315450; cv=none; b=TXXVyGtLnLxKd/pgdngxpH+BuqClDAHDRXBTssCN/K8leCBtEwsKV15NdG0zZXI4Ua44JPnQGz1D5eAseFDyfKO37ygd6iAO6rTUZin8xsATYF/L1IX3I7z8qLCNhVcuUSZLfv01c40VipVuf4nd8zhQvShS50JOwIl2DbWuAC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315450; c=relaxed/simple;
	bh=YDXYlNXbMEeqdRXT/18RnuNoGU0ezsOy7LCKbJ9Je78=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MW3h3jkG64T4qCC8yvr8acBGjTagyXOCSAjep4ZqV1+HzKfggtxnUcoQ6zc9VP9m8KEizgQ4yjS4F9t+/E8gWcuVdvY174GnNarJbLIR2oPT0G/BZDLejGFVs+HBmhIaaW2BRgk8n2xwc8RVD1giC0lc+ev5eXaZsF2Qg7UDSYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=KAL1IhSb; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421AwvQv022493;
	Fri, 1 Mar 2024 18:49:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=pX880VHAiAcKRls7BPjtfXjDb7SpOtdl+UFZ3qPxx60=; b=KA
	L1IhSbUxXIkHg+U5/kqU4BHlgD8eexB8iJCuhy+yYWXbrrNGD3/BNP4fU223ECvE
	pbigtTe6NHusoBW9ODNgRMhxwg5Mj6T2wuVjXEtsE1a4oooO9UrJsfvxC66Qlr9L
	a9rz0JLHd89T9o7hxnMsp4fKKSG8iq7xqlxJMtXHncGnrawE5IQ1lKhoyeL28yFd
	cJsKdXXBvSN9OpXtxYpB1wXGlXOetgkod4brXW/fF25uetrcsMlc+EE1a3HjIsyE
	cSZ+y/ztFRyB1lZNTS6SZN3v9QXIMjNvB7NGm5eIwN0zRw4cWRJnYTWJTricY73g
	Fcw/Rvj18/g3UposTNFg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3whf4e8q8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 18:49:50 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1CD384002D;
	Fri,  1 Mar 2024 18:49:43 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1277F2B0123;
	Fri,  1 Mar 2024 18:48:33 +0100 (CET)
Received: from [10.201.21.177] (10.201.21.177) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Mar
 2024 18:48:32 +0100
Message-ID: <ffdb0f72-5e49-4e41-9801-399035c0bdce@foss.st.com>
Date: Fri, 1 Mar 2024 18:48:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mtd: rawnand: Fix and simplify again the continuous
 read derivations
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
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Julien Su
	<juliensu@mxic.com.tw>, Jaime Liao <jaimeliao@mxic.com.tw>,
        Jaime Liao
	<jaimeliao.tw@gmail.com>,
        Alvin Zhou <alvinzhou@mxic.com.tw>, <eagle.alexander923@gmail.com>,
        <mans@mansr.com>, <martin@geanix.com>,
        =?UTF-8?Q?Sean_Nyekj=C3=A6r?= <sean@geanix.com>,
        <stable@vger.kernel.org>
References: <20240223115545.354541-1-miquel.raynal@bootlin.com>
 <20240223115545.354541-2-miquel.raynal@bootlin.com>
From: Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <20240223115545.354541-2-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_20,2024-03-01_02,2023-05-22_02

Hi Miquel,

On 2/23/24 12:55, Miquel Raynal wrote:
> We need to avoid the first page if we don't read it entirely.
> We need to avoid the last page if we don't read it entirely.
> While rather simple, this logic has been failed in the previous
> fix. This time I wrote about 30 unit tests locally to check each
> possible condition, hopefully I covered them all.
> 
> Reported-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Closes: https://lore.kernel.org/linux-mtd/20240221175327.42f7076d@xps-13/T/#m399bacb10db8f58f6b1f0149a1df867ec086bb0a
> Suggested-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Fixes: 828f6df1bcba ("mtd: rawnand: Clarify conditions to enable continuous reads")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Tested-by: Christophe Kerello <christophe.kerello@foss.st.com>

Regards,
Christophe Kerello.

> ---
>   drivers/mtd/nand/raw/nand_base.c | 38 ++++++++++++++++++--------------
>   1 file changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 3b3ce2926f5d..bcfd99a1699f 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -3466,30 +3466,36 @@ static void rawnand_enable_cont_reads(struct nand_chip *chip, unsigned int page,
>   				      u32 readlen, int col)
>   {
>   	struct mtd_info *mtd = nand_to_mtd(chip);
> -	unsigned int end_page, end_col;
> +	unsigned int first_page, last_page;
>   
>   	chip->cont_read.ongoing = false;
>   
>   	if (!chip->controller->supported_op.cont_read)
>   		return;
>   
> -	end_page = DIV_ROUND_UP(col + readlen, mtd->writesize);
> -	end_col = (col + readlen) % mtd->writesize;
> +	/*
> +	 * Don't bother making any calculations if the length is too small.
> +	 * Side effect: avoids possible integer underflows below.
> +	 */
> +	if (readlen < (2 * mtd->writesize))
> +		return;
>   
> +	/* Derive the page where continuous read should start (the first full page read) */
> +	first_page = page;
>   	if (col)
> -		page++;
> -
> -	if (end_col && end_page)
> -		end_page--;
> -
> -	if (page + 1 > end_page)
> -		return;
> -
> -	chip->cont_read.first_page = page;
> -	chip->cont_read.last_page = end_page;
> -	chip->cont_read.ongoing = true;
> -
> -	rawnand_cap_cont_reads(chip);
> +		first_page++;
> +
> +	/* Derive the page where continuous read should stop (the last full page read) */
> +	last_page = page + ((col + readlen) / mtd->writesize) - 1;
> +
> +	/* Configure and enable continuous read when suitable */
> +	if (first_page < last_page) {
> +		chip->cont_read.first_page = first_page;
> +		chip->cont_read.last_page = last_page;
> +		chip->cont_read.ongoing = true;
> +		/* May reset the ongoing flag */
> +		rawnand_cap_cont_reads(chip);
> +	}
>   }
>   
>   static void rawnand_cont_read_skip_first_page(struct nand_chip *chip, unsigned int page)

