Return-Path: <stable+bounces-244924-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RZfINB7o/mlCzQAAu9opvQ
	(envelope-from <stable+bounces-244924-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 09:54:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC064FE968
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 09:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 463713009CCD
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 07:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F743537C7;
	Sat,  9 May 2026 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqRPa73c"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98A81E8320
	for <stable@vger.kernel.org>; Sat,  9 May 2026 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778313217; cv=none; b=R2C/WP8JytrWXi86tZGXeVAhDFb8MSmnFeqERwShX56ZLz3yeuV3VPNn3m8BYu3IqL6MCBKMWQ91a3EXkdFo4vSIYJ0fL/Z/jrKCuazo3+lOGsoRoEy14tut73VViJDivnscM02QPJMo+RXA4Yv1zzIdJUWH61jLOvTahz8go0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778313217; c=relaxed/simple;
	bh=3B9mghRGfG6NfMCUWmI2vb/rw+V9XG23rc0+3od1t/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TSiUequtwQ8K1Bwp98hqpkaUvjhzlZ8UwXwh78Y+zIsAv602+vOW4wGAYm2i89L0gBE+IiR4rHRjRSVZyeWGJ/oc17Kud5Io7trmO4bLdcSEOqkRjuRlUHzt6mC/Li/EJckl/Y9kjE1XOTzFnfNuD6WVlRmMpo75FUryh0TDZ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqRPa73c; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2baef9f5ecdso11138705ad.1
        for <stable@vger.kernel.org>; Sat, 09 May 2026 00:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778313215; x=1778918015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xOdWB60cPMW/PFpHCU8hncuPFFRRtLa7yAfAZLtU4YM=;
        b=UqRPa73co664VRkVtRiSpDGSGVJnFXZKC59wqyR1JjN+O76DS/inA++1GLjw1SuxNd
         RwjV6pziXQ4Ky/gNpEAR9/upM8C+Z6hPO0/R6PLlpt/FlCaE00y6Kxe4UlvHAM4aZdej
         6YUsoaxPwgdP5/rQz7/tRGG6JDRqIrXJ4uprlAy89qk3c/1BGWgRnoZmbFjUlG8riJRb
         Y4U9QIl+R/vUWKvq6kM9LHBxorfLkJXRP3M9OPbVRnMtOWYGOtfubmgehxfYuZ7bTzRd
         BJf6fa81FiTp84JH+Jzh+4dv/yuKRNRw2VtrhVE6eYTjYZ8I1NJsxu6LTFMrjg2Vtr+U
         vtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778313215; x=1778918015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOdWB60cPMW/PFpHCU8hncuPFFRRtLa7yAfAZLtU4YM=;
        b=RMhUHiRZlPZyreVH0JmWrLRI11ID+VbIYJyZr71whz+q/P8ZVi3bGrViVvWjPUWE8D
         Ik9/ZsUmgUs1rAY8lYMfNQABMz3KIbgDK7z/9iVaF2xCowNeTe3an3KefITEO2KaEKkx
         +lTXcEDeKS8VH7NpSZmPb5kiPgA7Vw9AJTlG3MGY2GXqnStMEGXygkD0mz/JMu/hSeUm
         RouIDu8QlwR3SJCcFwM7hUJBYIanuJLdadd3wmV+/yH5/EbGud5cd9WRjUCvyb1RObi9
         Hn5LBki3VEwD96GqmtCEoy6X3VEDncPNNizxMDKg8+0pfn+/HNIA6v6+PXVQcXsNbylW
         n5Kw==
X-Gm-Message-State: AOJu0YwfpU33AzZeYtWfKsFpiFBteyKp675GpFZksEsDmhXjS08QbgYd
	6wamWmOKbXxQ1gqwsVE3cSNcnTsUEwR+gjF7sPaAW3/5Noym695KozJfh60pzw==
X-Gm-Gg: Acq92OHFzJRBUH2vy8yatXWpu4X2+HDn2Ak+F7asMO6jOPiY1OOWXaZh4f25SIXDAWx
	EeTOgDwlTFLNSByHYXKY/L6lYwMIx4M7w2FQEqVBk3004w8ZhGt4AiYoVcttkClKBWIAMi9Q8yj
	4AbI6RXB5isFLyGayrhdkUp0iV87RCFGL2PEISdwaaD+NUjxkCe5/d6m5hKhSc2QcdKu0gPYfsy
	JBlctPvG9BURaqqRYK/ZjuKdP3tuE4T6jlLx+/bVPup/G+N4MpAvE+t1QX49qJiZ07xdjWxIaXS
	KPgQ+ilL+YqxRmn7jt+19KS34jcP8iF3ZOZIYxSc+EuAg7/M5gFyFhnUb3Au4iopu6ycYgr7jIL
	MjDeJzixiHB/JeE5TSj2vyEH6Vi7lEhS5bnMSjXzQsVZ0W28I3bRvZk0qkh69gdlQYkB/Pak6xG
	OONURrFX3pEXyZV+mRPS+kIeDNSvAGAWEPCKiaD+AG2EcA5ogrVN87Ms3xHPqAiihzD3WV24QH
X-Received: by 2002:a17:903:1aa4:b0:2bc:810b:5c0c with SMTP id d9443c01a7336-2bc810b5c75mr8911425ad.34.1778313215089;
        Sat, 09 May 2026 00:53:35 -0700 (PDT)
Received: from PC.localdomain (softbank060090219114.bbtec.net. [60.90.219.114])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d405efsm45779045ad.23.2026.05.09.00.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 00:53:34 -0700 (PDT)
From: Rion Kiguchi <kiguchi.r.sec@gmail.com>
To: kiguchi.r.sec@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] staging: vme_user: validate slave window size against buffer size
Date: Sat,  9 May 2026 16:53:18 +0900
Message-ID: <20260509075318.640383-1-kiguchi.r.sec@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1DC064FE968
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244924-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kiguchirsec@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The VME_SET_SLAVE ioctl in drivers/staging/vme_user/vme_user.c accepts
a user-controlled slave.size and forwards it to vme_slave_set() without
comparing it against image[minor].size_buf. The slave-image kernel
buffer is allocated at probe time with a fixed size of PCI_BUF_SIZE
(0x20000 / 128 KiB), but the configured VME window size can be made
much larger via the ioctl.

The subsequent read() / write() handlers (vme_user_read /
vme_user_write) clamp the I/O range against vme_get_size() (the
configured window size, attacker-controlled) but never consult
size_buf. The slave I/O paths buffer_to_user() and buffer_from_user()
then index image[minor].kern_buf with *ppos values up to
image_size - 1, well beyond the actual allocation.

Result: a local user with read/write access to /dev/bus/vme/s* can
trigger out-of-bounds read and write of the kernel slab adjacent to
the slave-image buffer.

Fix: reject slave.size > size_buf in the VME_SET_SLAVE handler. Also
add defensive bounds checks against size_buf in buffer_to_user() and
buffer_from_user() so that the I/O paths cannot exceed the
allocation even if a future ioctl path forgets to validate.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Rion Kiguchi <kiguchi.r.sec@gmail.com>
---
 drivers/staging/vme_user/vme_user.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/staging/vme_user/vme_user.c
index 11e25c2f6..41b8d5b51 100644
--- a/drivers/staging/vme_user/vme_user.c
+++ b/drivers/staging/vme_user/vme_user.c
@@ -156,6 +156,11 @@ static ssize_t buffer_to_user(unsigned int minor, char __user *buf,
 {
 	void *image_ptr;
 
+	if (*ppos < 0 || (u64)*ppos >= image[minor].size_buf ||
+	    count > image[minor].size_buf - (u64)*ppos) {
+		pr_warn_ratelimited("%s: out-of-bounds access\n", __func__);
+		return -EINVAL;
+	}
 	image_ptr = image[minor].kern_buf + *ppos;
 	if (copy_to_user(buf, image_ptr, (unsigned long)count))
 		return -EFAULT;
@@ -168,6 +173,11 @@ static ssize_t buffer_from_user(unsigned int minor, const char __user *buf,
 {
 	void *image_ptr;
 
+	if (*ppos < 0 || (u64)*ppos >= image[minor].size_buf ||
+	    count > image[minor].size_buf - (u64)*ppos) {
+		pr_warn_ratelimited("%s: out-of-bounds access\n", __func__);
+		return -EINVAL;
+	}
 	image_ptr = image[minor].kern_buf + *ppos;
 	if (copy_from_user(image_ptr, buf, (unsigned long)count))
 		return -EFAULT;
@@ -394,6 +404,14 @@ static int vme_user_ioctl(struct inode *inode, struct file *file,
 				return -EFAULT;
 			}
 
+			/*
+			 * Reject window sizes larger than the kernel buffer
+			 * allocated at probe time, otherwise subsequent
+			 * read/write would access memory beyond kern_buf.
+			 */
+			if (slave.size > image[minor].size_buf)
+				return -EINVAL;
+
 			/* XXX	We do not want to push aspace, cycle and width
 			 *	to userspace as they are
 			 */
@@ -401,7 +419,6 @@ static int vme_user_ioctl(struct inode *inode, struct file *file,
 				slave.enable, slave.vme_addr, slave.size,
 				image[minor].pci_buf, slave.aspace,
 				slave.cycle);
-
 			break;
 		}
 		break;
-- 
2.43.0


