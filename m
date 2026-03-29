Return-Path: <stable+bounces-230933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEmcKD0ryWknvgUAu9opvQ
	(envelope-from <stable+bounces-230933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:38:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F067352444
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B4403003D2A
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621EA36EAA4;
	Sun, 29 Mar 2026 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e+/FJH0Q"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F952F4A15
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774791481; cv=none; b=ho7nzraoBOc74q3tcd8Ho+1PiLemQzNMyqA2lTGSL2dB4UD8bD+lX3hpG8uVvf2X5vefDT+sSQTYbNL5udAZa4nmu4sDTSe/t/qneiXb8SZxJEgIiMaYIk8D9HWx5UoRXJRkp0Y5KTQm9g93z01NuBxEOZ4UB/86+nrF+mBc5+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774791481; c=relaxed/simple;
	bh=rErbn54l/e8Ip2+idhieGxOUk8BjhxFiRKEyIK2D3po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amWkduylTR6gsKVUdhcr0IMXjAgHsshKZ4llK3on+pH/myR1JHJlCdsschwOkJEOykrHZ7a4Wk7WGqo4l3mOIw//EOji3dIBIxWKBla6DLxzX5S7vTw+zniWN3/fpsUVhX6CrDojcHV9F/d5xnzvpDlWrINsGcGsu9cVNh7Ei/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e+/FJH0Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62T90r2S2879954;
	Sun, 29 Mar 2026 13:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=qbZlSTU3IUxao/NbPLY562qBloyjVU
	FO/87sI79NkhE=; b=e+/FJH0QVIrD1S9hVuPUVHoLdM8VUTa0CMijNmlipCIvBF
	Kar4zBsRr9U2dzu1iXkfPHhIedPNnmj5s9WbilaztmoQDFDgTww5QEwqIjK7g4D9
	7delC85t75z971Omyu5csjN9MAUj4/1zLa+YFVXthlMRMUB+sYHm69D5hf0TRIL1
	xiZFWpOBIaS0Ag0teI0+1hAlTBvfFQVwLLISQ0Wv01fU2dHiO+qF31Oy44tYRvYj
	jtOwlNywM3poZeNPAzQesd5JTASCIUykRMkExxkqRL1YC/Qf1gIxFoKvU9ea7Bk7
	T8LGmJWW2mFNa8Io2Ukjrd6hdTyW6UXCA/dO+zrg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q2uewk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Mar 2026 13:37:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62TAF80X031034;
	Sun, 29 Mar 2026 13:37:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjh8tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Mar 2026 13:37:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62TDboma43712928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 29 Mar 2026 13:37:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD96120043;
	Sun, 29 Mar 2026 13:37:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BB8520040;
	Sun, 29 Mar 2026 13:37:50 +0000 (GMT)
Received: from localhost (unknown [9.111.25.211])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 29 Mar 2026 13:37:50 +0000 (GMT)
Date: Sun, 29 Mar 2026 15:37:48 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.6.y] s390/entry: Scrub r12 register on kernel entry
Message-ID: <p01.gc8f4b9804bce.ttcnxpc@ub.hpns>
References: <2026032923-rerun-crouch-f0cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026032923-rerun-crouch-f0cc@gregkh>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SEBXpis4zHIHmvKVrobh7HxwCGVkk3EE
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69c92b33 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=bAswlcalVcA4mDXWVpAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SEBXpis4zHIHmvKVrobh7HxwCGVkk3EE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI5MDEwMyBTYWx0ZWRfX+GDCQyZbBZeK
 Su/pDIowZKrfgRm288EMbAXCW/H2XAjhmdkfRXppNJaO8G9qaBt7U9OUkoV6gx6bf36m+pmxIAC
 Ufe8ZjCqhg2NZrVOfFpN3TGDAwjf2t2i9722xG4bHHwppxO1Pqu0gLz9tznEbAE/MEZyC1nP0DI
 uWTf+WOfzCS5bfXxW4Zkemv55TL5IKTpeFrtOc0oLVWKC8Ay6c7ZqwQYJTXH7eONhMAUgDW8Mpr
 K5iRsh690oSBraEku0XbsOvBQkw+kU2Jms4LWmg7EWId578g4rEn8zRwGCIwxhNEVjeuZ/D9g6V
 FGf9Xo1rGaACMielrjGyOhvdzawQHjn55iUlKeVAZv+WCi7M75J5CJeBQC8r5VdFSN1AiaSmEcq
 D8RkCrTjg8+YE0rkqeYsg5trmK9yoM7qX2JifpTuANMRGJ+62nFa9Z5VJ+t04MumxDUETPqtzji
 LtJnVpTzRRXR33kzN4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_03,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603290103
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-230933-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ub.hpns:mid];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gor@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 4F067352444
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Before commit f33f2d4c7c80 ("s390/bp: remove TIF_ISOLATE_BP"),
all entry handlers loaded r12 with the current task pointer
(lg %r12,__LC_CURRENT) for use by the BPENTER/BPEXIT macros. That
commit removed TIF_ISOLATE_BP, dropping both the branch prediction
macros and the r12 load, but did not add r12 to the register clearing
sequence.

Add the missing xgr %r12,%r12 to make the register scrub consistent
across all entry points.

Fixes: f33f2d4c7c80 ("s390/bp: remove TIF_ISOLATE_BP")
Cc: stable@kernel.org
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/kernel/entry.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 0476ce7700df..b8c5c78b0d14 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -300,6 +300,7 @@ SYM_CODE_START(system_call)
 	xgr	%r9,%r9
 	xgr	%r10,%r10
 	xgr	%r11,%r11
+	xgr	%r12,%r12
 	la	%r2,STACK_FRAME_OVERHEAD(%r15)	# pointer to pt_regs
 	mvc	__PT_R8(64,%r2),__LC_SAVE_AREA_SYNC
 	MBEAR	%r2
@@ -378,6 +379,7 @@ SYM_CODE_START(pgm_check_handler)
 	xgr	%r5,%r5
 	xgr	%r6,%r6
 	xgr	%r7,%r7
+	xgr	%r12,%r12
 	lgr	%r2,%r11
 	brasl	%r14,__do_pgm_check
 	tmhh	%r8,0x0001		# returning to user space?
@@ -439,6 +441,7 @@ SYM_CODE_START(\name)
 	xgr	%r6,%r6
 	xgr	%r7,%r7
 	xgr	%r10,%r10
+	xgr	%r12,%r12
 	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA_ASYNC
 	MBEAR	%r11
@@ -547,6 +550,7 @@ SYM_CODE_START(mcck_int_handler)
 	xgr	%r6,%r6
 	xgr	%r7,%r7
 	xgr	%r10,%r10
+	xgr	%r12,%r12
 	mvc	__PT_R8(64,%r11),0(%r14)
 	stmg	%r8,%r9,__PT_PSW(%r11)
 	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
-- 
2.53.0

