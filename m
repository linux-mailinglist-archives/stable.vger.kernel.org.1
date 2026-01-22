Return-Path: <stable+bounces-211290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDV2MxttcmlpkwAAu9opvQ
	(envelope-from <stable+bounces-211290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:31:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C38C6C763
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93E09303B29E
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179CF36BCFB;
	Thu, 22 Jan 2026 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FSqaOqNn"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C8D3148B4
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104948; cv=none; b=LsqIDaWkOW1VWJdCcHUUzZs3YXQ7lplJx8Dipb8lDO786+kR7NKgQXOELS+yU+wFl8FPO/jbttc3OndHOQgz2i39bvWaYdPVZLe+xynjIswPvFkSbykGUTqVGWbKufMc2IzhVhzJsgIAWvg0ICk1OX31YgU+h0FgGUb9e4INlDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104948; c=relaxed/simple;
	bh=9VHgNaYbPqdgo/w5EWEd0+bQOJCv7p9BykptJ+e29dw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fX2ljcWYUD3x2fiqJOHkj03xblOjOzFRd+dkM9f+W/yY1PN9dRg6SJt6Vl9xuUpD1UM/4CxnKymfCYwNuqdG5S4zkmI6ImYnU+8adsVROywQUNnUNkdeRxIRC+4frfQVqsFa6KVDc7/g2k5nA16pX9jnEoQSaHgG+6R4v/c03eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FSqaOqNn; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b722bc1be1so1231179eec.0
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 10:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769104934; x=1769709734; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ONgWQBMchvmRZkoqsxyw4prfXqUNlXapI8P6hstcLnY=;
        b=FSqaOqNn6s6r7uJyhWZefQ+JVej1cJJdHlMFRSkjdLI6L1iYZ1zq6wRaCUciZD4nHv
         ItQvwmqZ7WPPCMkb7ObEFD/OeKo8is9mUYtlP5qbXJrqj6sHRo6FohVKXHuxi3HATomi
         8ovaFMlTJPdIw3944HRh0UGSH7eKQSxjhnwgqtJnhywNmkrAhqUp5BuDFv0n5Baa8C2N
         E0n5RXO0Bu1giz5cq42MTXXaB25DeTf7Mi/ULAtSpxLnyWHt5pivhqanNqOBFkbw9cIZ
         zBcmmq1IPs1E/hfOMr4c5o4sgAjaXuzCHBEv+kcqiwaC66ofezRwtVW2jxEgPb4KoMO4
         SyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769104934; x=1769709734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONgWQBMchvmRZkoqsxyw4prfXqUNlXapI8P6hstcLnY=;
        b=T4kmUQnypGF1bjbiIV+9AZjtfKu55osyc4CgGF/rhHucOAe55E22JsvfUXcE64lRfi
         7tP20eLFZGzdqE2XPJBaaeCC55syAXojwld0pjCs1hsPaDGh8QIUboggc9CzpAt7bHv7
         T1BuSYdQqjpA0rLlYpFd2vH+yjFpHIlUscwtRZL9lMfy16wh+96RaZ3MlCqKPGtkaXkV
         6J4zogDdeVIIHXzizgwtwJgQBMGFY4SpH4Miha2XlP6yOxt395OQTQd6eUxU3T0tnqi7
         OBvbUWNuADc9ap1KGt7dfdDogyaEe+nNWf5++Zrf24f/IEfjWY+/C54k06+8gWbJHnUK
         dU7w==
X-Forwarded-Encrypted: i=1; AJvYcCXRrNBRsyr81Y+ODkrV2LF+27p3nyS+FKfCq9I0GzCn9mELsIU3/mvQBmhO0DjGP6aZb0zHrZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypG7aRLgAIDyeEKWM4qekLNr89+JF4yRUL07s8MszL1YwrmUee
	nJNVZnsscl6yd9oMtlEwnKwa5/TlR1xEvSrRnDNq/AORGJrKkSXjecuutjHJrzsMF6vdD3I8K5u
	VH3kcYVYyqHSpzw==
X-Received: from dybqo12.prod.google.com ([2002:a05:7301:678c:b0:2b6:b6b8:7fee])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:3008:b0:2b7:2586:954e with SMTP id 5a478bee46e88-2b739b76ea4mr120629eec.25.1769104933824;
 Thu, 22 Jan 2026 10:02:13 -0800 (PST)
Date: Thu, 22 Jan 2026 18:02:02 +0000
In-Reply-To: <aXHfYfNZ20-3J8qR@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aXHfYfNZ20-3J8qR@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122180203.1502637-1-cmllamas@google.com>
Subject: [PATCH v2] binder: fix UAF in binder_netlink_report()
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Alice Ryhl <aliceryhl@google.com>, Li Li <dualli@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211290-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C38C6C763
X-Rspamd-Action: no action

Oneway transactions sent to frozen targets via binder_proc_transaction()
return a BR_TRANSACTION_PENDING_FROZEN error but they are still treated
as successful since the target is expected to thaw at some point. It is
then not safe to access 't' after BR_TRANSACTION_PENDING_FROZEN errors
as the transaction could have been consumed by the now thawed target.

This is the case for binder_netlink_report() which derreferences 't'
after a pending frozen error, as pointed out by the following KASAN
report:

  ==================================================================
  BUG: KASAN: slab-use-after-free in binder_netlink_report.isra.0+0x694/0x6c8
  Read of size 8 at addr ffff00000f98ba38 by task binder-util/522

  CPU: 4 UID: 0 PID: 522 Comm: binder-util Not tainted 6.19.0-rc6-00015-gc03e9c42ae8f #1 PREEMPT
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   binder_netlink_report.isra.0+0x694/0x6c8
   binder_transaction+0x66e4/0x79b8
   binder_thread_write+0xab4/0x4440
   binder_ioctl+0x1fd4/0x2940
   [...]

  Allocated by task 522:
   __kmalloc_cache_noprof+0x17c/0x50c
   binder_transaction+0x584/0x79b8
   binder_thread_write+0xab4/0x4440
   binder_ioctl+0x1fd4/0x2940
   [...]

  Freed by task 488:
   kfree+0x1d0/0x420
   binder_free_transaction+0x150/0x234
   binder_thread_read+0x2d08/0x3ce4
   binder_ioctl+0x488/0x2940
   [...]
  ==================================================================

Instead, make a transaction copy so the data can be safely accessed by
binder_netlink_report() after a pending frozen error. While here, add a
comment about not using t->buffer in binder_netlink_report().

Cc: stable@vger.kernel.org
Fixes: 63740349eba7 ("binder: introduce transaction reports via netlink")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 535fc881c8da..4e16438eceb7 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2991,6 +2991,10 @@ static void binder_set_txn_from_error(struct binder_transaction *t, int id,
  * @t:		the binder transaction that failed
  * @data_size:	the user provided data size for the transaction
  * @error:	enum binder_driver_return_protocol returned to sender
+ *
+ * Note that t->buffer is not safe to access here, as it may have been
+ * released (or not yet allocated). Callers should guarantee all the
+ * transaction items used here are safe to access.
  */
 static void binder_netlink_report(struct binder_proc *proc,
 				  struct binder_transaction *t,
@@ -3780,6 +3784,14 @@ static void binder_transaction(struct binder_proc *proc,
 			goto err_dead_proc_or_thread;
 		}
 	} else {
+		/*
+		 * Make a transaction copy. It is not safe to access 't' after
+		 * binder_proc_transaction() reported a pending frozen. The
+		 * target could thaw and consume the transaction at any point.
+		 * Instead, use a safe 't_copy' for binder_netlink_report().
+		 */
+		struct binder_transaction t_copy = *t;
+
 		BUG_ON(target_node == NULL);
 		BUG_ON(t->buffer->async_transaction != 1);
 		return_error = binder_proc_transaction(t, target_proc, NULL);
@@ -3790,7 +3802,7 @@ static void binder_transaction(struct binder_proc *proc,
 		 */
 		if (return_error == BR_TRANSACTION_PENDING_FROZEN) {
 			tcomplete->type = BINDER_WORK_TRANSACTION_PENDING;
-			binder_netlink_report(proc, t, tr->data_size,
+			binder_netlink_report(proc, &t_copy, tr->data_size,
 					      return_error);
 		}
 		binder_enqueue_thread_work(thread, tcomplete);
-- 
2.52.0.457.g6b5491de43-goog


