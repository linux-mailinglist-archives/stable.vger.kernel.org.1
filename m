Return-Path: <stable+bounces-226989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLdQGDxaumnFUgIAu9opvQ
	(envelope-from <stable+bounces-226989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:54:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C81A2B74B1
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCB5A302B197
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E1336F41C;
	Wed, 18 Mar 2026 07:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KXjx8VeX"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C8B36EAB5
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820406; cv=none; b=UmJ8CWJWawH8uFbgUK883RUohSd3nHN+9WdAcg+ANQeG+AVbZD4TYqXudpCwi4QnK1N5n7XfhvMlA0W4Q5sOrlOmG4vfwlxN/mDYMhQZhNhFJu6UIjm+X6GvcrE4Z8vnd1+tUxGu3W4ZZ0Pfy2V7x2wfMArRd9i714roMOW+VtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820406; c=relaxed/simple;
	bh=Wh/awYJY4o7LXd9voQBSO/SliYAJ8/1ksA9oufAIkww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6LkQXK8GBbAI3wwQ3kXSlwVt+asCwwbI5yBNfhs5uYuo0wF7mEOFF/cocCsRbvYhMTjav9EPRQsdq2d3xS4XHCAnk2XMyEXbiGD78Oxk9vYF1DKytvy7bw+BY8QDhoDKk99HjXb5zkXwReC8Ns3UCYYGnE8gi2EkuKBvPGtHdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KXjx8VeX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HMUvTW1189478
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xI7SGXsw9QZI5296v
	6pNTkZSneNQYV8HkmK9nmgGHw4=; b=KXjx8VeXoUDThYh1PxAghuggCI56eUECU
	hcIEgriszWEgX9cXWWEkpcm8T6WWtw0Mm4Q2gifBo5YQ9EZ7Dvjh4bX0HuZVfQut
	47BrDrSiX0sc/eMD1reH9Pa1GA9Xwn10V85YqKS4y0/tkN8/uKj73WWphDdtefLm
	yw3YI0PBlY67GCY9Ury1OVroAQxEOCCTj0B6k/6E2tXuC+LBNpG7VdVb+3uXA135
	5DYi6+YwrxzMH19OxEJ88MWNX0klGiUKHl6Y+TnwuWH3p4jR1beSX7Nrj+9N30Bt
	axTAbCgeGq8FWc490I/9Ou0WI8PkFJukrTMFez/4spK8QUtnWDv/w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfk2tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:53:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I44OUX005412
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:53:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0sd43k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:53:18 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62I7rEqC37224914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 07:53:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C345B20043;
	Wed, 18 Mar 2026 07:53:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF4B220040;
	Wed, 18 Mar 2026 07:53:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 07:53:14 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 6.1.y] s390/xor: Fix xor_xc_2() inline assembly constraints
Date: Wed, 18 Mar 2026 08:53:13 +0100
Message-ID: <20260318075313.4053353-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031700-prowler-dreamless-96ea@gregkh>
References: <2026031700-prowler-dreamless-96ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dXYgNqcSSf7xJZm9Re4deHCBYWFoNMcB
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69ba59ef cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=aKZOg4wb7pFh2cTURR0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA2NCBTYWx0ZWRfX0IYteaxKsERS
 SJV7UGcBHlvPy6RzWWmi4zCHgPCuejRKcGAuLuJvyUb4W5oM9ePVwg8JJpyKtQlDTGEJGWYRowj
 XHJmvDFjLKzmD8sOzHENpwQtQJbbM9Nnxv4vkKiGDqkSeULJoqKFGo2c3X3Lq0CyRBTvw0fzdZR
 bQbAWAMJeMtv8KNxBRjQnE4zVLPpJl/tN+HNvGNq4dNuZJcITLuYw/HSMN+8Cp3ToyLAprUSrwI
 oGF2WAYkuAlXCFG1YNLiFTpDtoS99/PVL2KMs52J77IkNu796FRzcATYSkZlUYeohd8T2HZh9II
 Rm0ENK74/5NMtB5h0c6YyM0KEPxrhtnfMtBJOiSh5CLjfh5WLwLO/FDmYn+uIBbqW+qbtCux9Od
 owJp7nG/RXRc51FwQG5lX2jWkxE6/fiDOW3ZMYLJEy/0CYFtGhLYel+IQNPnhGcrh1A6XtiJxtR
 dHPfIxRDUOZT30c/SlQ==
X-Proofpoint-GUID: dXYgNqcSSf7xJZm9Re4deHCBYWFoNMcB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180064
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226989-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hca@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 0C81A2B74B1
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


