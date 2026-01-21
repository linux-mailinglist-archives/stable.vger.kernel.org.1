Return-Path: <stable+bounces-210769-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKk/BEz0cGmgbAAAu9opvQ
	(envelope-from <stable+bounces-210769-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 16:44:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 974835965C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 16:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A053AC1197
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36A1304BDF;
	Wed, 21 Jan 2026 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZJrd/0D2"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33E248AE21
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007028; cv=none; b=f0/wmy3i1ZZ5GDAjdq6kt1lXoRJXFSsC30/238NOgKimI82bRjZKl6JnjuQbOOwOOmy7vVDqkt87gGYCAoMtr7xnZm5WWDxIKiz2eC3d/rqonxoSE46wk+VYLJ43QYfbgKi7t1npZYbr2c7jMyb+rVC4ZWrBV4qsj4kT+16uDeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007028; c=relaxed/simple;
	bh=blsOvSu+NsTlGasp6WKVyqG0n743f0kngtoxvejq31g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qobJ40BOiLZYqUCEkedXX8CoG+alkaDG8a2ETo6bfeHGZNYiQZSPrwWDGF9JMevYytNyFoVyqFePyFmJsKV/ABoITnb8hb0Wp+Y70w7+WezginSLEDOiqOD2Loom1OiGoyE4V424jYYAPMuJE9pxnWWec3wTQM6ZLjLtpXDSDPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZJrd/0D2; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-124743cf760so1198429c88.1
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 06:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769007026; x=1769611826; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=euAK2if6pWi2IvG5zRCjntEoGbMw8B6pYC9dKG2JFHU=;
        b=ZJrd/0D2nvOBtVTRDXrZ4rtwHP9ZNM7xpjM2CWlSH26tFw+UqLmgfw3JRbhzBe2OVX
         Fv3mkxho6cMMABFdQ/RMPNGLgd5BeVhu2eam3rYGu7C+Q9I6jpZpW/Q8SW+cg8g/9QRh
         clOpAn23Jsnm+t5Ol6m485O8bQjMvoWSaxMEkhmo46LdsN7nGZRXhCkSxa6RCOiFNis7
         D5K0nPeYuQi+hExZN2X/WeVNnFgXmCbzCpqshe6yO449ZDHvyoxNw7emcvym8Xrx/TCv
         ddAEnqpJaKwdbi4IBBYE9bm6OPtiWxkKqMjFPeOWemUGufPDonV4JSop6XspdfkAKqV6
         OprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769007026; x=1769611826;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=euAK2if6pWi2IvG5zRCjntEoGbMw8B6pYC9dKG2JFHU=;
        b=b/mbsYLtYV057A5jwh5PxmvBlrR4QmwBC8mfZ/RM52x9S/uo/7l4iNzj80lno3P2t3
         RsUAiiy21b6YSNWoJaOQ75nez3CLmzzN/U4FKxlVAaE9VQEFiKxYJdEj+Qmq6VedzYar
         QHSIOYyCDKLwoJf4L26to/06eye9R3ESqbtPX1HixR9s3Y4zqIIsPETGgbuEsRkzUbug
         sTTqZ5Z6tyyb8h9Py6WEKd78pLGsAj0ZwUSZZOfU3cLbLpYgPZeM8nIzQOdXGcVh/cue
         saAusk0BaSEekT/94DfSsQaMTB9N/QL7IBPQQ6L4Wy0dBpZ0AMqc0WeuEhHPgSi1hI+b
         dHTg==
X-Forwarded-Encrypted: i=1; AJvYcCWmo9gywm5vUCivmvu2Ee6votFRkg+Gq2N8q66N20BlU8YeBPXVUTgD7e42GpE9NltbyptnUak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrY/ZMvN/sjjbmuG+FY3VbjyR4Kdl34aarptC3+CQsfLaICweR
	KQsc6QQTZGrqPWi1Nq5MLCpJ8RupkFP8B30zmtMbW6+XRd8Mb57vbwlseOAty6FjJXkJKve5xJi
	TIFmNTUeUCx4roA==
X-Received: from dlbpy14.prod.google.com ([2002:a05:7022:e98e:b0:11d:cfa0:5ddf])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:7a7:b0:11d:f44c:afbc with SMTP id a92af1059eb24-1246aadcce9mr4085014c88.37.1769007025887;
 Wed, 21 Jan 2026 06:50:25 -0800 (PST)
Date: Wed, 21 Jan 2026 14:50:04 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260121145005.120507-1-cmllamas@google.com>
Subject: [PATCH] binder: fix UAF in binder_netlink_report()
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Alice Ryhl <aliceryhl@google.com>, Li Li <dualli@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210769-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 974835965C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
binder_netlink_report() after a pending frozen error.

Cc: stable@vger.kernel.org
Fixes: 63740349eba7 ("binder: introduce transaction reports via netlink")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 535fc881c8da..70dc63a6e06a 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3780,6 +3780,14 @@ static void binder_transaction(struct binder_proc *proc,
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
@@ -3790,7 +3798,7 @@ static void binder_transaction(struct binder_proc *proc,
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


