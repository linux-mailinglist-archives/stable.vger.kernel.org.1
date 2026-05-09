Return-Path: <stable+bounces-244926-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKI/Ix3q/mkdzgAAu9opvQ
	(envelope-from <stable+bounces-244926-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 10:02:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5D44FEA08
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 10:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4209E3006454
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 08:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312DB2E7F0A;
	Sat,  9 May 2026 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HogMdyQd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42E813635E
	for <stable@vger.kernel.org>; Sat,  9 May 2026 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778313755; cv=none; b=IkONOAIG37MQxFoUmFAC8I/X+7mZP+qEWKrRwh82tFAuaP5IadNCk3SG7w0S0i/x6rurui7F1OgcqCKG9cKeT+Rwr0oZ5K73I9zoLVLdY0s/Efl6LtjB7PKSqijoRxWcHMwFD+O6cNvPlVXVA0FMCBiD7diw25HB8ldMZuLaOec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778313755; c=relaxed/simple;
	bh=3B9mghRGfG6NfMCUWmI2vb/rw+V9XG23rc0+3od1t/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R3hnQk3l3KpJEMYCbC2ltGQ0xl4Gm0+MuSUdhNGyaXsdYrlWxfeXhha7FICxQ0ZecSlRbnKyqMilUGCzJuOsQJy/cd4tWfNNhvdILR1rPQVYcO7NyO0dqhPdmGYVUYicjkcvmbn7zUHLPdhUTr/xwCGvrbXzUJKEfGn6xfR/J84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HogMdyQd; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so1483791b3a.3
        for <stable@vger.kernel.org>; Sat, 09 May 2026 01:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778313753; x=1778918553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xOdWB60cPMW/PFpHCU8hncuPFFRRtLa7yAfAZLtU4YM=;
        b=HogMdyQdmWxoKV9+DMkNliWNrJdzsqV8uEK0fDrlEZrWqOckVvaUNeqZUeVmbczrxr
         ap/KsAG8aiRy8w7WrGwySL9L7vsuZNzf7nOTby+cRcbfFinIknBNcN29YWIv31WeCiSi
         VvEe5hJHl15Q9gD32Low/OT/Kz2bq+H1GzLJ+LPuUwharA63z2Wva9/hZ4FEJrft++bA
         cAW2RdL5YxAHLqn886EqSaakxe/PnlxMLHKvkwAlcbqt6jR+Rl4Qbz78bAvsT4HzBb7S
         l6sEIutaEOz650FPcnwyESJinmfmQ9Wrv9zAWzkZLk2/Goew8JPCT3j9yeEpXUdhEshN
         Ym3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778313753; x=1778918553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOdWB60cPMW/PFpHCU8hncuPFFRRtLa7yAfAZLtU4YM=;
        b=f4GeK9mI6L2XKRt8Vn0x9SYzfFgVezUBVCUe8e3aXbrYh7a7M7EgtEDpCl7mCoPYOa
         YpVmXWZK5QQe61V25c4yI8TMyGInH3t7kHB24jGwuAXbTxibp6992Z6ClPwK/TFgqmTV
         0X3LVs14CIV4D9Ql0k5/buTXITtzej08FgS4rnoqipu4XElRyosHQ2pmvD/aq2FHYpb3
         6Ypn0d2eNmKYkQflFa5hL8mhvHemdYqCmLBorbUBFbpyI9yMs6xpLo/iPQaVtEFM2UvN
         CIeP+7xxYmxfEBsG7fEZfAx+BXts6ZS689TS/wSYaWb4oxviQYi27B+0YZzidfUZFurk
         JsqQ==
X-Gm-Message-State: AOJu0Yyq9digESPjGHBL+BdH+U+rtaexNYqU69CJLzwwMgpQVVDt9tUF
	RpmJqqJir1J7przY1vZde1uvqLbDfYRSLbjdPMNI4x/JPd9P7EbCWs93hwFcfg==
X-Gm-Gg: Acq92OE5d4mVyBMmiVA4b8myWauAi09gEL649zWkHK3gxssmSD3/EZxcwP33CWUCDLt
	B8pEUj37/REkcL0sjEIAO1gIKzPEDiOYk93hC3c0QqTB3yNT51VOZLR0hMj/0VVHdi2jsV/azpW
	BEoQoMwlydqlno9gpdGaK2wtgQ6r6N49hE77NLLMEiA30kdQ4rxJuWZZMov6g0XxPfU9YXiam7D
	WpTG8QguZrxvNRvRDvrhIKFYl4hZ8llFB19Z1orNDRwCo7yJeGWjOSqxaH/K3qQYbLkuWixmdap
	pOtg/AfBn0cGCgqMJfrytNchQVdH2jCc6UMdLYQrppbZzlNGuNLNPLtBA5ucWYdcbEKuEhqkJH1
	u9Zc8iUKkT24IQeE0dgfZ0qmwO7Bm4f3tR1mPRYj9x4qRyu0l9OFW74YxqcjthUNEplofJqZSRv
	djizpf/HSISEBeXyZ/MF5OTlXASiIFz11AHfg65IMcJgDRUsybopWffhnM7wicN0pJHafuyo7e
X-Received: by 2002:a05:6a00:4191:b0:82f:85c8:fc19 with SMTP id d2e1a72fcca58-83a5b9de7c7mr15053689b3a.11.1778313753070;
        Sat, 09 May 2026 01:02:33 -0700 (PDT)
Received: from PC.localdomain (softbank060090219114.bbtec.net. [60.90.219.114])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965645140sm14980495b3a.12.2026.05.09.01.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 01:02:32 -0700 (PDT)
From: Rion Kiguchi <kiguchi.r.sec@gmail.com>
To: kiguchi.r.sec@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] staging: vme_user: validate slave window size against buffer size
Date: Sat,  9 May 2026 17:02:11 +0900
Message-ID: <20260509080211.640660-1-kiguchi.r.sec@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3B5D44FEA08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244926-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kiguchirsec@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
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


