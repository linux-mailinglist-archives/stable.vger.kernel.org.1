Return-Path: <stable+bounces-246455-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ+zJtpuA2p15wEAu9opvQ
	(envelope-from <stable+bounces-246455-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:18:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3504452740E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F47030E72EE
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583DF33ADBA;
	Tue, 12 May 2026 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HwAZ9kFl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC913EDE45;
	Tue, 12 May 2026 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609272; cv=none; b=a6Pix9j+yyUyzoxLT3+8hW2TNciCzWNd4Z5vbd2LJQg2xIiSkYhvICl9x4EpBPsysTOUD+KQ8zKN4gA2mfJFPuoi8rWYNJgywOLJ/ugvxMC2SXcjA4dom/+V+/kdgBtVKStD7i9zumuvGiEKGVTRFmY0v/KfKtotxPBsBSUYVzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609272; c=relaxed/simple;
	bh=6x1UTeNCUVtPAL9whcCrZc4LZm6+JYjSo1icYSOls2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZGIphNsBCwkssRAIPdc9AckNOUkwfuen7NWcou1dJJGxguRWFKL0LE2tCkZDIlZfJhwMspiWT9lrKOkL9r24aqxSHWbKjY3ig8cQGslaeWhnmYQD8YuoC2klOCOgSZrr8jmiicVqa17Eofrcon9+o1U++0PThP9lx7WpRrUWUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HwAZ9kFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75F8C2BCB0;
	Tue, 12 May 2026 18:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609272;
	bh=6x1UTeNCUVtPAL9whcCrZc4LZm6+JYjSo1icYSOls2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HwAZ9kFlcIsLhxd+AiaGdlW7Wk9woZutHTmVqe0ECwdOyqxX8Tm7xBjJ1/MBF/ddS
	 0UeD5mGBErqSpBJmsYZhl3zzBPvRK9ui1BQc+dmh3R5EbMGmXDu1Y64xintFmciFPd
	 YAz6sY7sgs/49Zg7Ggjnp1khS7fc+IkvBM8K5aiU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haren Myneni <haren@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH 7.0 114/307] pseries/papr-hvpipe: Fix null ptr deref in papr_hvpipe_dev_create_handle()
Date: Tue, 12 May 2026 19:38:29 +0200
Message-ID: <20260512173942.529406478@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3504452740E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-246455-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux.ibm.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

commit 1b9f7aafa44f5ce852c00509104d10fd9eb0f402 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 57 ++++++++++----------
 1 file changed, 30 insertions(+), 27 deletions(-)

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
-- 
2.54.0




