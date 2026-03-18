Return-Path: <stable+bounces-226975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGcLLbFWumm8UQIAu9opvQ
	(envelope-from <stable+bounces-226975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:39:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EC72B7154
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9673A305A230
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD88368279;
	Wed, 18 Mar 2026 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I/Sb4kA+"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6951E35CB6B
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773819436; cv=none; b=Qul5cnEoPAm571RQFLkC5/hmSDdK0UE78t9ZOwg6Zh3QuS90kJ8gdAbA0UPijaIsHwRP0Pnp92BzXIak/IPqelo4o/5t1TZYOA8Lb21yUKpnyX4mpZeIaza+hB93pUOOU4Q7lev3TNLP5F11Izix1Bpm6u1vQ/cL5dpFrQ4ZgYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773819436; c=relaxed/simple;
	bh=HSSHjAnZ8ETfAtDGj4VEq4v5g7OlEyOhFOIKxhTdD2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6XStlS8Sf2vuStJRsLYuOhRVhCRyVoFw9r2Eer863zTqEj4UJRS/MrtXRnrclxYIpTJuKuhYmqTY6vZ38ahfSzxz3PJr8i01kkvBX2GAeeK1VfGonZhKsC7zbgmmJWnplhEVvil88ttd+f/E9O/5gu234D2ieHyDBrvNt6TGCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I/Sb4kA+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HH0mna412294
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NYkUEpPhHDeo4OnoF
	87Zr7bYlXYQpeHIJreggEommK4=; b=I/Sb4kA++QuMsRl/NWg2SOBpwoHXNHGAv
	8AHehWbcY0v188UGS0OF7tpIPIeyXO93stxI6kt17oUk8cE9XdX5532h2i2t5AVU
	14mBOJlO5zWDA2t7ln4tWqYvbfFIGBNI8SK7rlTNyCCghLATrEREW/VOG/hFFWO0
	cNopHAHnqdoQo7kCaT21c+DfRWMW91RJaVLrgWQ6bxc0xpwSy91ocI6CpGQgtltR
	G4gu8kglbScjY5teKOJHtRaaQqJeSzLwym7QGDAQjJ6HMZeIsbFOc8y2LhytQupI
	TEY4DupxAmINNDY4mjrAA4Dd0WPOAIR6rnlyhG/cBChWNtqjocOyg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64rug3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:37:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I4o2J4028720
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:37:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgkcwkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:37:13 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62I7b9r211141414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 07:37:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D00620040;
	Wed, 18 Mar 2026 07:37:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 211722004B;
	Wed, 18 Mar 2026 07:37:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 07:37:09 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 6.6.y] s390/stackleak: Fix __stackleak_poison() inline assembly constraint
Date: Wed, 18 Mar 2026 08:37:05 +0100
Message-ID: <20260318073705.3409519-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031739-hankie-exceeding-ac13@gregkh>
References: <2026031739-hankie-exceeding-ac13@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: emM-3vb6ahxaHN14kLmqmMxUaV7i3pPN
X-Proofpoint-GUID: emM-3vb6ahxaHN14kLmqmMxUaV7i3pPN
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69ba562a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=dh6oAghXbX3gNeQxLKgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA2MCBTYWx0ZWRfX+LQCvWDbgMZ2
 bYNIEmn7ARn4BeYdy1ffO9+HWHufrM++oOPK//u1EBDVNr2bVJN2Z4zIhSHIC2Br3xmuscAsOAi
 Yh7GmfdMBMNR3lAmkb4qblZFV1iWfw35WFD/grJiFMyebMYfNxJySyJGiCsDRhh+1+FchqzvXe1
 7cJtSLMZXndLBzKQGllbhJMWS6ExZgh8WL0ttycUb7rVihwe4z9YyYtqDywJTGfn077SigIGGd+
 ZBhHnrzHRWrBOyCM6gijZ81KjUu+zhH1v+5c/47ST4J5FX/jS38aie0aBXK6Tg1WflbMAJQdd83
 Jp82RlNRJu6kqI2DlQfGt+XIvFJNTNhO7psPaHpG6kn9eGdn/bB44eul1Cf/qJ0CdJAJ1xqk984
 itCGVYoAF830ANR3AlowcYRgm56xubvtUenjP0TDUI5I/iyIS0BRqO53N3RV+ACS/nN/wfx50yH
 FJS/lw98IEEQnLAKfBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180060
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226975-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hca@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:mid];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 04EC72B7154
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The __stackleak_poison() inline assembly comes with a "count" operand where
the "d" constraint is used. "count" is used with the exrl instruction and
"d" means that the compiler may allocate any register from 0 to 15.

If the compiler would allocate register 0 then the exrl instruction would
not or the value of "count" into the executed instruction - resulting in a
stackframe which is only partially poisoned.

Use the correct "a" constraint, which excludes register 0 from register
allocation.

Fixes: 2a405f6bb3a5 ("s390/stackleak: provide fast __stackleak_poison() implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Link: https://lore.kernel.org/r/20260302133500.1560531-4-hca@linux.ibm.com
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
(cherry picked from commit 674c5ff0f440a051ebf299d29a4c013133d81a65)
---
 arch/s390/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 2f373e8cfed3..e0db966e185b 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -146,7 +146,7 @@ static __always_inline void __stackleak_poison(unsigned long erase_low,
 		"	j	4f\n"
 		"3:	mvc	8(1,%[addr]),0(%[addr])\n"
 		"4:\n"
-		: [addr] "+&a" (erase_low), [count] "+&d" (count), [tmp] "=&a" (tmp)
+		: [addr] "+&a" (erase_low), [count] "+&a" (count), [tmp] "=&a" (tmp)
 		: [poison] "d" (poison)
 		: "memory", "cc"
 		);
-- 
2.51.0


