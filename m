Return-Path: <stable+bounces-191447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8925FC14798
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 12:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D3E188C3EC
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 11:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13D930F526;
	Tue, 28 Oct 2025 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JVQ4C5d+"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F79C30EF8C;
	Tue, 28 Oct 2025 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652300; cv=none; b=sBoazyP6tLDahiiIq9uInqYEkZE6S+0oox8I5LD0FTCSPHn8DKW2ZwhEFpH3H7sFeqUL0fAKOqw6klNSxsk2VI09b2WHAofISOcyQ8DVk/LP11DYLnsVmZ0iqB3KZFIjwT1qWXjGxEK5menF5h3E41NZ2hGPpTslXktaE5cR1dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652300; c=relaxed/simple;
	bh=XlwnLTEXDaAA9THPxSptUWk8urWs/Zft1ubjgPctUMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IUvY/sXPRKq6s4vNs0YoEejJNg8lUdgyLdE1+sQAUnyJpHKLA4WVeJ/nPnGtsWKae2c3CqOyvst9Zg5FVdnqTq49Lmm6uEQCuxm/E4sWJOZlvXZxnEyqec9IwA9IbITXP9DjzT5kBrDr684HnYe/m//yKvMEWxHBPfemMHqdJ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JVQ4C5d+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S0bVS7003058;
	Tue, 28 Oct 2025 11:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=3UFCQaEJaKcAaDn//yddwHbbu2/BdSOUSDaCpfPtN
	Cs=; b=JVQ4C5d+FuthlAJnCJhyVH7PAn27Ych7LnI7WJiIICZxUZp1Wahl62YFW
	X1N1ipiWr8wi+SSm0xreYqjQpK3ugJTf2LLizDTif993LstvHxvZke97kJlF0dC5
	pgh1MMST1FAP76er2c8fnFFWsYx6O3v0EOOOHuWsq0RsEaZRL4D/BJ/aRNc0WmlB
	nf052kJSiTrleV/YMDryoXHf5HmH8v5qnXDnnlB2w/A3DdUwL8gA0T/8C602NCVs
	KGLKC9oRWPGZsPPtYsgvZOueguAgn3kW9P546tFFZ42+pcb5w/TKW4QPBnf+jdh+
	3dWqlM3JjufOSB0+PL0wXtt3PPu/Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p993mc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 11:51:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S9DHCS006884;
	Tue, 28 Oct 2025 11:51:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1bk12784-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 11:51:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59SBpXm734865460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 11:51:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CF4C2004B;
	Tue, 28 Oct 2025 11:51:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 373D920043;
	Tue, 28 Oct 2025 11:51:33 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Oct 2025 11:51:33 +0000 (GMT)
From: Peter Oberparleiter <oberpar@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Matthieu Baerts <matttbe@kernel.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: [PATCH] gcov: Add support for GCC 15
Date: Tue, 28 Oct 2025 12:51:25 +0100
Message-ID: <20251028115125.1319410-1-oberpar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=6900ae48 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=5kkN_RTO9X0oWNACuksA:9
X-Proofpoint-GUID: 4n_WuyfmTOpa3Yd-oe4i2D4s9nEqYF-I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxOSBTYWx0ZWRfX0IKWkoejrboP
 qnPYkTTIPqILEzmuWaDUoNA/z99XIQshzDxIRcNA7TZRpBwnWWqI29x/EibRpenxNB09Pbhe7jH
 hHdughHTreMFmiqGqO7nNfBfAUgZZOFILkMFR2BoKdknvAL0l7g/jXpf4u4Htq6pxYqyYOTfDea
 NHJapzz0vCx+V+kgw49D7wJjD4IE9gk50K+4Btjttajs73ayh4O6nUMl7dwmJPgpPGM4xgt3qE/
 RBc5oixTTcp5uLdbW4cvzAwbUj4QXwqgoPIbndokd7uDHbGb08YQE3vY7MhJqyCwrLWIHf8W86n
 TUUTTOE3KZo5I7tVMsWXKR4g1qX0i7dyBjl73RVMfZIEgahE6RnjC3lQoRWzZkhYstXU3ksuG4O
 Pspm7JCaDT3QDCJhIDK24nFexTVsKg==
X-Proofpoint-ORIG-GUID: 4n_WuyfmTOpa3Yd-oe4i2D4s9nEqYF-I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250019

Using gcov on kernels compiled with GCC 15 results in truncated 16-byte
long .gcda files with no usable data.  To fix this, update GCOV_COUNTERS
to match the value defined by GCC 15.

Tested with GCC 14.3.0 and GCC 15.2.0.

Reported-by: Matthieu Baerts <matttbe@kernel.org>
Closes: https://github.com/linux-test-project/lcov/issues/445
Tested-by: Matthieu Baerts <matttbe@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 kernel/gcov/gcc_4_7.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
index a08cc076f332..ffde93d051a4 100644
--- a/kernel/gcov/gcc_4_7.c
+++ b/kernel/gcov/gcc_4_7.c
@@ -18,7 +18,9 @@
 #include <linux/mm.h>
 #include "gcov.h"
 
-#if (__GNUC__ >= 14)
+#if (__GNUC__ >= 15)
+#define GCOV_COUNTERS			10
+#elif (__GNUC__ >= 14)
 #define GCOV_COUNTERS			9
 #elif (__GNUC__ >= 10)
 #define GCOV_COUNTERS			8
-- 
2.48.1


