Return-Path: <stable+bounces-116802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F882A3A14B
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 16:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11C916FE13
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 15:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B40926A1B0;
	Tue, 18 Feb 2025 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TuTzUoIA"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825A92309B5;
	Tue, 18 Feb 2025 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892758; cv=none; b=RCyS1M6hmUf17yoxPr/7LgH3BSKnoqwwBL8h+htx4XQdUrKGZOLa4PexfQvBtXMctH/Me1tI+t7g3hbogARshhsMrRMG0pq7sugCq0j3X64ahMhg4vIBMsCi9tVdTljmUNmlTAazBA07ZAqYWiYzb4Lao4EvT292NvZohYm8iSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892758; c=relaxed/simple;
	bh=cebdUepuNmHAOy5Y0aQZ25FQI35Aq8QteNsvMkN1rw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbLgIVO6+j90obPBJ3mKuy0nCfEcKFjHJFm6Zts4eNDl1ykeTE7/rMdn8RoKbUx5eanFVaqqj75gngaqztVJpSZjDFokT5LsphdK/kwdLbu8iLbP1z28LAYTMdVV7jnN1fnI5M11YVx0M3gYh2ns89Rop82IsBYSsGXIesWm8lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TuTzUoIA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I7YZHO012419;
	Tue, 18 Feb 2025 15:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ezITce
	tY82oZmI8ZqAp0N40R8I0MQ2cOiJxYTTekkRM=; b=TuTzUoIAuQVLjvEm3IgfnT
	qd/Gy9xAVVP/1Z9P7MxynVRI0uE5GCdSaDbGUY53kAMMl/+q6Z1/4/1KOj6yaWAQ
	1sXZZ/PLvwfaRW69M4cXopSjPBx2pOoJ5nQxQmCFVp4+DIY0epOSXsh7WEermrrW
	qp57YJJ8kBV+xpwqKFSrzkUCNlyP050anCX3IJRvGFkok34IgHCDaJj1T/PUwyY1
	uMo2n56VUqFTzT3kAAQ/4wndrdqygIk3uD7dPcMz/Ll8T2L1dyr33H5hC2CG4hPI
	EwDS/GX+xzVf39LQTNtkSignul0m8fKdH7zZrHsjJSixyWM8t2KNUhkaaR+Nudfg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vnwpj9x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 15:32:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51IDQaJF001641;
	Tue, 18 Feb 2025 15:32:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u5myv02a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 15:32:31 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51IFWSNC41157068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 15:32:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBC632004E;
	Tue, 18 Feb 2025 15:32:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB4CB20049;
	Tue, 18 Feb 2025 15:32:27 +0000 (GMT)
Received: from [9.152.224.153] (unknown [9.152.224.153])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Feb 2025 15:32:27 +0000 (GMT)
Message-ID: <febb6754-f2a3-411c-a201-c403960856d0@linux.ibm.com>
Date: Tue, 18 Feb 2025 16:32:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "s390/qeth: move netif_napi_add_tx() and napi_enable() from
 under BH" has been added to the 6.13-stable tree
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20250218123639.3271098-1-sashal@kernel.org>
 <b01c840b-55fb-455d-88fa-69848d2dcebf@linux.ibm.com>
 <2025021828-pond-matador-38d9@gregkh>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <2025021828-pond-matador-38d9@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a7dFZDyYc7MjvgatGB4ZbE9hMXUW8xKz
X-Proofpoint-ORIG-GUID: a7dFZDyYc7MjvgatGB4ZbE9hMXUW8xKz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_07,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180114



On 18.02.25 16:19, Greg KH wrote:
> On Tue, Feb 18, 2025 at 04:08:25PM +0100, Alexandra Winter wrote:
>>
>>
>> On 18.02.25 13:36, Sasha Levin wrote:
>>> This is a note to let you know that I've just added the patch titled
>>>
>>>     s390/qeth: move netif_napi_add_tx() and napi_enable() from under BH
>>>
>>> to the 6.13-stable tree which can be found at:
>>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>>
>>> The filename of the patch is:
>>>      s390-qeth-move-netif_napi_add_tx-and-napi_enable-fro.patch
>>> and it can be found in the queue-6.13 subdirectory.
>>>
>>> If you, or anyone else, feels it should not be added to the stable tree,
>>> please let <stable@vger.kernel.org> know about it.
>>>
>>
>> Hello Sasha,
>> this is a fix for a regression that was introduced with v6.14-rc1.
>> So I do not think it needs to go into 6.13 stable tree.
>> But it does not hurt either.
> 
> It fixes a commit that is already in the 6.13 stable queue:
> 
>>>     Fixes: 1b23cdbd2bbc ("net: protect netdev->napi_list with netdev_lock()")
> 
> So for that reason, this commit should be applied, right?
> 
> thanks,
> 
> greg k-h


In that case: Yes, of course.

Sorry. I didn't expect Jakub's netdev->lock series to have gone into stable.
I should have checked.

