Return-Path: <stable+bounces-248669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ps4B6JSB2pIygIAu9opvQ
	(envelope-from <stable+bounces-248669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:06:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA565546F4
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBD1233940D7
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B123B4EAF;
	Fri, 15 May 2026 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k045NdM8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8D32609EE;
	Fri, 15 May 2026 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862327; cv=none; b=bfOaMZfkixsMOG2Aebm3zIwJpkSlTUWOyVGKyzWNJOSfHIlspJtOQsu8WWWyzUDRqda01PzYd3HKnsofVsUpkj9iNj3QOHS1/zcxEikIHi2yhN80MdB8RX4iVBDK2Q48vphSJHna+IDf7CFWuHSzqwwOMoPqA2Wv7rFW9o01R24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862327; c=relaxed/simple;
	bh=oFHliOU/GyWNr1u8iN5z4UHSYvJsao4Aq3z/VAfbEdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8S8rfrSy7fiDfB/Ie4zLxBne2ILHu7LPnnIfjtpVkFycHJvQaf4Gi+9dYZl2/l/rLYGvnFJrgEzYUvK6eEs9Fd4d3SR6qSwj5Py1CL3YiKPuKgl/EmyLokgv7S+6TdIkk5umsD/qjjYoqkNmiECTlpuyZXqRrnJcXg4eY/hiME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k045NdM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C01BC2BCB0;
	Fri, 15 May 2026 16:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862327;
	bh=oFHliOU/GyWNr1u8iN5z4UHSYvJsao4Aq3z/VAfbEdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k045NdM8BxlriKMs+ZaBZc6l8jZoSkY4vr272i3DZltYGsC0QxEgpYgO2Xnm9yYqd
	 IvnSm0vBgXmdjCuSycKlbSYztXcdS+6GKJ7zYe4Q5rNvLFVbNTsIjS00tqCjvCvSs3
	 CJCFblftCGcbWmjww4xCD1KOWE0Ok8NehU3rKeAk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 161/188] pseries/papr-hvpipe: Fix race with interrupt handler
Date: Fri, 15 May 2026 17:49:38 +0200
Message-ID: <20260515154700.820980059@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 8BA565546F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-248669-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.ibm.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -449,13 +449,14 @@ static int papr_hvpipe_handle_release(st
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
@@ -466,10 +467,10 @@ static int papr_hvpipe_handle_release(st
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
@@ -485,20 +486,21 @@ static const struct file_operations papr
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
@@ -515,18 +517,18 @@ static int papr_hvpipe_dev_create_handle
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
 



