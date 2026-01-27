Return-Path: <stable+bounces-211696-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vDdKNaMReGn7ngEAu9opvQ
	(envelope-from <stable+bounces-211696-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 02:15:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0578EA3A
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 02:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64EF33021584
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 01:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D412233723;
	Tue, 27 Jan 2026 01:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LyhmGZ1S"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281042356A4
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 01:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769476512; cv=none; b=llQNaPp5sVSciWrwiZURzzwgPOjk2w6hIBVqBuS9kx+1wgcozSXC/WYnkisyL+430FKihpEmxqX9SKLtvFsS50lVsmqJmczoVdUCII7jMw7XGIULToCzcawjRP+iLFuAlwSllXLcSvYH0m7uyi/brd41GLdzCpXB8AYSO0YIJ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769476512; c=relaxed/simple;
	bh=4hWe/ZeM0/dp3df6siLGhiMwgMH8EDIhO8UEJze1og4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPkHfPnpWUoXsrCaLaLiBuj9FMsLWU3aMPh1EBajvJoNWcSgkuXaah7stfuMfKa77AJuQ2nMfU+EYkfLIxNSbBG2tqCPjhvmhTy9LBt+Jdz8EbRLIge7H2YGs383omP8n0NJ9Jantrd390Fg895lFfSDPBokAqSdUQKnKO8juwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LyhmGZ1S; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so9877562a12.0
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 17:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769476507; x=1770081307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0WNey5zwe01UB/P+i2RgBgqNj6Zk0tMin0y60LW9DU=;
        b=LyhmGZ1SjaKcXkdPeUy3t1G4mJ6tqe2tqKiv8Ka2YmsY0n/qEtOfQu3u3atQfqJ4FY
         eb065r52Ndvk156jmTru4PZrfLZ7yGcRzCJFbigSe/JdrFDKMBTvPirZRtLp949yhoo6
         M2d+TU2u4FooR7tvfJDdnfWcFoWfoR/caZBDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769476507; x=1770081307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V0WNey5zwe01UB/P+i2RgBgqNj6Zk0tMin0y60LW9DU=;
        b=YfxICJvCyMDnhsi5M/nqd8FQnUW3TyexEGEP38vdQeO/U02EcLqDCATn/SnF7NbCpK
         0dyZLePSp8b/NVocHRyy55kmB16zQ5G2AJcC9ZCWXuRUJowkdIsTDbf7GYvn0LxJranH
         J3qdkypgkp9ADGOy4hFm4yvtv0Yxe8IF4Mt70ol20VmiFqNKvWEXyfjXU9HYsHAPiAyB
         Ft9GSuZTzfFkFVmbTNR2CZ2B4lpnOgESa5hi3Vyn+HJ07kkiVfsVI32vpVvDIlFecFLq
         /tWkyUyf5FrKH67eTNATeE0HvQmfHQNlYHvQIXXfyLOBWHJWRwqM+Cm7M6HpjP+MCG8u
         3PCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXhG6yDehcjGq5BpCwK8g7km44l8EZFrFtwfP2ZRxDDeHsklrRtOTAlrF8E4n1wlxrQVJ0E84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM3uPORbg717dTeh7x/xjdIrD2fgqrIdC2EppJTWiu/xjKUmIb
	1vgpawtDoQtz2bY/+kK6eB6z701XWcAVDJC7M4UHs6ZVteW0/sag/Ll7AumFMU+Gr3AohfInH0L
	Tpzj3mA==
X-Gm-Gg: AZuq6aKq1dEs4+rfT3u0Vg+sDgZenMFkYkZt40xRyBeLlsZ3tPNGnUJ73OGcN6N9q6g
	OmASTNxknW3LtVr8JxrJ1pZbphr/zbLuz4xDfWGeVCehrF1Vtaw8mutIcbi33x7T4FhzsP0ah10
	whh9y6EU1J0VoZ7CkaLcOIW2Zroq7PdFvgqjMlNojtvL6jB3gjy5AtjtmEsLqsNGMbpYEcc02bC
	BL6lVxJsS9CyLB3eJhSaXJv5FGMZZfbsu06g5mbpDKL9G/jqhl8oWR4d2wL0xr+JSS+KfV+J7Kq
	p5HCMc9w2B9zRsdCeoUu/8XkRJlSqcdl1t2Pvc1BLAOVt/E7VH3oT3klc/sSVgU+bUyMNMn4i7q
	FJrUD/J3FjlKEdzPiKwye+V0kb8hDvaKO0mYSFIL1Cxsi1ElW795lgY6WhhJ3LQYSOtJaCy1XBR
	RBJ76922Z+IQU+zVwZiMUrLMvqcoXh0cAaL/fGTwCbD7Avd8eESw==
X-Received: by 2002:a17:907:6d19:b0:b87:2882:bf7e with SMTP id a640c23a62f3a-b8ceed95ademr439295466b.11.1769476507003;
        Mon, 26 Jan 2026 17:15:07 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b6fc4aasm718862366b.36.2026.01.26.17.15.05
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 17:15:05 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4359249bbacso3891061f8f.0
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 17:15:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWxBZRzS3COom1q4U92E5ytV1GBF+nozALr8lavenKFBx7JeCWE+VjUfu6/M4EvOxaiJQFfeHQ=@vger.kernel.org
X-Received: by 2002:a5d:64e9:0:b0:430:2773:84d6 with SMTP id
 ffacd0b85a97d-435c9d1a409mr9683879f8f.24.1769476505162; Mon, 26 Jan 2026
 17:15:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=FV=Vmk1jA+dAgJNVDMtxrhhrPxgnXkNxiqJXWBvgUcZZUxQ@mail.gmail.com>
 <20260126033012.934143-1-realwujing@gmail.com>
In-Reply-To: <20260126033012.934143-1-realwujing@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 26 Jan 2026 17:14:53 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WVtFAPZ3=6pPnOV=vbMhFwfH9LaZ5oNgAKtcj5hA0q2Q@mail.gmail.com>
X-Gm-Features: AZwV_QjgByfA3hEAUN30WElxUvkskpDfD8rbwB8NvDK5sJAq06ev73kRykPD3JE
Message-ID: <CAD=FV=WVtFAPZ3=6pPnOV=vbMhFwfH9LaZ5oNgAKtcj5hA0q2Q@mail.gmail.com>
Subject: Re: [PATCH v3] watchdog/hardlockup: Fix UAF in perf event cleanup due
 to migration race
To: Qiliang Yuan <realwujing@gmail.com>
Cc: akpm@linux-foundation.org, lihuafei1@huawei.com, 
	linux-kernel@vger.kernel.org, mingo@kernel.org, mm-commits@vger.kernel.org, 
	song@kernel.org, stable@vger.kernel.org, sunshx@chinatelecom.cn, 
	thorsten.blum@linux.dev, wangjinchao600@gmail.com, yangyicong@hisilicon.com, 
	yuanql9@chinatelecom.cn, zhangjn11@chinatelecom.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,huawei.com,vger.kernel.org,kernel.org,chinatelecom.cn,linux.dev,gmail.com,hisilicon.com];
	TAGGED_FROM(0.00)[bounces-211696-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[chromium.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chromium.org:email,chromium.org:dkim]
X-Rspamd-Queue-Id: 3F0578EA3A
X-Rspamd-Action: no action

Hi,

On Sun, Jan 25, 2026 at 7:30=E2=80=AFPM Qiliang Yuan <realwujing@gmail.com>=
 wrote:
>
> Hi Doug,
>
> Thanks for your further questions and for digging into the 4.19 vs ToT
> differences.
>
> On Sat, 24 Jan 2026 15:36:01 Doug Anderson <dianders@chromium.org> wrote:
> > The part that doesn't make a lot of sense to me, though, is that v4.19
> > also doesn't have commit 930d8f8dbab9 ("watchdog/perf: adapt the
> > watchdog_perf interface for async model"), which is where we are
> > saying the problem was introduced.
> >
> > ...so in v4.19 I think:
> > * hardlockup_detector_perf_init() is only called from watchdog_nmi_prob=
e()
> > * watchdog_nmi_probe() is only called from lockup_detector_init()
> > * lockup_detector_init() is only called from kernel_init_freeable()
> > right before smp_init()
> >
> > Thus I'm super confused about how you could have seen the problem on
> > v4.19. Maybe your v4.19 kernel has some backported patches that makes
> > this possible?
>
> You caught it! Here is the context for the differences:
>
> 1. Mainline (ToT):
>    - `lockup_detector_init()` is always called before `smp_init()`
>      (pre-SMP phase).
>    - Risk source: The asynchronous retry path (`lockup_detector_delay_ini=
t`)
>      introduced by 930d8f8dbab9, which runs in a workqueue (post-SMP)
>      context and triggers the UAF.
>
> 2. openEuler (4.19/5.10):
>    - Local `euler inclusion` patches moved `lockup_detector_init()` after
>      `do_basic_setup()` (post-SMP phase).
>    - Risk source: The initial probe occurs directly in a post-SMP
>      environment, exposing the race condition.
>
> For openEuler (4.19/5.10) kernel, the call stack looks like this:
>   kernel_init()
>   -> kernel_init_freeable()
>     -> lockup_detector_init()       <-- Called after smp_init()
>       -> watchdog_nmi_probe()
>         -> hardlockup_detector_perf_init()
>           -> hardlockup_detector_event_create()
>
> In mainline (ToT), the initial probe (safe) call stack is:
>   kernel_init()
>   -> kernel_init_freeable()
>     -> lockup_detector_init()       <-- Called before smp_init()
>       -> watchdog_hardlockup_probe()
>         -> hardlockup_detector_event_create()
>
> However, the asynchronous retry mechanism (commit 930d8f8dbab9) executes =
the
> probe logic in a post-SMP, preemptible context.
>
> For the mainline (ToT) retry path (at risk), the call stack is:
>   kworker thread
>   -> process_one_work()
>     -> lockup_detector_delay_init()
>       -> watchdog_hardlockup_probe()
>         -> hardlockup_detector_event_create()
>
> Thus, `930d8f8dbab9` remains the correct "Fixes" target for ToT.

OK, at least I'm not crazy! That does indeed explain why things seemed
so wonky...


> > OK, fair enough. ...but I'm a bit curious why nobody else saw this
> > WARN_ON(). I'm also curious if you have tested the hardlockup detector
> > on newer kernels, or if all of your work has been done on 4.19. If all
> > your work has been done on 4.19, do we need to find someone to test
> > your patch on a newer kernel and make sure it works OK? If you've
> > tested on a newer kernel, did the hardlockup detector init from the
> > kernel's early-init code, or the retry code?
>
> In newer kernels, when the probe fails initially and falls
> back to the retry workqueue (or even during early init if preemption is
> enabled), the `WARN_ON(!is_percpu_thread())` in
> `hardlockup_detector_event_create()` does indeed trigger because
> `watchdog_hardlockup_probe()` is called from a non-bound context.
>
> I have verified this patch on the openEuler 4.19 kernel. During our stres=
s
> testing, where we start dozens of VMs simultaneously to create high resou=
rce
> contention, the UAF was consistently reproducible without this fix and is=
 now
> confirmed resolved.
>
> The v4 patch addresses this by refactoring the creation logic to be state=
less
> and adding `cpu_hotplug_disable()` to ensure the probed CPU stays alive.

OK, so I think the answer is: you haven't actually seen the problem
(or the WARN_ON) on a mainline kernel, only on the openEuler 4.19
kernel...

...actually, I looked and now think the problem doesn't exist on a
mainline kernel. Specificaly, when we run lockup_detector_retry_init()
we call schedule_work() to do the work. That schedules work on the
"system_percpu_wq". While the work ends up being queued with
"WORK_CPU_UNBOUND", I believe that we still end up running on a thread
that's bound to just one CPU in the end.  This is presumably why
nobody has reported that "WARN_ON(!is_percpu_thread())" actually
hitting on mainline.

Given the above, it sounds to me like the problem you're having is
with a downstream kernel and upstream is actually fine. Did I
understand that correctly?

If that's the case, we'd definitely want to at least change the
description and presumably _remove_ the Fixes tag? I actually still
think the code looks nicer after your CL and (maybe?) we could even
remove the whole schedule_work() for running this code? Maybe it was
only added to deal with this exact problem? ...but the CL description
would definitely need to be updated.


> I'll wait for your further thoughts on v4:
> https://lore.kernel.org/all/20260124070814.806828-1-realwujing@gmail.com/

Sure. In the very least the CL description would need to be updated
(assuming my understanding is correct), but for now let's avoid
forking the conversation and resolve things here?

-Doug

