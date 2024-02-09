Return-Path: <stable+bounces-19381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4CA84F614
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 14:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FDD28377A
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 13:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7F23C68E;
	Fri,  9 Feb 2024 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Okd7x1tc"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A968E3C6B9
	for <stable@vger.kernel.org>; Fri,  9 Feb 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485825; cv=none; b=W/0a1r5TK4Se0m+CPQ5yx/XXhsFrIwbfR0lZtL0S6nHfB6sLz1UwIi59wcp5xPXQF2C/3NfK3RXAOwbLnh4LRSO8lUQaOM0hKWIrLCfLDWKRf8eXAPWlgdRYqglsLiWRQQdeFjmuEf5iQ8QK3QePVsfFOgJ9QAA3l9q3JwaU9hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485825; c=relaxed/simple;
	bh=kfTVrwcpX3p4AJNgFqVOizgY7/PPieRyaJ8WISQuaK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ALKZC3KfSSKqiY5wcnACkijMZdAt1+IeXg0Nyyj5y0D/n/wvClAhgIOhucNiqXPY6huY4WfjO+HOSwLRFTOzXkSLG/FaRulGpoG73OgwCOox+BOvVO7sEIivAAJeEF6OGdKKvjsw6ggXbqh02exAA63lvBPX3eNLPDD2TK3SMhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Okd7x1tc; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419DQV2U025580;
	Fri, 9 Feb 2024 14:35:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=eCEkKbZGZPL3zRpBq/852hOYd7stcJAFijx6CGG5eU4=; b=Ok
	d7x1tc9V/Hkn6VKrH0MPwWzDV8LmBIB4KBOB42nxxy8Cuh2NRlkz0XEM2WMhg3hz
	NvoBoUB12VDKBVUDUaPoabiJd0F2cQChnkMpV6P7pSiGs+cJ0lcYRFMifSKQQmU5
	Qoq/TSV8xDNUJ9je6dy2jsJb3bru8u48liColUWBqraDBhGheS2QhuFOtSlLMEq+
	H3iSE+m5XrO34kpVpEJSV6/Mn8RJoqOmRVIu94bbmo8qh2MESUz+Zj1sjE2cwsDU
	L1bFwqaQBujWG8qGaGB8GMa3xOfJexQNvrbWH08xE3OptgHxYVtewfbJRKmrqnBD
	FtHPnMXHJvio26K0dnBg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w1f6414p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 14:35:47 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7FAE410004F;
	Fri,  9 Feb 2024 14:35:46 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6BBDA22FA2C;
	Fri,  9 Feb 2024 14:35:46 +0100 (CET)
Received: from [10.201.22.200] (10.201.22.200) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 9 Feb
 2024 14:35:45 +0100
Message-ID: <cce57281-4149-459f-b741-0f3c08af7d20@foss.st.com>
Date: Fri, 9 Feb 2024 14:35:44 +0100
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
References: <20231222113730.786693-1-miquel.raynal@bootlin.com>
From: Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <20231222113730.786693-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_11,2024-02-08_01,2023-05-22_02

Hi Miquel,

I am testing last nand/next branch with the MP1 board, and i get an 
issue since this patch was applied.

When I read the SLC NAND using nandump tool (reading page 0 and page 1), 
the OOB is not displayed at expected. For page 1, oob is displayed when 
for page 0 the first data of the page are displayed.

The nanddump command used is: nanddump -c -o -l 0x2000 /dev/mtd9

Page 0:
   OOB Data: 7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00 
|.ELF............|
   OOB Data: 03 00 28 00 01 00 00 00 a4 03 00 00 34 00 00 00 
|..(.........4...|
   OOB Data: 7c 11 00 00 00 04 00 05 34 00 20 00 06 00 28 00 
||.......4. ...(.|
   OOB Data: 1b 00 1a 00 01 00 00 00 00 00 00 00 00 00 00 00 
|................|
   OOB Data: 00 00 00 00 10 05 00 00 10 05 00 00 05 00 00 00 
|................|
   OOB Data: 00 00 01 00 01 00 00 00 e8 0e 00 00 e8 0e 01 00 
|................|
   OOB Data: e8 0e 01 00 44 01 00 00 48 01 00 00 06 00 00 00 
|....D...H.......|
   OOB Data: 00 00 01 00 02 00 00 00 f0 0e 00 00 f0 0e 01 00 
|................|
   OOB Data: f0 0e 01 00 10 01 00 00 10 01 00 00 06 00 00 00 
|................|
   OOB Data: 04 00 00 00 04 00 00 00 f4 00 00 00 f4 00 00 00 
|................|
   OOB Data: f4 00 00 00 44 00 00 00 44 00 00 00 04 00 00 00 
|....D...D.......|
   OOB Data: 04 00 00 00 51 e5 74 64 00 00 00 00 00 00 00 00 
|....Q.td........|
   OOB Data: 00 00 00 00 00 00 00 00 00 00 00 00 06 00 00 00 
|................|
   OOB Data: 10 00 00 00 52 e5 74 64 e8 0e 00 00 e8 0e 01 00 
|....R.td........|

Page 1:
   OOB Data: ff ff 94 25 8c 3c c7 44 e7 c0 b7 b0 92 5e 50 fb 
|...%.<.D.....^P.|
   OOB Data: 80 ca a3 de e2 73 b4 4e 58 39 fe b4 85 76 65 31 
|.....s.NX9...ve1|
   OOB Data: 48 86 91 f3 58 0b 59 df 2c 08 75 8b 6f 48 36 a6 
|H...X.Y.,.u.oH6.|
   OOB Data: bc 16 61 58 db 52 08 75 8b 6f 48 36 a6 bc 16 61 
|..aX.R.u.oH6...a|
   OOB Data: 58 db 52 08 75 8b 6f 48 36 a6 bc 16 61 58 db 52 
|X.R.u.oH6...aX.R|
   OOB Data: 08 75 8b 6f 48 36 a6 bc 16 61 58 db 52 08 75 8b 
|.u.oH6...aX.R.u.|
   OOB Data: 6f 48 36 a6 bc 16 61 58 db 52 ff ff ff ff ff ff 
|oH6...aX.R......|
   OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
|................|
   OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
|................|
   OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
|................|
   OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
|................|
   OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
|................|
   OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
|................|
   OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
|................|

I have checked what is happening in rawnand_enable_cont_reads function,
and for page 0, con_read.ongoing = true when for page 1 con_read.ongoing 
= false

page 0:
[   51.785623] rawnand_enable_cont_reads: page=0, col=0, readlen=4096, 
mtd->writesize=4096
[   51.793751] rawnand_enable_cont_reads: end_page=1, end_col=0
[   51.799356] rawnand_enable_cont_reads: con_read.ongoing=1

page 1:
[   53.493337] rawnand_enable_cont_reads: page=1, col=0, readlen=4096, 
mtd->writesize=4096
[   53.501413] rawnand_enable_cont_reads: end_page=1, end_col=0
[   53.507013] rawnand_enable_cont_reads: con_read.ongoing=0

I do not expect con_read.ongoing set to true when we read one page.

I have also dumped what happened when we read the bad block table and it 
is also strange for me in particular the value end_page.

[    1.581940] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xd3
[    1.581966] nand: Micron MT29F8G08ABACAH4
[    1.581974] nand: 1024 MiB, SLC, erase size: 256 KiB, page size: 
4096, OOB size: 224
[    1.582379] rawnand_enable_cont_reads: page=262080, col=0, readlen=5, 
mtd->writesize=4096
[    1.582411] rawnand_enable_cont_reads: end_page=0, end_col=5
[    1.582419] rawnand_enable_cont_reads: con_read.ongoing=0
[    1.585817] Bad block table found at page 262080, version 0x01
[    1.585943] rawnand_enable_cont_reads: page=262080, col=0, readlen=5, 
mtd->writesize=4096
[    1.585960] rawnand_enable_cont_reads: end_page=0, end_col=5
[    1.585968] rawnand_enable_cont_reads: con_read.ongoing=0
[    1.586677] rawnand_enable_cont_reads: page=262016, col=0, readlen=5, 
mtd->writesize=4096
[    1.586700] rawnand_enable_cont_reads: end_page=0, end_col=5
[    1.586708] rawnand_enable_cont_reads: con_read.ongoing=0
[    1.587139] Bad block table found at page 262016, version 0x01
[    1.587168] rawnand_enable_cont_reads: page=262081, col=5, 
readlen=1019, mtd->writesize=4096
[    1.587181] rawnand_enable_cont_reads: end_page=0, end_col=1024
[    1.587189] rawnand_enable_cont_reads: con_read.ongoing=0
[    1.587672] rawnand_enable_cont_reads: page=262081, col=1024, 
readlen=5, mtd->writesize=4096
[    1.587692] rawnand_enable_cont_reads: end_page=0, end_col=1029
[    1.587700] rawnand_enable_cont_reads: con_read.ongoing=0

I currently do not understand the logic implemented but there is 
something suspect around end_page variable.

end_page = DIV_ROUND_UP(col + readlen, mtd->writesize);
=> So, if i have well understood, end_page is the number of pages we are 
going to read.

if (page + 1 > end_page) {
=> We are comparing the page that we are starting to read with the 
number of pages to read and not the last page to read

chip->cont_read.first_page = page;
chip->cont_read.last_page = end_page;
=> first_page is the first page to read and last page is the number of 
pages to read.

Before this patch,
chip->cont_read.last_page = page + ((readlen >> chip->page_shift) & 
chip->pagemask);
=> last page was the last page to read.

Regards,
Christophe Kerello.

On 12/22/23 12:37, Miquel Raynal wrote:
> On Fri, 2023-12-15 at 12:32:08 UTC, Miquel Raynal wrote:
>> The current logic is probably fine but is a bit convoluted. Plus, we
>> don't want partial pages to be part of the sequential operation just in
>> case the core would optimize the page read with a subpage read (which
>> would break the sequence). This may happen on the first and last page
>> only, so if the start offset or the end offset is not aligned with a
>> page boundary, better avoid them to prevent any risk.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache reads")
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next.
> 
> Miquel
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

