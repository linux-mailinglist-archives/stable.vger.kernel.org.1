Return-Path: <stable+bounces-76905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E8597EC5C
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 15:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C40B282827
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FE61993B1;
	Mon, 23 Sep 2024 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KzYL0Jtz"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B507919922F;
	Mon, 23 Sep 2024 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098565; cv=none; b=mB/8Ysx0Zwghn+mYYy2fZRj/KIW/hpnDYuX66c0hjKSlnEW4g5gIXL/+BaSF0huci5Woy0erfQ3QmQkI5nbGlC+kHzHFaZhA8zq0lD6woF282L7wDLOxvikAMjoIOwvWFpbZuuSBHfWa9QbGImQTiA5SCasfyCadDvJnwjF4sR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098565; c=relaxed/simple;
	bh=6ldzArpZc68z7glLwNUL1QXsRpeVl2IqY3TIk92Ps2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JPFN/JAcgdeiY8fyoPzIMki0dH4lFsY035acJBJjeap9xcmofdAUfVntYsBTmqqU8xia1bJP+rTMEiMEYv6N5aJzmeIVC4ygeQAPx5MGD6oFP2gwac6C2/FVbRnnPLM3oavmZBfnQ9oSDAbRUWgeGFzy7D0GRK4Stvc9uq9a4TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KzYL0Jtz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N3QAmf019038;
	Mon, 23 Sep 2024 13:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=K6VUVDVlbjknK1JITS3QVF2LIj
	rXAxju6GiTmbIQkx4=; b=KzYL0JtzygsIgy+RbQQRJC7wt6VXu1BITPSf4zBl1B
	dcB8dE+JztIiaQ3mPqvFEEhHDaHeeOd4qngx7NPZrxXE864WT+LoHE9T3UlAbNZT
	Qdhv3LvkGX2C8J1zlideLrGbNB7bzwhO0M6rGWSTFzcc2BVEHtvoFBuk16saAdWL
	R43XjJn0e18G9u62W0iiV41xRW+AdTiAm67RVUWO909iPAYEslkBIYC5vKfqVSYK
	GhmNRT4+24v7tR/xMFRyuqAeKtfqa4PyNIVRfTuMa60+iptTePQZ/jrlNkDqUb8o
	KLbYUbeiALd9iAZKnl9ZI8mHUJwr5fPpwHxc5lbae8ng==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjrc305-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 13:30:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48NBI9Xt012507;
	Mon, 23 Sep 2024 13:30:44 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t9fpptav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 13:30:44 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48NDUhW731916756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 13:30:43 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B95FE58062;
	Mon, 23 Sep 2024 13:30:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EF1458066;
	Mon, 23 Sep 2024 13:30:43 +0000 (GMT)
Received: from ltcden12-lp3.aus.stglabs.ibm.com (unknown [9.40.195.53])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Sep 2024 13:30:43 +0000 (GMT)
From: Danny Tsen <dtsen@linux.ibm.com>
To: linux-crypto@vger.kernel.org
Cc: stable@vger.kernel.org, herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com,
        Danny Tsen <dtsen@linux.ibm.com>
Subject: [PATCH 0/3] crypto: Fix data mismatch over ipsec tunnel encrypted/decrypted with ppc64le AES/GCM module.
Date: Mon, 23 Sep 2024 09:30:37 -0400
Message-ID: <20240923133040.4630-1-dtsen@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yvnFcF5vjJnVYZy3BRhiNiuA6wQdrHdK
X-Proofpoint-ORIG-GUID: yvnFcF5vjJnVYZy3BRhiNiuA6wQdrHdK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_10,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409230099

Fix data mismatch over ipsec tunnel encrypted/decrypted with ppc64le AES/GCM module.

This patch is to fix an issue when simd is not usable that data mismatch
may occur. The fix is to register algs as SIMD modules so that the
algorithm is excecuted when SIMD instructions is usable.

A new module rfc4106(gcm(aes)) is also added. Re-write AES/GCM assembly
codes with smaller footprints and small performance gain.

This patch has been tested with the kernel crypto module tcrypt.ko and
has passed the selftest.  The patch is also tested with
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS enabled.

Fixes: fd0e9b3e2ee6 ("crypto: p10-aes-gcm - An accelerated AES/GCM stitched implementation")
Fixes: cdcecfd9991f ("crypto: p10-aes-gcm - Glue code for AES/GCM stitched implementation")
Fixes: 45a4672b9a6e2 ("crypto: p10-aes-gcm - Update Kconfig and Makefile")

Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>

Danny Tsen (3):
  crypto: Re-write AES/GCM stitched implementation for ppcle64.
  crypto: Register modules as SIMD modules for ppcle64 AES/GCM algs.
  crypto: added CRYPTO_SIMD in Kconfig for CRYPTO_AES_GCM_P10.

 arch/powerpc/crypto/Kconfig            |    2 +-
 arch/powerpc/crypto/aes-gcm-p10-glue.c |  141 +-
 arch/powerpc/crypto/aes-gcm-p10.S      | 2421 +++++++++++-------------
 3 files changed, 1187 insertions(+), 1377 deletions(-)

-- 
2.43.0


