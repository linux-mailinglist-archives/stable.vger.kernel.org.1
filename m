Return-Path: <stable+bounces-163657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DF8B0D1CC
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 08:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017963A466C
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 06:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA42728A731;
	Tue, 22 Jul 2025 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SvTVeMvT"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74751A29A
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753165606; cv=none; b=aHsNAAYip0/2+78nkddWVBbS86/IJvqmK0eTgnBiiQ2fuhIVtvJV5GqbnsDTOOIpunCRWCf6jmg+ZyPTkuqdyey3oPZP46elYxYzQjRsgEK63RO2kOXpT1AyAmzpzCtrqpw6fGNHdp9CL8aIC7c1mf6l3P0VjnvZ9fBOQpQPZ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753165606; c=relaxed/simple;
	bh=GJupSTEJxYxweJ499pFCHc2a3nx8ydrfECvVlgOCuIE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eq0EWjWCvuBNF2l/TQa+VIOQvE6JWr+SNHWYr6CK94Gy5S2gnMKPznvQK6erfVxcFurYrjUxmHFMgEp0BvidB98coaG5uBqoJTr6GxHg14qwr54d+MBoAD0UzNSLzW75dv/m5Eo2JwxFjSmqNJ7hNV8WwRPhOyDFxC82owCo+Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SvTVeMvT; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TCmh021355
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=6AFZ+ujkxMh+BWjq
	xdaofFvqult6MSkWyWPI6aovOJY=; b=SvTVeMvTasJYHGk08Ozb7d+cVlLHdJ2A
	RuRjYh6EnjMgcn/Qaw4VKKHHMSqdXjU23U/jXe/pSN1OY4oVZfeUAr6B0LLa6srC
	/MR02NnF0jO77pT9ST0GfelW/XTYrBkktP/a6r95OszaYWUMKdf+Mri4lnjh0CiO
	WmPVIchaQ1Pa74cRkjg2VXnIr9nCU21VlK2E7eRvAB/GO36TxPMJRb3T6mYLNpYv
	Xk68z/F2MM2cksJWbeeIPGtgCCimxv4BQMfYwsBFcOV6COHMyFe9FtI92HCT8Tl3
	lQuXqhUptyk1eaGCw7jHJYWKR5AsjmjTM7Ec8UNqTd5Pl4fl+q/M1w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e9mhgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:26:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56M6JePI010306
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:26:43 GMT
Received: from skatage-ol9.osdevelopmeniad.oraclevcn.com (skatage-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4801t8xdkv-1
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:26:43 +0000
From: Siddhi Katage <siddhi.katage@oracle.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y 0/4] Fix blank WHCAN value in 'ps' output
Date: Tue, 22 Jul 2025 06:26:38 +0000
Message-ID: <20250722062642.309842-1-siddhi.katage@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=692 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220051
X-Authority-Analysis: v=2.4 cv=eqbfzppX c=1 sm=1 tr=0 ts=687f2f23 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7B0HGO_KyTO1TtxdyTYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3BnYxUYHf_T2Qmyd7mKuqYCciUaNq3p3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA1MSBTYWx0ZWRfX6JhfTbpQVo45
 cI3ah8iBy/DbvRp1dSaBz6y1GnsLM0rHLrKtovTsBNcPJPReM4Dg5cu+CdlXDAo858H37ko1hSn
 2SZW9L92Y+Nhh/+nqYIsHSm2FOL2YKP/Yr25s/P8F99KK58X8KVfRRiwU1Lrdy8ZLqflkU+G1yf
 /XQpnSG+JO/MMDtcbj+dU8GoLs0NjGevX2prDJTYcbHOtzVpp0o9iV2ZcU8FAUXFKMxNClzrtEH
 J3rgoChsm9kIvc0OJC1buclHS/z8vwuYOlPvwG69BBAERFnUubrd5CjXiljQ2OMlUJ1O+Goj4m+
 ROsf1yxbBjnShN47CIaspnU4rGV/beYaBO+/Qtigm5F36mJ2Y+eJ6adzibC5FoNC/Lczl29rGcJ
 s6/lXV7WTDgqKGNCmWqQxyexzBZCvg+I4LnnvdTupjYjEGtxsA+2Pck6E0T4qK2fnOw9gruN
X-Proofpoint-ORIG-GUID: 3BnYxUYHf_T2Qmyd7mKuqYCciUaNq3p3

The 'ps' output prints blank(hyphen) WHCAN value for all the tasks.
This patchset will help print the correct WCHAN value.


Kees Cook (1):
  sched: Add wrapper for get_wchan() to keep task blocked

Peter Zijlstra (2):
  x86: Fix __get_wchan() for !STACKTRACE
  x86: Pin task-stack in __get_wchan()

Qi Zheng (1):
  x86: Fix get_wchan() to support the ORC unwinder

 arch/alpha/include/asm/processor.h      |  2 +-
 arch/alpha/kernel/process.c             |  5 +-
 arch/arc/include/asm/processor.h        |  2 +-
 arch/arc/kernel/stacktrace.c            |  4 +-
 arch/arm/include/asm/processor.h        |  2 +-
 arch/arm/kernel/process.c               |  4 +-
 arch/arm64/include/asm/processor.h      |  2 +-
 arch/arm64/kernel/process.c             |  4 +-
 arch/csky/include/asm/processor.h       |  2 +-
 arch/csky/kernel/stacktrace.c           |  5 +-
 arch/h8300/include/asm/processor.h      |  2 +-
 arch/h8300/kernel/process.c             |  5 +-
 arch/hexagon/include/asm/processor.h    |  2 +-
 arch/hexagon/kernel/process.c           |  4 +-
 arch/ia64/include/asm/processor.h       |  2 +-
 arch/ia64/kernel/process.c              |  5 +-
 arch/m68k/include/asm/processor.h       |  2 +-
 arch/m68k/kernel/process.c              |  4 +-
 arch/microblaze/include/asm/processor.h |  2 +-
 arch/microblaze/kernel/process.c        |  2 +-
 arch/mips/include/asm/processor.h       |  2 +-
 arch/mips/kernel/process.c              |  8 ++--
 arch/nds32/include/asm/processor.h      |  2 +-
 arch/nds32/kernel/process.c             |  7 +--
 arch/nios2/include/asm/processor.h      |  2 +-
 arch/nios2/kernel/process.c             |  5 +-
 arch/openrisc/include/asm/processor.h   |  2 +-
 arch/openrisc/kernel/process.c          |  2 +-
 arch/parisc/include/asm/processor.h     |  2 +-
 arch/parisc/kernel/process.c            |  5 +-
 arch/powerpc/include/asm/processor.h    |  2 +-
 arch/powerpc/kernel/process.c           |  9 ++--
 arch/riscv/include/asm/processor.h      |  2 +-
 arch/riscv/kernel/stacktrace.c          | 12 ++---
 arch/s390/include/asm/processor.h       |  2 +-
 arch/s390/kernel/process.c              |  4 +-
 arch/sh/include/asm/processor_32.h      |  2 +-
 arch/sh/kernel/process_32.c             |  5 +-
 arch/sparc/include/asm/processor_32.h   |  2 +-
 arch/sparc/include/asm/processor_64.h   |  2 +-
 arch/sparc/kernel/process_32.c          |  5 +-
 arch/sparc/kernel/process_64.c          |  5 +-
 arch/um/include/asm/processor-generic.h |  2 +-
 arch/um/kernel/process.c                |  5 +-
 arch/x86/include/asm/processor.h        |  2 +-
 arch/x86/kernel/process.c               | 62 ++++++-------------------
 arch/xtensa/include/asm/processor.h     |  2 +-
 arch/xtensa/kernel/process.c            |  5 +-
 include/linux/sched.h                   |  1 +
 kernel/sched/core.c                     | 19 ++++++++
 50 files changed, 94 insertions(+), 155 deletions(-)

-- 
2.47.1


