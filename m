Return-Path: <stable+bounces-155362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF56AE41A4
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69BB73A927A
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739D924E019;
	Mon, 23 Jun 2025 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ep3F3Oyi"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14D024DD00
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684115; cv=none; b=kfxdZm19ridMwokaUTaqsxQqqwjB9UOcn980rlOpjDgmcet1OMitKSvcs4G8xJT10bJXfjp9/5Jc9i0qwmZIZLu7euoB7JedXSytRnsf6zYiPdU/K8POR0ooyVpyI+ltWQlm3lyOJELsb8p+e9+oP8W02drQ4JssgZ3QguAxnGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684115; c=relaxed/simple;
	bh=EuS/w9+ZUDb+m04nvM1PMm81J0b4E/xCdzxfxm/kgcw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=I0cJK6enBBxX37d9GTWRjk3CrdZDELQAwA/KMBaCGpCYZmjjCCvg8lEv3tARaW6boo7ToS19541r8wk/dizclPKysBj5U8uxLxamigjyglm1Vd4tAsTzoqpuPsu3Njz3SDSXZE5/g2RATR/0O29BAc6l15lxFhcy7NVOVyzynkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ep3F3Oyi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9Dk3m025522
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=RRuQjFTDADQwzGTXAfLZcmggoj5w5TJa0rw9ZaOKM
	rk=; b=Ep3F3Oyi7odIr/UUhz/GSz1/3okw7y4ehN8iPcRcI7rqwXd19x4cOaSSd
	P3W7Qfq2WQAcUKlSRFwHrjuHZqkeWUXOty90Mwxc6QZBptEmZOoAGUex2yTtMthR
	U1b7obrgARM+JEEbAfiM1jMkX0PjuVnHlVRw5qV25evQ9NnlOdSF/liHFF7G1KbB
	ETqhDoLNWBP4m/pcOKSIpfUJyAZH4mL0OGBpI9Jw8a04HSHwd1gj5K2uijmS/vHJ
	aQAsgONha4an2kiwfCPRtlk2477WvfLyNehTAB8EV/tyLtzXKdJY+iHFDNBRsLJC
	YxR7NVS1tx7Qu5I9eEf3W1iTJ2Ejw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8j21aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:08:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NBdVoE006408
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:08:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82nxqyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:08:25 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55ND8OHa58720722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:08:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECE4C20040
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:08:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFE8620043
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:08:23 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:08:23 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y] s390/entry: Fix last breaking event handling in case of stack corruption
Date: Mon, 23 Jun 2025 15:08:23 +0200
Message-ID: <20250623130823.733595-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA3NyBTYWx0ZWRfXwYDaI0p0FHlP 93ILVUTnegexKO/xM578bL3BGGMJDWoMkOwJXIgpdBrHbOz/NeNg82Ep1r3kCdGXXmZcFsDwlbR vR8PgbLNIGF4KB6LQMDzGaVIeAsyFdB0XDnVQnijSYOq4gkEZpmZi28dxBLrfP7yzLUZdid2sWf
 xMMDGlWzUTQE41FQofFRi+TgNXkU/CO9pYnezsiYpXCP8FSyahI1v9NWbwSpSbc3xP24ffCXtj6 4y00Q050wWWGbY2LTcTUizroGSzQ5ON3lOC9kw+YjjX/g2gOceNRDIh5bb7PA5rqY3vX1qZyMeO VhEWlZUQWLGRO5b/5PjO9QUIUcPWmBL+NEW8721oqqOEvDcUIyhdORE26ipcd21mih4Jajhqop7
 aNLc1BghN/efaolfgEq6TJ6IcpFtR+Lvrt9UdN+uEgkME33W24pIhG/qBOGrV3johYwM84Ul
X-Proofpoint-GUID: KQ1PYv5UiExe7Yhh86xSK9DwcVXM9nWN
X-Proofpoint-ORIG-GUID: KQ1PYv5UiExe7Yhh86xSK9DwcVXM9nWN
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685951cb cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=8Ck9TpFAnHqLg_FyizcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=836 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
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
index ebad8c8b8c57..0476ce7700df 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -639,7 +639,7 @@ SYM_CODE_START(stack_overflow)
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


