Return-Path: <stable+bounces-100950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED299EE998
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AFE6280CD7
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B032080FC;
	Thu, 12 Dec 2024 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rESBc7Da";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5JFiNov1"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91287213E97
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734015731; cv=none; b=cVfaDUJuX4SH40hl6JNGwn25vJ7kALqGCW7MAWT4MdM0/cpC3tyB8Ly+iSW9rEzL1qJKf4AR5KHq49NVFYjBkf6RkvKahH7RR+3WMVBIGQVOCcMNGm719BUGGIFhxbVIk980wvWgpYop8iREbXF0ZO83LUvc6IDhiGaqZQ8+ZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734015731; c=relaxed/simple;
	bh=8gZhjEop+4H4/UIJC0AWI8W8hpFOGgzk8STfp10Jm6Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ivFbJtcl3+M3lnpVs+v1mM/DJOC55oHGFhhO+VbTMFlPGO7ff5nx4ySv/Z38bujRDOYLQgHz1C7HByQmqjVIbK+JGhbTJf7Ectz1F6D+qZl8+l85f5levAAaSRT5+5SnnFfLXB5veQeZM6/1UFLfZXDUrCeZ5eFbgELXBphHWkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rESBc7Da; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5JFiNov1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734015726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OvdKC2WkupAqsNOAoRYlOXYwQS8i1HwE801YVXxdDOk=;
	b=rESBc7DaeBuyg14lECYp0gRvZmUAGEUbUJIaML/KiqKmvPRfqnymApADLAJTPe0YeivNSI
	iAoYVPwN+wnwEaP+WYkDK1g4wE/+wwG0W1G4fu8oWf7h2bH84MnQWfhPM1wv+d7RRT8LU3
	/9ng7IbFOBpEuuT6KHs97XZ0pRnTzFLjlU+d/4ixoAIQLtsDzgb8A35v3UrxUzp6pv+scu
	ZUFvg0rfe2ztQ11R5vOJ4O0QbGYb4dsZE2ECah6ZLavNGwz1rYm9xfgIcqLeZDKnWgdfVM
	usZd5WJrok02L3mURit5CDodaflNjmMHpGQ4OhPfFuyPWTW6debSa/tTJQLMZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734015726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OvdKC2WkupAqsNOAoRYlOXYwQS8i1HwE801YVXxdDOk=;
	b=5JFiNov15xe1E+cwExgGMhdxDPOdxDco0GUhArnVlyaugZk475h4nbZrRWkBWsOuReeKt0
	Idv+UwnA+MiaMqBw==
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux@roeck-us.net, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] clocksource: Make negative motion
 detection more robust" failed to apply to 6.12-stable tree
In-Reply-To: <2024121255-handled-ample-e394@gregkh>
References: <2024121203-griminess-blah-4e97@gregkh> <87ikrp9f59.ffs@tglx>
 <2024121232-obligate-varsity-e68f@gregkh>
 <2024121235-impale-paddle-8f94@gregkh> <87frmt9dl3.ffs@tglx>
 <2024121205-override-postbox-5ed6@gregkh>
 <2024121255-handled-ample-e394@gregkh>
Date: Thu, 12 Dec 2024 16:02:06 +0100
Message-ID: <87cyhx9c7l.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12 2024 at 15:37, Greg KH wrote:
> On Thu, Dec 12, 2024 at 03:35:14PM +0100, Greg KH wrote:
>> On Thu, Dec 12, 2024 at 03:32:24PM +0100, Thomas Gleixner wrote:
>> > On Thu, Dec 12 2024 at 15:18, Greg KH wrote:
>> > > On Thu, Dec 12, 2024 at 03:17:03PM +0100, Greg KH wrote:
>> > >> > But I don't think these two commits are necessarily stable materi=
al,
>> > >> > though I don't have a strong opinion on it. If c163e40af9b2 is
>> > >> > backported, then it has it's own large dependency chain on pre 6.=
10
>> > >> > kernels...
>> > >>=20
>> > >> It's in the queues for some reason, let me figure out why...
>> > >
>> > > Ah, it was an AUTOSEL thing, I'll go drop it from all queues except
>> > > 6.12.y for now, thanks.
>> > >
>> > > But, for 6.12.y, we want this fixup too, right?
>> >=20
>> > If you have c163e40af9b2 pulled back into 6.12.y, then yes. I don't kn=
ow
>> > why this actually rejects. I just did
>> >=20
>> > git-cherry-pick c163e40af9b2
>> > git-cherry-pick 51f109e92935
>> >=20
>> > on top of v6.12.4 and that just worked fine.
>>=20
>> The build breaks :(
>
> To be specific:
>
> kernel/time/timekeeping.c: In function =E2=80=98timekeeping_debug_get_ns=
=E2=80=99:
> kernel/time/timekeeping.c:263:17: error: too few arguments to function =
=E2=80=98clocksource_delta=E2=80=99
>   263 |         delta =3D clocksource_delta(now, last, mask);
>       |                 ^~~~~~~~~~~~~~~~~
> In file included from kernel/time/timekeeping.c:30:

Ah. You also need:

d44d26987bb3 ("timekeeping: Remove CONFIG_DEBUG_TIMEKEEPING")

which in turn does not apply cleanly and needs the backport
below. *shrug*

Thanks,

        tglx
---
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 2341393cfac1..26c01b9e3434 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -301,7 +301,6 @@ CONFIG_DEBUG_MEMORY_INIT=3Dy
 CONFIG_DEBUG_PER_CPU_MAPS=3Dy
 CONFIG_SOFTLOCKUP_DETECTOR=3Dy
 CONFIG_WQ_WATCHDOG=3Dy
-CONFIG_DEBUG_TIMEKEEPING=3Dy
 CONFIG_DEBUG_RT_MUTEXES=3Dy
 CONFIG_DEBUG_SPINLOCK=3Dy
 CONFIG_DEBUG_MUTEXES=3Dy
diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper=
_internal.h
index 902c20ef495a..715e0919972e 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -68,9 +68,6 @@ struct tk_read_base {
  *			shifted nano seconds.
  * @ntp_error_shift:	Shift conversion between clock shifted nano seconds a=
nd
  *			ntp shifted nano seconds.
- * @last_warning:	Warning ratelimiter (DEBUG_TIMEKEEPING)
- * @underflow_seen:	Underflow warning flag (DEBUG_TIMEKEEPING)
- * @overflow_seen:	Overflow warning flag (DEBUG_TIMEKEEPING)
  *
  * Note: For timespec(64) based interfaces wall_to_monotonic is what
  * we need to add to xtime (or xtime corrected for sub jiffy times)
@@ -124,18 +121,6 @@ struct timekeeper {
 	u32			ntp_err_mult;
 	/* Flag used to avoid updating NTP twice with same second */
 	u32			skip_second_overflow;
-#ifdef CONFIG_DEBUG_TIMEKEEPING
-	long			last_warning;
-	/*
-	 * These simple flag variables are managed
-	 * without locks, which is racy, but they are
-	 * ok since we don't really care about being
-	 * super precise about how many events were
-	 * seen, just that a problem was observed.
-	 */
-	int			underflow_seen;
-	int			overflow_seen;
-#endif
 };
=20
 #ifdef CONFIG_GENERIC_TIME_VSYSCALL
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 1f003247b89b..96933082431f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -195,97 +195,6 @@ static inline u64 tk_clock_read(const struct tk_read_b=
ase *tkr)
 	return clock->read(clock);
 }
=20
-#ifdef CONFIG_DEBUG_TIMEKEEPING
-#define WARNING_FREQ (HZ*300) /* 5 minute rate-limiting */
-
-static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
-{
-
-	u64 max_cycles =3D tk->tkr_mono.clock->max_cycles;
-	const char *name =3D tk->tkr_mono.clock->name;
-
-	if (offset > max_cycles) {
-		printk_deferred("WARNING: timekeeping: Cycle offset (%lld) is larger tha=
n allowed by the '%s' clock's max_cycles value (%lld): time overflow danger=
\n",
-				offset, name, max_cycles);
-		printk_deferred("         timekeeping: Your kernel is sick, but tries to=
 cope by capping time updates\n");
-	} else {
-		if (offset > (max_cycles >> 1)) {
-			printk_deferred("INFO: timekeeping: Cycle offset (%lld) is larger than =
the '%s' clock's 50%% safety margin (%lld)\n",
-					offset, name, max_cycles >> 1);
-			printk_deferred("      timekeeping: Your kernel is still fine, but is f=
eeling a bit nervous\n");
-		}
-	}
-
-	if (tk->underflow_seen) {
-		if (jiffies - tk->last_warning > WARNING_FREQ) {
-			printk_deferred("WARNING: Underflow in clocksource '%s' observed, time =
update ignored.\n", name);
-			printk_deferred("         Please report this, consider using a differen=
t clocksource, if possible.\n");
-			printk_deferred("         Your kernel is probably still fine.\n");
-			tk->last_warning =3D jiffies;
-		}
-		tk->underflow_seen =3D 0;
-	}
-
-	if (tk->overflow_seen) {
-		if (jiffies - tk->last_warning > WARNING_FREQ) {
-			printk_deferred("WARNING: Overflow in clocksource '%s' observed, time u=
pdate capped.\n", name);
-			printk_deferred("         Please report this, consider using a differen=
t clocksource, if possible.\n");
-			printk_deferred("         Your kernel is probably still fine.\n");
-			tk->last_warning =3D jiffies;
-		}
-		tk->overflow_seen =3D 0;
-	}
-}
-
-static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr,=
 u64 cycles);
-
-static inline u64 timekeeping_debug_get_ns(const struct tk_read_base *tkr)
-{
-	struct timekeeper *tk =3D &tk_core.timekeeper;
-	u64 now, last, mask, max, delta;
-	unsigned int seq;
-
-	/*
-	 * Since we're called holding a seqcount, the data may shift
-	 * under us while we're doing the calculation. This can cause
-	 * false positives, since we'd note a problem but throw the
-	 * results away. So nest another seqcount here to atomically
-	 * grab the points we are checking with.
-	 */
-	do {
-		seq =3D read_seqcount_begin(&tk_core.seq);
-		now =3D tk_clock_read(tkr);
-		last =3D tkr->cycle_last;
-		mask =3D tkr->mask;
-		max =3D tkr->clock->max_cycles;
-	} while (read_seqcount_retry(&tk_core.seq, seq));
-
-	delta =3D clocksource_delta(now, last, mask);
-
-	/*
-	 * Try to catch underflows by checking if we are seeing small
-	 * mask-relative negative values.
-	 */
-	if (unlikely((~delta & mask) < (mask >> 3)))
-		tk->underflow_seen =3D 1;
-
-	/* Check for multiplication overflows */
-	if (unlikely(delta > max))
-		tk->overflow_seen =3D 1;
-
-	/* timekeeping_cycles_to_ns() handles both under and overflow */
-	return timekeeping_cycles_to_ns(tkr, now);
-}
-#else
-static inline void timekeeping_check_update(struct timekeeper *tk, u64 off=
set)
-{
-}
-static inline u64 timekeeping_debug_get_ns(const struct tk_read_base *tkr)
-{
-	BUG();
-}
-#endif
-
 /**
  * tk_setup_internals - Set up internals to use clocksource clock.
  *
@@ -390,19 +299,11 @@ static inline u64 timekeeping_cycles_to_ns(const stru=
ct tk_read_base *tkr, u64 c
 	return ((delta * tkr->mult) + tkr->xtime_nsec) >> tkr->shift;
 }
=20
-static __always_inline u64 __timekeeping_get_ns(const struct tk_read_base =
*tkr)
+static __always_inline u64 timekeeping_get_ns(const struct tk_read_base *t=
kr)
 {
 	return timekeeping_cycles_to_ns(tkr, tk_clock_read(tkr));
 }
=20
-static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
-{
-	if (IS_ENABLED(CONFIG_DEBUG_TIMEKEEPING))
-		return timekeeping_debug_get_ns(tkr);
-
-	return __timekeeping_get_ns(tkr);
-}
-
 /**
  * update_fast_timekeeper - Update the fast and NMI safe monotonic timekee=
per.
  * @tkr: Timekeeping readout base from which we take the update
@@ -446,7 +347,7 @@ static __always_inline u64 __ktime_get_fast_ns(struct t=
k_fast *tkf)
 		seq =3D raw_read_seqcount_latch(&tkf->seq);
 		tkr =3D tkf->base + (seq & 0x01);
 		now =3D ktime_to_ns(tkr->base);
-		now +=3D __timekeeping_get_ns(tkr);
+		now +=3D timekeeping_get_ns(tkr);
 	} while (raw_read_seqcount_latch_retry(&tkf->seq, seq));
=20
 	return now;
@@ -562,7 +463,7 @@ static __always_inline u64 __ktime_get_real_fast(struct=
 tk_fast *tkf, u64 *mono)
 		tkr =3D tkf->base + (seq & 0x01);
 		basem =3D ktime_to_ns(tkr->base);
 		baser =3D ktime_to_ns(tkr->base_real);
-		delta =3D __timekeeping_get_ns(tkr);
+		delta =3D timekeeping_get_ns(tkr);
 	} while (raw_read_seqcount_latch_retry(&tkf->seq, seq));
=20
 	if (mono)
@@ -2300,9 +2201,6 @@ static bool timekeeping_advance(enum timekeeping_adv_=
mode mode)
 	if (offset < real_tk->cycle_interval && mode =3D=3D TK_ADV_TICK)
 		goto out;
=20
-	/* Do some additional sanity checking */
-	timekeeping_check_update(tk, offset);
-
 	/*
 	 * With NO_HZ we may have to accumulate many cycle_intervals
 	 * (think "ticks") worth of time at once. To do this efficiently,
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7312ae7c3cc5..3f9c238bb58e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1328,19 +1328,6 @@ config SCHEDSTATS
=20
 endmenu
=20
-config DEBUG_TIMEKEEPING
-	bool "Enable extra timekeeping sanity checking"
-	help
-	  This option will enable additional timekeeping sanity checks
-	  which may be helpful when diagnosing issues where timekeeping
-	  problems are suspected.
-
-	  This may include checks in the timekeeping hotpaths, so this
-	  option may have a (very small) performance impact to some
-	  workloads.
-
-	  If unsure, say N.
-
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPTION && TRACE_IRQFLAGS_SUPPORT
diff --git a/tools/testing/selftests/wireguard/qemu/debug.config b/tools/te=
sting/selftests/wireguard/qemu/debug.config
index 9d172210e2c6..139fd9aa8b12 100644
--- a/tools/testing/selftests/wireguard/qemu/debug.config
+++ b/tools/testing/selftests/wireguard/qemu/debug.config
@@ -31,7 +31,6 @@ CONFIG_SCHED_DEBUG=3Dy
 CONFIG_SCHED_INFO=3Dy
 CONFIG_SCHEDSTATS=3Dy
 CONFIG_SCHED_STACK_END_CHECK=3Dy
-CONFIG_DEBUG_TIMEKEEPING=3Dy
 CONFIG_DEBUG_PREEMPT=3Dy
 CONFIG_DEBUG_RT_MUTEXES=3Dy
 CONFIG_DEBUG_SPINLOCK=3Dy



