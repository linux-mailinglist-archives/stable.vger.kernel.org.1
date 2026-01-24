Return-Path: <stable+bounces-211474-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yErwAYNXdWnYEAEAu9opvQ
	(envelope-from <stable+bounces-211474-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 00:36:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC577F468
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 00:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E60A300CFD6
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 23:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E88027A133;
	Sat, 24 Jan 2026 23:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EcXKtZh3"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE3827CB35
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 23:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769297781; cv=none; b=Rli0LLFXyUBco8ZM+ESmatIxPyneEKZetvIczfgI2CpjMHjj8eX11+dMlmnmoxj7+2AYMzhoZHBtstPJjGgJdxkWxXrhyvjWMAN5ZpV3aORS+vmQYmRHWRKwQLfvKlQj3PJBi2WOqqgzV9mPmQKxj8LhdvkP9IwQYeoezbjwoCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769297781; c=relaxed/simple;
	bh=F7IdeJxEuwyJhlT1kgnXqGZv2HwcrsfzSvPn/0f4rt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HK9gUGirVTLF2zJbswjrAXC0fGqMW1ppLvVth6bAhFmmSp75TgAHlOpz7XYortN9vxk88WJj57QOHMNSLwul5lCfhy7q7H4aXxEr7Hcf0aDdyhXzqr46aXPuzbLqAdHEgDlRjTFntScxHG7KFvQJsT7lRCSicC6rXDzqz/vmcDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EcXKtZh3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b88455e6663so490662866b.1
        for <stable@vger.kernel.org>; Sat, 24 Jan 2026 15:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769297776; x=1769902576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7IdeJxEuwyJhlT1kgnXqGZv2HwcrsfzSvPn/0f4rt4=;
        b=EcXKtZh3KjR6EEU4oJNoh35dgZ4I6tV1dad+HPwVip4LjAvCAJGtkwjgacODmCmzML
         DEZhhloPLFK1KZquIqENkz+8Pz7rhh5UGCNygvad5kZKsa8k7qg2H0bT8M4AcGAMDUYg
         DcxEz53qBEMZtDPbcFkcIttS5NqS3dajMj+X0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769297776; x=1769902576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F7IdeJxEuwyJhlT1kgnXqGZv2HwcrsfzSvPn/0f4rt4=;
        b=YqBWSJmMGZ2t0+xfHamayiFhRTwfJHJ38vq51Mk8S0wPo/NpBe7Y4fxC27AgDpzawM
         3YCsZtjJ857F1OxJ1dQtOP1kL06EDIY7es3HbfazwhC9n6TTme4O4CFp6eVI/Fi7TS70
         b14QRkMBMTiv+hmyvuVnNvv1CJ4f65l8aCA6Gn/x72m/yQ9j7EmYjFaDiVGETWu2KkLa
         b+JMbTnxocMYIsLfblEPOqkgPqSLcR+qRBhxm50kWcfmlDJB+3Due9Nn/u7if50RmKVb
         9DVMHbSRga6lHS7KtfSKneT6d/SYxDt/lBQDYllPXH8oyuV1iXhy4WR/7SYlVeyAPV0a
         +new==
X-Forwarded-Encrypted: i=1; AJvYcCU5iSDfeL9UB/UhVGRGwCUlK+cNkbLkOV5BhkCbNNRjecn/CPCQBJx+ne6I2ILTs122rJMxkTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfd2LQQdTFd2ijtMEFG60vr0jbFWslcM3qOAhu6IwPJ5RMxzMm
	fkkIWWkpu3nv0JE40VqYyvz6wWdyDxY2D2e4bgXC+0brRhOKkZGR/9g0g/klyltG1IS0xa41dCK
	CoBw0uw==
X-Gm-Gg: AZuq6aJrtBfWg07gLkP6n7Se0nZQEcf/WQzpGsq1VLhsDDUgBIX5uX914fT/5ncj5QB
	E6Rd9LBs0CMSvHB2iXi4IFLH9g+peuSmX5Y60KiP8AjXysqZ7jzfccL9ykE2YZ03Jdi57S6DFJ4
	lKo9as67aXhnCVPpD/wKyf57EFiPpzD/2wJkPKclOedKHgDb0u0dSK0+VDoHMawiLefOP2yegXb
	LkoPLchtUf1JysD+wlsdpCWvTTKnzuhCadwHNZ/9lxWCRfVsWoG6wVIiJAqlHCEVuwTo7BQ5AI3
	haGBhWG2vN72YTC9CI+qdu3wICvxXxCdFphcPe4IesP7qcx1fmf3MeBZP/SIPjYo/SCpvCWRsnA
	Lb9Yf8oDDW9KYWrVLnMg82SyLqO2PY+NZiQ6HtUQ4v2yVfvn20WuicPJ1UEV7uHTskO9OR0oK87
	oZbeg8plvWdrJ8WJqzmtcIpq62qqeTT30V6qvSUS47xHQ5qVFhmQ==
X-Received: by 2002:a17:907:7b8b:b0:b73:8d2e:2d38 with SMTP id a640c23a62f3a-b8d4f75f6b1mr6376766b.50.1769297775707;
        Sat, 24 Jan 2026 15:36:15 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b7ae986sm341721966b.57.2026.01.24.15.36.13
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jan 2026 15:36:15 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-432d2670932so3114356f8f.2
        for <stable@vger.kernel.org>; Sat, 24 Jan 2026 15:36:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFCT5rYEPoolnKD0yT2vIEeCuK07aU6xYPoFrtfl0PdEtqVM73bt2JIe8sXsiA8CAyC99fFYE=@vger.kernel.org
X-Received: by 2002:a5d:5f93:0:b0:435:982d:97ee with SMTP id
 ffacd0b85a97d-435ca1afeb0mr132288f8f.57.1769297772964; Sat, 24 Jan 2026
 15:36:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=FV=WHWrKS_LVjod6nhnPdEk9_ZqeubGpft3PJOUJNMbBxfg@mail.gmail.com>
 <20260124065719.805144-1-realwujing@gmail.com>
In-Reply-To: <20260124065719.805144-1-realwujing@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Sat, 24 Jan 2026 15:36:01 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vmk1jA+dAgJNVDMtxrhhrPxgnXkNxiqJXWBvgUcZZUxQ@mail.gmail.com>
X-Gm-Features: AZwV_QjwSccMhlpIM9-YrAxACDjpiR1Rl3L9SfoYHyhRS2AZtl7vffA2Ud_GyTI
Message-ID: <CAD=FV=Vmk1jA+dAgJNVDMtxrhhrPxgnXkNxiqJXWBvgUcZZUxQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,huawei.com,vger.kernel.org,kernel.org,chinatelecom.cn,linux.dev,gmail.com,hisilicon.com];
	TAGGED_FROM(0.00)[bounces-211474-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: AFC577F468
X-Rspamd-Action: no action

Hi,

On Fri, Jan 23, 2026 at 10:57=E2=80=AFPM Qiliang Yuan <realwujing@gmail.com=
> wrote:
>
> Thanks for the detailed review!
>
> > Wait a second... The above function hasn't existed for 2.5 years. It
> > was removed in commit d9b3629ade8e ("watchdog/hardlockup: have the
> > perf hardlockup use __weak functions more cleanly"). All that's left
> > in the ToT kernel referencing that function is an old comment...
> >
> > Oh, and I guess I can see below that your stack traces are on 4.19,
> > which is ancient! Things have changed a bit in the meantime. Are you
> > certain that the problem still reproduces on ToT?
>
> The function hardlockup_detector_perf_init() was renamed to
> watchdog_hardlockup_probe() in commit d9b3629ade8e ("watchdog/hardlockup:
> have the perf hardlockup use __weak functions more cleanly").
> Additionally, the source file was moved from kernel/watchdog_hld.c to
> kernel/watchdog_perf.c in commit 6ea0d04211a7. The v3 commit message
> inadvertently retained legacy terminology from the 4.19 kernel; this will
> be updated in V4 to reflect current ToT naming.
>
> The core logic remains the same: the race condition persists despite the
> renaming and cleanup of the __weak function logic.
>
> Regarding ToT reproducibility: while the KASAN report originated from
> 4.19, the underlying logic is still problematic in ToT. In
> watchdog_hardlockup_probe(), the call to
> hardlockup_detector_event_create() still writes to the per-cpu
> watchdog_ev. Task migration between event creation and the subsequent
> perf_event_release_kernel() leaves a stale pointer in the watchdog_ev of
> the original CPU.
>
> > Probably want a "Fixes" tag? If I had to guess, maybe?
> >
> > Fixes: 930d8f8dbab9 ("watchdog/perf: adapt the watchdog_perf interface
> > for async model")
>
> Commit 930d8f8dbab9 introduced the async initialization which allows
> preemption/migration during the probe phase. This tag will be included in
> V4.

The part that doesn't make a lot of sense to me, though, is that v4.19
also doesn't have commit 930d8f8dbab9 ("watchdog/perf: adapt the
watchdog_perf interface for async model"), which is where we are
saying the problem was introduced.

...so in v4.19 I think:
* hardlockup_detector_perf_init() is only called from watchdog_nmi_probe()
* watchdog_nmi_probe() is only called from lockup_detector_init()
* lockup_detector_init() is only called from kernel_init_freeable()
right before smp_init()

Thus I'm super confused about how you could have seen the problem on
v4.19. Maybe your v4.19 kernel has some backported patches that makes
this possible?

While I'm not saying that the v4 patch you just posted is incorrect,
I'm just trying to make sure that:

1. We actually understand the problem you were seeing.

2. We are identifying the correct "Fixes" commit.


> > I'm still a bit confused why this warning didn't trigger previously.
> > Do you know why?
>
> In 4.19, hardlockup_detector_event_create() did not include the
> WARN_ON(!is_percpu_thread()) check, which was added in later versions. In
> ToT, this warning is expected to trigger if watchdog_hardlockup_probe()
> is called from a non-per-cpu-bound thread (such as kernel_init). This
> further justifies refactoring the creation logic to be CPU-agnostic for
> probing.

OK, fair enough. ...but I'm a bit curious why nobody else saw this
WARN_ON(). I'm also curious if you have tested the hardlockup detector
on newer kernels, or if all of your work has been done on 4.19. If all
your work has been done on 4.19, do we need to find someone to test
your patch on a newer kernel and make sure it works OK? If you've
tested on a newer kernel, did the hardlockup detector init from the
kernel's early-init code, or the retry code?

-Doug

