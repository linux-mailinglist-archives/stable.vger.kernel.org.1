Return-Path: <stable+bounces-110162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA44A191A6
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 13:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26C11623F9
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 12:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39278212D85;
	Wed, 22 Jan 2025 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kELFAIRW"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8321E1F8F16;
	Wed, 22 Jan 2025 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737549862; cv=none; b=UWp0kDB/WrZaej0kzuaJt/bQMwzBHSgQsM8t31yUWWYdTUQzVuOq6e+jfjmfnwYSHsLX//XJk4TK+CZMSCDo6sVLRoPZaJGTp4w03YYh0vsrIEDnBppN7ziIBnXVYug7nIbWA9oP+X/bqi72LRUNTrx1I420F8/d/Ckohnd08gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737549862; c=relaxed/simple;
	bh=choBP//gbppPa4tzOPsdKjnuX3co6yUcfhKCLGNdOBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snULwRbodB9Vh99qFtmY5R2LWR090iB2+v3WeIpy8ReRzH8X1Riwr4e31j3XCcha6RqeDXPOfJDYLUzppcfsHUQmnuIrGfn+07+JdkxxsDWZQzGfEh7aFe+uikI0Uw9MhOXY0Seva+fQJ72VPYCwFZh5mhXQM68zz9+eDk9Oq+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kELFAIRW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M7WuQf012808;
	Wed, 22 Jan 2025 12:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XlYM4s
	Kxk84TwQy/utw7Dea1Av6/+t1sQO/BqDHu2ao=; b=kELFAIRWLum03i75P7GFU+
	njJBT+fmaE9wzzNlBoSV/by3FoVHOe4BTJubAs87LIippisi3G9TlvF9im9r3o3Q
	34jhc7rK6CaJlv4zuKvhke2+lWU21RzShAZ6ftHmzbPqb/b68hIe3KuGjDSALw/V
	UG1X4H+ztnAE1jqwPQ8+twk3h5xb426uqsRBqHOAGPWQKPovwGRLqUNKmVW7h8ef
	cYf2gjHk6EnbPbMOVQ+cXA5lSsYkGFnrs8asw1wabAfvfSXp7WInQy8JHqDIGhcA
	payoL0ukeE1qXPIhbOMy60NwH3jyfGbez06fgK4p8sOhrCNOxVHVF2RjnrnYmi/Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44avcp1ak6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 12:44:08 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50MCXGka013766;
	Wed, 22 Jan 2025 12:44:08 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44avcp1ak3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 12:44:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MAVRIE022384;
	Wed, 22 Jan 2025 12:44:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448r4k8arc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 12:44:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MCi3dK56885598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 12:44:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D256120043;
	Wed, 22 Jan 2025 12:44:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D90320040;
	Wed, 22 Jan 2025 12:43:59 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.99.85])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jan 2025 12:43:58 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, vaibhav@linux.ibm.com,
        vaish123@in.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries/iommu: Don't unset window if it was never set
Date: Wed, 22 Jan 2025 18:13:57 +0530
Message-ID: <173754932979.1094869.2005290852678611840.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <173674009556.1559.12487885286848752833.stgit@linux.ibm.com>
References: <173674009556.1559.12487885286848752833.stgit@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BL7oZJv0OrjYS4LKyT-JwHw51RSJMHux
X-Proofpoint-GUID: 4u0jaRfOtPp97hSgEWWwhOZtnJCnz-LL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_05,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 mlxlogscore=248 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220093

On Mon, 13 Jan 2025 03:48:55 +0000, Shivaprasad G Bhat wrote:
> On pSeries, when user attempts to use the same vfio container used by
> different iommu group, the spapr_tce_set_window() returns -EPERM
> and the subsequent cleanup leads to the below crash.
> 
>    Kernel attempted to read user page (308) - exploit attempt?
>    BUG: Kernel NULL pointer dereference on read at 0x00000308
>    Faulting instruction address: 0xc0000000001ce358
>    Oops: Kernel access of bad area, sig: 11 [#1]
>    NIP:  c0000000001ce358 LR: c0000000001ce05c CTR: c00000000005add0
>    <snip>
>    NIP [c0000000001ce358] spapr_tce_unset_window+0x3b8/0x510
>    LR [c0000000001ce05c] spapr_tce_unset_window+0xbc/0x510
>    Call Trace:
>      spapr_tce_unset_window+0xbc/0x510 (unreliable)
>      tce_iommu_attach_group+0x24c/0x340 [vfio_iommu_spapr_tce]
>      vfio_container_attach_group+0xec/0x240 [vfio]
>      vfio_group_fops_unl_ioctl+0x548/0xb00 [vfio]
>      sys_ioctl+0x754/0x1580
>      system_call_exception+0x13c/0x330
>      system_call_vectored_common+0x15c/0x2ec
>    <snip>
>    --- interrupt: 3000
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries/iommu: Don't unset window if it was never set
      https://git.kernel.org/powerpc/c/17391cb2613b82f8c405570fea605af3255ff8d2

Thanks

