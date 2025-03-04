Return-Path: <stable+bounces-120332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29121A4E9E1
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714188A42C8
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC402857D8;
	Tue,  4 Mar 2025 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P/uEBCD8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB7127F4FD
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106580; cv=none; b=V8ouT6Gl848r8TJnebfeA4rzoruzfwTKYn00ckr8Af0nxVVRMwRVhoOOQLpI8FZSKpye/8ZPdRJbUFoVS65daeCRRx9XsQUB1lqYOxlq3RQ0DBYqxkVZrDRWy5Wt9plMUJtXAmq+xUFqv1oj3K6eXYsRm5tAJMv+tzonlTG4n88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106580; c=relaxed/simple;
	bh=2vP/5pjsx7lCzeb/rVeIlqHlgj2N3XZluN7vHU3X+V8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=umaqjIraRIAIwRapBdCpLyXhSXLIMiuUtlepariGYLcOBNoqeXhzYYgwQAv8p6+diaSPCINKNHs9YctcnUhneH80tE/8JAs83Obn546Dy19MY5dceLPIr/HCI5EhmMLGVmQt630tU8d6hNXtOhtVsP176DHxCdPqy8dvbNvBw1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P/uEBCD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E9AC4CEE9;
	Tue,  4 Mar 2025 16:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741106580;
	bh=2vP/5pjsx7lCzeb/rVeIlqHlgj2N3XZluN7vHU3X+V8=;
	h=Subject:To:Cc:From:Date:From;
	b=P/uEBCD8N9wxaGWSAq2wG0XdN8rVN36hEMAyuRQkE0/CyQxvCVqv9k5N5cwqmjQAH
	 KW+KlKUqle+2o9Swb4v/TBTaLYB/EkQtWxYrgOz60hsUKoZIoWxF3fCNG95W0dyR85
	 gITgTs64oSzY7G+DlwsVKt9a6Vls0ybvhJkEJ6/g=
Subject: FAILED: patch "[PATCH] ima: Reset IMA_NONACTION_RULE_FLAGS after post_setattr" failed to apply to 5.10-stable tree
To: roberto.sassu@huawei.com,zohar@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:42:37 +0100
Message-ID: <2025030437-anaerobic-valiant-b3b2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 57a0ef02fefafc4b9603e33a18b669ba5ce59ba3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030437-anaerobic-valiant-b3b2@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 57a0ef02fefafc4b9603e33a18b669ba5ce59ba3 Mon Sep 17 00:00:00 2001
From: Roberto Sassu <roberto.sassu@huawei.com>
Date: Tue, 4 Feb 2025 13:57:20 +0100
Subject: [PATCH] ima: Reset IMA_NONACTION_RULE_FLAGS after post_setattr

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

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 24d09ea91b87..a4f284bd846c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -149,6 +149,9 @@ struct ima_kexec_hdr {
 #define IMA_CHECK_BLACKLIST	0x40000000
 #define IMA_VERITY_REQUIRED	0x80000000
 
+/* Exclude non-action flags which are not rule-specific. */
+#define IMA_NONACTION_RULE_FLAGS	(IMA_NONACTION_FLAGS & ~IMA_NEW_FILE)
+
 #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
 				 IMA_HASH | IMA_APPRAISE_SUBMASK)
 #define IMA_DONE_MASK		(IMA_MEASURED | IMA_APPRAISED | IMA_AUDITED | \
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f2c9affa0c2a..28b8b0db6f9b 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -269,10 +269,13 @@ static int process_measurement(struct file *file, const struct cred *cred,
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


