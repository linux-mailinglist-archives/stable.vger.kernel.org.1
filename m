Return-Path: <stable+bounces-179144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFE8B509E6
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 02:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8FB1BC2620
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 00:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BAC137C52;
	Wed, 10 Sep 2025 00:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o2Oceh/+"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD0D86340
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 00:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757464123; cv=none; b=N94hfW6nNy8U5E+mhMs+qissgILScmOTvHNh3945g8fevyg4RyApohA59DWO+LQD45Hwy2YuVv7z0oaNROTDXL/o1sUeAmqHxs9Zypxs247OWkxHqz57VZPuE43xMHy2T1pHYBXvJGHIIGjeA9Jtum+/HLRV0sozuhsT4pu86Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757464123; c=relaxed/simple;
	bh=E2kS4xrsKOCOHKyT28bqJ+HqM6wPHx7XyuxQM/Fopnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GEmNqrJIpRcQP1sXpVFStDt/AxesSxm0tEfaQj1yPGC0d1RgUJlSmsXZooJOMdjreH8xazN1aMucKUGp7Gm3h1ZuB3gdyyChyC/MZX8d9jFMFaZhiBTlhB7mhsYDk+lVQCZ5kSqP6G4x0mnvWEwsKIKl4rUsOGuy2K0soVjZ8uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o2Oceh/+; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589L0pqQ030562;
	Wed, 10 Sep 2025 00:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=IQAtOiarjXq7hlbJdjE6FZ3OEFbgO
	IL5lnLVzZTWsnE=; b=o2Oceh/+jbYKDJrVnpCbx/3RbYkWKBrG/7jcjM5Oi4OJo
	/mASlQS2HGx55GyCN6wKiRUMOmT1gCLKnUNYsf6MDBIVtcO1KxYzbeK75kfTDva3
	OEbruGqhYUs688oGH3eiFCiSU+7ExGw33kmpjvqb4qp2fgL/YmVJTnc8snepzZOe
	i1rhtkYuPlecBNb1MCmCvZphOrwMO6AKdAXD5DWyLvFWXJrKGTeiNoNfYZp6LSsd
	CjewytAgDfwIFBTs3ak9SMowSn4D7APeglw9yC94vhTFe5Ho3QWz/Y5cfaOdzjKg
	oF3C2sUdYx/JiDbdyB2VqWrmywYGd2i4yZ35E/h3g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1k72u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 00:28:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58A0GiTs030623;
	Wed, 10 Sep 2025 00:28:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdaa3sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 00:28:30 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58A0STEv002550;
	Wed, 10 Sep 2025 00:28:29 GMT
Received: from bostrovs-home.us.oracle.com (bostrovs-home.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.198])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bdaa3s6-1;
	Wed, 10 Sep 2025 00:28:29 +0000
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, bp@alien8.de
Subject: [PATCH v3 5.15.y 0/3] Fix TSA CPUID management in KVM
Date: Tue,  9 Sep 2025 20:28:23 -0400
Message-ID: <20250910002826.3010884-1-boris.ostrovsky@oracle.com>
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
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=760 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509100003
X-Proofpoint-ORIG-GUID: rRGXMeJEFt6CoDqwc7FIs7R_d0wec3CZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfX2ZMeoXod5esI
 OlOCW8o2wxHVeDl9Avr9CGj3zBBG8OroiUmJOA8ZGgORn4pqAtfAUeBgCnd2mGMoJgxpStUmdVS
 aGukf6Tdd2E9NlTbFZYPsjC5ZeIz1sYPkY0N9QSqzyI0PEIxwvl4ikA6xX7ew9b1NeAH+QIgqLO
 d+pUSbkdrlm1u3VwyXCnnj+wzAIfxFSRL0bk7n41VF3+XlGZ9Sx+MmbHNIGscsOqCuibxqSYAZZ
 RP0pM5Wp+6/Lk/ZGDSOIF48fLdjzTg0YOuAlTBLJhwh2ypOlBX1R6lWoIBv1jmawaME8pcJ3sOE
 IWRJYmaT/yISSpXFpcFWfVvqD20IxMZYQqLpn+toGruXUOF1h+cTo7wXLP4ZTwaF3InLyy+hn7d
 /oF3jq4x
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68c0c62f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=yJojWOMRYYMA:10 a=geNAKzCj22anuR6ZNiUA:9
X-Proofpoint-GUID: rRGXMeJEFt6CoDqwc7FIs7R_d0wec3CZ

v3:
* Make commit message in patch 2 more verbose

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


