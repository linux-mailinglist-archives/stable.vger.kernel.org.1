Return-Path: <stable+bounces-224643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM82AA0JsWnhpwIAu9opvQ
	(envelope-from <stable+bounces-224643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 07:17:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5743325CBDC
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 07:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 887F4313FABD
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 06:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11832EC0A4;
	Wed, 11 Mar 2026 06:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WdfUPqE2"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EABF1A6805;
	Wed, 11 Mar 2026 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773209864; cv=none; b=pIUgYgABg415V8fJ9qB/fUUPcNlD9R9YbXwuM3ozkfadSOmQPaM+sQAQN/dMySFxTApR4ORWRjpa32bAsSwVZtU7rbgqfKD5o3V9Gsi4MtWZ44XHP3lSPiPZR8SMAv2kaKI84NtXTJc3s6VoX0DShgkYLsY4m9GV4VmWItQMvOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773209864; c=relaxed/simple;
	bh=y64Mh80p5X3MO1QUjCXAWOrQXqmOOP3HwN7I9HE04WY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pMZhmzN6H7xb4XFD8UfxynMmNDOnJnQLoTGtJjvg29SBv+IMYdGk4ZcX7YWKNlnn7z8ns+66OFf0BjSi3hGv3Y7RBfk2l6CQlQf/zYjfRiHkjy4KsDXncV1AWOE/JjIVJAdflKAaGwE46RFhAjcP+qUFoeOtsPH/mrUbnRSd7Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WdfUPqE2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AHN4NH153178;
	Wed, 11 Mar 2026 06:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=7F7of/pioiEzfSaxmZRMCX3Fg2mJoOP4EB0Z/kFfv
	fc=; b=WdfUPqE23fcAEdtiEj9iapy3pSScU4VjAghhrcdwmt2X3SgVFXSkSEPxb
	/VdlRUx5esipp+8IUMIRl4aUCLmX3jhaz/ikAy5y5yycHMc0YRD4UFd7B2VcCUPD
	4/eZIrhw+SS+Raw0DHXxD4vMa1g5ZFFqEm2YIPXg2j5fkXbg8vkQbMkEV0xY+Ui/
	NdqZTXn3v7YhyKEfkdR6FCNMuKj8DXh7CZ7jZLk0inEv24Fs38mt/amH4zn9ZrfT
	fS0D5+DeiaGwfqL+L28rTB44DqTDo58lUGc366pfyUbfS9zgA5goUge1y8A1yh8H
	/jt11qcdMv7nBz9kVPCmQ5LhAehbw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1mnywj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 06:17:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62B12Xvn015653;
	Wed, 11 Mar 2026 06:17:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crybncady-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 06:17:31 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62B6HR6N12255660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 06:17:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 585B02005A;
	Wed, 11 Mar 2026 06:17:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B30A42004E;
	Wed, 11 Mar 2026 06:17:24 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.22.168])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 06:17:24 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: sshegde@linux.ibm.com, chleroy@kernel.org, nysal@linux.ibm.com,
        mkchauras@linux.ibm.com, rafael@kernel.org, daniel.lezcano@kernel.org,
        christian.loehle@arm.com, mkchauras@gmail.com, npiggin@gmail.com,
        linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2] cpuidle: powerpc: avoid double clear when breaking snooze
Date: Wed, 11 Mar 2026 11:47:09 +0530
Message-ID: <20260311061709.1230440-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69b108fc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=cVrzkdVh9Pqr8fURmIoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA0OSBTYWx0ZWRfX5OlTuLCxBycs
 bsoQQt2MYTPFxkbG+pgCJpHm6FfnYhFm7WQ2aE4LrjClRvwwvtcE+XTQJyLAieMDac4/2tqAJiH
 KLoVPhxvV5WcI/S2qBVPVyEIr5bvDC5oiDkcq6sJNZdpERMHxXib4rdDSwxWkz5z9jilH1Pdi+e
 Mf3XiBpkV4Ha+e6N3w2bc4ZtQHugpGFnM5+IaXqnjDQsZ6cHizwXJoVawQkxIIWOH2QaOwteQ/K
 2LTKxDDvND7F5d4lNvU31db5x0DUv+6khf5TJMEjGxB7O4QWnyfYCV9yboD2QCG4w1M/06Obf9V
 fJ7rOJqJct2fNJAkTaEBvOePpWCirvJddfYO+9G7R3S0XRYz0hn/u3tKiq7F/f29cEywnjp/Jl0
 qEgxf1CjR+9BoXrOt6LlKs4b9PeQfDVxW3LJe1NjgEd6WXhIiF2lH0hE/gLVTZmP5hPlRyrplIz
 kbVhZoMlQm2qrbkir9w==
X-Proofpoint-GUID: IwXrcu66crhxX1fWNSOJmNmD6fEejyAe
X-Proofpoint-ORIG-GUID: KUkcok53n_Viifrr4RsG4gVX4qwPZMwN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110049
X-Rspamd-Queue-Id: 5743325CBDC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224643-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,arm.com,gmail.com,vger.kernel.org];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sshegde@linux.ibm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

snooze_loop is done often in any system which has fair bit of
idle time. So it qualifies for even micro-optimizations. 

When breaking the snooze due to timeout, TIF_POLLING_NRFLAG is cleared
twice. Clearing the bit invokes atomics. Avoid double clear and thereby
avoid one atomic write.

dev->poll_time_limit indicates whether the loop was broken due to
timeout. Use that instead of defining a new variable.

Fixes: 7ded429152e8 ("cpuidle: powerpc: no memory barrier after break from idle")
Cc: stable@vger.kernel.org
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
v1->v2:
- Added rwb tag - Thanks to Mukesh Kumar Chaurasiya
- Added fixes tag
v1: https://lore.kernel.org/all/20260310152811.1131119-1-sshegde@linux.ibm.com/

 drivers/cpuidle/cpuidle-powernv.c | 5 ++++-
 drivers/cpuidle/cpuidle-pseries.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 9ebedd972df0..b89e7111e7b8 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -95,7 +95,10 @@ static int snooze_loop(struct cpuidle_device *dev,
 
 	HMT_medium();
 	ppc64_runlatch_on();
-	clear_thread_flag(TIF_POLLING_NRFLAG);
+
+	/* Avoid double clear when breaking */
+	if (!dev->poll_time_limit)
+		clear_thread_flag(TIF_POLLING_NRFLAG);
 
 	local_irq_disable();
 
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index f68c65f1d023..864dd5d6e627 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -64,7 +64,10 @@ int snooze_loop(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	}
 
 	HMT_medium();
-	clear_thread_flag(TIF_POLLING_NRFLAG);
+
+       /* Avoid double clear when breaking */
+	if (!dev->poll_time_limit)
+		clear_thread_flag(TIF_POLLING_NRFLAG);
 
 	raw_local_irq_disable();
 
-- 
2.43.0


