Return-Path: <stable+bounces-262664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4ynwDLaSKmrJsgMAu9opvQ
	(envelope-from <stable+bounces-262664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 12:49:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 13196670FFE
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 12:49:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=kM8a6pMA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262664-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-262664-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 667B1301889E
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 10:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CFA3DA7D0;
	Thu, 11 Jun 2026 10:49:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B43D9DD2;
	Thu, 11 Jun 2026 10:49:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781174949; cv=none; b=ZTnalCBrmUzB8FKt0C7tQKij3YEENBUF1QedreMmZ0N9irYuyKXwbPfOh4YVoV2pDdvjdeVcYgH6XOlecp9F/41Zl9ew7nkuejD8vt84j54bvAzA/cSqE4oHQI3fPq1as4WJFUlB9W6HMMABjic+3F0rhg+Uc7c9cgYpo22vEmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781174949; c=relaxed/simple;
	bh=E9LD0KaoekkpZDOgReAv+jIHFcm3JMDkv+YM2vE7mVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeYP5lm5A28S5RwDJLaYvAvmc7w2jiv+CdV+H0dWzEX3OO/6xa8GKnQR3bXr4a8e2nL4teMoleWox+8sJTF1mfPNWoqvLW2/FBThZs/zmI2gZOX2WdqjdCX2ieVgvnqtnsKSFM5/oT9aogRl8Q46fmg+5BBrAex4MuMFmflSSKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kM8a6pMA; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BAjK1f3872955;
	Thu, 11 Jun 2026 10:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0M6otYUwAQsCSsg3O
	XW+47eGEZKvl9gACVSlDP9kStk=; b=kM8a6pMABUl10hzvVLEUawRJxEY2xf5a2
	ZXM9pQSz4T+lhWYp7Tb23qbDc3BqNOuzbsak171tOHGid7GIsfyM3aHt9oZ/5pQp
	u6HfktaRE4BOwh1QzzyLSm7SgKLXVURVy4+cjyueJSDylX5CIbwngypfDIo5uhAI
	BdB6fH1+QQBXfW9dESWXWxY1ovsYRMD4YWVthcbDyVku/LKJdAnEfVawWg3lqX8K
	velrVeY6i5hB48yRjoWhhWp29WKdfcUuYNhrglvao9RTdZ/8+UyL6AT48hZQZwNJ
	Xk4MNh3GZuVKl0+Ao3psIu5dif2AAvCYqFle/jDwjz0lf/4z0op2A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8etxrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 10:48:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BAYpqU013759;
	Thu, 11 Jun 2026 10:48:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09jtd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 10:48:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BAmpUC42009082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 10:48:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A541A20040;
	Thu, 11 Jun 2026 10:48:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EB3D2004D;
	Thu, 11 Jun 2026 10:48:51 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 10:48:51 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v3 2/5] KVM: s390: Fix unlikely race in try_get_locked_pte()
Date: Thu, 11 Jun 2026 12:48:47 +0200
Message-ID: <20260611104850.110313-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611104850.110313-1-imbrenda@linux.ibm.com>
References: <20260611104850.110313-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEwNiBTYWx0ZWRfX8o3f86JFmvSJ
 o2YrkTbC/Bs0UaNWdz2BPd8h9oliwV8FK1Z0/EtHCwppI+TMOHT4Mgi2afEXJPqZ39cdTmO+Dhq
 UApRddkU7XteDNOi+GBMhQyiquPw/d/c9pQVKzroznCgqhWbhqlqiawCkcOUPpi7XI5OqtvdTnE
 ea+ZgTOYUy2B6QM+RSKDboD40Kk7mzLDfXMsbu7l6tjNVS4oieqTGDPDQDnh/eD0cS1DZBY2DJ3
 HfHCt5ws1L+6uhACFiBiOf/09oDC+jqDh0OdR8qd/DXv+0wWaszfTMPCQcLrhDb2UWGqXeR7wVl
 35fYqESyLsHFaPMzn2/0NZJ7s7BWIcH2EeH5cBYUzZktJfongMUP7QGymiM7QNc20WoZ8ML6pcr
 XMaWjBhIjTTITgUJ4GpeohQvOI2Feehc2kDNpid/+i7y4kIxclhK1Argh71rdtcSux5PsDAJ1sD
 sHkKpaFFUl2Y1y0s5Uw==
X-Authority-Analysis: v=2.4 cv=dr7rzVg4 c=1 sm=1 tr=0 ts=6a2a929a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=WbevkOawJw57NP_rgK0A:9
X-Proofpoint-ORIG-GUID: 0hgAf1K2y8VMPjRIhSLs7Wa2lka0Rkci
X-Proofpoint-GUID: 0hgAf1K2y8VMPjRIhSLs7Wa2lka0Rkci
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEwNiBTYWx0ZWRfX/Ygio7RNG2sk
 y2ixIUc+5UcPMX++13+oIAPOeGsxd2uazCm25p0jZ924+pkcMkjDugmg1BExoXhAOOGcjguYXrC
 zGVhKCBgJMgb9mAoaJZLLTK0D5G+FwU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110106
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262664-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[imbrenda@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:borntraeger@de.ibm.com,m:frankja@linux.ibm.com,m:david@kernel.org,m:seiden@linux.ibm.com,m:nrb@linux.ibm.com,m:schlameuss@linux.ibm.com,m:gra@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[imbrenda@linux.ibm.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13196670FFE

Fix an unlikely race in try_get_locked_pte(), which could have happened
if puds or pmds get unmapped between the p?dp_get() and p?d_offset()
functions.

Fixes: 89fa757931dc ("KVM: s390: Avoid potentially sleeping while atomic when zapping pages")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
CC: stable@vger.kernel.org # 7.1
---
 arch/s390/mm/gmap_helpers.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
index 1cfe4724fbe2..ee3f37af8aee 100644
--- a/arch/s390/mm/gmap_helpers.c
+++ b/arch/s390/mm/gmap_helpers.c
@@ -51,15 +51,15 @@ pte_t *try_get_locked_pte(struct mm_struct *mm, unsigned long vmaddr, spinlock_t
 	pgd = pgdp_get(pgdp);
 	if (pgd_none(pgd) || !pgd_present(pgd))
 		return NULL;
-	p4dp = p4d_offset(pgdp, vmaddr);
+	p4dp = p4d_offset_lockless(pgdp, pgd, vmaddr);
 	p4d = p4dp_get(p4dp);
 	if (p4d_none(p4d) || !p4d_present(p4d))
 		return NULL;
-	pudp = pud_offset(p4dp, vmaddr);
+	pudp = pud_offset_lockless(p4dp, p4d, vmaddr);
 	pud = pudp_get(pudp);
 	if (pud_none(pud) || pud_leaf(pud) || !pud_present(pud))
 		return NULL;
-	pmdp = pmd_offset(pudp, vmaddr);
+	pmdp = pmd_offset_lockless(pudp, pud, vmaddr);
 	pmd = pmdp_get_lockless(pmdp);
 	if (pmd_none(pmd) || pmd_leaf(pmd) || !pmd_present(pmd))
 		return NULL;
-- 
2.54.0


