Return-Path: <stable+bounces-233370-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JcwMEGX02n3jQcAu9opvQ
	(envelope-from <stable+bounces-233370-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 13:21:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A174A3A3144
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 13:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 144CB3006B73
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 11:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825382DB788;
	Mon,  6 Apr 2026 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJoAzJJu"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ECF3314B9
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775474491; cv=pass; b=becOoXwK3zoetOByU8Nk6yjuKfH+Zccs7fXfjlRBAu0ShsQBDbBjGJhA10juMQfCww0bTc4Ogi6783gvO5fA4AUHG7Ms7xnEDMaB22iEekHxnCdAsp+ug0I1TQYs1WXKOIR9iHOve9DlEggCTAQXIFuBQMMtKznZcWFcjlgKVY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775474491; c=relaxed/simple;
	bh=+n62Xi89zk6CnVw+XF8IGOE3ZI3q8T6CvEvyJgo7J/Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WeDKusDf3vFD3k0qMKFDTzwllLhDUzkw+rppt1AjzJEKQEzV8Sg40/DAaIWkxVDVIjNz6TTBlR28jGG/9cJucW3XuKW0NTbTjix52OP0DAZzmkDe7jWKUTsdBnqiwcURnkHeN6qXbXDc60Gdx7YY2HyrvUArBvdH6km4S8P4sJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oJoAzJJu; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1271257ae53so3874887c88.1
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 04:21:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775474489; cv=none;
        d=google.com; s=arc-20240605;
        b=VQYq7OtBroUFI1esejtSs4wB8pLQjztghWulpRfBdl/1JpxH6/3PXYSNNOXQT+Zxwn
         cz6xRfC54vZkc7XFTvaJ96j9fNwi6xsrqfQ1AHVjVrQYP5Dx7B3fqlhK0ZdDaR9V5HlJ
         UUC6C1yo6p4xaWo9fMKJhen0qZD4rJsXvblL7UHlDqhhyWNZLyPjfBGr3LnPYrCFCk8h
         jPGo4rgZy4JJu83frasGavNF2KlqpxNOZt3Q9fvB3FRAvDAEpjktBVuqqXTv4fDxdjvH
         MUxGMM7LHuNm7/ldvzgBB6u5L4UZRYZ92b2+UPJd+4J3J82Ap7m6MAQsdsnlqUTJSByb
         fSkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=t95BVlFfdvOs5fw/SGxCyY2QTrIHnmC9oYmVhJdlUk4=;
        fh=8Gt9z1OGcRxyFJcJUdxLhaqIGChJYD0a+GI/F5Jcmmc=;
        b=OR29kVqHZ1n86f6oNR4extPXES3vGiFAoWnw0ttbHKBjG6ue6FIRzB3n2XgVY3Swai
         8PwKM40niFQXQ+GKKMB1j1wSpzQaV0EHDY+AqQ6SFOlBdDSZMRgbE74UclQHNKwS8Re+
         UIl7g8w7CsvU77icGDjEzyDTkeMuNI8qxobaSmg278E3wjwXGwRpCrxGdcEPDv/ggNva
         tM3EEG2M0KexcQU13zle4U4IEsKIlVoxGxmJHPKv1QMTmpx+FgvxzUzNmHpALz98OKSr
         xiKNHHI6zKHd7iNZYPiQRQPDM3sWbxpPUnUGzoKPALk73pNdRDILYENGplc0sWA+fLh3
         OfHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775474489; x=1776079289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t95BVlFfdvOs5fw/SGxCyY2QTrIHnmC9oYmVhJdlUk4=;
        b=oJoAzJJurV+9BS1H/mENHoTQvXLZv4v6+PbuLRLBVLcQvuNSSSW1+dioYXg2oDgox9
         TRhp5FYkDgXPZISWkl+h63xxZbRun89Hfl4OwdzBu5va3nd41/5dYQjxGxaF957zYckh
         LIXLvh9dyhpwNxBPTDV1NlU1prVd6xQJ5CmSu+Uh+i0j6ILI+5USu5OIrPu0oyr6EOIW
         MZM7JQtkLrF9w+YBXztvLxkH/q9Px+7Q20bBbRuTNZJ8dg27c9B7vNCl4WrMmV45Azqv
         4IizRzd52fCgUItofI61OOedLhhk5h5i89Bfv3qtJBIF7Ct0/Eq7vPZuGMqtiPk/FC5M
         pDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775474489; x=1776079289;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t95BVlFfdvOs5fw/SGxCyY2QTrIHnmC9oYmVhJdlUk4=;
        b=j4UwwiL0dErVHxWgKyelBpweCYAh/lxTldzfCq1WLRoWF95X80tzMlj+ZYH/wwbzFN
         1GUcLkHI3gC/Gz2qHXLaBP7TlzW6eTi2CizeSytYKzqs+nC6G8ZiqPIOzQMr2pDGMoth
         I0b2C5iyLjwrG8yympL9VR+54gblUlu/Pod0rSqUlmCdPo1A+r5uSIGgs6peBdg0gmkR
         g8t2hm8BX9Qsc2I/prNqjB3ib2fnOx5N/lgjInyLC+lbsaSQk87E2IZP+4jskFDx8xdm
         vipnldk/DfTjvFuynP/9vVSmmN57OVN3yk6gJYcI0OWXkGDrTGGRCiucEikXFzQoRadX
         gsNg==
X-Gm-Message-State: AOJu0YwzQeaVHxsUphJq5wmZXfGI3u5ampG0r103HKJjvKW/FcEXZpQP
	lAb/2fhjfC86hsieieHqtlYVEc9wLfmATALpKtPwJ9UX9pAy/ZqN7CYKt4RZ/bkn/oIRX3KSWmP
	XNDjGkUuhNwH90fY8wUwWvV6g1uAStFs=
X-Gm-Gg: AeBDievJEnjV0Rbj8dXUlzhOISl47RVA5AuEE+K1QHR2S0CpZNPi3w6LEgjX8PZRZzR
	JSrO3u+0zVAQEHEFVE5RxyRyKEM1DewICjdU2MToNYf+ynX80MVuX2VKMXRKZxgYLP3Hubqg1ac
	saoEJntFZP2UfDIn2ZUHEaDaBX/b+yHL94ATchfnwuXwusU70lraUgjnENxXtmWfyShSrV+u8a2
	kk2Yx2ZWyqu9Gy1taPAnFVTnPWINQeN6g9oyGstUu2OF7LcjScGI7L+0k2/qLpn8IiFR5YdK5Yy
	iN1C7Ncl
X-Received: by 2002:a05:7022:6725:b0:128:cf5c:5356 with SMTP id
 a92af1059eb24-12bfb6ec488mr4917113c88.5.1775474489005; Mon, 06 Apr 2026
 04:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: chichina c <li17324910702@gmail.com>
Date: Mon, 6 Apr 2026 19:21:18 +0800
X-Gm-Features: AQROBzDeGLFT7O9eXFGoyzujv58rVUqO1IVJknTlZCTs1XTjGQpO0f6fVLpGbmo
Message-ID: <CAOKsz8yxa3Dj1TGiEwE+2Qkx=F520_pSeVSR6h265jkOxbJGUw@mail.gmail.com>
Subject: [BUG] virt: acrn: destroy_workqueue() called before eventfd wait
 queue removal in acrn_irqfd_deinit()
To: fei1.li@intel.com
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, yakui.zhao@intel.com, 
	shuo.a.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233370-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[li17324910702@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A174A3A3144
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

I found a teardown ordering bug in the ACRN irqfd cleanup path that can
lead to a use-after-free (queue_work() on an already-destroyed workqueue)
when an eventfd is closed concurrently with VM destruction.

Bug description
===============
In acrn_irqfd_deinit() (drivers/virt/acrn/irqfd.c:217-227), the cleanup
order is:

    1. destroy_workqueue(vm->irqfd_wq);          /* line 222 */
    2. list_for_each ... hsm_irqfd_shutdown(irqfd); /* line 224-225 */

hsm_irqfd_shutdown() calls eventfd_ctx_remove_wait_queue(), which removes
the irqfd's wait entry from the eventfd's wait queue.  However,
destroy_workqueue() is called BEFORE this removal, leaving the wait
entries live across the window between lines 222 and 225.

During that window, if an external process closes (or the kernel delivers
POLLHUP to) an eventfd that still has an irqfd attached, the wakeup
callback hsm_irqfd_wakeup() fires (irqfd.c:74-92) and calls:

    queue_work(vm->irqfd_wq, &irqfd->shutdown);   /* line 89 */

At this point vm->irqfd_wq has already been destroyed by
destroy_workqueue().  destroy_workqueue() sets the internal
__WQ_DESTROYING flag (kernel/workqueue.c), which causes __queue_work()
to emit WARN_ONCE and return early rather than corrupt heap directly -
but the ordering invariant is still violated and on kernels with
panic_on_warn=1 this becomes a kernel panic (denial of service).

Note that hsm_irqfd_wakeup() does not hold irqfds_lock and has no
synchronization with acrn_irqfd_deinit(), so there is no existing
mechanism to close this race window.

Compare with KVM's irqfd implementation (virt/kvm/eventfd.c), which
correctly performs eventfd_ctx_remove_wait_queue() on every irqfd
*before* flushing/destroying any workqueue infrastructure.

Affected code
=============
File: drivers/virt/acrn/irqfd.c

  void acrn_irqfd_deinit(struct acrn_vm *vm)
  {
          struct hsm_irqfd *irqfd, *next;

          dev_dbg(acrn_dev.this_device, "VM %u irqfd deinit.\n", vm->vmid);
          destroy_workqueue(vm->irqfd_wq);         /* BUG: too early */
          mutex_lock(&vm->irqfds_lock);
          list_for_each_entry_safe(irqfd, next, &vm->irqfds, list)
                  hsm_irqfd_shutdown(irqfd);  /* removes wait queue entries */
          mutex_unlock(&vm->irqfds_lock);
  }

The invariant that must hold: all call sites that can invoke
queue_work(vm->irqfd_wq, ...) must be silenced before destroy_workqueue()
is called.  hsm_irqfd_wakeup() can only be silenced by removing the wait
queue entry via eventfd_ctx_remove_wait_queue(), which only happens inside
hsm_irqfd_shutdown().

Proposed fix
============
Move the irqfd shutdown loop before destroy_workqueue():

--- a/drivers/virt/acrn/irqfd.c
+++ b/drivers/virt/acrn/irqfd.c
@@ -217,9 +217,15 @@ void acrn_irqfd_deinit(struct acrn_vm *vm)
 {
        struct hsm_irqfd *irqfd, *next;

        dev_dbg(acrn_dev.this_device, "VM %u irqfd deinit.\n", vm->vmid);
-       destroy_workqueue(vm->irqfd_wq);
-       mutex_lock(&vm->irqfds_lock);
+
+       /*
+        * Shut down every irqfd first to remove all wait queue entries.
+        * This ensures hsm_irqfd_wakeup() can no longer call queue_work()
+        * on irqfd_wq before we destroy it.
+        */
+       mutex_lock(&vm->irqfds_lock);
        list_for_each_entry_safe(irqfd, next, &vm->irqfds, list)
                hsm_irqfd_shutdown(irqfd);
        mutex_unlock(&vm->irqfds_lock);
+
+       destroy_workqueue(vm->irqfd_wq);
 }

After this change destroy_workqueue() also implicitly flushes any
hsm_irqfd_shutdown_work instances that were already queued before deinit
started (e.g. from a racing POLLHUP that arrived before deinit), so the
flush semantics are preserved.

Additional note
===============
The teardown ordering bug above is real, but simply moving
destroy_workqueue(vm->irqfd_wq) after the deinit loop may still be
insufficient.

A racing POLLHUP may already have queued irqfd->shutdown before
acrn_irqfd_deinit() acquires irqfds_lock. If deinit then calls
hsm_irqfd_shutdown() directly and frees irqfd, a pending or in-flight
hsm_irqfd_shutdown_work() can later dereference the freed irqfd, turning
this into a different use-after-free.

So the safe teardown sequence may need to be:

    1. under irqfds_lock, detach each irqfd from vm->irqfds and remove
       its eventfd wait queue entry;
    2. keep detached irqfds alive temporarily;
    3. flush/destroy irqfd_wq so any previously queued shutdown work
       drains;
    4. only then drop eventfd references and free the detached irqfds.

This is closer to KVM's two-stage deactivate/cleanup model, where the
irqfd is first made inactive and unhooked from eventfd, and is freed
only after shutdown work has been flushed.



Kernel version tested on 7.0-rc6

Fixes: aa3b483ff1d7 ("virt: acrn: Introduce irqfd")
Reported-by: chichi

