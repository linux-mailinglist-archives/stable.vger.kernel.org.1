Return-Path: <stable+bounces-231418-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EL6cCCe9y2kwKwYAu9opvQ
	(envelope-from <stable+bounces-231418-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:25:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EED369711
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4F9D301727D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C111C3E1CE6;
	Tue, 31 Mar 2026 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W4iW2jmr"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674093DCD9C
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959832; cv=none; b=WqatOVvI2oR4S+Gkn/+zYCdUgDPjTOn4odnTQZtwL+hzWV+D2AudK5EZ7Ijwpj2m4fE1uyO983z0m9h0euRg8NG5zoE4rZmhBnjuUVn0tcw1/mAIU9726cHLhdIFG/Ggr4eyN6R+kfaz5qRjwQ2vr0LccnhSsD5QkdnH1F7pr4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959832; c=relaxed/simple;
	bh=VL8kDvjmg68LRVsMoOCBa7OgMWsbvtToanpomrwbdKE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NkNAJtmT8aiJqzz8IrCYLWKWs5kf4opzAh20lTgSrLpkCPa+hE481Fgd/PWH28tznSgBvPOXyhAv+AcKo5k2Q6PWJn/L4iaB+SkzgwFoTT7OGUmCHMZGZv/5CgOKQzBskrXeFtR1HcLdsdRxwQ4r+xWHCb+5fU4eP8XbzqB1mpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W4iW2jmr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V2Omtt3405202;
	Tue, 31 Mar 2026 12:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=BYwhyKZEBuXPSm4QIU6uds/+uDLl
	jIOs1Yff7F5nXXU=; b=W4iW2jmrlkms5QbbexekK98/vLmsK9Axt19OT3Fr31b/
	fyMpKZoM6mI6W86P9cAo5Jlg3lY1eq4VTjZAuGVeWPCeDdUms628EDh+bTUaT5oh
	p5RZHAUmgtXqcW0On6YNcyt6Isnse05DhrY9/kXTIdBvPppRbajPMFl6hUOzZh0p
	apkECWbB+EWFaCuntUtuvw+rahsPQFZKXgkOVYkP0ygX67aFeh3ZKq7+iBQRWVfy
	Aa48JOqgG2EF8qxwkg1r6/esX+pLDkqMRxyKvCS1b3OsLHlxtiCf3ZCEOLbx6/av
	QWFhgyswi1/YnHhvlFXon1Pm/eEVCm/mxnZV489RUQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g1u7a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 12:23:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62VBP05B005980;
	Tue, 31 Mar 2026 12:23:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy12w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 12:23:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62VCNh8A43909480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 12:23:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB78020043;
	Tue, 31 Mar 2026 12:23:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7230D20040;
	Tue, 31 Mar 2026 12:23:43 +0000 (GMT)
Received: from localhost (unknown [9.111.25.211])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 31 Mar 2026 12:23:43 +0000 (GMT)
Date: Tue, 31 Mar 2026 14:23:42 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 5.10.y] s390/syscalls: Add spectre boundary for syscall
 dispatch table
Message-ID: <p01.g4865e9641758.ttcrjn3@ub.hpns>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69cbbcd5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=ag1SF4gXAAAA:8 a=VnNF1IyMAAAA:8 a=s6l9CJkWEEISTPkelCwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: Wwz1tdOSP1mPu1_aleN3RK8QmZze-3af
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDExOSBTYWx0ZWRfX+tM4p2sNPsjF
 XM1uKUOcS+AzGSbHohucQn2gP21OBfN5FSXnVvObaOVMklBDUkKWqCXZE3JzX6Fe777uqR1WSOf
 xYRMpRMaJqBxFiHeXkNdEyA6nudIGu1gLD1t7zbdZzI0dSzPPEl77HEPs0p8maYXVF38aZRNMy8
 hlt5KzxBDgdfpB42b42nhAG26qkzadQwnfUnHfFaqiD3oO7HNrEQ0+yqokIfJXj7yub8CDZ/ox6
 I5lcDd/0vsVs5pzBYHVqSfxppbR63ngZPxB2o+qhHIwXsXR5p74XlT6R+egWberL9MBJpAwycz9
 Fzra4VzAEib2sCX0d334VgwE72lz4inB3gEh8iLWKv+wB0+nW36+PTl0gFTpSTkmiOhWk0wpVDK
 +sbm791LrHQLvL20dXw8QqCs9mzK+Fjz9/ggs92p1mVi4E2lX5QO0tk8msJ2LlHmDF7o09SnWXb
 FZM7jCUzG/eqmXW/QPQ==
X-Proofpoint-GUID: Wwz1tdOSP1mPu1_aleN3RK8QmZze-3af
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310119
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231418-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,ub.hpns:mid,arndb.de:email];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gor@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 83EED369711
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit 48b8814e25d073dd84daf990a879a820bad2bcbd ]

The s390 syscall number is directly controlled by userspace, but does
not have an array_index_nospec() boundary to prevent access past the
syscall function pointer tables.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Fixes: 56e62a737028 ("s390: convert to generic entry")
Cc: stable@kernel.org
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Link: https://lore.kernel.org/r/2026032404-sterling-swoosh-43e6@gregkh
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
[ gor: 5.10 backport. In 5.10, commit 56e62a737028 ("s390: convert to
  generic entry") has not been applied — syscall dispatch is in
  assembly (entry.S), not in C (syscall.c). The equivalent to
  array_index_nospec() is implemented using the same clgr/slbgr/ngr.

  SVC 0 path: the user-controlled syscall number in r1 is clamped via
  a single unsigned compare (clgr) followed by slbgr/ngr. The original
  cghi/jnl bounds check branch is replaced — the clamp handles both
  cases: in-bounds values pass through, out-of-bounds values are zeroed
  (producing the same r8=0 dispatch to table[0] as the original branch).

  SVC 1-255 path: syscall number from the 8-bit instruction immediate
  is always in bounds. ]
Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/kernel/entry.S | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 127a8d295ae3..106f4b21faf2 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -420,12 +420,15 @@ ENTRY(system_call)
 	# svc 0: system call number in %r1
 	llgfr	%r1,%r1				# clear high word in r1
 	sth	%r1,__PT_INT_CODE+2(%r11)
-	cghi	%r1,NR_syscalls
-	jnl	.Lsysc_nr_ok
+	lghi	%r0,NR_syscalls-1
+	clgr	%r1,%r0				# CC0/1 if r1 in bounds
+	slbgr	%r0,%r0				# mask = -1 in bounds, 0 out of bounds
+	ngr	%r1,%r0				# clamp r1
 	slag	%r8,%r1,3
 .Lsysc_nr_ok:
 	stg	%r2,__PT_ORIG_GPR2(%r11)
 	stg	%r7,STACK_FRAME_OVERHEAD(%r15)
+	xgr	%r1,%r1				# scrub r1, unclamped user value for svc 1-255
 	lg	%r9,0(%r8,%r10)			# get system call add.
 	TSTMSK	__TI_flags(%r12),_TIF_TRACE
 	jnz	.Lsysc_tracesys
-- 
2.53.0

