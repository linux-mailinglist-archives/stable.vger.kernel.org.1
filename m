Return-Path: <stable+bounces-77838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DB9987BD3
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 01:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2091DB23046
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 23:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420C01B07C7;
	Thu, 26 Sep 2024 23:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UjKmqrtv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A729C1B07A3
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727393804; cv=none; b=LvvRRAOJM0EyWmIWbI4E7mNx35nJYzcu4Nc5K08ZXvqmo/ycIZkTCsw6I/rmt4QtFOo/l6JVj1OAZms7oBzO6Hlw86MeCk8QnhV5xD/Cmmv2XmAbz+XYLDSoKWDT40JZV4sLQb8tdKSfP/Fl3PLg+QM4q4oJiit/ZsQY+24Q4bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727393804; c=relaxed/simple;
	bh=auRMKL1VHLPn5sEdsai0MKgq314tffwblT0/P66foLE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bfm2PQlDvEZAC6xax6kOeSaRwcf3aSOIwKyALFDhf2b/iWuk5yocLWS60XuM5cLNHoWuDjgRye107ED60+MCcbH1Cc6qaMdDjDPgdzCS/7zcZ1Xlm/cKBCItja9uBLMkD0sgHY13DK7zYbMKeyW1XXnOI4WNb15EsmW48H77zFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UjKmqrtv; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7db6dbaca2cso1644997a12.0
        for <stable@vger.kernel.org>; Thu, 26 Sep 2024 16:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727393802; x=1727998602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T6NRiF2jzOTlmTLkf7ByKoCRNQ6oQZl+i/6FjfYR9L0=;
        b=UjKmqrtvihgYWXBhNwq111kAy1lP8WUSQ71t+KAnIgi4qxRdKLRwvEHv9rprckR4bl
         fJRNTh80+bmh+IzJxX8jwrPwSNJC77XmYRiUZuXNpk36Xa9TCPKm7A63GusK6dhAeO+L
         4sb6gGSZUIDlVAPYqaMGflARZUKQSR1xHjwhdOtHRAn7h0XQlTZ4JxlyvJIQZOr8eZCc
         mhpbkIYa7WMS0JJZxLqbz/Rd+gdPOfj/2sCcTM6I9YzHWZ3CjGZCIn5yTBcI7zfr2t2C
         aYkoKCx9LYlPUf3hZP9D6jtq75eINW2Ycujkc6GXFAZsy9w+y5fZonRxOjNrcUEmjmbU
         GA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727393802; x=1727998602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6NRiF2jzOTlmTLkf7ByKoCRNQ6oQZl+i/6FjfYR9L0=;
        b=HmrhceJB940BHPLW8a8s2/l+s7LOrumLLSswWB+0zHe7OBXSQjndzS4HWgfU34BL9P
         HBDgL3+EL4BHhEVPcDSJyq2ZIXo/cgD5JsFdMLmTMtYaJrmmWjXerCn0jiV66kVb5OHG
         rxQDEoyPn1GYDDg8BCNG1M2xm3IDsxwLNbJsWXinR4hKQBgrPhD/KpP36pO8ExXO32Yq
         RiKwGGKQxA4HHjovdLddGBMMRRQydKdKqoH1hERzDxx/aldKtISIhRGEwZt3EuX9UEJ9
         ZTjdsgiWGFC4B9KmZSCugpEFgx4fF4haQ4JR+3oiQP8OOkhVI2eEtYduDr3vZjgVWX9p
         2ksg==
X-Forwarded-Encrypted: i=1; AJvYcCX6OID+RCdN6P782LU1RgkNN3TRGBHilgC71KDex9q7Iqiry9qBftLERS403guMHqcHI5C5vlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYL9jbD5Rb+S7BizJ/Wm9bg4gf0Ud0GLVLqE77xsgeR8j14qhk
	MfmTNqTH8Y+6UQ4eLQjeZrJM5LzoXBUSR+40m4VgssPLWrGzDucKsytOffDB91I7jpnYmQfnp0L
	UvdvPcBWGWg==
X-Google-Smtp-Source: AGHT+IFihG4ru2+qA62xmp+Q9HYnVhUZSB5tUQoaGcqfi/yvOJNOAZkdrn4uF1RoIXFBnpcn8PoMYI7uHJeYrg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90a:c211:b0:2d8:b6bc:e5fa with SMTP
 id 98e67ed59e1d1-2e0b8ed126bmr6261a91.3.1727393801170; Thu, 26 Sep 2024
 16:36:41 -0700 (PDT)
Date: Thu, 26 Sep 2024 23:36:12 +0000
In-Reply-To: <20240926233632.821189-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240926233632.821189-2-cmllamas@google.com>
Subject: [PATCH v2 1/8] binder: fix node UAF in binder_add_freeze_work()
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Yu-Ting Tseng <yutingtseng@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"

In binder_add_freeze_work() we iterate over the proc->nodes with the
proc->inner_lock held. However, this lock is temporarily dropped in
order to acquire the node->lock first (lock nesting order). This can
race with binder_node_release() and trigger a use-after-free:

  ==================================================================
  BUG: KASAN: slab-use-after-free in _raw_spin_lock+0xe4/0x19c
  Write of size 4 at addr ffff53c04c29dd04 by task freeze/640

  CPU: 5 UID: 0 PID: 640 Comm: freeze Not tainted 6.11.0-07343-ga727812a8d45 #17
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   _raw_spin_lock+0xe4/0x19c
   binder_add_freeze_work+0x148/0x478
   binder_ioctl+0x1e70/0x25ac
   __arm64_sys_ioctl+0x124/0x190

  Allocated by task 637:
   __kmalloc_cache_noprof+0x12c/0x27c
   binder_new_node+0x50/0x700
   binder_transaction+0x35ac/0x6f74
   binder_thread_write+0xfb8/0x42a0
   binder_ioctl+0x18f0/0x25ac
   __arm64_sys_ioctl+0x124/0x190

  Freed by task 637:
   kfree+0xf0/0x330
   binder_thread_read+0x1e88/0x3a68
   binder_ioctl+0x16d8/0x25ac
   __arm64_sys_ioctl+0x124/0x190
  ==================================================================

Fix the race by taking a temporary reference on the node before
releasing the proc->inner lock. This ensures the node remains alive
while in use.

Fixes: d579b04a52a1 ("binder: frozen notification")
Cc: stable@vger.kernel.org
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Todd Kjos <tkjos@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 978740537a1a..4d90203ea048 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5552,6 +5552,7 @@ static bool binder_txns_pending_ilocked(struct binder_proc *proc)
 
 static void binder_add_freeze_work(struct binder_proc *proc, bool is_frozen)
 {
+	struct binder_node *prev = NULL;
 	struct rb_node *n;
 	struct binder_ref *ref;
 
@@ -5560,7 +5561,10 @@ static void binder_add_freeze_work(struct binder_proc *proc, bool is_frozen)
 		struct binder_node *node;
 
 		node = rb_entry(n, struct binder_node, rb_node);
+		binder_inc_node_tmpref_ilocked(node);
 		binder_inner_proc_unlock(proc);
+		if (prev)
+			binder_put_node(prev);
 		binder_node_lock(node);
 		hlist_for_each_entry(ref, &node->refs, node_entry) {
 			/*
@@ -5586,10 +5590,13 @@ static void binder_add_freeze_work(struct binder_proc *proc, bool is_frozen)
 			}
 			binder_inner_proc_unlock(ref->proc);
 		}
+		prev = node;
 		binder_node_unlock(node);
 		binder_inner_proc_lock(proc);
 	}
 	binder_inner_proc_unlock(proc);
+	if (prev)
+		binder_put_node(prev);
 }
 
 static int binder_ioctl_freeze(struct binder_freeze_info *info,
-- 
2.46.1.824.gd892dcdcdd-goog


