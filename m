Return-Path: <stable+bounces-60707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B77939162
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 17:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081D81F22389
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 15:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5C016DED9;
	Mon, 22 Jul 2024 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUCB4tfH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5403F16DEDD
	for <stable@vger.kernel.org>; Mon, 22 Jul 2024 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660769; cv=none; b=eR2JtZw/yUgU7mgULbcSW/GwkwxihZ3LUVVmR3S90chzVHaeyRob3ZQ5DsG25ms65FWICW7fcmVzmqfZ+FNLY88b/xTI8aC5cgg5EehDbrY41q690f5SVmQ2i1kSDE65hw/KURYMKnxo305bzEDwAxgx3kmC1M8MP1UMhJmmko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660769; c=relaxed/simple;
	bh=LLmxdL4u/Mhyal3QF3/MChzoXEvP2wigRQ06+I85kmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qNQT8wf+BBDGNgrbZvHGaBbY4+7QGm66knHwtKa9KyjE7lOa1rP/JzW8eSea/b3u4RMLAhtPicZZyR3hwnAwvsT/75hAh9rZPLWqNRlhOb9uDbNJDS5QgELHz0fzDHnIjOgPV4Z9z4HolZyKl/BIxngpv/7Iwz9EPbdS1gZDir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BUCB4tfH; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so4375747a12.3
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 08:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721660767; x=1722265567; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KU5BQQwtIcalZfeboisW/1e2TYxwdVpk+lG2qlAAqv4=;
        b=BUCB4tfHByW+4IIA3MYc0MLVISxJOaXNlryn+uwICK8WX6SIGRq9bOQ9hedpW81ilZ
         rHzGvZlg8yRKZgwfgN2tBonsSqbrrEUSjvlclp+lWbH7P9B3xY4e/eDQaFwush3mZ/sH
         Lhs8dcttIwIIyNz+TAypRcGI8mBHJkAX1bO21HN5uU8l+ShLPZGYW9pMBebKU8u0ofJT
         NfFBy7iIxKY85pI0AffZ8RR3vZBeQujyCVITsGl6Xtuyrn+PJ4ozaITVzcVKsGWda006
         eK265kNkQVA80p+G5HoGlp/rbvqdA5uqgQiQpPn5tuoZkhjGOBknXhzalFG4+d+KBPUS
         ERIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721660767; x=1722265567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KU5BQQwtIcalZfeboisW/1e2TYxwdVpk+lG2qlAAqv4=;
        b=e7awYzCCkPfS9ZjBXf5LR5Y28678mOBqp4WgY2wdVLeepVV1fmEpw9wt/1OKeWYH9+
         9KwzUWxKcpjSCKK/T5tJoH6i8gGMUURS0ZmBfX5QzYdUV10XkGQpUAoGBiP/J+EwbWqw
         h8D1gxblky6LwV088WUSe2KVitOP5W6jK7iFET6Bh5X/E5iarfH6GepObRBfwYipvomZ
         QdX4OurFa+8KyzREnUl0+CJKjnASKUSU8UEl2pqcIkmWwwx4OgBlu9/xe7HUzej8HaOi
         ma+toVERifPsenwezIM+ghTmvihydndYaciuApcKUQKm9X1D5JRYFmCVCwhVk28HiYeI
         RcdA==
X-Forwarded-Encrypted: i=1; AJvYcCXEnLdpocegka+4Ncow0xGtlT++D68Wpi5rh+dfuPuaURiAvTyAGKQB3Y+QublCFPzhayU3Gem51OFbXQ8oEvd149E1Lk/b
X-Gm-Message-State: AOJu0YxdRuNaBP5ugEMoAUslYsJXGhHlvzKYyBxeTer2WU9gzQQ9yOpn
	CNYN1Yx28znLdEI0g2ZjMb4JTDI1dNkmqfyw4HtR/B7/YkD9T/t4bOEOUySrZxIYFwgbS9sg2P3
	PhG7HHhZksw==
X-Google-Smtp-Source: AGHT+IEpZntRK1q7/f5m7UJELo9pH3YowAuw5RP+07SdJepHripYxPtr7//b8UY/ekC03Jhdkl3j3wkpvbQ2gQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:5a52:0:b0:787:6c0a:4683 with SMTP id
 41be03b00d2f7-79fa0fe721cmr23030a12.6.1721660767229; Mon, 22 Jul 2024
 08:06:07 -0700 (PDT)
Date: Mon, 22 Jul 2024 15:05:11 +0000
In-Reply-To: <CAH5fLgj6=6ZcVT13F8kP7g2NnRgBmZn+KKPANt=fSoFEJisi-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAH5fLgj6=6ZcVT13F8kP7g2NnRgBmZn+KKPANt=fSoFEJisi-w@mail.gmail.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240722150512.4192473-1-cmllamas@google.com>
Subject: [PATCH v2] binder: fix descriptor lookup for context manager
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	syzkaller-bugs@googlegroups.com, stable@vger.kernel.org, 
	syzbot+3dae065ca76952a67257@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

In commit 15d9da3f818c ("binder: use bitmap for faster descriptor
lookup"), it was incorrectly assumed that references to the context
manager node should always get descriptor zero assigned to them.

However, if the context manager dies and a new process takes its place,
then assigning descriptor zero to the new context manager might lead to
collisions, as there could still be references to the older node. This
issue was reported by syzbot with the following trace:

  kernel BUG at drivers/android/binder.c:1173!
  Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
  Modules linked in:
  CPU: 1 PID: 447 Comm: binder-util Not tainted 6.10.0-rc6-00348-g31643d84b8c3 #10
  Hardware name: linux,dummy-virt (DT)
  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : binder_inc_ref_for_node+0x500/0x544
  lr : binder_inc_ref_for_node+0x1e4/0x544
  sp : ffff80008112b940
  x29: ffff80008112b940 x28: ffff0e0e40310780 x27: 0000000000000000
  x26: 0000000000000001 x25: ffff0e0e40310738 x24: ffff0e0e4089ba34
  x23: ffff0e0e40310b00 x22: ffff80008112bb50 x21: ffffaf7b8f246970
  x20: ffffaf7b8f773f08 x19: ffff0e0e4089b800 x18: 0000000000000000
  x17: 0000000000000000 x16: 0000000000000000 x15: 000000002de4aa60
  x14: 0000000000000000 x13: 2de4acf000000000 x12: 0000000000000020
  x11: 0000000000000018 x10: 0000000000000020 x9 : ffffaf7b90601000
  x8 : ffff0e0e48739140 x7 : 0000000000000000 x6 : 000000000000003f
  x5 : ffff0e0e40310b28 x4 : 0000000000000000 x3 : ffff0e0e40310720
  x2 : ffff0e0e40310728 x1 : 0000000000000000 x0 : ffff0e0e40310710
  Call trace:
   binder_inc_ref_for_node+0x500/0x544
   binder_transaction+0xf68/0x2620
   binder_thread_write+0x5bc/0x139c
   binder_ioctl+0xef4/0x10c8
  [...]

This patch adds back the previous behavior of assigning the next
non-zero descriptor if references to previous context managers still
exist. It amends both strategies, the newer dbitmap code and also the
legacy slow_desc_lookup_olocked(), by allowing them to start looking
for available descriptors at a given offset.

Fixes: 15d9da3f818c ("binder: use bitmap for faster descriptor lookup")
Cc: stable@vger.kernel.org
Reported-and-tested-by: syzbot+3dae065ca76952a67257@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000c1c0a0061d1e6979@google.com/
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c  | 15 ++++++---------
 drivers/android/dbitmap.h | 22 +++++++---------------
 2 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index f26286e3713e..905290c98c3c 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1044,13 +1044,13 @@ static struct binder_ref *binder_get_ref_olocked(struct binder_proc *proc,
 }
 
 /* Find the smallest unused descriptor the "slow way" */
-static u32 slow_desc_lookup_olocked(struct binder_proc *proc)
+static u32 slow_desc_lookup_olocked(struct binder_proc *proc, u32 offset)
 {
 	struct binder_ref *ref;
 	struct rb_node *n;
 	u32 desc;
 
-	desc = 1;
+	desc = offset;
 	for (n = rb_first(&proc->refs_by_desc); n; n = rb_next(n)) {
 		ref = rb_entry(n, struct binder_ref, rb_node_desc);
 		if (ref->data.desc > desc)
@@ -1071,21 +1071,18 @@ static int get_ref_desc_olocked(struct binder_proc *proc,
 				u32 *desc)
 {
 	struct dbitmap *dmap = &proc->dmap;
+	unsigned int nbits, offset;
 	unsigned long *new, bit;
-	unsigned int nbits;
 
 	/* 0 is reserved for the context manager */
-	if (node == proc->context->binder_context_mgr_node) {
-		*desc = 0;
-		return 0;
-	}
+	offset = (node == proc->context->binder_context_mgr_node) ? 0 : 1;
 
 	if (!dbitmap_enabled(dmap)) {
-		*desc = slow_desc_lookup_olocked(proc);
+		*desc = slow_desc_lookup_olocked(proc, offset);
 		return 0;
 	}
 
-	if (dbitmap_acquire_first_zero_bit(dmap, &bit) == 0) {
+	if (dbitmap_acquire_next_zero_bit(dmap, offset, &bit) == 0) {
 		*desc = bit;
 		return 0;
 	}
diff --git a/drivers/android/dbitmap.h b/drivers/android/dbitmap.h
index b8ac7b4764fd..956f1bd087d1 100644
--- a/drivers/android/dbitmap.h
+++ b/drivers/android/dbitmap.h
@@ -6,8 +6,7 @@
  *
  * Used by the binder driver to optimize the allocation of the smallest
  * available descriptor ID. Each bit in the bitmap represents the state
- * of an ID, with the exception of BIT(0) which is used exclusively to
- * reference binder's context manager.
+ * of an ID.
  *
  * A dbitmap can grow or shrink as needed. This part has been designed
  * considering that users might need to briefly release their locks in
@@ -58,11 +57,7 @@ static inline unsigned int dbitmap_shrink_nbits(struct dbitmap *dmap)
 	if (bit < (dmap->nbits >> 2))
 		return dmap->nbits >> 1;
 
-	/*
-	 * Note that find_last_bit() returns dmap->nbits when no bits
-	 * are set. While this is technically not possible here since
-	 * BIT(0) is always set, this check is left for extra safety.
-	 */
+	/* find_last_bit() returns dmap->nbits when no bits are set. */
 	if (bit == dmap->nbits)
 		return NBITS_MIN;
 
@@ -132,16 +127,17 @@ dbitmap_grow(struct dbitmap *dmap, unsigned long *new, unsigned int nbits)
 }
 
 /*
- * Finds and sets the first zero bit in the bitmap. Upon success @bit
+ * Finds and sets the next zero bit in the bitmap. Upon success @bit
  * is populated with the index and 0 is returned. Otherwise, -ENOSPC
  * is returned to indicate that a dbitmap_grow() is needed.
  */
 static inline int
-dbitmap_acquire_first_zero_bit(struct dbitmap *dmap, unsigned long *bit)
+dbitmap_acquire_next_zero_bit(struct dbitmap *dmap, unsigned long offset,
+			      unsigned long *bit)
 {
 	unsigned long n;
 
-	n = find_first_zero_bit(dmap->map, dmap->nbits);
+	n = find_next_zero_bit(dmap->map, dmap->nbits, offset);
 	if (n == dmap->nbits)
 		return -ENOSPC;
 
@@ -154,9 +150,7 @@ dbitmap_acquire_first_zero_bit(struct dbitmap *dmap, unsigned long *bit)
 static inline void
 dbitmap_clear_bit(struct dbitmap *dmap, unsigned long bit)
 {
-	/* BIT(0) should always set for the context manager */
-	if (bit)
-		clear_bit(bit, dmap->map);
+	clear_bit(bit, dmap->map);
 }
 
 static inline int dbitmap_init(struct dbitmap *dmap)
@@ -168,8 +162,6 @@ static inline int dbitmap_init(struct dbitmap *dmap)
 	}
 
 	dmap->nbits = NBITS_MIN;
-	/* BIT(0) is reserved for the context manager */
-	set_bit(0, dmap->map);
 
 	return 0;
 }
-- 
2.45.2.1089.g2a221341d9-goog


