Return-Path: <stable+bounces-233372-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGcsHEKb02majgcAu9opvQ
	(envelope-from <stable+bounces-233372-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 13:38:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 823F93A31BD
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 13:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BD4B3004D12
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 11:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC6A3314D0;
	Mon,  6 Apr 2026 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrJHZZh2"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2985153BE9
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775475514; cv=pass; b=XzsB3UE4Rfkz56IyUUEntyKe0ycnAVvaUeBmb8D/h9SscIdBAegnQUBjbOW4xX4N//Hbe4O+XJ0Smv8zEqlGL8TLDQDSw1qCocD34eNmndN3lOEmW2ArOil/tMZ2YPM3zM20GYCmuTeuz1V42lMt9OxM5hMsu+GPQcmZNBUsDHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775475514; c=relaxed/simple;
	bh=bnnbD36JRK1H0WmZABZ2TVcYz5ypqCF3La8J3Y5l9rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdjQk/Xh9C9NUQX0QQMPYPSeTjAYpQ47RbzPPkzjE/xXsoK2niM6manih70Z6Ph3TGUDMFTPmn5CbooMtf954VNhdtK1ih0doVi2CoIKHgRlrSECrp/oAXD/vj1Ts4M4tH1B/24zER4j7kEzuQ/E7HrdBloWzLqTIhdOPQbpJJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrJHZZh2; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1271195d2a7so8168835c88.0
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 04:38:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775475512; cv=none;
        d=google.com; s=arc-20240605;
        b=cU0XlWqswmavFpxsPy63EWrClkin/p6Dc5gl+VpNOTAXdmBkOBP6354JM+NEULwW/a
         wLimAHPF+XB6hW5VYeMgDYv+btgLCKaxwaflLKYfCe9M/Ds1+z56g7TCD/DYtQk0uhcZ
         sp8fcPj/oCpnImpG/ePnXlofSKd3Tb8DBSwkjPQMr0170VAnRbH5yQu74qEOASgLsKjI
         cbJEK+jnNjGTSFRmZqravOJESXFkLlIQF25E6zsmPutCUSevAFRxNo5RnB0dovK5ROZO
         3dHY6zT3lHEyLSefg4sPAAkpoMdXH4TqLkTQN6+VuEC1cgZTOIVk/pd/Rcgx1linXvr7
         OwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MTv8dwBsuDw9G43cN+a9fRgKYOA57T1yFLSQo5apy/w=;
        fh=5j8VGXsnNGG1Sv3GNmGgXjW2hPG33Et1Tw+8HUqZ6Ko=;
        b=E5BSkGIPoli5gTpgn1HsWbRfK04+9pRhTJ1vlkqQEhWNCN0/AxpX58AEOFbyL6MPPY
         kuiloWmCXIWHYiW8lGZtuBMIyxACRTvhBrFhXosH2xXe80rhiFNQZGQYAk0xuEkAr36d
         6wKQcUjLeij9dJvtmUDg5epRR4WAtdaQ81qdFY+dBf8ipLgNMlAjh6Bw/mCtndlqcm1L
         I8fW5MYElbolBn9Hwh4mlBp/lTbRBG45PcXxSuP8a5cWU/Wc2Ji963UyULiUR2zBKIDo
         wbjeQ8H5tPBeiSxOBaeZfynjF2haLcP1Z8+/xhxuQ/mHtINCeGS6OXXz9KLwQubEwd1o
         rbRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775475512; x=1776080312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTv8dwBsuDw9G43cN+a9fRgKYOA57T1yFLSQo5apy/w=;
        b=WrJHZZh2+FjPL1odYbeYboOTGTwFJnctUETLCoKBDHRrTk/CKgH4HT/XsX2Mn5oVb6
         ibiz6M8s6F8bELy6wP/0tBzimk+20IJEHs43Is8Q4TbaoUX9RojJShdoykAZrsTY3lfc
         6CWZFYvmoeK928T8MUTUGKGF32dqNFi2s6AexJ1OdBkPdeZ+y0Yl7p7oyP70uqZqRSUS
         lazXBQMePoNEePNNPZaeF0AKxxayDGTUS4kwi2TuYRgvcGirCKGKlOy7bOwTCVc7Y/gf
         kUo6RGs6u4//XcI/IbbFeT7yQBeR0owfV55oiwT1fF0poPFkcTphF0YFbXsBBG78uzpD
         4Nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775475512; x=1776080312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MTv8dwBsuDw9G43cN+a9fRgKYOA57T1yFLSQo5apy/w=;
        b=HiEdc8YEf/VgUtbp9a9c65TZNVASwUEG686m77G/TzS1t9nz5GJlmGycIuMxvrMl9K
         fX8wZc8xuaVyf9uj3bDxJAV3LkfESpoOxDzDiPxC714ndmtieb6C1Ki8ASZDzGyo5Dab
         48SC2NneV9r4hRjCZ18jDR2SWUDQr9gp65piaSAA+KWW0BL0cxdjFDhIdiJzUpWzDbT/
         pH7XWGdVDU474DBqDgFXYcdoJsIOG9S8hswtuuATn+mA9J3ppj7IiEuckW8fW1MllQ0/
         aiJOk2s4UXXeYP3JQ292AmdY+2yJ8KG8U/D6nEr0Nm+WpH2Us4IdKIzeeCOkIXUx4VxX
         1UfA==
X-Gm-Message-State: AOJu0Yx0GXtegIsj74auoxRpaGU/Ba6GeY0NOAkHNLkZ4jJSMqHTzuES
	IfHIZoNGY8qi11dfJrGiFCgjNV7J/ZjrEs7DeIST2d3x+VTFO7jR2ytYrko/HnXDxIxdZCQAqQT
	qddBY9g7YL1jzYKx7G+MQ/VVdUbVv+Rw=
X-Gm-Gg: AeBDieurLty4ba6T/znjhlbOy8aE+Bc1oLVzMXyixzUPumFICo8gk2C8ekr91wjmVaj
	GR1fD/UPFrAaE4w1Pf9sVOO+jqwIReJ62anEbe1sEvNZm4CwGQnYIvvL9GDVRoJCi5TZnSs+a4n
	9nT4ko+WGUEbtRSvB3kHYC7kI+vkuxWzGl3/VmBXBrHdlAgG0pX/0yDojqpVt24uT6xEuqj4Zq/
	SkeEBwoz1UKvrJL4yR09bgqVnSDLTh7DVPnooq9N6WCgpFsPSOzFGT3w9POoXm+ftjiwmnHM3BK
	wiLMCo0B
X-Received: by 2002:a05:7022:6199:b0:128:d107:da0f with SMTP id
 a92af1059eb24-12bfb6fb627mr5618745c88.10.1775475511991; Mon, 06 Apr 2026
 04:38:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOKsz8yxa3Dj1TGiEwE+2Qkx=F520_pSeVSR6h265jkOxbJGUw@mail.gmail.com>
In-Reply-To: <CAOKsz8yxa3Dj1TGiEwE+2Qkx=F520_pSeVSR6h265jkOxbJGUw@mail.gmail.com>
From: chichina c <li17324910702@gmail.com>
Date: Mon, 6 Apr 2026 19:38:21 +0800
X-Gm-Features: AQROBzBURXUhSPg04MNKIAyCjYPyDCQNhMaVXd5bT34Mp0qbWqwVU1ZICL-F0CU
Message-ID: <CAOKsz8zLUQ_AtDWJ9uPfEjj5f1w2P8vFvD9wwWOb9pqJehK7HQ@mail.gmail.com>
Subject: Re: [BUG] virt: acrn: destroy_workqueue() called before eventfd wait
 queue removal in acrn_irqfd_deinit()
To: fei1.li@intel.com
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	acrn-dev@lists.projectacrn.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233372-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[li17324910702@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 823F93A31BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Adding this email address to the thread for
reference=EF=BC=9Aacrn-dev@lists.projectacrn.org.
=3D=3D=3D=3D=3D=3D



Hi,

I found a teardown ordering bug in the ACRN irqfd cleanup path that can
lead to a use-after-free (queue_work() on an already-destroyed workqueue)
when an eventfd is closed concurrently with VM destruction.

Bug description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
panic_on_warn=3D1 this becomes a kernel panic (denial of service).

Note that hsm_irqfd_wakeup() does not hold irqfds_lock and has no
synchronization with acrn_irqfd_deinit(), so there is no existing
mechanism to close this race window.

Compare with KVM's irqfd implementation (virt/kvm/eventfd.c), which
correctly performs eventfd_ctx_remove_wait_queue() on every irqfd
*before* flushing/destroying any workqueue infrastructure.

Affected code
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
File: drivers/virt/acrn/irqfd.c

  void acrn_irqfd_deinit(struct acrn_vm *vm)
  {
          struct hsm_irqfd *irqfd, *next;

          dev_dbg(acrn_dev.this_device, "VM %u irqfd deinit.\n", vm->vmid);
          destroy_workqueue(vm->irqfd_wq);         /* BUG: too early */
          mutex_lock(&vm->irqfds_lock);
          list_for_each_entry_safe(irqfd, next, &vm->irqfds, list)
                  hsm_irqfd_shutdown(irqfd);  /* removes wait queue entries=
 */
          mutex_unlock(&vm->irqfds_lock);
  }

The invariant that must hold: all call sites that can invoke
queue_work(vm->irqfd_wq, ...) must be silenced before destroy_workqueue()
is called.  hsm_irqfd_wakeup() can only be silenced by removing the wait
queue entry via eventfd_ctx_remove_wait_queue(), which only happens inside
hsm_irqfd_shutdown().

Proposed fix
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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

