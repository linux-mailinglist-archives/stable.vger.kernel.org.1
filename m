Return-Path: <stable+bounces-143130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 745DAAB3100
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A553B26CA
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 08:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74486253F1B;
	Mon, 12 May 2025 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k/0inRMx"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1D0847B;
	Mon, 12 May 2025 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747036974; cv=none; b=CFEDEbr+40FE+e9KuCJ3ZVhl2tZ0xYcjtveG1Zhah+vEzCQ8Z0n93KRX4MPXBOgfPWOJGCqX1Krw07gvnP3FMui7V+xL9AdsxLX/fQPeu+chicnHUvk2SVjHRDJ59WUPhM7jpM5fe/H9xj0H7lU8443I3C5zxaBqyF7Xrs5c/rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747036974; c=relaxed/simple;
	bh=Nst55cqMiYMVHFprUhEL/vDD2A0tDgtMlRdnrM3qjGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FL3CbXNjg7IdT0yJvlcJEuHI3GUNLclJu33czuPctczUNyat7NokiNOS7/l050t5UU2jXD4ohq49LS2WsuAAoqWrdnn1HrZiKRuySNUghJBJhHr6lqufGtvsfDWEw4YeAyct+Fz5+sAT/lZJ69wVvp+eUUkBA/0g5iPFo0t3pCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k/0inRMx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C755Y7027362;
	Mon, 12 May 2025 08:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7JRvNTyxV9YsYCnuwt4edatvqYw2j2
	8lyOI4l2EhUJs=; b=k/0inRMxe48gIMKMfJMiFKtWQwBTAzxcHYxgrDykgZ9QbW
	yEgvr/YjKvOHl9hly9k2/8tZItV1IyW7KsgigqL8cpMB7epKHeEoqbdcP8aeJVsK
	HCvmU2QErrx2iKooihHXaqkwNI9E2snIEVcgKcEA85Vz3Tri/cmglI4BCN6lOgcB
	uZumDSpXOA4d4PqKLahnNRQeQWecWPllWTKa8mjiFSlR967z/EzCa1/nCdAT30Ov
	WchOD+yItLXFJNm4pR86TF6Unz/9Rx9OiMS6FyIOwhX+rX0af1mHGeVaJgPOXm7D
	V5iwCW88rdc/n1bOgy+WyJLYOAkB/DrEI7yvi7rA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kc9m07va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 08:02:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54C53r57025907;
	Mon, 12 May 2025 08:02:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46jj4nmyaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 08:02:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54C82k7A53018894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 08:02:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66BF320040;
	Mon, 12 May 2025 08:02:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F27A02004E;
	Mon, 12 May 2025 08:02:45 +0000 (GMT)
Received: from osiris (unknown [9.111.2.7])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 May 2025 08:02:45 +0000 (GMT)
Date: Mon, 12 May 2025 10:02:44 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: Patch "s390/entry: Fix last breaking event handling in case of
 stack corruption" has been added to the 6.6-stable tree
Message-ID: <20250512080244.12203Abb-hca@linux.ibm.com>
References: <20250511175902.3461288-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511175902.3461288-1-sashal@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=cYzSrmDM c=1 sm=1 tr=0 ts=6821ab2b cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=JgVO5t9tc_OA9yA2:21 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=Zl-5n85lNOg4vEYqP88A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: eQUhHvzRrWBxtaH3wN3FsPcxI08gbhGP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA3OSBTYWx0ZWRfX6RrQN1n6RpJt ZILAU5AzclKTreW2jS8oNi3gdfXS+KBHUcGUdh8hsLJ3h7rS5QwRhpkBuJFfVhbKG/Z2HZn7pE8 sbWTEQuPTfOMcrmMDYqZSakVoK0xhzPqztvOWYr4uffiYJlzNoAYM0Q0OXStyxNoLPwSAapziHi
 Yj7GCDNnBU1kd+lWIiH+PXGDbq5B+4gHv3opPs3P3GNguk5mfjnsyVD6/fmarNVwGJVkqGo6uRr YHgdCuzn7opf78CoembqBleudVBKgZeDYdRse6ORs0uZ7dTar/w7zihXclqKlM1ILTkzdh6vigy pM3b3xEBSyr1a4mdO9q1gmwNO9cQwDubQ4wERkUN94RKlIwN0tnY2bQ31iClSZSx7rsGvlaLCZq
 h4MN9B6boNHg6JnOHHc0h8BwUBhqOiY3CnndabOE4hpjIXPvZedeSdrP/JokFAxfYdikEBqv
X-Proofpoint-ORIG-GUID: eQUhHvzRrWBxtaH3wN3FsPcxI08gbhGP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120079

On Sun, May 11, 2025 at 01:59:02PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     s390/entry: Fix last breaking event handling in case of stack corruption
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      s390-entry-fix-last-breaking-event-handling-in-case-.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This patch shouldn't be applied as it is to 6.6, 6.1, and 5.15 stable kernels,
since it won't compile. I'll provide a slightly modified variant.

