Return-Path: <stable+bounces-185727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED97BDB2D2
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 22:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6DD18A17DE
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 20:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCE8305974;
	Tue, 14 Oct 2025 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiZ6AFYB"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB14305972
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760472799; cv=none; b=YOEVgXmavJhBT5/ABhpIAuSxbA3q1bP0DkAewKQH8R7BcyRd498XHeaG6E19OqG/cJypH0aJ0Qw1DCDadno7zQUJ55tIkc6JFiTYjdhEWHdBVQpRwf3WDlDp8uVCs5uj1DVihfKp+IbG+2XwwteJ9WmRUQrXV+P4VfyIHYXWhwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760472799; c=relaxed/simple;
	bh=/cutkUyT9TzRXiISSRXINEB2viiQ8pGyNBaZSSMuOtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7BzpThZMc53Nkl4paqrxldrhZohXquoGhHZHGYdua6c3tkmmjGwztLIY2wCrcr7DKwaaX1ZK/jMT+GiYxDkcoG95vUC2IsksQg+6SSHCviszE2hKXZyJaPgLiwKLaw052DbilMjFNg0mT3zx3OyuV5CCx4TcXxM+bGZvBHXnUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiZ6AFYB; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5ce093debf6so5375974137.1
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 13:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760472796; x=1761077596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6UhijKgUcN+fj0joxI9PxxfblSymYfYP7njUr+44ck=;
        b=OiZ6AFYBDkF96gkMcaCUrONGtaq6AnWLzwyVVSv+70S0Em6YevQYwpM+zaotKk7aMI
         VfG0kvimrXAH4FnUnsFcu/bT6nXztlrzKXwlq9rRnMEtsG/AYsOh44gveD5n1ifnKSRJ
         SE7Zycz1yOGiuEbShxrZ/gvWT2QkN1Su6h2DCC+NmYJ6xYpUwdR9NzhqfDmXqXGqL4db
         /N2Ve7YijL1A03y1ltvSh5srRZfZo2RG6Z+p1H02BzwqPM+6TtQ8pRpRuFsdphbOHUew
         wHnWlJ9thLXT0o5bQh+RBKHIOrfECkUSTS0mmE8bE6+Ja4P0VxWyaa6iafUBHCqPsXd5
         Hl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760472796; x=1761077596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6UhijKgUcN+fj0joxI9PxxfblSymYfYP7njUr+44ck=;
        b=NlzculTCwuKb7iDxkZkuiJVMr6GAxV0Krz5Ydts7JtireT9m5uqIZyEBE2v3edKyId
         AFhMf7tvr6QWJv3b5SAmnsRtoD4zf/aJ/jHQR6KLdUz2SCXySltCLEZr5xzt0uJAGkYV
         MNjBr9qw6pjm0i0hED4+sx4fW33rM2cA2FR/GBvYn0PCFm8fCGw9cTcgFHmNf7JdeyFB
         W0qiNz9e/T8ZjIkPuSc7n0Pszy0J3QQoKzeIheIofXFeHfW+Xq+j3COpc+wOcMuoGCrt
         Gn77bMiKcuWQnUW7czn7c9WpnOKTVjnbMeU+7v46EFN4SMs7Zx+e5GlQ2poukqwmOKio
         Ub1g==
X-Forwarded-Encrypted: i=1; AJvYcCXFs8pnJsOiaRE7hvjzoYPDQP9aTdpJs72C/+ppWdDXllbRbdQsXo3kpgbrdNyrVB4MS/Iq/MI=@vger.kernel.org
X-Gm-Message-State: AOJu0YypIl72Eef7wM59SrQtBnEG/h8qVeCc9hgETqoLcF7G4woeUSsk
	HHaMRoZYmEeMPxd1PIGE5mpoUuxuS+tCf0foqLuTZb+2nuHeqUIj1OeB1niHby0mO3BtcM5d4lR
	BwpxaZf0x0LlL9w+StuqV+EwbSy2RJF0=
X-Gm-Gg: ASbGnct2OhxYcKl4Pp/urPr8lxXCnAWT2Sl/V/rdi28ePfWu9dqkjbBiMlnOg7H32Zj
	4WnAQ9BHH25koLLz4F7qzZ0tIaBVLYfv9dk0Z4vZ+ZIAANinTYM+T1828KRpUp1PezIIA86NEx4
	w66R+3to6esWmsqTJI7TKomPIXN1roSE/QuZNdKkoCUaicfIPBsSABYgCypr51mZweQiQiTfdea
	f6I+PbYyvabRBYOPiUDrXzqNz3Z2wlQcj9VRR+4TFu7py0UiiR9jaGQ/TI=
X-Google-Smtp-Source: AGHT+IH4K2DgTClVeZ9XiY7Y0e4sIzBbX+qBGQyiLw3YUv9MNAM6xIwxW8sgShmKrvQfr9ZnTQhHrg4oCI51vtgcC/A=
X-Received: by 2002:a05:6102:a4e:b0:528:92b8:6c3e with SMTP id
 ada2fe7eead31-5d5e21ce95amr11293034137.1.1760472795886; Tue, 14 Oct 2025
 13:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHPNGSQpXEopYreir+uDDEbtXTBvBvi8c6fYXJvceqtgTPao3Q@mail.gmail.com>
 <8aed5e69-57b1-4a01-b90c-56402eb27b37@linux.intel.com> <CAHPNGSTgahRhAg5eM=pnn45rw=TJzTz4AfeckcB2RcsPvxCeGg@mail.gmail.com>
 <ad3ef789-3f12-4107-abad-cf7b4775e38d@linux.intel.com>
In-Reply-To: <ad3ef789-3f12-4107-abad-cf7b4775e38d@linux.intel.com>
From: Octavia Togami <octavia.togami@gmail.com>
Date: Tue, 14 Oct 2025 13:13:03 -0700
X-Gm-Features: AS18NWBIAx4E_zYNl4uSTgPaysqtlF63sUqPuVdyfBWUpeSLNWk5hHfxyt-i2YI
Message-ID: <CAHPNGSTmv7qxMYOs6h1uevB4Rjiy9R+-YTt0gZ2D1tVh7-cuxQ@mail.gmail.com>
Subject: Re: [REGRESSION] bisected: perf: hang when using async-profiler
 caused by perf: Fix the POLL_HUP delivery breakage
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Octavia Togami <octavia.togami@gmail.com>, stable@vger.kernel.org, 
	regressions@lists.linux.dev, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That patch is also working fine.

On Mon, Oct 13, 2025 at 11:41=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel=
.com> wrote:
>
>
> On 10/13/2025 2:55 PM, Octavia Togami wrote:
> > That change appears to fix the problem on my end. I ran my reproducer
> > and some other tests multiple times without issue.
>
> @Octavia Thanks for checking this patch. But following Peter's comments, =
we
> need to update the fix. So could you please re-test the below changes? Th=
anks.
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7541f6f85fcb..ed236b8bbcaa 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11773,7 +11773,8 @@ static enum hrtimer_restart
> perf_swevent_hrtimer(struct hrtimer *hrtimer)
>
>         event =3D container_of(hrtimer, struct perf_event, hw.hrtimer);
>
> -       if (event->state !=3D PERF_EVENT_STATE_ACTIVE)
> +       if (event->state !=3D PERF_EVENT_STATE_ACTIVE ||
> +           event->hw.state & PERF_HES_STOPPED)
>                 return HRTIMER_NORESTART;
>
>         event->pmu->read(event);
> @@ -11827,7 +11828,7 @@ static void perf_swevent_cancel_hrtimer(struct
> perf_event *event)
>                 ktime_t remaining =3D hrtimer_get_remaining(&hwc->hrtimer=
);
>                 local64_set(&hwc->period_left, ktime_to_ns(remaining));
>
> -               hrtimer_cancel(&hwc->hrtimer);
> +               hrtimer_try_to_cancel(&hwc->hrtimer);
>         }
>  }
>
> @@ -11871,12 +11872,14 @@ static void cpu_clock_event_update(struct
> perf_event *event)
>
>  static void cpu_clock_event_start(struct perf_event *event, int flags)
>  {
> +       event->hw.state =3D 0;
>         local64_set(&event->hw.prev_count, local_clock());
>         perf_swevent_start_hrtimer(event);
>  }
>
>  static void cpu_clock_event_stop(struct perf_event *event, int flags)
>  {
> +       event->hw.state =3D PERF_HES_STOPPED;
>         perf_swevent_cancel_hrtimer(event);
>         if (flags & PERF_EF_UPDATE)
>                 cpu_clock_event_update(event);
> @@ -11950,12 +11953,14 @@ static void task_clock_event_update(struct
> perf_event *event, u64 now)
>
>  static void task_clock_event_start(struct perf_event *event, int flags)
>  {
> +       event->hw.state =3D 0;
>         local64_set(&event->hw.prev_count, event->ctx->time);
>         perf_swevent_start_hrtimer(event);
>  }
>
>  static void task_clock_event_stop(struct perf_event *event, int flags)
>  {
> +       event->hw.state =3D PERF_HES_STOPPED;
>         perf_swevent_cancel_hrtimer(event);
>         if (flags & PERF_EF_UPDATE)
>                 task_clock_event_update(event, event->ctx->time);
>
>
> >
> > On Sun, Oct 12, 2025 at 7:34=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.in=
tel.com> wrote:
> >>
> >> On 10/11/2025 4:31 PM, Octavia Togami wrote:
> >>> Using async-profiler
> >>> (https://github.com/async-profiler/async-profiler/) on Linux
> >>> 6.17.1-arch1-1 causes a complete hang of the CPU. This has been
> >>> reported by many people at https://github.com/lucko/spark/issues/530.
> >>> spark is a piece of software that uses async-profiler internally.
> >>>
> >>> As seen in https://github.com/lucko/spark/issues/530#issuecomment-333=
9974827,
> >>> this was bisected to 18dbcbfabfffc4a5d3ea10290c5ad27f22b0d240 perf:
> >>> Fix the POLL_HUP delivery breakage. Reverting this commit on 6.17.1
> >>> fixed the issue for me.
> >>>
> >>> Steps to reproduce:
> >>> 1. Get a copy of async-profiler. I tested both v3 (affects older spar=
k
> >>> versions) and v4.1 (latest at time of writing). Unarchive it, this is
> >>> <async-profiler-dir>.
> >>> 2. Set kernel parameters kernel.perf_event_paranoid=3D1 and
> >>> kernel.kptr_restrict=3D0 as instructed by
> >>> https://github.com/async-profiler/async-profiler/blob/fb673227c7fb311=
f872ce9566769b006b357ecbe/docs/GettingStarted.md
> >>> 3. Install a version of Java that comes with jshell, i.e. Java 9 or
> >>> newer. Note: jshell is used for ease of reproduction. Any Java
> >>> application that is actively running will work.
> >>> 4. Run `printf 'int acc; while (true) { acc++; }' | jshell -`. This
> >>> will start an infinitely running Java process.
> >>> 5. Run `jps` and take the PID next to the text RemoteExecutionControl
> >>> -- this is the process that was just started.
> >>> 6. Attach async-profiler to this process by running
> >>> `<async-profiler-dir>/bin/asprof -d 1 <PID>`. This will run for one
> >>> second, then the system should freeze entirely shortly thereafter.
> >>>
> >>> I triggered a sysrq crash while the system was frozen, and the output
> >>> I found in journalctl afterwards is at
> >>> https://gist.github.com/octylFractal/76611ee76060051e5efc0c898dd0949e
> >>> I'm not sure if that text is actually from the triggered crash, but i=
t
> >>> seems relevant. If needed, please tell me how to get the actual crash
> >>> report, I'm not sure where it is.
> >>>
> >>> I'm using an AMD Ryzen 9 5900X 12-Core Processor. Given that I've see=
n
> >>> no Intel reports, it may be AMD specific. I don't have an Intel CPU o=
n
> >>> hand to test with.
> >>>
> >>> /proc/version: Linux version 6.17.1-arch1-1 (linux@archlinux) (gcc
> >>> (GCC) 15.2.1 20250813, GNU ld (GNU Binutils) 2.45.0) #1 SMP
> >>> PREEMPT_DYNAMIC Mon, 06 Oct 2025 18:48:29 +0000
> >>> Operating System: Arch Linux
> >>> uname -mi: x86_64 unknown
> >> It looks the issue described in the link
> >> (https://lore.kernel.org/all/20250606192546.915765-1-kan.liang@linux.i=
ntel.com/T/#u)
> >> happens again but in a different way. :(
> >>
> >> As the commit message above link described,  cpu-clock (and task-clock=
) is
> >> a specific SW event which rely on hrtimer. The hrtimer handler calls
> >> __perf_event_overflow() and then event_stop (cpu_clock_event_stop()) a=
nd
> >> eventually call hrtimer_cancel() which traps into a dead loop which wa=
its
> >> for the calling hrtimer handler finishes.
> >>
> >> As the
> >> change (https://lore.kernel.org/all/20250606192546.915765-1-kan.liang@=
linux.intel.com/T/#u),
> >> it should be enough to just disable the event and don't need an extra =
event
> >> stop.
> >>
> >> @Octavia, could you please check if the change below can fix this issu=
e?
> >> Thanks.
> >>
> >> diff --git a/kernel/events/core.c b/kernel/events/core.c
> >> index 7541f6f85fcb..883b0e1fa5d3 100644
> >> --- a/kernel/events/core.c
> >> +++ b/kernel/events/core.c
> >> @@ -10343,7 +10343,20 @@ static int __perf_event_overflow(struct perf_=
event
> >> *event,
> >>                 ret =3D 1;
> >>                 event->pending_kill =3D POLL_HUP;
> >>                 perf_event_disable_inatomic(event);
> >> -               event->pmu->stop(event, 0);
> >> +
> >> +               /*
> >> +                * The cpu-clock and task-clock are two special SW eve=
nts,
> >> +                * which rely on the hrtimer. The __perf_event_overflo=
w()
> >> +                * is invoked from the hrtimer handler for these 2 eve=
nts.
> >> +                * Avoid to call event_stop()->hrtimer_cancel() for th=
ese
> >> +                * 2 events since hrtimer_cancel() waits for the hrtim=
er
> >> +                * handler to finish, which would trigger a deadlock.
> >> +                * Only disabling the events is enough to stop the hrt=
imer.
> >> +                * See perf_swevent_cancel_hrtimer().
> >> +                */
> >> +               if (event->attr.config !=3D PERF_COUNT_SW_CPU_CLOCK &&
> >> +                   event->attr.config !=3D PERF_COUNT_SW_TASK_CLOCK)
> >> +                       event->pmu->stop(event, 0);
> >>         }
> >>
> >>         if (event->attr.sigtrap) {
> >>
> >>

