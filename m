Return-Path: <stable+bounces-179402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B9CB55932
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 00:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DD2A02566
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 22:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5476028507B;
	Fri, 12 Sep 2025 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HoYPYUHT"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2C226D4E6
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757716170; cv=none; b=UCNt68fDNyIfBfAwenAkYcWjEpgbVa6ZOATNiCtFb2K/Osu+cb0RdOCy0ubPBhcUyGpFkUr+Z/kr3NbqRRDmEqmjPXmvttxgkZ46Tj4m3bhaOlaAQF8dFpwy65zn9y6Xs/8wrQ+lq/M8LhnJlz8ywsv3btJGOD2nmFOHfxje4vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757716170; c=relaxed/simple;
	bh=ILprAyiZqYxVcfWoCC50tM4Ie7s5KuoVpnW87DCoLjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I7NqxGbcOBLkt04KPVEezSWmFQnumkCszAMw8XEg1BgW/whKC7e4vCLQlOAuLKP4GAfvaJX7RrwbDfhWdF/CWeRN9HNaTOArnwyhvIfpmpb29oan9xJ6PhpmngL0KB1EN1KGnHkAjRX5fgpjyq8mAllYXNEAJq9pDjYPlhkWvDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HoYPYUHT; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CLftq9001800;
	Fri, 12 Sep 2025 22:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=9IcuvnsO2J116AwkWBrn8YabcUIIq
	uAy+OhzQDLE0EQ=; b=HoYPYUHTp1SX1r074Ujnpnd51LNExkT5oHa4mql1JLBfj
	EU3AiektnyposSjRzTp7V6Ws7xaNThLv038FchBm7d2jz3+/xAIEG7N3Qbu8VS8G
	4o0bWgs7MxuzBHJXpUdgjH3Nd+bulsRa2qVTnT1nr9atjGuEIXpqee8Q1b2c3v/5
	t7v3mCLHFZ12eTkuU/aImVyM8OVzFiHrHXuzUBVJE/7uOaJguoPvDaPmi32N/SKU
	4aSbow7X5X0HP+AfHtpce6K/NA3+PBf3XScj3xpgjTRqDKB6jPiKc/+PJQjinpAd
	xBMdjgGT+Xj0oPrvOYGsK9i/53C2jz5iETLs1J0ZQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922x991s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 22:29:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CJp4Zg013674;
	Fri, 12 Sep 2025 22:29:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdemahn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 22:29:18 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58CMTHqi020533;
	Fri, 12 Sep 2025 22:29:17 GMT
Received: from bostrovs-home.us.oracle.com (bostrovs-home.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.198])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bdemaha-1;
	Fri, 12 Sep 2025 22:29:17 +0000
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, bp@alien8.de
Subject: [PATCH 6.1.y 0/3] Fix TSA CPUID management in KVM
Date: Fri, 12 Sep 2025 18:29:12 -0400
Message-ID: <20250912222915.3143868-1-boris.ostrovsky@oracle.com>
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
 definitions=2025-09-12_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=635 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NiBTYWx0ZWRfXwPEE5AnYv8G1
 wiDAfM9seN9GfsX0Aq4L1+oGj6pZnt6ZNFNXysElNrkDhmDoT6O+/DMynqX0cLZEDkPkVaQ2XHm
 anedVvNuNgCHe9zDjbaTGef88VytALG3+odE16ieM/3V53CFExXvIcay3qRST6BPTJzolKI9REB
 HWwMwmEDbEaYmKys7odzRZ5zFINJgBWb3vKnwYCLdfcB38qgnoFOh+J1D3BxcMntoKVZPscN2FA
 eiE8RrhkHIousgtgbfUji8FaRfA3+6qHSPQfuODqxaGA1xs7B3KL6uclh+7RUU/X63u3a5FYyFz
 02Tz9f/x86dcv+0+LNJDgGnmeFmwZw+LEL17Jn6ZzkeNcsiYhyLGXhC4lEBHnTvVR4nj9+XESYO
 9zuG6Rir
X-Proofpoint-GUID: bDcQlICqKDczQGLUyEJ3gkYnak02B-Ad
X-Proofpoint-ORIG-GUID: bDcQlICqKDczQGLUyEJ3gkYnak02B-Ad
X-Authority-Analysis: v=2.4 cv=LYY86ifi c=1 sm=1 tr=0 ts=68c49ebe b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=O_RcZoAimDaxSrFsZxsA:9

Backport of AMD's TSA mitigation to 6.1.y did not set CPUID bits that are
passed to a guest correctly (commit c334ae4a545a "KVM: SVM: Advertise
TSA CPUID bits to guests")


Boris Ostrovsky (1):
  KVM: SVM: Return TSA_SQ_NO and TSA_L1_NO bits in __do_cpuid_func()

Borislav Petkov (AMD) (1):
  KVM: SVM: Set synthesized TSA CPUID flags

Kim Phillips (1):
  KVM: x86: Move open-coded CPUID leaf 0x80000021 EAX bit propagation
    code

 arch/x86/kvm/cpuid.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

-- 
2.43.5


