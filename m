Return-Path: <stable+bounces-242234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBwDKiwq9GlT+wEAu9opvQ
	(envelope-from <stable+bounces-242234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 06:21:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C91E4AA43F
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 06:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B58A30826FB
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 04:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE191301471;
	Fri,  1 May 2026 04:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WflBnlVV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60246303A35
	for <stable@vger.kernel.org>; Fri,  1 May 2026 04:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608741; cv=none; b=TL+hfXA0zEVa9uKC1MhHSHBqnBq/cM9R8b7pqy0mRMyR5/QtMLubVeTGMPaB71eETl2heSR8bGiyqpjVOPqDCY+728rEAOiB1J1WzIjwmsAvDFGHzDz0mVSVkDH2EmDhe9IpMx4RKq+DlUSlz2MH4JppPKaoSE+mIbfbRidS5gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608741; c=relaxed/simple;
	bh=9NbnFzTEGh6+lE1PwksEW7af7i8jzYb/dCKoYyURmxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRv7cuOxtReXa1cYNqCiDKdwO0pvjh+Vd8IM6c5fSN6wXwTRvqYWuYVZ3LV7sx7xrgGQuV6KstRPNehDgBUqY6ksM0R4hKwjCBLyL9u9F0GjpjM9agvPJUGN7bLvBMLVmKwOzZnSnIiasxhxbQn8VLNtgMb87+rwInoxfc7pyE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WflBnlVV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-834f1075805so1167180b3a.2
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 21:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777608740; x=1778213540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYNm6J9AhUQ6HT8V6B6W7Iuh7E+aasxrExqJ2exyz7U=;
        b=WflBnlVVLpYKdqZ5+gvI7bTslgdtAUNJ8HJNO541GdBxHGlR1YHd8uBzDm1zAf4oZV
         nkxZRbPocjasqAZWQ94rZg1CKbKbaVGjKdmA23rmemQIekV6OBdXP+W1WjEIl0LR9eHF
         2BjVGuLtvP/CuA034+o7zFdRfHFs9PeJBJMyMHjjninSBID1QP6bjOIM9jRO0IHwn7Ix
         hmnSJlbMcC4Th5v7+BJiy9cgmAvfClMRQ4LtWeTlf8nUyz2DrHM6Cwr+l4BtgOt7epCt
         SFp5s916/tW9oSYDO3cxIotZFjU+Z9b4yxed38Nz10xDjsGHbup9lwNWrNyXjNe30uL+
         ai6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777608740; x=1778213540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PYNm6J9AhUQ6HT8V6B6W7Iuh7E+aasxrExqJ2exyz7U=;
        b=ZCZzwYFbnOSVY+y2eR51FVIe4afyiG+xLUAQVhHJN/nw5DaraNvYJ55sKAL+9vIk/J
         58Gxh/PxRdT71KmR/uF6EcUJK3UACr8X026UhVSuGKXpymUfTRkjlVzps1/deR2LqrdT
         eK7WC9utEk9o0sHbp4RS/Xlf1/V7pX9t3U4OoABWMSzlOzhLcibJNUZwFyUzBb0v1hjc
         +aUUGWjDDvvachmYCJ4fBXMeJMe2DRq2ncRRVO7JkP+Omnqs2AgOhkLMA53UuI/GzQEN
         e3a7viSJR9hSf6MIO5Lx8AcntwWMisRYXAAiIjRYbTolDeBCz28mFmlozlwWJ7VqMg3V
         CoSg==
X-Forwarded-Encrypted: i=1; AFNElJ+BMJX+oJGYY4GMgkx54DbVSMPckci9F4NCqIXwPiLOZEUdgiwK48CINySkGzdqaLtyx9V6AO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFZNQs/rqKKPMuasS0HLa5a9DcRyo+7RRR5JOoFuyLMTlXUzkC
	INg8ZTvhhTRu775QIXRm4Hc2fFlbH1eJ3Z8E4i3Q600g4BqSX/aWdnAG
X-Gm-Gg: AeBDietaPTID4DoGngvOI9nOyP0xPkEqxhpX1ylNipz3/D3zSSpJMQxXm4YvElmAwUG
	EYgGjLFLqjh209F6uAQkuXRWccFfwy7NW77/kBHvzm5aJoY4+g0PfvlW4TCxCTZpr3aLTADm2Nk
	zb4RSPJKTLorr3cJ6/698g7/n5JK5LV5zFMTtXut/8Ecf430IljC3/hDke7JUQ8AXJgbKSO4m1U
	ibygotUU6ON5PUDFDHpywcYC6IJQNfCNZdVKvgYrI0c5uAcvsGJGuEqgh0QDzH8mmksSdx4Luy2
	tMhs6pnFq6i06tRobkdSN7+p81E5ovSAkism4WVy1eVFMbf/4pfgeOB1I5+iUfP/yGtmBYv+i9l
	Wuo3cyyVRO9R35h409ykVo8U/934ihpIAMebdVKtBKShH14c6GUKC9o7K6a88o5ti5V0n1jr7Rb
	9PJElPXnBt7gRmaMZS5a6abiDM0wb+Kiv9WEIeJPgmz1JucdUUqrUW3pLdtcB16WM=
X-Received: by 2002:a05:6a00:1c9e:b0:824:adf4:5a2f with SMTP id d2e1a72fcca58-834fdc5c2admr6357028b3a.43.1777608739583;
        Thu, 30 Apr 2026 21:12:19 -0700 (PDT)
Received: from localhost.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b485eesm1159428b3a.48.2026.04.30.21.12.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 21:12:18 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/9] pseries/papr-hvpipe: Fix race with interrupt handler
Date: Fri,  1 May 2026 09:41:40 +0530
Message-ID: <e4ed435c44fc191f2eb23c7907ba6f72f193e6aa.1777606826.git.ritesh.list@gmail.com>
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
X-Rspamd-Queue-Id: 2C91E4AA43F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242234-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

While executing ->ioctl handler or ->release handler, if an interrupt
fires on the same cpu, then we can enter into a deadlock.

This patch fixes both these handlers to take spin_lock_irq{save|restore}
versions of the lock to prevent this deadlock.

Cc: stable@vger.kernel.org
Fixes: 814ef095f12c9 ("powerpc/pseries: Add papr-hvpipe char driver for HVPIPE interfaces")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 14ae480d060a..c41d45e1986d 100644
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
 
 	src_info = kzalloc_obj(*src_info, GFP_KERNEL_ACCOUNT);
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
2.39.5


