Return-Path: <stable+bounces-77044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F8A984B38
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 20:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E0C281D75
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 18:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87B11ACE00;
	Tue, 24 Sep 2024 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LkrjiQcY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B4D1AC8A9
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203448; cv=none; b=lvgyJPbNOsz4E89S3c8UQp6D7P92epxbihv1Qt8sYHUmO5Y36yO65sQDhVyCU5KozzL2md5plZTQmj0l8s/+t99DxmecLkH8E3wlmUQt1q1/qE+RrKeLPxyQlvBP90DxcXqXYm9pOHW26dlvkUrvJ05fNh8sk8pCPP8YM16XlU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203448; c=relaxed/simple;
	bh=6IcAOQbnIDXKr2A0ZKbc2TQ+WiL9rcFfhDZ+QZYUbO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LZ6+rTPiKVK9LShdevR+K/QSxbpKuNkdPU2h3LZesIpAsNjO34oTcr4CIp1rMgwhGX0MsQ5PimHsQzxY8FZqEx0ztXtijwMX5fNmbRg9AP7HdBxloHKWDU6dCilAyQc1q76QH3iwAm7J20q8ykFikXXeJJXOD6Eao2+gwpMeu1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LkrjiQcY; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2d8a1e91afaso5481960a91.1
        for <stable@vger.kernel.org>; Tue, 24 Sep 2024 11:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727203446; x=1727808246; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p9nV8NJnDAA8uw9/rFdmJcfCelAbKvt9jSwnFiN7UHQ=;
        b=LkrjiQcYGjpRI/XXk2P4QgHq+7JazinMGwPTznY1t+cCkmee1jS3pplxHKnslKihOD
         vH3nodAigK4fce37x0hEmUwaTwBUI9F8mE5kYtsGJ0eXJ2xX67CoeobvtCCpL+Xi2WVE
         mns0q6oJZWuXUSoTOJNBQ/QgoXVDVBkV1xYBgQie2Zvo1E/Hhjq1kzrWm8NX8X5wK34W
         q97OthS78ZaKGlYR86rl+DZm5J/UeE6wKaqJIl/MyM7hmeWUSNXUtNvu90iMuioKQHsP
         xuWPKSlyOuzyY7O65Omh/+dh/LhTn805jk12HWRg39i1ZjRvvTbss7pMooRfOPnUmD/5
         NnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727203446; x=1727808246;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9nV8NJnDAA8uw9/rFdmJcfCelAbKvt9jSwnFiN7UHQ=;
        b=MW0Tx7gqaMBjqcDElaZrXteCEE5lNo15Nmopg0e+9tkFx3q6vJ+gqMkjySe3F2WUcE
         CPD7Npi2A5D8ckwK7qP4mUkm3Oz0ihWooew0IdzwmercieH3omzC20zOvEBBgXdgYS6P
         5pg4ttT1vZtFaPDmt0T7XtW1gXRNFnx49SCOqlNdcZsJzosSe4j5XoMimVfDq+rq0bQ2
         PEeLBbvDUgzGSUfKZrvDTD+WIRyaeDLLkxeeAf2ucBFaRvhiOgVndmia0R++6zLIoZBA
         LPuX2/lEtQ4ybP8p5CJhJitOkk0aGUCnptCmemAy23/W2dNzMwtxouqTtzQmiNmMNBmZ
         /6CA==
X-Forwarded-Encrypted: i=1; AJvYcCWSeSZMGF0AaD3APEXMldZ1I9xdQz+k/ftdrbQS2Vf3SsN7RbAhfUf2cAlQntFNVg5Fn9L3jBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZFowczhqFX8CCLk/bp3kgpIEydQOD2OgRj+wazToxYMYIqLE
	yra/Z/70JHqL3ZFnQOCpsYBViwrBJHJjL7Kept9dajqU8K/kpQlqeqVwc+iAjq5FdmbpdBHLteC
	vHSZB/Lkhvw==
X-Google-Smtp-Source: AGHT+IED5bbPPsmWzf1m5V5YEsxBnJHtsfLGQbUbAh1wa2CPeDYb/L6NPSsFpciX/Ya40Q/IMW/yE35PTwxa8g==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90b:81:b0:2dd:92e5:701a with SMTP id
 98e67ed59e1d1-2e06affde31mr56a91.8.1727203446127; Tue, 24 Sep 2024 11:44:06
 -0700 (PDT)
Date: Tue, 24 Sep 2024 18:43:53 +0000
In-Reply-To: <20240924184401.76043-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924184401.76043-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240924184401.76043-2-cmllamas@google.com>
Subject: [PATCH 1/4] binder: fix node UAF in binder_add_freeze_work()
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Yu-Ting Tseng <yutingtseng@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
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
2.46.0.792.g87dc391469-goog


