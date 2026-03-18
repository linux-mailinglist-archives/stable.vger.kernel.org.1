Return-Path: <stable+bounces-226984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EG/bGO1YumkqUwIAu9opvQ
	(envelope-from <stable+bounces-226984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:49:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E96F22B7337
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44AE130729C8
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C36936E49E;
	Wed, 18 Mar 2026 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e8YbWjYo"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AEB36DA0E
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820049; cv=none; b=KHRyOezqwYwBxIssb1etbIS005rDPoa1j/kJdGhXx0DvZOKQIsJgvTToIYcGPs72JqLFanUr2UQ8NaU1f2Se+VnuNabjQ+xMppV/wAIEnb9jSSG2AzjuAHV/YVBeNuQqJZuC7MMUbKGsXco+/qkmuV3Vs7d4UB3S142YqWs+taw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820049; c=relaxed/simple;
	bh=Wh/awYJY4o7LXd9voQBSO/SliYAJ8/1ksA9oufAIkww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LS7t0EbdPJMRUz+O02NaBmFaRg2j1RPfYGQ52Lzx7Ux0cM/m3KBESl6REeATX4E51rqWv6xdrIT+8l8MAc5yS8TdK3zRYR124XvcBFQPlBo0Q6RljqM1S3kTpqf4Lr7yc/D+Xo5cRANGn5Geu9iD2XH++sStqRbgWwEX9xdk5VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e8YbWjYo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I2ENbP3113932
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xI7SGXsw9QZI5296v
	6pNTkZSneNQYV8HkmK9nmgGHw4=; b=e8YbWjYoMmHTYS3ckpxjLpkP9FAaZIwcK
	i7llQ1ff+4TY0FpkE32N6u8n9tF7g5RerBdzKHzrqMjxfCKPbyGFxpongfIznBI8
	PquvGjOtM5eHKxE6PuMv64Dx7h5EEeQc+WA3WHEDPR8OszxFF1MOy9QNrYfg1Z9N
	c+3RyTKAL4t6WlTzrEFydap1HIsHuAKzc/qjmqw6zGrwZ0ffi3lXSXBog0R8H0Jc
	jgs7F4ZbLBd0lCxd27VFeLkFij39c6q9MLF2QJCLNv217xpxsje3gOl8iVcBDPmG
	q94p0QheADfydgS/jipC7Uu+XkWaO7gdPoSo+WXZxNSb2o01uV5WQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs8s3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:47:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I4xf0t014113
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:47:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcy51kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:47:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62I7lL7F31785548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 07:47:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7337D2004F;
	Wed, 18 Mar 2026 07:47:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CD162004E;
	Wed, 18 Mar 2026 07:47:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 07:47:21 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 6.6.y] s390/xor: Fix xor_xc_2() inline assembly constraints
Date: Wed, 18 Mar 2026 08:47:18 +0100
Message-ID: <20260318074718.3818273-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031759-playback-tree-e12e@gregkh>
References: <2026031759-playback-tree-e12e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69ba588e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=aKZOg4wb7pFh2cTURR0A:9
X-Proofpoint-ORIG-GUID: GDEwsfegzSrKLzd0EDqIbKDRrd_j0J_l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA2NCBTYWx0ZWRfX7C7zUTTOCbZ4
 xru/i2EG1Ku5wkL/jbrqu5e62WHssmQILmMrO1VOX1YlDrN9uECpY0QVOOQt+ujYf5BNW0w1RK4
 /3KmsqBCByENkKdrhY8dIQoMx7C+WrcOcfoto4Np9GJIB8gKBva4xliHf38vM0r65HhZzfWaC/s
 lRgE56K0SJxU8orslGg5OojC9WFD7+nl8jJb7QFqQD0jlU9F50PT06No0JpgVgzE2aAcPZgmBkL
 VINumznEPokkqBHWe2W4YjXYPHjw/OpG9ZFrSVjgrXsM3hZ3VIj5Nq5Np4lv6odsa3JzJlj1cXu
 ZukXK45QfQgCLayD1t57pOW5M0rfYXIc/NRXvvbqF6RpderRLXk55hEAYbPoFFn1xyV+kckPT93
 hpYAMbMlAAkxSZu6pxjCwaO72n5nNAjVHjTBl1DqeRfnfgk52u65e0p8q72WNHzfKXhJ+dyADO0
 K2kA4QcL1WoqWgf+iXA==
X-Proofpoint-GUID: GDEwsfegzSrKLzd0EDqIbKDRrd_j0J_l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180064
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226984-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hca@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: E96F22B7337
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The inline assembly constraints for xor_xc_2() are incorrect. "bytes",
"p1", and "p2" are input operands, while all three of them are modified
within the inline assembly. Given that the function consists only of this
inline assembly it seems unlikely that this may cause any problems, however
fix this in any case.

Fixes: 2cfc5f9ce7f5 ("s390/xor: optimized xor routing using the XC instruction")
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Link: https://lore.kernel.org/r/20260302133500.1560531-2-hca@linux.ibm.com
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
(cherry picked from commit f775276edc0c505dc0f782773796c189f31a1123)
---
 arch/s390/lib/xor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/lib/xor.c b/arch/s390/lib/xor.c
index fb924a8041dc..76d7ca64d231 100644
--- a/arch/s390/lib/xor.c
+++ b/arch/s390/lib/xor.c
@@ -29,8 +29,8 @@ static void xor_xc_2(unsigned long bytes, unsigned long * __restrict p1,
 		"	j	3f\n"
 		"2:	xc	0(1,%1),0(%2)\n"
 		"3:\n"
-		: : "d" (bytes), "a" (p1), "a" (p2)
-		: "0", "1", "cc", "memory");
+		: "+d" (bytes), "+a" (p1), "+a" (p2)
+		: : "0", "1", "cc", "memory");
 }
 
 static void xor_xc_3(unsigned long bytes, unsigned long * __restrict p1,
-- 
2.51.0


