Return-Path: <stable+bounces-50518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BE0906B00
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3704282977
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DD51411E0;
	Thu, 13 Jun 2024 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JJsz3lHw"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8079E5BACF
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278198; cv=none; b=bKxiyv1EmXt59L14fsxH2pcgHJXVPG9Xx4VGMLC7q5A61Y3e7AU0kUJC97OFGpPp4hGoLZpQ53r83UPMxz3yJhYbJTQgS6DVMyqNp0EugfOD0KWx0KfrWPvPSUuSA0Kkrus/0mgYEQk+bk8j3fWHAdyA6UYHktFMsEKGSswYUmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278198; c=relaxed/simple;
	bh=T6uZnfSzdX0IUpv6hf91Qhf9lgFc6kpkMYemBUFTg+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=oU/Ohh/C4dOd5HekKLU3aVXD/nU9StxFS/MjSegERZ+4Dls8RBsCdCOXjFP8HAuJq5CygsmzKp+toPZejioyafSTY38kSTSbn4kHmevKORh1UC3irTBbFO1pBY+pCf5Ir856sGaWMuSJVFFaZBG2+x1Uj8X5qv4FXripRVQzvqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JJsz3lHw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D9KXS5007959;
	Thu, 13 Jun 2024 11:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:reply-to:in-reply-to:references:message-id
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	TNSFjjMHPcSDJinGkQ6Jojv2qSo9QPYLdAUjKLxJ1Ss=; b=JJsz3lHwtj2RKL5/
	6E+Pt64cBhSm0uwvo634poagODM4lv57L8d9omQVR69FKcuXq0hb2aV5Rw/6Ofch
	8MdI9ydDHTsFldgoRYKefMBVm/0/Zprz+suo95FyxBY62xpoyAvCET923IyFP9qB
	8kFsn/P2T/PUn8xqAlzFHuR3CoH67hmBDzBkaRrWKWhKhx5UBpblIx96Aopgrj73
	T3MBvVRX45KkFvguntXXo3CFKlz7lWXw/8f1B2g88e92Q9ek3/LhTKyV5Z2qzQBG
	KBBlTfRs5xkYzFwsMDx+TL9Q8ksRTi+gab0cxQnVOe1tOvrf9QObsniuKML+zUZA
	mTX1/g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqpq09be5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 11:29:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45DABZ7V023575;
	Thu, 13 Jun 2024 11:29:53 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn3umxjgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 11:29:53 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45DBTnpf48431546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 11:29:51 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ACB758056;
	Thu, 13 Jun 2024 11:29:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B1455803F;
	Thu, 13 Jun 2024 11:29:49 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Jun 2024 11:29:49 +0000 (GMT)
Date: Thu, 13 Jun 2024 13:29:48 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: gregkh@linuxfoundation.org
Cc: dengler@linux.ibm.com, hca@linux.ibm.com, jchrist@linux.ibm.com,
        nsg@linux.ibm.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] s390/cpacf: Split and rework cpacf query
 functions" failed to apply to 4.19-stable tree
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <2024061300-undead-mortuary-7444@gregkh>
References: <2024061300-undead-mortuary-7444@gregkh>
Message-ID: <884044c9000408bac4fe190f3dc684af@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BKben24hu0aRZVerHDTdBEVXerY6YYR1
X-Proofpoint-GUID: BKben24hu0aRZVerHDTdBEVXerY6YYR1
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_03,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1011 mlxlogscore=955
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130082

On 2024-06-13 12:10, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 4.19-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following 
> commands:
> 
> git fetch
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
> linux-4.19.y
> git checkout FETCH_HEAD
> git cherry-pick -x 830999bd7e72f4128b9dfa37090d9fa8120ce323
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to
> '2024061300-undead-mortuary-7444@gregkh' --subject-prefix 'PATCH
> 4.19.y' HEAD^..
> 
> Possible dependencies:
> 
> 830999bd7e72 ("s390/cpacf: Split and rework cpacf query functions")
> b84d0c417a5a ("s390/cpacf: get rid of register asm")
> 5c8e10f83262 ("s390: mark __cpacf_query() as __always_inline")
> e60fb8bf68d4 ("s390/cpacf: mark scpacf_query() as __always_inline")
> 
> thanks,
> 
> greg k-h
> 
...

Thanks Greg, but I think we don't need this patch for this old stable 
kernel.

