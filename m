Return-Path: <stable+bounces-247825-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IONaGps7B2ottwIAu9opvQ
	(envelope-from <stable+bounces-247825-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:28:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 094D65521FF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EEDA3009F43
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC3C49550E;
	Fri, 15 May 2026 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DstDY0an"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315DE3FE670
	for <stable@vger.kernel.org>; Fri, 15 May 2026 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858905; cv=none; b=UDFbno/pUPOKaa+1tTRxtPzS/n/b+UgzClYM/nDBky7SAkm3xz7J3inZDlIWc1IdN3a0jmIBgpFG/W2g3NKA1bkEkNk1g04ut/RgN6WIiT4J26T85s09maaLTMGTDYnEZOj6NSYQjm6sxnhOZxRLMFDH2CUEorzNkY/rFRyp5S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858905; c=relaxed/simple;
	bh=m/vAsjy+7c9OKOsfRl/fgWoItiU200r13XnOBRdohUE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Z1s/6p7rKSpmsyyjk6KMmxHnLe2hZZ74OERgcmqxF5QAp8bJcOWrcUAdGL9wZId5+2b0I6s5TfWJlKKj7ONkT/LM5asQj03uZ16cChSCvQfkJ52/TPcF9xD5JOo88ITqGpODColviMWrOHqeDSA/hJNh6B+5MxIR9sJU0kU9WRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DstDY0an; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F4AC2BCB0;
	Fri, 15 May 2026 15:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778858904;
	bh=m/vAsjy+7c9OKOsfRl/fgWoItiU200r13XnOBRdohUE=;
	h=Subject:To:Cc:From:Date:From;
	b=DstDY0anZLYUoOgXOK3NYWA9HqzUnZzaZFmd2U2mfNk2moV0Jfo5B76JBvsxByCZR
	 DgodzukMjO68st9W0SesFEh+YGd1N09WA9Ymb0QgaujLm0Iyny4i+cVaab/KyByqBY
	 eO5fsy4k1zDtRElJcWrTGhivo2azlhuS/ghCYYYU=
Subject: FAILED: patch "[PATCH] pseries/papr-hvpipe: Fix null ptr deref in" failed to apply to 6.18-stable tree
To: ritesh.list@gmail.com,haren@linux.ibm.com,maddy@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 17:28:29 +0200
Message-ID: <2026051529-salami-uncouple-7bcf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 094D65521FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247825-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,linux.ibm.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 1b9f7aafa44f5ce852c00509104d10fd9eb0f402
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051529-salami-uncouple-7bcf@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1b9f7aafa44f5ce852c00509104d10fd9eb0f402 Mon Sep 17 00:00:00 2001
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Date: Fri, 1 May 2026 09:41:42 +0530
Subject: [PATCH] pseries/papr-hvpipe: Fix null ptr deref in
 papr_hvpipe_dev_create_handle()

commit 6d3789d347a7 ("papr-hvpipe: convert papr_hvpipe_dev_create_handle() to FD_PREPARE()"),
changed the create handle to FD_PREPARE(), but it caused kernel
null-ptr-deref because after call to retain_and_null_ptr(src_info),
src_info is re-used for adding it to the global list.

Getting the following kernel panic in papr_hvpipe_dev_create_handle()
when trying to add src_info to the list.
 Kernel attempted to write user page (0) - exploit attempt? (uid: 0)
 BUG: Kernel NULL pointer dereference on write at 0x00000000
 Faulting instruction address: 0xc0000000001b44a0
 Oops: Kernel access of bad area, sig: 11 [#1]
 ...
 Call Trace:
 papr_hvpipe_dev_ioctl+0x1f4/0x48c (unreliable)
 sys_ioctl+0x528/0x1064
 system_call_exception+0x128/0x360
 system_call_vectored_common+0x15c/0x2ec

Now, the error handling with FD_PREPARE's file cleanup and __free(kfree) auto
cleanup is getting too convoluted. This is mainly because we need to
ensure only 1 user get the srcID handle. To simplify this, we allocate
prepare the src_info in the beginning and add it to the global list
under a spinlock after checking that no duplicates exist.

This simplify the error handling where if the FD_ADD fails, we can
simply remove the src_info from the list and consume any pending msg in
hvpipe to be cleared, after src_info became visible in the global list.

Cc: stable@vger.kernel.org
Fixes: 6d3789d347a7 ("papr-hvpipe: convert papr_hvpipe_dev_create_handle() to FD_PREPARE()")
Reported-by: Haren Myneni <haren@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/31ad94bc89d44156ee700c5bd006cb47a748e3cb.1777606826.git.ritesh.list@gmail.com

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 3392874ebdf6..402781299497 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -480,23 +480,10 @@ static const struct file_operations papr_hvpipe_handle_ops = {
 
 static int papr_hvpipe_dev_create_handle(u32 srcID)
 {
-	struct hvpipe_source_info *src_info __free(kfree) = NULL;
+	struct hvpipe_source_info *src_info;
+	int fd;
 	unsigned long flags;
 
-	spin_lock_irqsave(&hvpipe_src_list_lock, flags);
-	/*
-	 * Do not allow more than one process communicates with
-	 * each source.
-	 */
-	src_info = hvpipe_find_source(srcID);
-	if (src_info) {
-		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
-		pr_err("pid(%d) is already using the source(%d)\n",
-				src_info->tsk->pid, srcID);
-		return -EALREADY;
-	}
-	spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
-
 	src_info = kzalloc_obj(*src_info, GFP_KERNEL_ACCOUNT);
 	if (!src_info)
 		return -ENOMEM;
@@ -505,26 +492,42 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 	src_info->tsk = current;
 	init_waitqueue_head(&src_info->recv_wqh);
 
-	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
-		   anon_inode_getfile("[papr-hvpipe]", &papr_hvpipe_handle_ops,
-				      (void *)src_info, O_RDWR));
-	if (fdf.err)
-		return fdf.err;
-
-	retain_and_null_ptr(src_info);
-	spin_lock_irqsave(&hvpipe_src_list_lock, flags);
 	/*
-	 * If two processes are executing ioctl() for the same
-	 * source ID concurrently, prevent the second process to
-	 * acquire FD.
+	 * Do not allow more than one process communicates with
+	 * each source.
 	 */
+	spin_lock_irqsave(&hvpipe_src_list_lock, flags);
 	if (hvpipe_find_source(srcID)) {
 		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
+		pr_err("pid(%d) could not get the source(%d)\n",
+				src_info->tsk->pid, srcID);
+		kfree(src_info);
 		return -EALREADY;
 	}
 	list_add(&src_info->list, &hvpipe_src_list);
 	spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
-	return fd_publish(fdf);
+
+	fd = FD_ADD(O_RDONLY | O_CLOEXEC,
+		   anon_inode_getfile("[papr-hvpipe]", &papr_hvpipe_handle_ops,
+				      (void *)src_info, O_RDWR));
+	if (fd < 0) {
+		spin_lock_irqsave(&hvpipe_src_list_lock, flags);
+		list_del(&src_info->list);
+		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
+		/*
+		 * if we fail to add FD, that means no userspace program is
+		 * polling. In that case if there is a msg pending because the
+		 * interrupt was fired after the src_info was added to the
+		 * global list, then let's consume it here, to unblock the
+		 * hvpipe
+		 */
+		if (src_info->hvpipe_status & HVPIPE_MSG_AVAILABLE)
+			hvpipe_rtas_recv_msg(NULL, 0);
+		kfree(src_info);
+		return fd;
+	}
+
+	return fd;
 }
 
 /*


