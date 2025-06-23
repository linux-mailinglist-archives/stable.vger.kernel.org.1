Return-Path: <stable+bounces-155387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D940AE41C9
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38ED188E74E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CD4251792;
	Mon, 23 Jun 2025 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LfzGgtmU"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928E424DD07
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684297; cv=none; b=b+vcdKGvZdLMepMp+eDF7KgZZH002dZXFWxHPqxJ5FBVERntZlhau6203I9iEyAYkULYphg957I1CfnOMWE/BjUkGWgGRSqe5ygDHmnYV82zTkR+/wM1/iDYxr4KQzC3YBmLuH7kztpLWFcVggn1W5bpnWMMCbSkS2d89rOd55g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684297; c=relaxed/simple;
	bh=3QK9UWzZdBMjUSOk7fsUPey4uGzESZO4EHzkpdVG+OI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MkIPxnw5Gf9M9bJKo6sXyT7pJCV2Yp35fp7CEncu2XUKI0setKeK1GW3/30T6O8Gtu0UoHbcLqkMQ7uKMm1a8tW9YGVtjkF7Yn94GWDxZXmEw6UAWzQgcm/1O/6tNqLBOfbwRZBlryCOCffO6vUVE3T/hrOGFiznnewHKhCSEco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LfzGgtmU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ND4FGv021411
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=msN083kKZSjdvimXaw3wIGlhDpH2LXRoSL8SkBjpP
	SU=; b=LfzGgtmUcHEkjIXbIOLQ+lgn6eaNM+IriNRGNfvDwfDbLI0qtKOrSB0Jw
	EJpYnyozHIAkSz/ypxiEF8Kk+pEIe6Ni4F8YLjEg+V5/G1HlqJDwd774JYek+k/m
	PIOVcsNzuCS07BDRTI2wfDDJULRjc1Srah37daV9kXbzYkk4jY0Wh0qhu15xk9kP
	s+Fi19FzhMHHeTcdtItd16GqyJygHEExfJ2WsDXiw9NBt/83p28nsuN9lxQQJABK
	Yq6Q5zIO9rhbQhptiO3a3Pl9DufX+DMiRzdloi8IFrHIn/hQlJDuuW7Z/M3XBAQU
	ctSIRSzXPg4nRt0i8FHIjv+7kp+jg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5tj74m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:11:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NBxCbr002908
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:11:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e8jkxmvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:11:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55NDBVbb56295850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:11:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9C962004B
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:11:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9089220043
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:11:31 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:11:31 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y] s390/entry: Fix last breaking event handling in case of stack corruption
Date: Mon, 23 Jun 2025 15:11:31 +0200
Message-ID: <20250623131131.783064-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6E5x29JjLmUitasZNlvjoa8cf1zusWIb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA3NyBTYWx0ZWRfXyarHh3hFmrMl JwAL+d1RWz5hI9NqozzIa6a5rXFDfvDP449yP2V0fYKf/DaA4OITSiVgiZSPU93W5b3lbAKDKlE fAzjUErIDFPKhyRuiCaMciyI4AdIyus1XnjargpBhjylLpCiAIHHRXdktPC1Qxlj/xAn8XWN4We
 V86XkgRBsdoP5dvHkcXOWaENQoToMR8dsu5je3ipqtYi9zVSqR0Uv9QGKK/+6d4rX1rdz8Ot7Vr x4WHeDo7XZO9FRNUvQ9iPdR5EphE6UkmPDX/cZh9EUQ2tcDci5JJDb64kICQRRI5kUU4fCrRsBX DKprZJLAIjL0tK5tYZLQMM1Z6n3ErtdriXYw3aGk6K+hZmlQq4Tqf0NaiGlo58F+oWLqZltRDSB
 D14AYx6ZljiwzN6w1petLdFjYqwNKoDfOYtz5oJr/L2HH09y8cqzENeRdEAgMITyvZhFqWAp
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=68595286 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=8Ck9TpFAnHqLg_FyizcA:9
X-Proofpoint-GUID: 6E5x29JjLmUitasZNlvjoa8cf1zusWIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=839 impostorscore=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230077

commit ae952eea6f4a7e2193f8721a5366049946e012e7 upstream.

Note: the GET_LC macro and all the infrastructe that comes with this does
not exist for this kernel release. Therefore the patch is slightly
different to the upstream variant.

In case of stack corruption stack_invalid() is called and the expectation
is that register r10 contains the last breaking event address. This
dependency is quite subtle and broke a couple of years ago without that
anybody noticed.

Fix this by getting rid of the dependency and read the last breaking event
address from lowcore.

Fixes: 56e62a737028 ("s390: convert to generic entry")
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 62b80616ca72..576457915625 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -690,7 +690,7 @@ ENTRY(stack_overflow)
 	stmg	%r0,%r7,__PT_R0(%r11)
 	stmg	%r8,%r9,__PT_PSW(%r11)
 	mvc	__PT_R8(64,%r11),0(%r14)
-	stg	%r10,__PT_ORIG_GPR2(%r11) # store last break to orig_gpr2
+	mvc	__PT_ORIG_GPR2(8,%r11),__LC_PGM_LAST_BREAK
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 	lgr	%r2,%r11		# pass pointer to pt_regs
 	jg	kernel_stack_overflow
-- 
2.48.1


