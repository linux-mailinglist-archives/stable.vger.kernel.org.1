Return-Path: <stable+bounces-179143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D790B509E7
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 02:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A0897A1ECB
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 00:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B2545029;
	Wed, 10 Sep 2025 00:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Iw8nPu4K"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F9D8248C
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757464122; cv=none; b=qcHZOhHcio/3WHzWR4wdtuBVZh138M2Pt6IQsIWxg1ShN6yzYQdcVaq76csFmJyFEGfNflELYyHkDWBoWjDMNJ+Z0tnAjCBHzkVLoC5KemD6ZpbjrUILvIywYF/5UGylSEVh5Cd3Wvjnw/X2Rrru0fV91FAlu1cqgjLWWA4Xkyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757464122; c=relaxed/simple;
	bh=l0zA//DOd1kemr4ebaLQYo5tv6J3A5EHNlnICR/u0/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6YjMCpHK/Oi7V9N6MVmAsX3xS1bhV0KXkPKvODoWkw7VO7GR+JZIDtc4XVwNQn2b742Ay8PEB6ZKdCKmc6jLl5egrRbdNLNAsU+6kGwp89I7SSIHw28txzoprlwbrJEMBJkEDC6WL+fDzzhFltymcd+iYvqE5dPcCuMMcgpd+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Iw8nPu4K; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589L0XH9030303;
	Wed, 10 Sep 2025 00:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Xa4g6
	QrrC4DXGSZ0FmkSZfQ+PvfugThHglO6pDwWCiA=; b=Iw8nPu4KgMyPSOUojEkD5
	RZe+xFVKwqbMXXb7096xjsejzKe8M/TLFVb+OjvP0WgG8S+BwmJqk62AxGnDjsBQ
	5QaRX2CV7zR0ZNDA0+gvclen0wuqKyIwqF65r1N3Zt97NW5TklJqo59ksmaIAHuJ
	aPDodrtKpKBWHV1G80/L74zL1bVPkK6DodzATdjqG0Z0CquJMtJzdoRU/Lg+8Sfm
	B4oYXl2I29okrIVFIyDBexRH9OZJRc84fKfftOWeq1TH8jBifgtv6l1xJUj9SSjn
	hUQy/z1/nTrHupTPyhnQc51yWeMxAugspnjcj1uiTw+P4XyG800vniNUhITHZRyw
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1k72v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 00:28:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589MA68u030711;
	Wed, 10 Sep 2025 00:28:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdaa3su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 00:28:31 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58A0STF1002550;
	Wed, 10 Sep 2025 00:28:31 GMT
Received: from bostrovs-home.us.oracle.com (bostrovs-home.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.198])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bdaa3s6-3;
	Wed, 10 Sep 2025 00:28:31 +0000
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, bp@alien8.de
Subject: [PATCH v3 5.15.y 2/3] KVM: SVM: Return TSA_SQ_NO and TSA_L1_NO bits in __do_cpuid_func()
Date: Tue,  9 Sep 2025 20:28:25 -0400
Message-ID: <20250910002826.3010884-3-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250910002826.3010884-1-boris.ostrovsky@oracle.com>
References: <20250910002826.3010884-1-boris.ostrovsky@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509100003
X-Proofpoint-ORIG-GUID: CzK6ODWj6queY2Fh4BthUHLLwvYg8x_1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfXyrXa1Yb9xbZr
 WW/CTLCruXJj1cFbOcRjUWaK27ly1cMAYHw3hhKqWmI3rdlIAmoBdoanqLnODjLcVFxpNrOe+AF
 +o5JrVrzj0TEyKckd9+5MHsFmCxWYNLbBiy8FIJ+LXy2hB12O4Fxg4n68vHqVJJl7E6CMEzu6gA
 B4O2Diw7rkAKsgcjl62TYX/LX/C+a0KdOtL2YEFBWBnDeGmLC0+HMm9BjyuMVCttn0qHP+1DD1K
 SPlYB4fxtTpvZFanE/3wntyvjrPg0il4V9/ChfZd8l4f62Gj1MC1A+kov1fRG/560xAL3Svjjbl
 DeW0trEG2Co+zw4SflbaDX2kToq/n3qzXcwWbYinY5FnYDKgN9PilDCYEOqVZHhcRfbHf+E2oAh
 9XyV8vpP
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68c0c630 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=92bzJRmnXUVhA8tt45oA:9
X-Proofpoint-GUID: CzK6ODWj6queY2Fh4BthUHLLwvYg8x_1

Commit c334ae4a545a ("KVM: SVM: Advertise TSA CPUID bits to guests")
set VERW_CLEAR, TSA_SQ_NO and TSA_L1_NO kvm_caps bits that are
supposed to be provided to guest when it requests CPUID 0x80000021.
However, the latter two (in the %ecx register) are instead returned as
zeroes in __do_cpuid_func().

Return values of TSA_SQ_NO and TSA_L1_NO as set in the kvm_cpu_caps.

This fix is stable-only.

Cc: <stable@vger.kernel.org> # 5.15.y
Fixes: c334ae4a545a ("KVM: SVM: Advertise TSA CPUID bits to guests")
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/kvm/cpuid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index f85a1f7b7582..4a644fcb0334 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1014,8 +1014,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
 		break;
 	case 0x80000021:
-		entry->ebx = entry->ecx = entry->edx = 0;
+		entry->ebx = entry->edx = 0;
 		cpuid_entry_override(entry, CPUID_8000_0021_EAX);
+		cpuid_entry_override(entry, CPUID_8000_0021_ECX);
 		break;
 	/*Add support for Centaur's CPUID instruction*/
 	case 0xC0000000:
-- 
2.43.5


