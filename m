Return-Path: <stable+bounces-242236-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EsUKcwq9Glp+wEAu9opvQ
	(envelope-from <stable+bounces-242236-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 06:23:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ACB4AA4BF
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 06:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A48430745C9
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 04:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2F12FB965;
	Fri,  1 May 2026 04:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvSfAXZo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF67E304BCB
	for <stable@vger.kernel.org>; Fri,  1 May 2026 04:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608750; cv=none; b=SSADdfnlXe8qy3p0J2mdQScx/gapZykhJkptda65ZHGgo73q6nNzsDMVavB3odP8cfRe/uPt4dS+fllbn5GXoB1iOVb1Hu6HrDAIplt9gzpexEilGYbi7djfwJXb/iKuH8ibji08s25ZL3btY8B8eX350mPOGeJMJx6eCA7IusE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608750; c=relaxed/simple;
	bh=Z2tXO/TODik6ZuM5fgaciL/nr8ovAug6a5249/dhZ1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gw7rF/YPMQlc/pLmKHbsN17HTyoPLiN5DvTKQb8tmJiyQoKROmeIOP5zGZSAZYCRRVTTvskgfPXNlNMqfQFY1U5TQBhfqC3mnwNXAj3MPXy+jTOXlazKvN6CNr0vd+xgWUJgi5ZTt9Qul9QjLWnm/95ZsL5L1yMX3BigzGPc884=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvSfAXZo; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c76bde70ec9so616730a12.2
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 21:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777608748; x=1778213548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF2w3z4/59cYB6Oy2yDdp9rDcfrHGTFcj+1xeJe6XK4=;
        b=EvSfAXZoRO1VrT3k6sVua0KgFCU8a9D2LK8EtiC5FTVY6C9pGkVvAb50x26xUJqD3D
         vcdcDKDzpVjjKIkp5sX+VYx9YSvJBJtWL8PUdlqveKa2rc2K/pOnlJ9nWMLYqbfdcfop
         rcqQUrmb0eBtyM7r0ktBH4uMefHsrNMjb5ecrM4fG0jSuXx1rK1xhkvGsAm4++QiBq/f
         LlUQQt5jnMntkNJ/OrjlEaTFLupq25YWMDJdQdiSk48v7P/RnOlvkV4GpivWqlVnIHDm
         2cAk9/BQ6rX9yv40ffT3GgR69LFKHo0iWrDGLPEe/WYvevgBNWjNlmCjpd0ErMp83BFU
         pCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777608748; x=1778213548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dF2w3z4/59cYB6Oy2yDdp9rDcfrHGTFcj+1xeJe6XK4=;
        b=WUYhgXQ6UBCCi0821erApt8gssVn+I15zyMbPjhuINCY7Y+F7aw64+ZXF1tuqHr/Gs
         l/jMOa5FseXpO22A7XMiKE/okfGf/hMiAgKYQ5aoCpULez6OFC8OYCG8znkMxHT4EXUJ
         KarzwVIBhLQK7/IM2aUTfIhNmMeHfHDtBdzGqrh+sHz1BkMIfeNqIfUfGWkaPVleUxMn
         p6Tog1eqxin2FTFi/NhalpF/II4Q5brK0KWVY0DFi6Hd/ALmDSQRbTQjkK9+XpuOoMBP
         2IHy7zI949wAxpqIg2JOqPSn7uRhL+j0Q0vwt3xR/rzenSWzq6iZljcvsdMAD/g2fMNB
         o4QA==
X-Forwarded-Encrypted: i=1; AFNElJ+EEPdcA71/YkqGKeLyYGiZXf12eeFmTVSILo9CcJa3ipezY0Fsci0H/JFGuKcRYswx9SJRy7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf4Hxdd6XwQapnVAZ6FsRDsRgeisOZoVOXCnV/g68QU2i70bca
	EztQQonHlAzizdK0Or2dunE6eEQcKrJETOvaJy8PjvicmqLlkKwVbSfw
X-Gm-Gg: AeBDietc9/f6uP9P+QD3qWxZm/plN6OGLQpyjQmeHGk1A9y+AT/LjIIyIBZA5C+R0Wu
	yBD3C1W1KSwqvTDuEEE2+amxvXktD2wsGes6ZWWtUxQKYHedNXavv38rw6v+MGK/rU0aEdDRrzI
	VD9k/c3h3X9deh19ro5Y/hJl7nIJmd9I8bwgu5Aq5H+LI3HYVMs/tmCxoHe/fLYsf+biraDdPKh
	lMPSeEGewxmrXXrIFLyzBgbg7irL8I/4dJgQMz0yESh71zPIAWN/4lRnSoz6MomJo2pJeP5XJ71
	/jXCRxcsLQWzOGLt6GOqzE3Jdj7fRD6Xiu6hO5JZvVCAJWwVP0YOiLnwJgm42ZOybhMcY5GIikh
	xa337FJc0f9XinLknjwEg2gv/Q5mJzBtRacPem7qJrTpNjr8mmH26HBbMzpbdUmylv+h8yA9CrE
	VdMbkNrHyk1znvpX5HgAWAKnRxY15x3nXylZ/vwaHf2J6Rts0zLuw3FY1Q5f+Bzf8=
X-Received: by 2002:a05:6a20:5483:b0:395:ce56:4448 with SMTP id adf61e73a8af0-3a3cf68b511mr6112736637.25.1777608748275;
        Thu, 30 Apr 2026 21:12:28 -0700 (PDT)
Received: from localhost.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b485eesm1159428b3a.48.2026.04.30.21.12.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 21:12:27 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/9] pseries/papr-hvpipe: Fix null ptr deref in papr_hvpipe_dev_create_handle()
Date: Fri,  1 May 2026 09:41:42 +0530
Message-ID: <31ad94bc89d44156ee700c5bd006cb47a748e3cb.1777606826.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1777606826.git.ritesh.list@gmail.com>
References: <cover.1777606826.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 03ACB4AA4BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242236-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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

Cc: Christian Brauner <brauner@kernel.org>
Cc: stable@vger.kernel.org
Fixes: 6d3789d347a7 ("papr-hvpipe: convert papr_hvpipe_dev_create_handle() to FD_PREPARE()")
Reported-by: Haren Myneni <haren@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
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
2.39.5


