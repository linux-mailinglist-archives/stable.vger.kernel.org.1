Return-Path: <stable+bounces-200532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A58CB1D8B
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 04:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8822A30528D4
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 03:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DA3274669;
	Wed, 10 Dec 2025 03:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mYWFHWaw"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2528922128B;
	Wed, 10 Dec 2025 03:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765339195; cv=none; b=jXC+Cd7AkO2TUGss2rBCSc3/Dtlmbr9nOoRdmih0h8kFxUuTvMiH5w9ticZL3MTLxGJFh6EH+dcimsn4Fk026cCbpqyd8EjSzCQzg2S6dvG6nuCVmrbcRRmlHa1hDE+zDmf6mzRfXjmEn8dc5mmVD6qfnlb86LTwBk614bH9eFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765339195; c=relaxed/simple;
	bh=vSuKjC0yEKEKa6s+93xjI0xrhqEMNE/AC9yI/hxVyC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GExHhyKKnEJx/zH281146P3VGSrjpJYRfW+N6LPGJXD/+ckXSNbr9jR8WAXvSpv9M6aCsz/g2ZQ7DTCNiX28O9SAc1OYikfldOypbhX5T+J88FgzcqzEHEBQ94Yb9rtAQA27kZmOQv2tiBvjLZGY9XGWBrXqOutLEs+g7vrOxV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mYWFHWaw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9GZ4gJ023198;
	Wed, 10 Dec 2025 03:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vSuKjC
	0yEKEKa6s+93xjI0xrhqEMNE/AC9yI/hxVyC0=; b=mYWFHWawmdNu39UpVZZEpF
	hbmNVJR26Cibw22s1PJxu5HAZNTGvB+A8nzpXuIcM8OLRhGeG/XruP4nnVuDnxDK
	qaUDsCMaK4UpjjfSG60h3KiHLGEyaLoOhaYV9LPOJS0fuCHOe4jQo3iiPQfEWzyZ
	c/2Ftca53qZWvbFndPHPY4bW3yjlSyV7vohDsMmuSIdKaHVA3FHs61kFldTx0Rjg
	gyCGRfGYaHUndnFYXoff/nvaLo1IjaBkfjdcPIPKhyIF97ksZkAGsLVs5e+YNV9r
	xfhDIStcBzGp7QuE978sS3DwpKuhND4gmiZsHr9yOEojnf6U4nX67zXavKqEJV7w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvr2rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 03:59:31 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BA3xVim022153;
	Wed, 10 Dec 2025 03:59:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvr2ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 03:59:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BA2XuWu012812;
	Wed, 10 Dec 2025 03:59:30 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aw0ajxha1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 03:59:30 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BA3xT2W25035318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 03:59:30 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B31BD5803F;
	Wed, 10 Dec 2025 03:59:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E68CF58060;
	Wed, 10 Dec 2025 03:59:25 +0000 (GMT)
Received: from [9.109.209.83] (unknown [9.109.209.83])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Dec 2025 03:59:25 +0000 (GMT)
Message-ID: <db8b70aa-efb8-4508-bfc8-d4427a75dc88@linux.ibm.com>
Date: Wed, 10 Dec 2025 09:29:24 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc: Add reloc_offset() to font bitmap pointer
 used for bootx_printf()
To: Finn Thain <fthain@linux-m68k.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Cedar Maxwell <cedarmaxwell@mac.com>, Stan Johnson <userm57@yahoo.com>,
        "Dr. David Alan Gilbert"
 <linux@treblig.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <22b3b247425a052b079ab84da926706b3702c2c7.1762731022.git.fthain@linux-m68k.org>
 <697723f8-ab0b-4cc4-9e83-ea710f62951a@csgroup.eu>
 <3ff1f917-fad4-c914-1ffc-58a5d8185368@linux-m68k.org>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <3ff1f917-fad4-c914-1ffc-58a5d8185368@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mo8uEcKTo_L2kOjX4tj8NW2EGiDy4CHl
X-Proofpoint-ORIG-GUID: fxMntS1jCNBUUIUn4dDlisCT7KVnqHy5
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=6938f023 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1UX6Do5GAAAA:8 a=bgEqKxG8ouH14nev-uYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX4Dehw9duoXy/
 n3Qmwb94yvlpF4f2LBepzzz0Cmdy3xBE2S+wqJk/gHotUPa0nL3n0e0DHfCTDL5uVl2gupQvl3b
 CSDf9yUK0yEBkVDXwk5aNmyat7a7TeJNxkxWS4vBnDgHbVMBR1ZXLWbFyxOw4f4axNSNKBlyYaJ
 0YOfAMnxpKNBnpwxsUn9f2xCv0m/rPn3zWPi6uzhZMV8VahI98UwNn76asels9+8QnMgtVpjkQI
 P0lUdC1L/gzVAR5ri6QkDkiLLQNtKfgxdzP7xuqZ1QFI8s1zFgC9rpHRwQZgURBr/f2YXJmNs/W
 1qo3s+FZ2lXRFokHJ03pbT1BQnn2TwrPJRi0WFKm/x9B8V/+LAgkNfx2Gncpdfub7obwIYDuRLG
 vPO6v+aWGKz/c7HnW0x37NAgVtLxow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000


On 12/10/25 3:11 AM, Finn Thain wrote:
> I noticed that this bug fix did not get included in the 'powerpc-6.19-1'
> pull last week. Was there a reason for that?

My bad, Will add it as part of the -rc  PR

Maddy

> On Wed, 12 Nov 2025, Christophe Leroy wrote:
>
>> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>

