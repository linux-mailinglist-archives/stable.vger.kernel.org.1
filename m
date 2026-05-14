Return-Path: <stable+bounces-247228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJu+GQLmBWoAdQIAu9opvQ
	(envelope-from <stable+bounces-247228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:10:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F95543C15
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3453830305FC
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 15:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C229A40758F;
	Thu, 14 May 2026 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyiCbIFT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE913D966B
	for <stable@vger.kernel.org>; Thu, 14 May 2026 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771305; cv=none; b=Wm/jhWKTkrYSMRUl7jDtrR75Wa9atAUO7E3fJSdzXj7W37PsX05CaTrbNOuyVzXATx1lfenvDqXE/Uw8xm4QxQ73aJcB7dUtGXf5XmsvldXpuyFctCGXo08XAZyos26dajW4dD8S4DRgbgbzQt0iM/HQj//ETaCtQVsMDeKglIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771305; c=relaxed/simple;
	bh=fyTrfTiwEfFchIi7ZKujqrMjVDnQUPEBbzuUUXkMVzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FviYILEhntl9dlMutbb7IpJu86fkYl7KDDjgQkgsQ60ufJIFpvj8mEGyFb/b4xJgPr5Lh6YpIGzipQmA9/hOMuTA68uc2/OsvbIt0917cRqlt0NQ0ERVmp8WY0v7CiCnZ0A5IY2/li+r1wWWnEsts9xoT3nZkS9pcZnx+gx3azs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyiCbIFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6476EC4AF09;
	Thu, 14 May 2026 15:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778771303;
	bh=fyTrfTiwEfFchIi7ZKujqrMjVDnQUPEBbzuUUXkMVzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UyiCbIFT5NzHRE7oGSF235ic2nojxQ1MEnsl0FPcRN4ERTOmVpd0T6myzVagfc+kO
	 SP/59w+R3HODG5obtwG0s9Qz75AHkgTTETs7PGhEkBcFPey3xzLD3As5Gf2Kp9/+v5
	 bl2rFUMLMgB5upVCEkCDXQbwtacxdCwZ2cGrX8SOmWGgPDzESgtrgS7mGQilZ4tHwX
	 KWFiFxIEguTrkaiOD+mhC5jZzn8wi/pM96+RuZpKENs1fKtuJdWx2HoTKDOc+JhZIg
	 VKnfMcbGxjPbOHFJwGyqJWyekc32kY/FD529p8K9NxirH+rlI0yL9uwPqc1CzMRpM9
	 UbEjI07BbCdXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] pseries/papr-hvpipe: Fix race with interrupt handler
Date: Thu, 14 May 2026 11:08:20 -0400
Message-ID: <20260514150820.274333-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514150820.274333-1-sashal@kernel.org>
References: <2026051217-briskness-posing-6f46@gregkh>
 <20260514150820.274333-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D0F95543C15
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.ibm.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247228-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

[ Upstream commit 7a4f0846ee6cc8cf44ae0046ed42e3259d1dd45b ]

While executing ->ioctl handler or ->release handler, if an interrupt
fires on the same cpu, then we can enter into a deadlock.

This patch fixes both these handlers to take spin_lock_irq{save|restore}
versions of the lock to prevent this deadlock.

Cc: stable@vger.kernel.org
Fixes: 814ef095f12c9 ("powerpc/pseries: Add papr-hvpipe char driver for HVPIPE interfaces")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/e4ed435c44fc191f2eb23c7907ba6f72f193e6aa.1777606826.git.ritesh.list@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index dd7b668799d9b..3df22407efae0 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -444,13 +444,14 @@ static int papr_hvpipe_handle_release(struct inode *inode,
 				struct file *file)
 {
 	struct hvpipe_source_info *src_info;
+	unsigned long flags;
 
 	/*
 	 * Hold the lock, remove source from src_list, reset the
 	 * hvpipe status and release the lock to prevent any race
 	 * with message event IRQ.
 	 */
-	spin_lock(&hvpipe_src_list_lock);
+	spin_lock_irqsave(&hvpipe_src_list_lock, flags);
 	src_info = file->private_data;
 	list_del(&src_info->list);
 	file->private_data = NULL;
@@ -461,10 +462,10 @@ static int papr_hvpipe_handle_release(struct inode *inode,
 	 */
 	if (src_info->hvpipe_status & HVPIPE_MSG_AVAILABLE) {
 		src_info->hvpipe_status = 0;
-		spin_unlock(&hvpipe_src_list_lock);
+		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 		hvpipe_rtas_recv_msg(NULL, 0);
 	} else
-		spin_unlock(&hvpipe_src_list_lock);
+		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 
 	kfree(src_info);
 	return 0;
@@ -480,20 +481,21 @@ static const struct file_operations papr_hvpipe_handle_ops = {
 static int papr_hvpipe_dev_create_handle(u32 srcID)
 {
 	struct hvpipe_source_info *src_info __free(kfree) = NULL;
+	unsigned long flags;
 
-	spin_lock(&hvpipe_src_list_lock);
+	spin_lock_irqsave(&hvpipe_src_list_lock, flags);
 	/*
 	 * Do not allow more than one process communicates with
 	 * each source.
 	 */
 	src_info = hvpipe_find_source(srcID);
 	if (src_info) {
-		spin_unlock(&hvpipe_src_list_lock);
+		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 		pr_err("pid(%d) is already using the source(%d)\n",
 				src_info->tsk->pid, srcID);
 		return -EALREADY;
 	}
-	spin_unlock(&hvpipe_src_list_lock);
+	spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 
 	src_info = kzalloc(sizeof(*src_info), GFP_KERNEL_ACCOUNT);
 	if (!src_info)
@@ -510,18 +512,18 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 		return fdf.err;
 
 	retain_and_null_ptr(src_info);
-	spin_lock(&hvpipe_src_list_lock);
+	spin_lock_irqsave(&hvpipe_src_list_lock, flags);
 	/*
 	 * If two processes are executing ioctl() for the same
 	 * source ID concurrently, prevent the second process to
 	 * acquire FD.
 	 */
 	if (hvpipe_find_source(srcID)) {
-		spin_unlock(&hvpipe_src_list_lock);
+		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 		return -EALREADY;
 	}
 	list_add(&src_info->list, &hvpipe_src_list);
-	spin_unlock(&hvpipe_src_list_lock);
+	spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 	return fd_publish(fdf);
 }
 
-- 
2.53.0


