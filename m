Return-Path: <stable+bounces-116797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C424A3A0CA
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 16:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6942F3A35EC
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA2226AAA8;
	Tue, 18 Feb 2025 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lOHVOoyS"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC71269AF4;
	Tue, 18 Feb 2025 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739891313; cv=none; b=UfAXn6edwAWxakf6tWRZPehlqSnnYilnc7Ca023ESRTorREPyl+kEpIYZb6OS0Iz6Hukq0S77u/t58obizRutPyGfTdodWZ4WOqzNDRRx305Y1t0BCTOOlqvd5kF6H4DrDNKOn/H26XbmEtFoxY/sBW3Mak0td20QLSJAbBb8yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739891313; c=relaxed/simple;
	bh=N3f3w6xDe70ElFGP8MyQepgO3g97i+zvP3CKOMHikEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBNYxRNWDQXyZAtWc1snRuVdyF0TIkojgigQsnLdM74ka4wrZdRqBYznyiymB1jqow8gnsfZ6gFmIai5uCWD9fBchfb+FzZFi1jYtpk+kikW/zQ5uV6hK0vBlXtDAJllmaAiwkwCCEjYI5AFJFq9ynjXUupw8iWUe8b0siKnIj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lOHVOoyS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ICsfal000995;
	Tue, 18 Feb 2025 15:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tRHzn0
	D8cT3+8Av3V8Tl9tmk5nNmERPXBlqr9Je1HDk=; b=lOHVOoySOInK/Pr+ooApt2
	AT+vl+jDyFCuDx8ic2OWX1Uwo8BgSyYfEya6nFc5E6iC/5Ws30bMTrA5xmD3osOY
	2Q0KXTGdSPRCO7ghBoi7oAydKXmIEGa8u/L07dQdWR3XL4Iu21mc/b/ftV0Op5CE
	I2Lj0AWoSZBo0NHURPzdwi2V2bKHnEZrui8QdNu84sgyQ3dG9VuQWMyHl9awoPbO
	RDYcMTaCbfkh7IuLzKFpom3ogBoqJA8drVA27Ru8sdA/maIqYYSwI4PkjgwrLuWx
	RNLIestscpcTSHfkx635OYetOzXLWwByu6oszYeJz/CIZyY4U0JFegmZavlmUf6A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vh2039xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 15:08:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51IErkF0013271;
	Tue, 18 Feb 2025 15:08:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44u7fkkjcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 15:08:29 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51IF8PS159441526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 15:08:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B73FD2004F;
	Tue, 18 Feb 2025 15:08:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CAFB2004E;
	Tue, 18 Feb 2025 15:08:25 +0000 (GMT)
Received: from [9.152.224.153] (unknown [9.152.224.153])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Feb 2025 15:08:25 +0000 (GMT)
Message-ID: <b01c840b-55fb-455d-88fa-69848d2dcebf@linux.ibm.com>
Date: Tue, 18 Feb 2025 16:08:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "s390/qeth: move netif_napi_add_tx() and napi_enable() from
 under BH" has been added to the 6.13-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Thorsten Winkler <twinkler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20250218123639.3271098-1-sashal@kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250218123639.3271098-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3BvEETAomPPc183iRx7V9kgf-o5eFtH1
X-Proofpoint-ORIG-GUID: 3BvEETAomPPc183iRx7V9kgf-o5eFtH1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_07,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180111



On 18.02.25 13:36, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     s390/qeth: move netif_napi_add_tx() and napi_enable() from under BH
> 
> to the 6.13-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      s390-qeth-move-netif_napi_add_tx-and-napi_enable-fro.patch
> and it can be found in the queue-6.13 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 

Hello Sasha,
this is a fix for a regression that was introduced with v6.14-rc1.
So I do not think it needs to go into 6.13 stable tree.
But it does not hurt either.


> 
> 
> commit 48eda8093b86b426078bd245a9b4fbc5d057c436
> Author: Alexandra Winter <wintera@linux.ibm.com>
> Date:   Wed Feb 12 17:36:59 2025 +0100
> 
>     s390/qeth: move netif_napi_add_tx() and napi_enable() from under BH
>     
>     [ Upstream commit 0d0b752f2497471ddd2b32143d167d42e18a8f3c ]
>     
>     Like other drivers qeth is calling local_bh_enable() after napi_schedule()
>     to kick-start softirqs [0].
>     Since netif_napi_add_tx() and napi_enable() now take the netdev_lock()
>     mutex [1], move them out from under the BH protection. Same solution as in
>     commit a60558644e20 ("wifi: mt76: move napi_enable() from under BH")
>     
>     Fixes: 1b23cdbd2bbc ("net: protect netdev->napi_list with netdev_lock()")
>     Link: https://lore.kernel.org/netdev/20240612181900.4d9d18d0@kernel.org/ [0]
>     Link: https://lore.kernel.org/netdev/20250115035319.559603-1-kuba@kernel.org/ [1]
>     Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>     Acked-by: Joe Damato <jdamato@fastly.com>
>     Link: https://patch.msgid.link/20250212163659.2287292-1-wintera@linux.ibm.com
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
> index a3adaec5504e4..20328d695ef92 100644
> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -7050,14 +7050,16 @@ int qeth_open(struct net_device *dev)
>  	card->data.state = CH_STATE_UP;
>  	netif_tx_start_all_queues(dev);
>  
> -	local_bh_disable();
>  	qeth_for_each_output_queue(card, queue, i) {
>  		netif_napi_add_tx(dev, &queue->napi, qeth_tx_poll);
>  		napi_enable(&queue->napi);
> -		napi_schedule(&queue->napi);
>  	}
> -
>  	napi_enable(&card->napi);
> +
> +	local_bh_disable();
> +	qeth_for_each_output_queue(card, queue, i) {
> +		napi_schedule(&queue->napi);
> +	}
>  	napi_schedule(&card->napi);
>  	/* kick-start the NAPI softirq: */
>  	local_bh_enable();


