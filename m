Return-Path: <stable+bounces-59392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C849931FB4
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 06:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9A21C20E2A
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 04:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B19F10A11;
	Tue, 16 Jul 2024 04:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rFr9xsfD"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA36117556
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 04:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721104142; cv=none; b=vEBDhat4xegHivGD+S+imGao2eIvUFgTC4UsZaRBcFVxzSLFspnxDv/K6FVvA8aDjWD19U1+lMxRIOqrrmdSrUO3YnNwYgi4xFf/HFfBxGwuZLdo23gL4OFli1SVP7AEMaMghBFMgKLn4dY+zau+SQNEzJIZUHbjGNRESElxW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721104142; c=relaxed/simple;
	bh=4Gi9EsuLgBZmH7h9xoX/wphIaCIqAVbRY7tbzzhbcYA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L9txV+1ajLc73aMTip8dbLalAojFjHZCDjW3Du1wraG5/JquxHQzpjQ2Yf3pQ7vEMuIKYAaDY44d1Ox++ZxUtQYjcWJlQSuJy0u+CPZEfwqRFVGa5QUrcpjy3ivrF/8jril7tIex4VRBgorvUUhWzoFPWTZ3H4uuW4FqfGJcKTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rFr9xsfD; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65eb8845bc6so80315077b3.3
        for <stable@vger.kernel.org>; Mon, 15 Jul 2024 21:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721104140; x=1721708940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt2IJQldOz0JFDryR35KpZ+LDeTPQpPCV34EnsUw17k=;
        b=rFr9xsfDWd3+jEvYiRE1RRFbKFm3Hq9uQnBfqqQxQEBKBrBbEZI/iy9bMulm/7l54C
         GOaYq/GSwey/uFtMDzRChmlaANAbY5Ovmbqzosn4vG0XIEXQexH0V1jYG8VNxCKxIJDg
         gi4GzyerIGXC0yI14oA8jU2OxfskPlCqhlDEnX95LP/8rwLaublfKicj0MYme7gIVZDK
         GeUzdO+bmU6DOCTZbeasH1IFzb9TI8mIHqPgs/4l/wdN2KzyEuAI+kH1rUZcpQOLYylq
         geoPXU6HAqLQPFj+q2vfhUjAvKb0irPxJXhi7yiZi2EEYkV9v0AlPt6tU5RhbLL7K9DU
         /u3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721104140; x=1721708940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt2IJQldOz0JFDryR35KpZ+LDeTPQpPCV34EnsUw17k=;
        b=U6JLqqgbUXqLhmsv98y08/6vUUqbmVI5CrXZWESOdiqCpCGckDYQXWwh60bS9E5Tkj
         9eyqYdn/cITzzKkxdYPBmT4oWX7nQb+4R8AWdiNq9nZNxbLNyZbJD0wVDwN/utsQTbK6
         a36qILmW/vxOFolvDAYB/ae+WDvrBy9h4hkdSA3Bi+/OnSO7Ma3WKa1KTM903EJujgf8
         /G7TiFpqLIcTlhFZrHryJIEv4DCj1nq1XNdqNFk4pDPpSAPhgGiG+LxlN7Zs6CAVUbjG
         3ew5FL9xUYn0XsIXeYdFsgcAN28omU3iDEftJ7vPPcvUlCOyYT8sTiEd7NU10ohEZLgG
         vruQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1L3EE1fsb7LpLOlIEgxVnTQ2ClRawnxSL5iPSjdfom3ADnOZSeY9ZCxgxQsoBJtGYISL3zbCNNDJXlsOAHF+1vDcQq6T+
X-Gm-Message-State: AOJu0YwyNlwfNgkYQktUjsZQwuAyv8fiZoSxKV+3PqzjsIws042hckoH
	JGhFhX3YXONFmJGhTs5Tqj/IcZCMkiZZsI9KOXlvdqA0Q829W761zaGv06ica6+dMDVTdty10Lu
	anczGr5evlg==
X-Google-Smtp-Source: AGHT+IEDUsoHRwY3Md2RBRvkyGLpUtH0lWc1gjEYWBrr7ZUoAYArK3I1k9Ht/aQJYwv2CfEx1ZkP97e56n6zIQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:690c:fd4:b0:62d:cef:67dd with SMTP id
 00721157ae682-6637f1c259emr508367b3.1.1721104139877; Mon, 15 Jul 2024
 21:28:59 -0700 (PDT)
Date: Tue, 16 Jul 2024 04:28:54 +0000
In-Reply-To: <000000000000601513061d51ea72@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <000000000000601513061d51ea72@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240716042856.871184-1-cmllamas@google.com>
Subject: [PATCH] binder: fix descriptor lookup for context manager
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
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c  | 15 ++++++---------
 drivers/android/dbitmap.h | 16 ++++++----------
 2 files changed, 12 insertions(+), 19 deletions(-)

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
index b8ac7b4764fd..1d58c2e7abd6 100644
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
@@ -132,16 +131,17 @@ dbitmap_grow(struct dbitmap *dmap, unsigned long *new, unsigned int nbits)
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
 
@@ -154,9 +154,7 @@ dbitmap_acquire_first_zero_bit(struct dbitmap *dmap, unsigned long *bit)
 static inline void
 dbitmap_clear_bit(struct dbitmap *dmap, unsigned long bit)
 {
-	/* BIT(0) should always set for the context manager */
-	if (bit)
-		clear_bit(bit, dmap->map);
+	clear_bit(bit, dmap->map);
 }
 
 static inline int dbitmap_init(struct dbitmap *dmap)
@@ -168,8 +166,6 @@ static inline int dbitmap_init(struct dbitmap *dmap)
 	}
 
 	dmap->nbits = NBITS_MIN;
-	/* BIT(0) is reserved for the context manager */
-	set_bit(0, dmap->map);
 
 	return 0;
 }
-- 
2.45.2.993.g49e7a77208-goog


