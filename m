Return-Path: <stable+bounces-133033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D230A91AA7
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31FD119E585D
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E4323C8A7;
	Thu, 17 Apr 2025 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gGtiBUn6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD01423C8A2
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889032; cv=none; b=VEYRKs9Po2cYH+66QbB71mN/1Xfv9hy2g4EvZj1toxnVucoya9vNgscEGqzndVgbO8uHs1wdXG0w4itiFSxYYnfGf9/ZuZds6LtLZD07ltXVlNzuJdEok4rIwyMdcRcjYMxHS20C74fy1tdMTDe86GZqXSyhjlUydvYQ+tV4JB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889032; c=relaxed/simple;
	bh=wHLYSUSstZddpXOdCY630C2L+WtST9Vojkhz0d+ku3o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h/091gkAICJ4PQ96+qgqxfBwkK4bGK3LBz5LTStgEMK/sJIQrDd+8XHlXv7Hv+knUkgtY4t50MD4aC5pavTwUWfGiwLFXV+HiM2aTjLiI6m3JgNx7+6CZg1ooJoe1c6TIlpBvMG0+uKV0GKW+Kbxt3+2RqNCZJ94mqXJvxITJIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gGtiBUn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23021C4CEE4;
	Thu, 17 Apr 2025 11:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744889032;
	bh=wHLYSUSstZddpXOdCY630C2L+WtST9Vojkhz0d+ku3o=;
	h=Subject:To:Cc:From:Date:From;
	b=gGtiBUn6GBUZ72KWEzfZeC2av2uTwt7YLxNeleIooSCdzI3lg4Bquo3PhQui2CQ2O
	 pNzWQ/QYHQWX3Iw8FjKzkXmux/dMjlNmYM0UTzoMDkfypU0EY2hlO764jw878pgVug
	 bZDPColKONnuxlsohjNoqVZRKjGwsRjqvBbP2KA0=
Subject: FAILED: patch "[PATCH] ima: limit the number of ToMToU integrity violations" failed to apply to 6.6-stable tree
To: zohar@linux.ibm.com,pvorel@suse.cz,roberto.sassu@huawei.com,stefanb@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 13:05:39 +0200
Message-ID: <2025041739-props-huff-8deb@gregkh>
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
git cherry-pick -x a414016218ca97140171aa3bb926b02e1f68c2cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041739-props-huff-8deb@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a414016218ca97140171aa3bb926b02e1f68c2cc Mon Sep 17 00:00:00 2001
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 27 Jan 2025 10:45:48 -0500
Subject: [PATCH] ima: limit the number of ToMToU integrity violations

Each time a file in policy, that is already opened for read, is opened
for write, a Time-of-Measure-Time-of-Use (ToMToU) integrity violation
audit message is emitted and a violation record is added to the IMA
measurement list.  This occurs even if a ToMToU violation has already
been recorded.

Limit the number of ToMToU integrity violations per file open for read.

Note: The IMA_MAY_EMIT_TOMTOU atomic flag must be set from the reader
side based on policy.  This may result in a per file open for read
ToMToU violation.

Since IMA_MUST_MEASURE is only used for violations, rename the atomic
IMA_MUST_MEASURE flag to IMA_MAY_EMIT_TOMTOU.

Cc: stable@vger.kernel.org # applies cleanly up to linux-6.6
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 3423b3088de5..e0489c6f7f59 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -181,7 +181,7 @@ struct ima_kexec_hdr {
 #define IMA_UPDATE_XATTR	1
 #define IMA_CHANGE_ATTR		2
 #define IMA_DIGSIG		3
-#define IMA_MUST_MEASURE	4
+#define IMA_MAY_EMIT_TOMTOU	4
 #define IMA_EMITTED_OPENWRITERS	5
 
 /* IMA integrity metadata associated with an inode */
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 95118c1887cb..f3e7ac513db3 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -129,14 +129,15 @@ static void ima_rdwr_violation_check(struct file *file,
 		if (atomic_read(&inode->i_readcount) && IS_IMA(inode)) {
 			if (!iint)
 				iint = ima_iint_find(inode);
+
 			/* IMA_MEASURE is set from reader side */
-			if (iint && test_bit(IMA_MUST_MEASURE,
-						&iint->atomic_flags))
+			if (iint && test_and_clear_bit(IMA_MAY_EMIT_TOMTOU,
+						       &iint->atomic_flags))
 				send_tomtou = true;
 		}
 	} else {
 		if (must_measure)
-			set_bit(IMA_MUST_MEASURE, &iint->atomic_flags);
+			set_bit(IMA_MAY_EMIT_TOMTOU, &iint->atomic_flags);
 
 		/* Limit number of open_writers violations */
 		if (inode_is_open_for_write(inode) && must_measure) {


