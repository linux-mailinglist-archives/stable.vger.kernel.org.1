Return-Path: <stable+bounces-71368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D1A961D9D
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 06:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C761C22050
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 04:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CC41411DE;
	Wed, 28 Aug 2024 04:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JG/4/4ww"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782DC84D0D;
	Wed, 28 Aug 2024 04:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724819298; cv=none; b=hUpiLS+OrFU27SUa10jz5FIQIo7a59SSs1ucEp6ySbvgQmw5TgmkYkBypYX8wEx1Ad5DFxsXBA4ekzVR83zqm3Ylx1ZVlt0Qb/w3+kO0BcVnXSr14nhydGwCNtQwJ8NAPP1ezPNZ0AzqZeZv83fSGeS8zCWZApU7Xp6OQDelaf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724819298; c=relaxed/simple;
	bh=j7dQoImDB968/XIbVVVl7t2T92nnmGCE9RxmmFkw5No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6AV7fPFReVYNFGhOtOd5vr0Rzv3gpYG1h8WQZPlSEcPvXO3lsBYYlHbBJ9dpFihSwlF9xfOp+Lt2ksaXUR7/qyBEL3ucZL5orsEezi0UPq40/QRPPr8AOOBfv5qfiMnnx04MMfttdjovtbUlOJiFOACSHcsYXTzvopRW4DfioQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JG/4/4ww; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RM3ZAf032439;
	Wed, 28 Aug 2024 04:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=lrEZQLNScxO3Ad12qhfC5Blo4k1
	ghWzWwmtxsRS0TaQ=; b=JG/4/4wwSurqJ7O7QxmT08L4os76Q1msQDO7lJj8CvX
	tORO8qMBeN99LNt1etXWuWubIsz0ezG4zyYA7riWeROJgONx5k1ki+VTt92tlIX9
	Fbnr9rXpnOifMQnIupiHI4aIhFmG3H8haXU0wDsSc23F5rHDbSbIBDC2RMc6IQX7
	ucjVAhLPeLl/6iD8Gj6BTedDqPnLHDwXUwV+anBFR63ZhICQBkQTj5xjdfw2qsZf
	IFiPrsC5TGTj59loMGX8I/32y3iy3HoxXyRSIAdE6S97TYpFQFmqbi0Q8INaGlfM
	kaAp8eJGjduvXpPzeWPg14YZhiKaBuJY7eut7/nBJzQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8u0yqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 04:28:00 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47S4RxO8011537;
	Wed, 28 Aug 2024 04:27:59 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8u0yqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 04:27:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47S0ihTC003137;
	Wed, 28 Aug 2024 04:27:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 417tupwvfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 04:27:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47S4RpO156361324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 04:27:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABB7420040;
	Wed, 28 Aug 2024 04:27:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14B1520043;
	Wed, 28 Aug 2024 04:27:51 +0000 (GMT)
Received: from localhost (unknown [9.43.2.34])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Aug 2024 04:27:50 +0000 (GMT)
Date: Wed, 28 Aug 2024 09:57:49 +0530
From: "Nysal Jan K.A." <nysal@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org,
        Geetika Moolchandani <geetika@linux.ibm.com>,
        Vaishnavi Bhat <vaish123@in.ibm.com>,
        Jijo Varghese <vargjijo@in.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/qspinlock: Fix deadlock in MCS queue
Message-ID: <r5teromuglnzq223dbou22m6if4ustlrvmp3tpvyjfjwatysta@s7ttblybzrxz>
References: <20240826081251.744325-1-nysal@linux.ibm.com>
 <D3R7YDW8U4QJ.1ZC4SPQN5SY1G@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D3R7YDW8U4QJ.1ZC4SPQN5SY1G@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9puRA-3cm2DeKhk8hqMwCnCsVnUtU6g3
X-Proofpoint-ORIG-GUID: ux2KRmQM4WDMz_MtQ-SwpFLq-YyTkmUj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_02,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=803 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408280027

On Wed, Aug 28, 2024 at 01:19:46PM GMT, Nicholas Piggin wrote:
<snip>
> What probably makes it really difficult to hit is that I think both
> locks A and B need contention from other sources to push them into
> queueing slow path. I guess that's omitted for brevity in the flow
> above, which is fine.
> 

I'll mention that in the commit message, just so that it is clear.

> 
> AFAIKS this fix works.
> 
> There is one complication which is those two stores could be swapped by
> the compiler. So we could take an IRQ here that sees the node has been
> freed, but node->lock has not yet been cleared. Basically equivalent to
> the problem solved by the barrier() on the count++ side.
> 
> This reordering would not cause a problem in your scenario AFAIKS
> because when the lock call returns, node->lock *will* be cleared so it
> can not cause a problem later.
> 
> Still, should we put a barrier() between these just to make things a
> bit cleaner? I.e., when count is decremented, we definitely won't do
> any other stores to node. Otherwise,
> 

Agree, that will make it cleaner.

> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
> Thanks,
> Nick

Thanks for the review Nick, I'll send a v2 with these changes.

Regards
--Nysal

