Return-Path: <stable+bounces-211895-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG47CjIweWlovwEAu9opvQ
	(envelope-from <stable+bounces-211895-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 22:37:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 863139ABFD
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 22:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 570473023DBF
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 21:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53969284884;
	Tue, 27 Jan 2026 21:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MDa8iGtn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BEB285C9F
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769549868; cv=none; b=M+Q9I8SbmMYbx7gq4Lz0qX47xiyWr8MsJ3TybA8EhrBkWyI+dQDll82K/q5wWfT8fkLWsQjotSH0PoqntE+8Aw91mzKKpp33DFaO7S6y2muochDkHGrgpAevJMzQw09kfHxbAnTdmcGeOLsQWGmZv85aAbfZgl9C8k+QLATlBa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769549868; c=relaxed/simple;
	bh=k24rl2pwV9S8wdx5Q4EogcGa3+wRhwsfuFNfVIXD2zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JsMUqt1pkgJGbO46d4aBrE43hlEM+9HqT5fZYL93dtZLjRKbQ5GmLuchgIwB0+8gvcN+XxOqS+voNrFsj4oHjDHMwxouHUQc+B4Qk1KCho70ZEJ8cOPPZySqTIzRp7Z6LBbc++GMp5TgVdy/zcApvY31bDBhN0olRj2r5xgnHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MDa8iGtn; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65378ba2ff7so9273692a12.2
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 13:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769549862; x=1770154662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxlQ2VzYf/wW3fAaLmPPug/KF1BdVRcmQSMFTpedgt8=;
        b=MDa8iGtn+BFB5NWhX5JY9J4tHEGcIcWD8pjpYgikefJ7lFYRFsWzvxCDwEUfHKL9UB
         kGf2qqitQ6hYcQ88RU/qNClUT5fF5/5P2YwnDDbFluqEqINecC3GnwxST5u5q2UJ0Q7z
         wl9huOTUJLTaulEWuj7SdgKR3K6KEQbg3j8Bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769549862; x=1770154662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RxlQ2VzYf/wW3fAaLmPPug/KF1BdVRcmQSMFTpedgt8=;
        b=U53ct8j17qYwoSLA076OfCnp/uSu7cmVRRsot/XntHk8XQzWQBJoFV+iVykBCX5un9
         yAGTkCDx5tiC4fLt6lwVe3eQGfeFsKirZ/RfQXZm7DD2y0R3r8HlPD25rYLdenJ3bvKR
         XKYIObijWgPwOnWm5USq1WDxDFCGn81p5gQzqR8VGl5Nfbva9mgJHAehYc8idniBc0EH
         bsJk8TFF1HEzFoo3RJwwzA8j1CMFGn+b6btGP9AthMgx8lSCIcDKvzekV11D0ckWMuQW
         k89LuApseRKNqkvw1+mCiM+K7ktnxh5+Kezks735CLIw+suopf4gLSQahBsfPNqPsaeq
         7Owg==
X-Forwarded-Encrypted: i=1; AJvYcCVi7Uz2Zx3V1OqLjV+Y/vrM+h961jeT6+LoIRi7zlZLJSLOkc1tRqAr4XDvMkk07bxG2KCxfZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbo1U43TH5DBSZ3i7FmXS0To7RLWXkeLSksu9GoaP1mmx0flX9
	uFBbwIHzVHSdIUhtxX6Jl1LAdUu8HzcTr5kdFuC8pygkMY3YThg/YJlaiqYONq1ymJKSx+5DX6I
	BX3FVJa6/
X-Gm-Gg: AZuq6aLlxo8e/xR6601ieBnkkpoWPmpUoVTdpUwd/7qD9VmN5ZKPphoukS1+aEjn9c7
	2WEiQvT1yz/wGnvd+Ise7O7bZnztqFd0BmQjFzXVQnrgdX8JxEGwsbS0i3jBFcWi9uO7VCLUlaZ
	7F37RfUbjxN+gRgtCOUqn70L6i0RNasyCpZhA3x/zPgBjo1fpjxk/2sQErOSbjdsOL+hLvEt1Fi
	lOP5Xkz2milsri7OLCqj9KlwvyArZZ6f0Cubot0D/Eg/Uo00ip4t336jzPaMYPC3s+3gOxjQNp4
	pgDcTTlUciczt3Q5GbywOOJeb63f6LkYteP1xewnmz6pWSO6SrD2UoYBxqOzkiwFCJhOnR+adfE
	V6UfqJ0V8PYPDFX7mQKAkqIyCziJ26/BE97J9pMG3gPp9R6N0W8yDtTbzwjAip8n6w1LiHWGxNm
	U7tZtneSid4iMHCQuirGM37a0DFiT5pdSR0FqgcZPMh5RPxqQtTQ==
X-Received: by 2002:a17:907:3e8d:b0:b87:7485:b4bf with SMTP id a640c23a62f3a-b8daae2888dmr215792266b.0.1769549862270;
        Tue, 27 Jan 2026 13:37:42 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf1c02c5sm33990866b.50.2026.01.27.13.37.40
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 13:37:40 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4801bc32725so47810005e9.0
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 13:37:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRwpGqM0U7DIoF8P15tINriM3YWNWr8xeiD2Ub6jeaDTUSjM3ICmwQF+aT0oG77DrMqpUYM9I=@vger.kernel.org
X-Received: by 2002:a05:600c:4fd4:b0:47e:e807:a05a with SMTP id
 5b1f17b1804b1-48069c98d9fmr34891525e9.33.1769549859984; Tue, 27 Jan 2026
 13:37:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=FV=WVtFAPZ3=6pPnOV=vbMhFwfH9LaZ5oNgAKtcj5hA0q2Q@mail.gmail.com>
 <20260127021711.1180952-1-realwujing@gmail.com>
In-Reply-To: <20260127021711.1180952-1-realwujing@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 27 Jan 2026 13:37:28 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U6sM71UuPbYZRWV87=p1ZO8-gpv3yzK8eMEv3dRNVgdA@mail.gmail.com>
X-Gm-Features: AZwV_QiU8gpalCQDsUTyyF4ZWe7CLPzTE1Lpz8wLHzb0knYx6-2dFCpdGvU65rM
Message-ID: <CAD=FV=U6sM71UuPbYZRWV87=p1ZO8-gpv3yzK8eMEv3dRNVgdA@mail.gmail.com>
Subject: Re: [PATCH v4] watchdog/hardlockup: Fix UAF in perf event cleanup due
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
	TAGGED_FROM(0.00)[bounces-211895-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 863139ABFD
X-Rspamd-Action: no action

Hi,

On Mon, Jan 26, 2026 at 6:17=E2=80=AFPM Qiliang Yuan <realwujing@gmail.com>=
 wrote:
>
> Hi Doug,
>
> Thanks for your insightful follow-up! It's great to have the openEuler vs=
. Mainline
> timing differences clarified=E2=80=94it definitely explains why we hit th=
is so reliably
> in our downstream environment.
>
> On Mon, Jan 26, 2026 at 5:14 PM Doug Anderson <dianders@chromium.org> wro=
te:
> > OK, so I think the answer is: you haven't actually seen the problem
> > (or the WARN_ON) on a mainline kernel, only on the openEuler 4.19
> > kernel...
> >
> > ...actually, I looked and now think the problem doesn't exist on a
> > mainline kernel. Specificaly, when we run lockup_detector_retry_init()
> > we call schedule_work() to do the work. That schedules work on the
> > "system_percpu_wq". While the work ends up being queued with
> > "WORK_CPU_UNBOUND", I believe that we still end up running on a thread
> > that's bound to just one CPU in the end. This is presumably why
> > nobody has reported that "WARN_ON(!is_percpu_thread())" actually
> > hitting on mainline.
>
> You are right that in the latest mainline, schedule_work() has been updat=
ed
> to use 'system_percpu_wq'. However, in many LTS kernels (including 4.19),
> schedule_work() still submits to 'system_wq', which lacks the per-cpu
> guarantee.

Really, it matters what schedule_work() does on anyone who happens to
have commit 930d8f8dbab9 ("watchdog/perf: adapt the watchdog_perf
interface for async model")... While I can sympathize with supporting
older kernels and doing backports, we have to focus on supporting the
mainline kernel here. If we're claiming that we're fixing a bug (and
even your newest CL says it's fixing a UAF and has a Fixes tag) then
the bug has to actually be there.


> More importantly, even on 'system_percpu_wq', the worker threads do not
> carry the PF_PERCPU_THREAD flag. is_percpu_thread() specifically checks
> (current->flags & PF_PERCPU_THREAD), which is reserved for kthreads
> specifically pinned via kthread_create_on_cpu().

I think we need to keep the focus on mainline or at least the kernel
as of commit 930d8f8dbab9. The grep for "PF_PERCPU_THREAD" has no hits
in either. In both cases, it is:

return (current->flags & PF_NO_SETAFFINITY) &&
    (current->nr_cpus_allowed  =3D=3D 1);


> Therefore, the
> WARN_ON(!is_percpu_thread()) in hardlockup_detector_event_create() is
> still violated in the retry path even on mainline.

To ask directly: have you seen this WARN_ON in mainline, or is this
all speculative?

I'm going to assert that the WARN_ON is _not_ seen on mainline and
wasn't there as of commit 930d8f8dbab9. Specifically, the same set of
patches that added the "retry" for the hardlockup detector had the
WARN_ON(). It feels highly unlikely the WARN_ON was firing at that
point in time. You can see the whole series of patches at:

https://lore.kernel.org/linux-arm-kernel/20220903093415.15850-1-lecopzer.ch=
en@mediatek.com/

...yes, I ended up rebasing them and included them when I landed the
buddy lockup detector where they landed, but they should have been
equivalent to Lecopzer's patches.


> The UAF risk stems from the fact that preemption is enabled during the
> probe. If the worker thread (even if on a per-cpu wq) is preempted or
> if the logic assumes the task cannot migrate (which is_percpu_thread
> usually guarantees), we have a logical gap. By making the probe path
> stateless and using cpu_hotplug_disable(), we eliminate this dependency
> entirely.
>
> > If that's the case, we'd definitely want to at least change the
> > description and presumably _remove_ the Fixes tag? I actually still
> > think the code looks nicer after your CL and (maybe?) we could even
> > remove the whole schedule_work() for running this code? Maybe it was
> > only added to deal with this exact problem? ...but the CL description
> > would definitely need to be updated.
>
> The schedule_work() in lockup_detector_retry_init() (added by 930d8f8dbab=
9)
> is necessary for platforms where the PMU or other dependencies aren't rea=
dy
> during early init.
>
> I agree that the commit description should be updated to clarify that
> while the issue was caught in a downstream kernel with shifted init timin=
gs,
> it identifies a latent race condition in the mainline retry path.
>
> Regarding the 'Fixes' tag, since 930d8f8dbab9 introduced the asynchronous
> retry path which calls the probe logic from a non-percpu-thread context,
> it still seems like the appropriate target for the "root cause" of the
> vulnerability.
>
> I'll refactor the commit message in V5 to better reflect this context
> and remove the emphasis on ToT being "broken" out-of-the-box (since early
> init is indeed safe there).
>
> How does that sound to you?

I'm still not convinced that there was ever a UAF in mainline nor that
this actually "Fixes" anything in mainline. I do agree that the code
is better by not having it write the per-cpu variable at probe time,
but unless you can say that you've actually tested _on mainline_ and
demonstrated that the WARN_ON() is truly hitting _on mainline_ by
providing a printout of it happening _on mainline_ or somehow shown
the UAF actually happening _on mainline_ then we simply can't claim
that this is a Fix. Although I supposed I'd also be OK with doing any
of the above on any pure upstream kernel after commit 930d8f8dbab9, as
well.

-Doug

