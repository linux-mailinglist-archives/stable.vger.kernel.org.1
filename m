Return-Path: <stable+bounces-133032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDE2A91AA8
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3339416CA08
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3687723C387;
	Thu, 17 Apr 2025 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yHXr4G9o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB88723C385
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889030; cv=none; b=VyV0bHq4ov09JUFPnK5T0vSOxvG4k4+8YLI7HsJUi6QeXkK//p8Z2lik5PdFZZLpMy4/ztEQNnIfKinSsAFumcD9rkhgVJkUESUrezHpV+vsYObo0nIO9Cn0UU3a0Kb2qQSc+AAvb9VteVNtdHQy2C0edAbQehEjC68X4+wcCzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889030; c=relaxed/simple;
	bh=t1Zxi4bI3NVisWBZHDcELmJO4NtpgFcvPpYG/E60lb8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aJouP/BBDMIYLxFKAS7H6DClLqBNhQXbQgF92RzIdY3jgR42Npf6MGqr6x+VW9hSmUFFPBG3mexAEFBeo51CDaJlxpjSQhw0i9QPQeoTb3puwicjcPUDgWLhwrjZem79ts7iDkWsu5HDeJmQQdjngzTs0Hu/ST3wk2V+LueL2lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yHXr4G9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229C5C4CEE4;
	Thu, 17 Apr 2025 11:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744889029;
	bh=t1Zxi4bI3NVisWBZHDcELmJO4NtpgFcvPpYG/E60lb8=;
	h=Subject:To:Cc:From:Date:From;
	b=yHXr4G9o6bMexwraol4e9eG24KeG2qHx0+Mte79fxr0bupjrusokL7Z4vJb3llaUJ
	 Od0jjGV2a3oEWzJ2bRtVk6mRFTujiq8lbonC59nl0UDZW6ONGHkW7vvInA6OLOYK35
	 LVruyK6y2/alU4gSLTgaFN74ZN2Y1B8V40Fw8F94=
Subject: FAILED: patch "[PATCH] ima: limit the number of open-writers integrity violations" failed to apply to 6.6-stable tree
To: zohar@linux.ibm.com,pvorel@suse.cz,roberto.sassu@huawei.com,stefanb@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 13:05:24 +0200
Message-ID: <2025041724-puritan-pointer-517f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5b3cd801155f0b34b0b95942a5b057c9b8cad33e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041724-puritan-pointer-517f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5b3cd801155f0b34b0b95942a5b057c9b8cad33e Mon Sep 17 00:00:00 2001
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 27 Jan 2025 10:24:13 -0500
Subject: [PATCH] ima: limit the number of open-writers integrity violations

Each time a file in policy, that is already opened for write, is opened
for read, an open-writers integrity violation audit message is emitted
and a violation record is added to the IMA measurement list. This
occurs even if an open-writers violation has already been recorded.

Limit the number of open-writers integrity violations for an existing
file open for write to one.  After the existing file open for write
closes (__fput), subsequent open-writers integrity violations may be
emitted.

Cc: stable@vger.kernel.org # applies cleanly up to linux-6.6
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index a4f284bd846c..3423b3088de5 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -182,6 +182,7 @@ struct ima_kexec_hdr {
 #define IMA_CHANGE_ATTR		2
 #define IMA_DIGSIG		3
 #define IMA_MUST_MEASURE	4
+#define IMA_EMITTED_OPENWRITERS	5
 
 /* IMA integrity metadata associated with an inode */
 struct ima_iint_cache {
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 28b8b0db6f9b..95118c1887cb 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -137,8 +137,13 @@ static void ima_rdwr_violation_check(struct file *file,
 	} else {
 		if (must_measure)
 			set_bit(IMA_MUST_MEASURE, &iint->atomic_flags);
-		if (inode_is_open_for_write(inode) && must_measure)
-			send_writers = true;
+
+		/* Limit number of open_writers violations */
+		if (inode_is_open_for_write(inode) && must_measure) {
+			if (!test_and_set_bit(IMA_EMITTED_OPENWRITERS,
+					      &iint->atomic_flags))
+				send_writers = true;
+		}
 	}
 
 	if (!send_tomtou && !send_writers)
@@ -167,6 +172,8 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 	if (atomic_read(&inode->i_writecount) == 1) {
 		struct kstat stat;
 
+		clear_bit(IMA_EMITTED_OPENWRITERS, &iint->atomic_flags);
+
 		update = test_and_clear_bit(IMA_UPDATE_XATTR,
 					    &iint->atomic_flags);
 		if ((iint->flags & IMA_NEW_FILE) ||


