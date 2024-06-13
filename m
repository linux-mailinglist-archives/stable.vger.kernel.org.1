Return-Path: <stable+bounces-50519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F36906B02
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B215F1F23148
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9309982C76;
	Thu, 13 Jun 2024 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kRn7i2zQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE2E137C22
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278265; cv=none; b=IhtPUyNL18QqcwfbeSdSqBssWKuGBXQNEwSPIQ8NlWsCk4xDB60Ri57L0rYzjZv/jb7C9mAfGbIaGlvYc4OnMtjHg3RbkZNXe0vYQnljdZH9GO7IvSzIZfU/7PSCZ27hT/rYmiaGv5v0r3/B82TaKUdICaZgnHsct2mg6D13W0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278265; c=relaxed/simple;
	bh=M/uZ5gWde+O49gWjoxAgHKf1FS3qT2yR1mQLU9zHvWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=GVCcaomiMxKOqgsMu3BRvfT7BWwM9RklIMm+HIJdXBV9YOm+9xDBluGpr/ZocPvkqrjEJMcgfrwm0JXJz7p0D/0++qoHbtTGhW66lefIyec470UezenIUX1brGrLTFb/CWJ04utlDnKMdLJlw1EQ4lOv5ayyxYU+iAo6Yd77+qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kRn7i2zQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DAp1V9004214;
	Thu, 13 Jun 2024 11:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:reply-to:in-reply-to:references:message-id
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	BpnaHEH6duaN4TfdKEW0XsikdoeQWrnEKNwglubqgZU=; b=kRn7i2zQNqb8mUht
	JE6MX9OEkv+D7dTv5Jb/X4Ho4F2WTOcdo/DGiEBwVEnIWQkcb5EXGr0RrJXVGtv3
	1z7g8piCMQA5q8rzydkfOYJ2KbIfyESQXj7znv8N2/rPGMzs96jib/oLzYPMCcYy
	3WyGgc+iLVG6ovfCwF3bqboq6p4DJLD2+GxX79jHBDIqq7cab541ZTY/vVYW+aUT
	2+bO/6Kgb3Q6s/IoezvlvmQc1ocNCcgKVQU4FvFPKXWYUMleK0XzJlsLVrggFFOA
	txKUTQvMHSulHq+zxfdUtFnYc9NOs1C+Y5s6FWPV+FGQzhcyXdpnhyPSslHLlkZu
	FVkEPA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqq4rsac6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 11:31:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45DBMlW1020063;
	Thu, 13 Jun 2024 11:31:00 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn34neu5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 11:31:00 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45DBUvi942139996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 11:30:59 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCC0B58076;
	Thu, 13 Jun 2024 11:30:55 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FC055805D;
	Thu, 13 Jun 2024 11:30:55 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Jun 2024 11:30:55 +0000 (GMT)
Date: Thu, 13 Jun 2024 13:30:55 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: gregkh@linuxfoundation.org
Cc: dengler@linux.ibm.com, hca@linux.ibm.com, jchrist@linux.ibm.com,
        nsg@linux.ibm.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] s390/cpacf: Split and rework cpacf query
 functions" failed to apply to 5.4-stable tree
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <2024061359-wasting-ribcage-b58b@gregkh>
References: <2024061359-wasting-ribcage-b58b@gregkh>
Message-ID: <565838defb6e33018156c57c45384410@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Mtbd7Pn8zzzhj9EUSdGCDZ-4v8FF93oA
X-Proofpoint-GUID: Mtbd7Pn8zzzhj9EUSdGCDZ-4v8FF93oA
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130082

On 2024-06-13 12:09, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 5.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following 
> commands:
> 
> git fetch
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
> linux-5.4.y
> git checkout FETCH_HEAD
> git cherry-pick -x 830999bd7e72f4128b9dfa37090d9fa8120ce323
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to
> '2024061359-wasting-ribcage-b58b@gregkh' --subject-prefix 'PATCH
> 5.4.y' HEAD^..
> 
> Possible dependencies:
> 
> 830999bd7e72 ("s390/cpacf: Split and rework cpacf query functions")
> b84d0c417a5a ("s390/cpacf: get rid of register asm")
> 
> thanks,
> 
> greg k-h
> 
...

Thanks Greg, but I think we don't need this patch for this old stable 
kernel.

