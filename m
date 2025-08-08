Return-Path: <stable+bounces-166876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0916B1ED0B
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 18:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D8C3A8A38
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 16:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B458286D74;
	Fri,  8 Aug 2025 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RVeye/4p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yKo9boRD"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC385285044;
	Fri,  8 Aug 2025 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754670832; cv=none; b=pyQzGfAe1HjHoaXAqjmgbl0ilu/fvmtgjnFEScHZ8gtVFz4o6OlbT7D6WJsZrkXyMTBVmuAGYLdp3Wcrb4dUUGKLrN09JaDL+SGKN9duoBPCBsEKhsCzAiL92b6Vkhf9L1gG9I14f50cAzvv+ioSD4YvKIUKNEld8Sklu2pwm9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754670832; c=relaxed/simple;
	bh=Pwdx/Tk5p4zqxvPam2CPyrJ36ROrTDvlqkdX+YdUIkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g81wmqgL8QKBmLbf+JeFHqNJTHzdfVtAiPV4vqJXFdqeLsC3MJ6422qBsSkthzSPCuWlXcsl8B71xzEypCgwbWVzPCQh7McIySptRA6gM7CKJwG53o6EPkpgdoLhGPE003ycpv5kx2D3qJ1nboYof1b1KBPcNIX9AGffUG0aaec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RVeye/4p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yKo9boRD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 8 Aug 2025 18:33:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754670827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfkgxAstW/grwEhYFrNwo+E5fvmu5YawBnjm5gjeKEk=;
	b=RVeye/4pqNL2Rxrp4JBr2Wp2ohhSaHCMyzNxVgG/9/7HGPigWp462OiTwF6vHVcrNpbow4
	7wJkqa21ZP0mippivOz8YAtRyYxkhRuQoubHDzkE7nkMGDOzysQJZJ6GuggbDyo/iEXjvt
	MIaWoSAL+nhJxyh5JqZmQjP1zRnJ/XlN/DCx2HXJK8+strGVM0pn+xidutZCla8Wlbwo+c
	iwoGKNWR3rWkqFsN9frsYfPpJq3KmJEFo5bwkkwDnAdbqDfEgsi8l8YBiQ9dOkpIcRYN1F
	i45zjDg/DIjJcGaGtrKLyDh56EKSEkpSjspVbdcgVfgguHLThjvs/cjlvK0GCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754670827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfkgxAstW/grwEhYFrNwo+E5fvmu5YawBnjm5gjeKEk=;
	b=yKo9boRDg7VkANZpRsdijWOQ+20lswktBfxzUY+LnXAzwElkHvWO+C+9kq+P/A1b/myyUo
	hVMWnerjXL/uPHAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Byungchul Park <byungchul@sk.com>, max.byungchul.park@gmail.com,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Michelle Jin <shjy180909@gmail.com>, linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
	kasan-dev@googlegroups.com, syzkaller@googlegroups.com,
	linux-usb@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] kcov, usb: Fix invalid context sleep in softirq path on
 PREEMPT_RT
Message-ID: <20250808163345.PPfA_T3F@linutronix.de>
References: <20250725201400.1078395-2-ysk@kzalloc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250725201400.1078395-2-ysk@kzalloc.com>

On 2025-07-25 20:14:01 [+0000], Yunseong Kim wrote:
> When fuzzing USB with syzkaller on a PREEMPT_RT enabled kernel, following
> bug is triggered in the ksoftirqd context.
>=20
=E2=80=A6
> This issue was introduced by commit
> f85d39dd7ed8 ("kcov, usb: disable interrupts in kcov_remote_start_usb_sof=
tirq").
>=20
> However, this creates a conflict on PREEMPT_RT kernels. The local_irq_sav=
e()
> call establishes an atomic context where sleeping is forbidden. Inside th=
is
> context, kcov_remote_start() is called, which on PREEMPT_RT uses sleeping
> locks (spinlock_t and local_lock_t are mapped to rt_mutex). This results =
in
> a sleeping function called from invalid context.
>=20
> On PREEMPT_RT, interrupt handlers are threaded, so the re-entrancy scenar=
io
> is already safely handled by the existing local_lock_t and the global
> kcov_remote_lock within kcov_remote_start(). Therefore, the outer
> local_irq_save() is not necessary.
>=20
> This preserves the intended re-entrancy protection for non-RT kernels whi=
le
> resolving the locking violation on PREEMPT_RT kernels.
>=20
> After making this modification and testing it, syzkaller fuzzing the
> PREEMPT_RT kernel is now running without stopping on latest announced
> Real-time Linux.

This looks oddly familiar because I removed the irq-disable bits while
adding local-locks.

Commit f85d39dd7ed8 looks wrong not that it shouldn't disable
interrupts. The statement in the added comment

| + * 2. Disables interrupts for the duration of the coverage collection se=
ction.
| + *    This allows avoiding nested remote coverage collection sections in=
 the
| + *    softirq context (a softirq might occur during the execution of a w=
ork in
| + *    the BH workqueue, which runs with in_serving_softirq() > 0).

is wrong. Softirqs are never nesting. While the BH workqueue is
running another softirq does not occur. The softirq is raised (again)
and will be handled _after_ BH workqueue is done. So this is already
serialised.

The issue is __usb_hcd_giveback_urb() always invokes
kcov_remote_start_usb_softirq(). __usb_hcd_giveback_urb() itself is
invoked from BH context (for the majority of HCDs) and from hardirq
context for the root-HUB. This gets us to the scenario that that we are
in the give-back path in softirq context and then invoke the function
once again in hardirq context.

I have no idea how kcov works but reverting the original commit and
avoiding the false nesting due to hardirq context should do the trick,
an untested patch follows.

This isn't any different than the tasklet handling that was used before
so I am not sure why it is now a problem.

Could someone maybe test this?

--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1636,7 +1636,6 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
 	struct usb_hcd *hcd =3D bus_to_hcd(urb->dev->bus);
 	struct usb_anchor *anchor =3D urb->anchor;
 	int status =3D urb->unlinked;
-	unsigned long flags;
=20
 	urb->hcpriv =3D NULL;
 	if (unlikely((urb->transfer_flags & URB_SHORT_NOT_OK) &&
@@ -1654,14 +1653,13 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
 	/* pass ownership to the completion handler */
 	urb->status =3D status;
 	/*
-	 * Only collect coverage in the softirq context and disable interrupts
-	 * to avoid scenarios with nested remote coverage collection sections
-	 * that KCOV does not support.
-	 * See the comment next to kcov_remote_start_usb_softirq() for details.
+	 * This function can be called in task context inside another remote
+	 * coverage collection section, but kcov doesn't support that kind of
+	 * recursion yet. Only collect coverage in softirq context for now.
 	 */
-	flags =3D kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
+	kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
 	urb->complete(urb);
-	kcov_remote_stop_softirq(flags);
+	kcov_remote_stop_softirq();
=20
 	usb_anchor_resume_wakeups(anchor);
 	atomic_dec(&urb->use_count);
diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index 75a2fb8b16c32..0143358874b07 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -57,47 +57,21 @@ static inline void kcov_remote_start_usb(u64 id)
=20
 /*
  * The softirq flavor of kcov_remote_*() functions is introduced as a temp=
orary
- * workaround for KCOV's lack of nested remote coverage sections support.
- *
- * Adding support is tracked in https://bugzilla.kernel.org/show_bug.cgi?i=
d=3D210337.
- *
- * kcov_remote_start_usb_softirq():
- *
- * 1. Only collects coverage when called in the softirq context. This allo=
ws
- *    avoiding nested remote coverage collection sections in the task cont=
ext.
- *    For example, USB/IP calls usb_hcd_giveback_urb() in the task context
- *    within an existing remote coverage collection section. Thus, KCOV sh=
ould
- *    not attempt to start collecting coverage within the coverage collect=
ion
- *    section in __usb_hcd_giveback_urb() in this case.
- *
- * 2. Disables interrupts for the duration of the coverage collection sect=
ion.
- *    This allows avoiding nested remote coverage collection sections in t=
he
- *    softirq context (a softirq might occur during the execution of a wor=
k in
- *    the BH workqueue, which runs with in_serving_softirq() > 0).
- *    For example, usb_giveback_urb_bh() runs in the BH workqueue with
- *    interrupts enabled, so __usb_hcd_giveback_urb() might be interrupted=
 in
- *    the middle of its remote coverage collection section, and the interr=
upt
- *    handler might invoke __usb_hcd_giveback_urb() again.
+ * work around for kcov's lack of nested remote coverage sections support =
in
+ * task context. Adding support for nested sections is tracked in:
+ * https://bugzilla.kernel.org/show_bug.cgi?id=3D210337
  */
=20
-static inline unsigned long kcov_remote_start_usb_softirq(u64 id)
+static inline void kcov_remote_start_usb_softirq(u64 id)
 {
-	unsigned long flags =3D 0;
-
-	if (in_serving_softirq()) {
-		local_irq_save(flags);
+	if (in_serving_softirq() && !in_hardirq())
 		kcov_remote_start_usb(id);
-	}
-
-	return flags;
 }
=20
-static inline void kcov_remote_stop_softirq(unsigned long flags)
+static inline void kcov_remote_stop_softirq(void)
 {
-	if (in_serving_softirq()) {
+	if (in_serving_softirq() && !in_hardirq())
 		kcov_remote_stop();
-		local_irq_restore(flags);
-	}
 }
=20
 #ifdef CONFIG_64BIT
@@ -131,11 +105,8 @@ static inline u64 kcov_common_handle(void)
 }
 static inline void kcov_remote_start_common(u64 id) {}
 static inline void kcov_remote_start_usb(u64 id) {}
-static inline unsigned long kcov_remote_start_usb_softirq(u64 id)
-{
-	return 0;
-}
-static inline void kcov_remote_stop_softirq(unsigned long flags) {}
+static inline void kcov_remote_start_usb_softirq(u64 id) {}
+static inline void kcov_remote_stop_softirq(void) {}
=20
 #endif /* CONFIG_KCOV */
 #endif /* _LINUX_KCOV_H */
--=20
2.50.1

Sebastian

