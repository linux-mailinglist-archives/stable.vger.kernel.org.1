Return-Path: <stable+bounces-254645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEnHDFAyF2rd7wcAu9opvQ
	(envelope-from <stable+bounces-254645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 20:05:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCA45E8AB2
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 20:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A15C330078E2
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 17:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B94645BD67;
	Wed, 27 May 2026 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3xryBTX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BFB451068
	for <stable@vger.kernel.org>; Wed, 27 May 2026 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904792; cv=none; b=G6hHsiyq2YGTCYSh8lMv0JtMGvSmgFwWR+PWnBSLbhS8mhdeHpDtHecvqKEjBaF6/cc0Jy//wL9vlV+AibNt9qx2N/YjoYC8FQj3/lkCXdymicegz4V+mgjmML/Sdr7L0lSh9GsyboO+QVBwn+HC7feCbDOCMCPQOi3RjNT2XX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904792; c=relaxed/simple;
	bh=/iLXk1NTpAxOluUfTjJSa68terq0yc7XiDTbUTDHgT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8SAd4WX1+9bSs1C1cENpMMYqm588gxkXxYfOibUfsYkyI2aMcYKGtGy5hgrgtg0db3KrtIj4UJQR2S7Qu3TBGUKj1EkijP6jwJrYpj/KEuQ2ReWtEJ7OpU9eU3vY8Z+jQ/JsmxTKx9/Bu6/JZ4ip7VdUuNQVorGxDOxf9bAfq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3xryBTX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ba928852a5so83990155ad.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 10:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779904789; x=1780509589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erbsC0Vg9mtqhwjoL7B+eBOB5DX7r/gCOj4pQxWk2VI=;
        b=S3xryBTXlCq0lBZdEqV6QJAPlgE1jd5lVCQGCrwhgfdgceHQpXbvItDyW9Qiwc6TH/
         WpVUw+Il4PkOYYp71acSI6R1ujC0PwNPU+pCJF2/ISBbrKZkVHDByLXC3+GR/g89u0aR
         A5+k/9vwDTZX+pL+zEzVJPYG1ygcNgi0/JMtRsX+sOjH5cchsoZ3L0zi6qcLg+fOogp9
         cboacMb/iXYl/P8/6gPR59gZ9ZvAW5K+TwJYGNFEgmgEEbxPeVVy8+g12LFCZ71uB5bn
         04cCLcWa77SQo4kJh06zRLxNGJBubKWQaNSdA26azJLyf+FjCm6SLv4UelHTlAAL9x4t
         m7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779904789; x=1780509589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=erbsC0Vg9mtqhwjoL7B+eBOB5DX7r/gCOj4pQxWk2VI=;
        b=JhRMHe/isi8ESfa6VUkKpczkI0iUBoZyqt4LY88ywPQimwt3IVXQxyXoWzA7VBK3sG
         /+ZWK29PTgW+my6sJXvtM5cpEIDpdvBbU5dCHHIJ+vEzUlVmBzQJAf+ZyHuxwnp6943A
         9+MGAsZD6sJ3vrhZSkEgTXDti2kbStlB3dK+Y5bd5LbPPOfoGFNZuTZJh5EajCtIXzPO
         RfEmmmSRXIVdDddTMn2XPBGONiOsMSnPPdt3do6ED++RQAuDjmuj8gVoSCxvC50FQ0b7
         bcYapiBexcl67x52WKDb8dvrgQBSsXzMyO/KRM0u9VquTeYNiHjh5XurilVtTDsuwlCP
         iqAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8o61kzerCai5cYo9uKzWsC2FPTJT63MVYBi5p4IUFspDBUHkkiHEtlCQP9o6xXjJhRgIvXZQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGGRgKefAYnoMLtt0lBr+h/qj7K1GuAvbbMKDSh79pyDnoCYwj
	8yxAcgAkn/E0mDpoAXQEvogbp5RrtHnZs3vqLwLVA6d8ucdAyoPsZHcF
X-Gm-Gg: Acq92OGza/0lOf0fKhYiXl94J0Nas1P0IWApD4rQK5oDkLIhxbQ1Veaafxtt3U8CFxs
	mSVk4NU3toXCYlki7Ed7Db1+y5A7jMBLhgx2DR93bDp+QkixipCRUT1HoCXJE2GnPRfwXfUXVqU
	d4y6Nc3tduaduKNXAbglwJ8F2Ql67suVHcaXOFHP2ztkkrVYmwkwVkG4GOn7qt7bfeZUU4ceMpW
	rocWqYGHaANKp7Xz8L8qcs9G6smyJpJP3OVZjTxBwIRMSAcj8De74b5aEUh9cxQZIb54DTf22cv
	4c4LXpTMs4lj7kulpJ5Aeqd+731LU1xHyU5WirMc8R8MqNuUpeZPDq2WPvPmV8YZIWBawxtmnfg
	OT29g+FIFawPBG5WtfLqagfFAdRQwdnG9gLJWk/HysptUbDrSAI6+irT9NrOyjCG/ghLhSxgExW
	Noa75Fj16wLo3HY6vD/gVU0DK0KerjRoYJVabWD8evRvDiTYAyCmN6NOc=
X-Received: by 2002:a17:903:46c8:b0:2be:fe68:a1c with SMTP id d9443c01a7336-2befe680ebamr8852645ad.39.1779904788724;
        Wed, 27 May 2026 10:59:48 -0700 (PDT)
Received: from LAPTOP-97G9G880.domain.name ([106.222.201.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695f05sm204648005ad.6.2026.05.27.10.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:59:48 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: andrew@codeconstruct.com.au
Cc: joel@jms.id.au,
	andrew@aj.id.au,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Karthikeyan KS <karthiproffesional@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
Date: Wed, 27 May 2026 17:59:38 +0000
Message-ID: <20260527175939.2939714-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <53952f011f2c57ad28d6f864317054a2a34922e5.camel@codeconstruct.com.au>
References: <53952f011f2c57ad28d6f864317054a2a34922e5.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[jms.id.au,aj.id.au,lists.infradead.org,lists.ozlabs.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-254645-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karthiproffesional@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8BCA45E8AB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

put_fifo_with_discard() acts as both producer and consumer on the kfifo:
it calls kfifo_skip() (advances out) and kfifo_put() (advances in) from
the IRQ handler without synchronizing with snoop_file_read(), which also
consumes via kfifo_to_user(). On SMP systems this concurrent access can
leave (in - out) larger than the ring buffer, so __kfifo_to_user()'s clamp
to (in - out) is ineffective and kfifo_copy_to_user() can attempt a
copy_to_user() past the kmalloc-2k backing store:

  usercopy: Kernel memory exposure attempt detected from SLUB object
  'kmalloc-2k' (offset 0, size 2049)!
  kernel BUG at mm/usercopy.c:99!
  Call trace:
   usercopy_abort
   __check_heap_object
   __check_object_size
   kfifo_copy_to_user
   __kfifo_to_user
   snoop_file_read
   vfs_read

Reproduced on ast2600-evb (dual-core ARM Cortex-A7) when the host floods
POST codes while userspace reads /dev/aspeed-lpc-snoop0.

Serialize kfifo access with a per-channel spinlock: use spin_lock()/
spin_unlock() in put_fifo_with_discard() (hardirq only) and
spin_lock_irq()/spin_unlock_irq() around kfifo_to_user() in
snoop_file_read().

Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
Cc: stable@vger.kernel.org
Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
---
Andrew,

Thanks for the review.

> The AST2500 has a (single-core) ARM1176JZS

Corrected in v3.

> Don't double-account for the bug

Agreed — the spinlock eliminates the unsynchronized window that
produces the inconsistent pointer state. Clamp removed.

> _irqsave isn't wrong

Changed to spin_lock_irq — fops callbacks always enter with
interrupts enabled.

> Can you provide more details? The 2500 is single-core

The issue was observed on physical AST2600 (dual-core Cortex-A7)
in production under heavy POST code traffic during concurrent
userspace reads. Since the x86 host does not model ARM weak memory
ordering, the race cannot be reproduced naturally in QEMU. The test
module adjusts kfifo pointers to reproduce the post-race state for
deterministic validation.

> AST2600 has a dual-core Cortex-A7, so your bug makes more sense there

Yes, the issue is intermittently observed on production AST2600.

Changes since v2:
- Dropped count clamp
- spin_lock_irqsave -> spin_lock_irq in snoop_file_read
- Fixed platform: AST2600 (dual-core Cortex-A7)
- Trimmed backtrace
- Added Fixes tag

 drivers/soc/aspeed/aspeed-lpc-snoop.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index eceeaf8df..ef6697a42 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -60,6 +60,7 @@ struct aspeed_lpc_snoop_model_data {
 
 struct aspeed_lpc_snoop_channel {
 	struct kfifo		fifo;
+	spinlock_t		lock;
 	wait_queue_head_t	wq;
 	struct miscdevice	miscdev;
 };
@@ -93,7 +94,11 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
 		if (ret == -ERESTARTSYS)
 			return -EINTR;
 	}
+
+	spin_lock_irq(&chan->lock);
 	ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
+	spin_unlock_irq(&chan->lock);
+
 	if (ret)
 		return ret;
 
@@ -121,9 +126,11 @@ static void put_fifo_with_discard(struct aspeed_lpc_snoop_channel *chan, u8 val)
 {
 	if (!kfifo_initialized(&chan->fifo))
 		return;
+	spin_lock(&chan->lock);
 	if (kfifo_is_full(&chan->fifo))
 		kfifo_skip(&chan->fifo);
 	kfifo_put(&chan->fifo, val);
+	spin_unlock(&chan->lock);
 	wake_up_interruptible(&chan->wq);
 }
 
@@ -192,6 +199,7 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		of_device_get_match_data(dev);
 
 	init_waitqueue_head(&lpc_snoop->chan[channel].wq);
+	spin_lock_init(&lpc_snoop->chan[channel].lock);
 	/* Create FIFO datastructure */
 	rc = kfifo_alloc(&lpc_snoop->chan[channel].fifo,
 			 SNOOP_FIFO_SIZE, GFP_KERNEL);
-- 
2.43.0


