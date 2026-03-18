Return-Path: <stable+bounces-226990-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBJCABtbumnFUgIAu9opvQ
	(envelope-from <stable+bounces-226990-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:58:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 039F72B75B9
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09CF730461FE
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC4A36CE03;
	Wed, 18 Mar 2026 07:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UKYEMB2Z"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0E836D500
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820518; cv=none; b=Z+HAX458wA8k+cltu0f3fXcLO3/pdD+MkKuoWPZoEakxKmXNpwyY6F/9lziKpgu0I0u6wlUOEFOrVTL6GcVhZncMMMVfLxOpHcM89uzWtnyrIDVhTlmuppqk6SaFcd+JY+dBwMPOaoBsqDm8bj0neKPpaZ66D6v+cuY+jUsfaN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820518; c=relaxed/simple;
	bh=iKV60luyfqdJYgz8KM4xmvxO6e8Gvek+TKyFGaZ/Ca0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgthAKEztVfHRnJJgYr5K4tGFk8j3YiHGjhgwu3Dz7u+hwFwgru67WpqFtREKZDGoWgekqDLrcPv4Ssi4Rgv7IY9GZ+wtMrjVglyo5piptFxhoynNpdiO8bQEy/yHnNhQjLotAyFUj+wRiGL9q+uYrLJCLdpNP3VmhRXTAGeI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UKYEMB2Z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I0d36q3698772
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xSR+eCg5fcsY5VQ/L
	66Naa82QXX245zQbtj0JavqUvQ=; b=UKYEMB2Z1rHm8d4tfMEV9lTQQ61RvQ7jH
	Xi7xdP2kxnRpTWtz6RqyLVE6iIOzP+Q6C/CyVWFM2bj1gmisiJhCmg46dvdmco3/
	WnBBJOprRd35ALR02s9g34XVmnFU2u1YQKl8OElCtaXBLF68zarxTCZaXScJqpod
	Miuc1oz1abaygRgvMiML65ryQODHNHD7Cme+JhF9wDBlwEp2HvfMd9BNolJMU10V
	tYW60TjBrpVSxc+XfaZHwTEsCWTFFJXcmpYq/bCdpKieHxoks4DS0m0Df1qN3nAp
	orXR4p1dJJcTBmxIRHhrv9Fcbo8ZCH+Ln65lDXUwpOvgIhjaJOu6g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64rwje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:55:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I5PE5e028739
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:55:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgkcyf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:55:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62I7tBZM43254112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 07:55:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7D0B2004B;
	Wed, 18 Mar 2026 07:55:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2E1F20049;
	Wed, 18 Mar 2026 07:55:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 07:55:11 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.10.y] s390/xor: Fix xor_xc_2() inline assembly constraints
Date: Wed, 18 Mar 2026 08:55:10 +0100
Message-ID: <20260318075510.4102927-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031701-slimness-shifter-65c0@gregkh>
References: <2026031701-slimness-shifter-65c0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MzgXECbns9V4I8JYlKYow784JuVkn9NB
X-Proofpoint-GUID: MzgXECbns9V4I8JYlKYow784JuVkn9NB
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69ba5a64 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=aKZOg4wb7pFh2cTURR0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA2NCBTYWx0ZWRfX4NOtj1/8XqYD
 EHKHw7B/YE4erDSYLfixfyXZB9pjQ95evU7r88FIiUkG3VWSVfIKDRMzA4Kn0eRDA0LdpReHdBX
 QHLl33aLW6w1rYWQbVYqRLuSXXN7l3nFUdNL5KMP0Qpq33WMX4Lo2/rWjQQffiGWzsx83JVeP6J
 Fycu644a9ifNDkjxNUM9RhJFEcd01HRllBhcM4zErseVm2zV9p13F1VA26n8wAlh8eaaOPUzaN/
 TSIKJ4K6XxSDkSS/vl90Y8dXNMWLX+MXIlsExoIEuXa3UZEq+wBsFQtZFUE4Kj8fMmbWTOFiD4S
 OMx0TPPxplxqp38kL+ycefFVxYZ6nc9OQye2ZgELPLchwNEmd4hpCXOKygy1D3kAvS43I2IQHi+
 5VbAdwjLK0rZsR2A0BEMtZcWdMBqiqihEFrhEZKjlfwgDxiaLNmAYO0LcxpICZHJU2GGXhV/ZLY
 JBMnnEd8sdIV1rVELtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180064
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226990-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hca@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.ibm.com:mid];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 039F72B75B9
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
index 29d9470dbceb..7a5bb4eef9da 100644
--- a/arch/s390/lib/xor.c
+++ b/arch/s390/lib/xor.c
@@ -28,8 +28,8 @@ static void xor_xc_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
 		"	j	3f\n"
 		"2:	xc	0(1,%1),0(%2)\n"
 		"3:\n"
-		: : "d" (bytes), "a" (p1), "a" (p2)
-		: "0", "1", "cc", "memory");
+		: "+d" (bytes), "+a" (p1), "+a" (p2)
+		: : "0", "1", "cc", "memory");
 }
 
 static void xor_xc_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
-- 
2.51.0


