Return-Path: <stable+bounces-110161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E11A191A7
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 13:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA2A3A1A43
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 12:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4429212D62;
	Wed, 22 Jan 2025 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TRmryvZN"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047991B4236;
	Wed, 22 Jan 2025 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737549861; cv=none; b=szVcpjx7UBnoq2It88slK58nPf3Rlmt0S+/TrxdQn0P1OPW5Pzlw+D1CuZ1O+D7CyGcjNe0XDrg6JvdFU6+BEsZpnox3zFL/xGjnfVx2Ms4Siwuipt5u3hkvkmPS6IJxwksJ/wh7tYL6UpM+BDtw1o8Hj8ygrC/o5ASKY0iofac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737549861; c=relaxed/simple;
	bh=1jb2jG0452OMaXAEsZi91BOryw+7ocpDQvkJxEs+p6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c31pSR9tksGMDFyAZHU2YaU7Lcu06s0p1WinCBLyryVk2y19X6SqKhcj2WTyhGRQnJaVnPVGKJOshOaVgOwaYU2FDysB37lEBuTznAwb4nwhWIDikAXDAYRtQub4FrlcZGf0T0UVzoQ7NOE3FxMFGNcovN3ClBwCwW0IMsEyeaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TRmryvZN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M7XFgA013536;
	Wed, 22 Jan 2025 12:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=N4+vfo
	6RvLX3tvVxY96IHe7MqDaFFU4R0Tj0aS2l2Y4=; b=TRmryvZNSjcEt/4UcaCq/X
	F0WGwkt+PEBiFIIngly3KSS9kH7mYQI5Kl2MwWTChBcCv7CDaxB5kg4TA0KLWBqN
	uPbj1DePw5ibBD0vRl9bxg3ARYtdK4P0xEoXR/3HKpLi3wnkGBq7qHj6aeutCu+W
	4DlYJ+Rv9ENoXj2yAbqejU4nNQVJPDQWHAbBpH8/avxwG0Kx1lIXEit04x+Jhdet
	Cl0VHEQsgVp04ettmPhLr9owF7ApMv46C3GEIBBERyVkFxyu57cPi2XEJ4dGb7PY
	XmISt2wJWAEBZtN4n2YclPTY+eW8yFpgQZmY4zFxco5BYS3R9U5vxy0EfZ9rJATg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44avcp1ajf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 12:44:01 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50MCOJGl025885;
	Wed, 22 Jan 2025 12:44:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44avcp1ajc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 12:44:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50M9Sf2M024231;
	Wed, 22 Jan 2025 12:44:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0y8jrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 12:44:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MChu9352887982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 12:43:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A93E520043;
	Wed, 22 Jan 2025 12:43:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 395F520040;
	Wed, 22 Jan 2025 12:43:50 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.99.85])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jan 2025 12:43:49 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org,
        Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: stable@vger.kernel.org, mahesh@linux.ibm.com, oohall@gmail.com,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
        vaibhav@linux.ibm.com, ganeshgr@linux.ibm.com, sbhat@linux.ibm.com,
        ritesh.list@gmail.com
Subject: Re: [PATCH v4 RESEND] powerpc/pseries/eeh: Fix get PE state translation
Date: Wed, 22 Jan 2025 18:13:48 +0530
Message-ID: <173754932978.1094869.2082514395132243482.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250116103954.17324-1-nnmlinux@linux.ibm.com>
References: <20250116103954.17324-1-nnmlinux@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mASYt3iwEHNCoh5m-cWb2INsCygynD2I
X-Proofpoint-GUID: acV33627Db4gdQoa2sXkv6fAzcBnizjr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_05,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 mlxlogscore=700 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220093

On Thu, 16 Jan 2025 04:39:54 -0600, Narayana Murty N wrote:
> The PE Reset State "0" returned by RTAS calls
> "ibm_read_slot_reset_[state|state2]" indicates that the reset is
> deactivated and the PE is in a state where MMIO and DMA are allowed.
> However, the current implementation of "pseries_eeh_get_state()" does
> not reflect this, causing drivers to incorrectly assume that MMIO and
> DMA operations cannot be resumed.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries/eeh: Fix get PE state translation
      https://git.kernel.org/powerpc/c/11b93559000c686ad7e5ab0547e76f21cc143844

Thanks

