Return-Path: <stable+bounces-23201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4C985E36B
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 17:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046521F22566
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 16:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945E680628;
	Wed, 21 Feb 2024 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Cn7r0iZ7"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FDB7FBB8
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533137; cv=none; b=EuLqPUFdSD8qnCLEZXFN11pjqEMyYsm0xPda36g2J+OTgnN3+A0aXI0+HJSjxU0bcrcV2pVIkdgF6xhdVE02UvCD/xxhj8I+Rdu4WFUpIynT7zMuUsAOGq/jNNX/UU6VdAydip3WU4mSeBzmPO3v5Oze/c5Xg47XEI+8X+RBpeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533137; c=relaxed/simple;
	bh=Qhnnq21WvmUtary5xYLxQzZvmF5bro5PLGcnOVAmL4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AptjavNIbrzuYRrLokEi+GZN9Hm6wGRBtjFThti4KFvH59vgjavu3yYBQ6Ck0GK3qrOM+L7+a90/jmXAx7N0x/es5jKg87kSjbpK2JZIPKGMFpWNbp6jmL5NC/1LywydYlYDi4SwR+5ck4i7qrIQSakitkpKRmlP/gc5QosVjpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Cn7r0iZ7; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LBQkT0027891;
	Wed, 21 Feb 2024 17:31:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=RgA97dYX4Od/frVDv9EeyOJvDvfZfZ84xgDgXSNIrPY=; b=Cn
	7r0iZ7b0iqY1dX0racFiikHG1ikeqF20ws9xFUbUjcSZjKKASBG7IlQN3QHtm1oC
	Se+M6TJz1ex2mc4JX/pKRZZ425FjBksCbfP+YpNOXR3FEeOVVeE7+UXuHOQys3/F
	eJQEWjLZ6xzKM4dpPAEJbjEIX4n1oGL5n7GQLvptSk/A6kJMDaXNAvXb4Pq1L6KP
	rOO35s6A3Ps+42VQcz/EEHfliB/81B+nxxk60JTqGLxr96xvr3+EtuVefdLJfWZo
	/XKvmLeaEPrlAV2qznuKRz4emm3qbNSb2I5SjrfHFdYTf3vgx5PMSIwDgbE6yEfm
	Hw8VXTTe6/xLxssqKIrA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wd201m79j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 17:31:18 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id F108B40044;
	Wed, 21 Feb 2024 17:31:06 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1D95F28CFA5;
	Wed, 21 Feb 2024 17:29:58 +0100 (CET)
Received: from [10.201.21.177] (10.201.21.177) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 21 Feb
 2024 17:29:57 +0100
Message-ID: <8ed32443-1343-4970-9f5a-34285850b372@foss.st.com>
Date: Wed, 21 Feb 2024 17:29:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mtd: rawnand: Clarify conditions to enable continuous
 reads
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav
	<pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>,
        Julien Su <juliensu@mxic.com.tw>, Jaime Liao
	<jaimeliao@mxic.com.tw>,
        Jaime Liao <jaimeliao.tw@gmail.com>,
        Alvin Zhou
	<alvinzhou@mxic.com.tw>, <eagle.alexander923@gmail.com>,
        <mans@mansr.com>, <martin@geanix.com>,
        =?UTF-8?Q?Sean_Nyekj=C3=A6r?= <sean@geanix.com>,
        <stable@vger.kernel.org>
References: <20231222113730.786693-1-miquel.raynal@bootlin.com>
 <cce57281-4149-459f-b741-0f3c08af7d20@foss.st.com>
 <20240221122032.502fbf3f@xps-13>
From: Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <20240221122032.502fbf3f@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_03,2024-02-21_02,2023-05-22_02

Hi Miquel,

On 2/21/24 12:20, Miquel Raynal wrote:
> Hi Christophe,
> 
> christophe.kerello@foss.st.com wrote on Fri, 9 Feb 2024 14:35:44 +0100:
> 
>> Hi Miquel,
>>
>> I am testing last nand/next branch with the MP1 board, and i get an issue since this patch was applied.
>>
>> When I read the SLC NAND using nandump tool (reading page 0 and page 1), the OOB is not displayed at expected. For page 1, oob is displayed when for page 0 the first data of the page are displayed.
>>
>> The nanddump command used is: nanddump -c -o -l 0x2000 /dev/mtd9
> 
> I believe the issue is not in the indexes but related to the OOB. I
> currently test on a device on which I would prefer not to smash the
> content, so this is just compile tested and not run time verified, but
> could you tell me if this solves the issue:
> 
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -3577,7 +3577,8 @@ static int nand_do_read_ops(struct nand_chip *chip, loff_t from,
>          oob = ops->oobbuf;
>          oob_required = oob ? 1 : 0;
>   
> -       rawnand_enable_cont_reads(chip, page, readlen, col);
> +       if (!oob_required)
> +               rawnand_enable_cont_reads(chip, page, readlen, col);

I am still able to reproduce the problem with the patch applied.
In fact, when nanddump reads the OOB, nand_do_read_ops is not called, 
but nand_read_oob_op is called, and as cont_read.ongoing=1, we are not 
dumping the oob but the first data of the page.

page 0:
[   57.642144] rawnand_enable_cont_reads: page=0, col=0, readlen=4096, 
mtd->writesize=4096
[   57.650210] rawnand_enable_cont_reads: end_page=1
[   57.654858] nand_do_read_ops: cont_read.ongoing=1
[   59.352562] nand_read_oob_op
page 1:
[   59.355966] rawnand_enable_cont_reads: page=1, col=0, readlen=4096, 
mtd->writesize=4096
[   59.364045] rawnand_enable_cont_reads: end_page=1
[   59.368757] nand_do_read_ops: cont_read.ongoing=0
[   61.390098] nand_read_oob_op

I have not currently bandwidth to work on this topic and I need to 
understand how continuous read is working, but I have made a patch and I 
do not have issues with it when I am using nanddump or mtd_debug tools.

I have not tested it on a file system, so it is just a proposal.

--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -3466,22 +3466,18 @@ static void rawnand_enable_cont_reads(struct 
nand_chip *chip, unsigned int page,
  				      u32 readlen, int col)
  {
  	struct mtd_info *mtd = nand_to_mtd(chip);
-	unsigned int end_page, end_col;
+	unsigned int end_page;

  	chip->cont_read.ongoing = false;

-	if (!chip->controller->supported_op.cont_read)
+	if (!chip->controller->supported_op.cont_read || col + readlen <= 
mtd->writesize)
  		return;

-	end_page = DIV_ROUND_UP(col + readlen, mtd->writesize);
-	end_col = (col + readlen) % mtd->writesize;
+	end_page = page + DIV_ROUND_UP(col + readlen, mtd->writesize) - 1;

  	if (col)
  		page++;

-	if (end_col && end_page)
-		end_page--;
-
  	if (page + 1 > end_page)
  		return;

Tell me if this patch is breaking the continuous read feature or if it 
can be pushed on the mailing list.

Regards,
Christophe Kerello.

>   
>          while (1) {
>                  struct mtd_ecc_stats ecc_stats = mtd->ecc_stats;
> 
> 
> If that does not work, I'll destroy the content of the flash and
> properly reproduce.
> 
> Thanks,
> Miquèl

