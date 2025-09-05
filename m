Return-Path: <stable+bounces-177889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC6FB46448
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 22:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051D81CC5A78
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 20:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142302D2495;
	Fri,  5 Sep 2025 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PYysnENh"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB442BE027
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102639; cv=none; b=YrWMXL+dW12XHdYRflr2+SbapYJgxrzl/XPkv+nfEl5P+QEIj/9lbIDrHmXLn57mfxxgCOP6n8kPPQKnILeO1+RgASTGuJWLXNBcQM11TQJKAKHNwQx+Rf8W9Zmx2DUPmNAwKRCqU8RenGT8Ne5DZlB1MNzhe9ocd579iQxsF2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102639; c=relaxed/simple;
	bh=SV5kyWxrfpqHx8O8433Cd3jgtyRi6tkS7dTnJ+eTX1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nqKWSGUdZyQZYWTAvvjOArKQyH6bOGcETpZ2E3wlXlaQQaty+Os1L/MfoeHVT0npoNbHcUe8OCEMrsWJSsPCrLHDtRwl0i1BJRpCfehnsWO3siOG5Dz2TLG91iobENAfmBnhWfpPGFTaDQmNWgAg+e/6z7kmDy+zE17r8es/cQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PYysnENh; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585JZ1pf020768;
	Fri, 5 Sep 2025 20:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=o18jg09cJC5pJfNN/JFGYUfCOSula
	ckDQaWnT/3tVHk=; b=PYysnENhmenDX+KxQjHH/UkCBUrXUEjrn9LjRYGkKkgDz
	/S/rRl8NH9jM7IyIn6HLf1bun84viD7ZvVnm8aKyxVOUeHM/6bcFoAXmQf7UmxrX
	4BtDk0IxAHXfAT6i6RgB7SHesoNTeTmP2jX6PnzSB2ZJYx4NFgp/PUFraudq37Tr
	VpAMiGdPn0efw/t/wZPUwZCglcuWpxdlHAMg9PoR2anqbwua8Sdh8cQc7pjE0LG9
	curCZYNSH3xzjpc6AVen9wVtWRC52VUSCAkiwc7VPYmVVE2z4N7HmOmTmXneRg6/
	BMTkUXZu48t9zRXbMs/jSP7DpMI3bkZ+cRYS6OaMw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 490650g1k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 20:03:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 585JimPp019658;
	Fri, 5 Sep 2025 20:03:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrdag0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 20:03:44 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585K3hQ7014431;
	Fri, 5 Sep 2025 20:03:43 GMT
Received: from bostrovs-home.us.oracle.com (bostrovs-home.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.198])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrdafyp-1;
	Fri, 05 Sep 2025 20:03:43 +0000
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, bp@alien8.de
Subject: [PATCH v2 5.15.y 0/3] Fix TSA CPUID management in KVM
Date: Fri,  5 Sep 2025 16:03:38 -0400
Message-ID: <20250905200341.2504047-1-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=729 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050197
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDE5MSBTYWx0ZWRfX7C9Jd0Wib6/F
 WuMyac2fBgItwJUOZH/kEDN/tXJdGqtrD4iBtr7dfFuPGa68GZOHK9zxv102Anf7kiEF1SGuVex
 uI5/VOH6Jl3JEuFy5nzI9b2w/FG5o/pbyisuBLzRbv+XT4qkZLyFWFJEUFUG9vUd1sNLXujjY7g
 DOnt/Mf1lT/Dg6S8prKWdCqBUfjwmNb3XArjA2nenREsUOeciN4bRKiDxAUo3mwe30rhd5A/HQP
 sPn7hAX+wHvNQCOWN1WtEVIa8gPtTDcgySPOmt+FfhdLDXTV4FSK1KR/35J3fjVNaqBZ8A5gnzQ
 LCF7e386+EEn2E5kgtaFl3lnK1YNzcVrpV3WxqV65tFmSguHPSPw/1KSV/GACr9sLvJeL62NKMC
 9T8RAbJX
X-Proofpoint-GUID: psdyibh5TkQKfpq9B8szjAicezxruLmH
X-Proofpoint-ORIG-GUID: psdyibh5TkQKfpq9B8szjAicezxruLmH
X-Authority-Analysis: v=2.4 cv=S8PZwJsP c=1 sm=1 tr=0 ts=68bb4221 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=geNAKzCj22anuR6ZNiUA:9

v2: 
* Move kvm_cpu_cap_mask(CPUID_8000_0021_EAX, F(VERW_CLEAR)) to the first
  patch
* Split second patch into two:
    fix TSA_SQ/L1_NO reporting (new patch)
    backport of LTS' f3f9deccfc68a6b7c8c1cc51e902edba23d309d4

Backport of AMD's TSA mitigation to 5.15 did not set CPUID bits that are
passed to a guest correctly (commit c334ae4a545a "KVM: SVM: Advertise
TSA CPUID bits to guests").

Boris Ostrovsky (1):
  KVM: SVM: Return TSA_SQ_NO and TSA_L1_NO bits in __do_cpuid_func()

Borislav Petkov (AMD) (1):
  KVM: SVM: Set synthesized TSA CPUID flags

Kim Phillips (1):
  KVM: x86: Move open-coded CPUID leaf 0x80000021 EAX bit propagation
    code

 arch/x86/kvm/cpuid.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

-- 
2.43.5


