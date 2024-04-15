Return-Path: <stable+bounces-39430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E94948A4F58
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4883283C56
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 12:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3C671B27;
	Mon, 15 Apr 2024 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FfSPlHIA"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBBF70CAD;
	Mon, 15 Apr 2024 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184948; cv=none; b=Ozkt4mNHGkLcvKsmdAg2FPYodlMe94QIJsFqLkMVLP2xwUCIVjVqPFdzXWXsPxRWM4ssXga838QN72X4UmF2N+Dg6yeEvAPVDHhuKMi9HXE9O7a+eACWng1sCm7w2Ic6DAdi3Kal30F2J0MnzKKu9aKJHZPCKKo6HyQ/bBWykNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184948; c=relaxed/simple;
	bh=SLqPUDnZQJ7KLOZ3S73Gfp8HN/lMB/aQX+C6Ajq9sJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cwru8VthFwbs3h1SmmhERKumABfjDyOLd5iiWlvJUvi1hyvX9GMiqcESUeFE+RkgYQxY/4Lkk/xtvLKkXoez6lpiHMtX8anRE+pdgkhNVhCnilRLD1sKWO0oH+2o02wFRcHxb9Mx0PNZlqUiuIK3XKu1WcTrdFQt26pxh7nnMsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FfSPlHIA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43F8TVhh019165;
	Mon, 15 Apr 2024 12:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=RVpea6VquN9ZLWMpRPLrV7d60QonAocYJrd3Fd1Oobk=;
 b=FfSPlHIAqnK/FJ2PydhNqc4Am3shD4wFGaa6F05pIQqzZtMnJFf3LtUQraPrSzoQqvpk
 OWbnPo7Vr1dPSy/nhzujBXajo+yFFR+exc5Dv04uxvwbIDttj+5SqwFrU/e5E4oTNZs4
 kMSSHRP4yofeQHi7gehxCZlAkDL75zUmIMfvMPeKU9oNFmJlO1BIfPQ6EMOPoOoqFyZ9
 xSp8LGVZELhlQ0v9uwNegiobAOMhj96yn3g9Wg5SYwde8Wq69mMCpqIuiFZdI/UAzeVj
 vhf/ukfOS+FpH/Qr5WA00lPT/bAulBHDDCFxhr2dr967oxsFTBLC5Yw+287Pd8cZ0eia MA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xgmufhgvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 12:42:24 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43FCQBom018162;
	Mon, 15 Apr 2024 12:42:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg4ct02vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 12:42:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43FCgIEW49348972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 12:42:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CBA92004D;
	Mon, 15 Apr 2024 12:42:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09E5020040;
	Mon, 15 Apr 2024 12:42:18 +0000 (GMT)
Received: from osiris (unknown [9.179.22.156])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 15 Apr 2024 12:42:17 +0000 (GMT)
Date: Mon, 15 Apr 2024 14:42:16 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, gbayer@linux.ibm.com,
        Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: Patch "Revert "s390/ism: fix receive message buffer allocation""
 has been added to the 6.8-stable tree
Message-ID: <20240415124216.7816-B-hca@linux.ibm.com>
References: <20240415085924.3035257-1-sashal@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415085924.3035257-1-sashal@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FzlKNRcO_NzY6X1g3IyERp38BVIHTDYh
X-Proofpoint-ORIG-GUID: FzlKNRcO_NzY6X1g3IyERp38BVIHTDYh
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_10,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=957
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150082

On Mon, Apr 15, 2024 at 04:59:24AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     Revert "s390/ism: fix receive message buffer allocation"
> 
> to the 6.8-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      revert-s390-ism-fix-receive-message-buffer-allocatio.patch
> and it can be found in the queue-6.8 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 8568beeed3944bd4bf4c3683993a9df6ae53fbb7
> Author: Gerd Bayer <gbayer@linux.ibm.com>
> Date:   Tue Apr 9 13:37:53 2024 +0200
> 
>     Revert "s390/ism: fix receive message buffer allocation"
>     
>     [ Upstream commit d51dc8dd6ab6f93a894ff8b38d3b8d02c98eb9fb ]
>     
>     This reverts commit 58effa3476536215530c9ec4910ffc981613b413.
>     Review was not finished on this patch. So it's not ready for
>     upstreaming.
>     
>     Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
>     Link: https://lore.kernel.org/r/20240409113753.2181368-1-gbayer@linux.ibm.com
>     Fixes: 58effa347653 ("s390/ism: fix receive message buffer allocation")
>     Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

I'm not sure if it makes sense to add and revert a patch within a
single stable queue (the same applies to 6.6). It might make sense to
drop both patches.

