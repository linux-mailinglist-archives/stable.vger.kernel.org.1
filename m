Return-Path: <stable+bounces-121133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9B5A540AA
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 03:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1EE53AEFAA
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 02:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F87F9F8;
	Thu,  6 Mar 2025 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GdJljHc/"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1343D2907
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741228138; cv=none; b=uiEuJ4q40m7mnz+JZFsRRsfF88P0QG0KlwRooPO//p9aFQQ+j12xoiPGDu7M4B8nsyR3V5GcNvHJSUF2dTYBtRzuH285A3z0mT7BNZIQTVFP4s5ZcRXoe4z5u/3jS3AV9NfGcOcLyzfnks8sF8oGOiDeRBLVHy1JZF+dNZl77k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741228138; c=relaxed/simple;
	bh=uazQrSGZViu1kwJXHSMrEhHzdNPQmdS2Aojz7kFl/g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/zyxRlkdGeEt/7gN3BLglc9ei2AzfLNkSrTnx9YVh4oipxnZUUFVw4mFXmXP7KbmpPzWUrQ+/+QTaTwqx8FOiGjiH1MfhiWqFJOWGdPF4y1RzLLmBRn3gJK9Z9ACLX4DhhY92wsNFMGmhQrp6UySpg1cG8V8A8WJ/dmx2faukk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GdJljHc/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525NLlr3016483;
	Thu, 6 Mar 2025 02:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9twF7oetfa04rQIqK
	2kTr51RR+KBjjrwXt2frS9Sbwk=; b=GdJljHc/ewT7Hrqwuu1s5s4WUZm7mvkxR
	3lKJ+btisY9F9I3jewO/tr+xcz8rM+HCQck7X2dalMJbXHNecHFMa31h5fAZnbgQ
	AYZUlDerdNEdg4CGI+AeXClQ4bSM6uBC4W7T8qYbCS1+8JOu/bMObQTOZUVApKFc
	XAgixpeBQkbezZdzVk6yWeyUb4B+xqCwXWTHstTALOGavEsI+J9hj9HW1BBlQiUB
	tTth35Qlmr4EzrtCzdwAiVFuiC4M0O+ADkLo4js2WEhzGrDDoMEYMD8+AaOEmCrB
	PblVdj3Ftf0e4ALWxu77tWEaRRI8/NNKbRavBlc7FJjYllvFZRa+g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456f08wxj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 02:28:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5260Vi2w032236;
	Thu, 6 Mar 2025 02:28:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjt6e9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 02:28:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5262Se3a41091564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Mar 2025 02:28:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED4CE2004D;
	Thu,  6 Mar 2025 02:28:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCB7020040;
	Thu,  6 Mar 2025 02:28:38 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.10.103])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Mar 2025 02:28:38 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 6.6.y] ima: Reset IMA_NONACTION_RULE_FLAGS after post_setattr
Date: Wed,  5 Mar 2025 21:28:33 -0500
Message-ID: <20250306022833.6151-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025030435-perm-thesis-21fc@gregkh>
References: <2025030435-perm-thesis-21fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _rolYS20U_5RynkuPjDpcwnz8wTBTFBo
X-Proofpoint-GUID: _rolYS20U_5RynkuPjDpcwnz8wTBTFBo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_01,2025-03-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060015

From: Roberto Sassu <roberto.sassu@huawei.com>

Commit 0d73a55208e9 ("ima: re-introduce own integrity cache lock")
mistakenly reverted the performance improvement introduced in commit
42a4c603198f0 ("ima: fix ima_inode_post_setattr"). The unused bit mask was
subsequently removed by commit 11c60f23ed13 ("integrity: Remove unused
macro IMA_ACTION_RULE_FLAGS").

Restore the performance improvement by introducing the new mask
IMA_NONACTION_RULE_FLAGS, equal to IMA_NONACTION_FLAGS without
IMA_NEW_FILE, which is not a rule-specific flag.

Finally, reset IMA_NONACTION_RULE_FLAGS instead of IMA_NONACTION_FLAGS in
process_measurement(), if the IMA_CHANGE_ATTR atomic flag is set (after
file metadata modification).

With this patch, new files for which metadata were modified while they are
still open, can be reopened before the last file close (when security.ima
is written), since the IMA_NEW_FILE flag is not cleared anymore. Otherwise,
appraisal fails because security.ima is missing (files with IMA_NEW_FILE
set are an exception).

Cc: stable@vger.kernel.org # v4.16.x
Fixes: 0d73a55208e9 ("ima: re-introduce own integrity cache lock")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
(cherry picked from commit 57a0ef02fefafc4b9603e33a18b669ba5ce59ba3)
---
 security/integrity/ima/ima_main.c | 7 +++++--
 security/integrity/integrity.h    | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index cc1217ac2c6f..98308a2bdef6 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -267,10 +267,13 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	mutex_lock(&iint->mutex);
 
 	if (test_and_clear_bit(IMA_CHANGE_ATTR, &iint->atomic_flags))
-		/* reset appraisal flags if ima_inode_post_setattr was called */
+		/*
+		 * Reset appraisal flags (action and non-action rule-specific)
+		 * if ima_inode_post_setattr was called.
+		 */
 		iint->flags &= ~(IMA_APPRAISE | IMA_APPRAISED |
 				 IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
-				 IMA_NONACTION_FLAGS);
+				 IMA_NONACTION_RULE_FLAGS);
 
 	/*
 	 * Re-evaulate the file if either the xattr has changed or the
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 9561db7cf6b4..ad20ff7f5dfa 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -42,6 +42,9 @@
 #define IMA_CHECK_BLACKLIST	0x40000000
 #define IMA_VERITY_REQUIRED	0x80000000
 
+/* Exclude non-action flags which are not rule-specific. */
+#define IMA_NONACTION_RULE_FLAGS	(IMA_NONACTION_FLAGS & ~IMA_NEW_FILE)
+
 #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
 				 IMA_HASH | IMA_APPRAISE_SUBMASK)
 #define IMA_DONE_MASK		(IMA_MEASURED | IMA_APPRAISED | IMA_AUDITED | \
-- 
2.48.1


