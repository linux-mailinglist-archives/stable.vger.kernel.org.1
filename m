Return-Path: <stable+bounces-181793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C91EBA501E
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 21:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98673255E3
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 19:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0637280308;
	Fri, 26 Sep 2025 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TsVVJRBb"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93ED2222C2
	for <stable@vger.kernel.org>; Fri, 26 Sep 2025 19:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758916484; cv=none; b=dt4MBbdUUvfjyA8DWAIv2RoA4JX1NCzMGiiaCViYhlXwYZua8V94tT+uhhHijrLrzhg91nKJ+0ct3u5jMFnaOmzQTXm8d/56ssihoUGS+0djI86s2yv0WmYOr52j9H/2rd5cKE1SMa2qwgLaYYcOqNT0uDZJ4F2sNSmqPdZuCdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758916484; c=relaxed/simple;
	bh=U1S6qVc8zFJzoJotfzJqFzUNbTwzB+Ke9Kbshsqdjck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnbkOxwbjF7EaRZcfRFMWINAT/3jjJYv7ko8zITRT7IZq+Z2/wKwSRyLwd1aralClJr/3VwBrCI2ZaQdZHtWt4GAqgCkuqrR5jwFT7DyITzcgMSwS+jzthwJ+pzrIpmGITDpPFB8uANmI7mj6r9fKObMOoUniLMFhf7mmNTVzuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TsVVJRBb; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57bf9bb803dso182e87.1
        for <stable@vger.kernel.org>; Fri, 26 Sep 2025 12:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758916481; x=1759521281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1S6qVc8zFJzoJotfzJqFzUNbTwzB+Ke9Kbshsqdjck=;
        b=TsVVJRBbe4icgkUgYTMfZUOIXu4Hb0MUEmEhydaJYwH3mRW3XfNIFkSIbBs5ZdI589
         8cvoMB5g44Kl05Up+LHuj/Bh5dKvbLbN6b453HZDrUXyFFzhQmGip64Z1pX8W03gtv8+
         BNtusS8FqYXqH7sUqs6rxhRAKoVODdP4GHGbcay0NuHsW1d2q9Cxxt5sRyydSHu5I0Lb
         DlIusM1KGmnZB4v2murMlSwB5h3GibPViAvdqkwMrxaFJc+R0R1DKS7nKYCq6DfTOLW8
         CV8cBn8t5mgs6vCciMQL2gSSYdWuvEkKOKMT2+1bTEeDKwuE049d8e26Zvh8zHVpkhtx
         W3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758916481; x=1759521281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1S6qVc8zFJzoJotfzJqFzUNbTwzB+Ke9Kbshsqdjck=;
        b=Z5yLWS9becXuBJ2OJm9ZpMQ/mrQ7gLhHaTjLAqXR06ICemp0etN9UWrGk13IA2W7SH
         vMnHS5UXcIYh4ALcLR7i53z74ioUQ55ideIJbe/R1r+an6gUMyf+a2WJgn4aQPwM95YK
         iOcfy4EEFqQdEGzVzqBh1244xrqHznfy7JrOAr4AQbzPIN9wRru4yj/rAGk6L9Qqumwa
         1QsyzFE1NnxfajYeUmIL0hMu6Y2OyzzvA7J4rW5TxnhNS8mNXS3rPvBSujgffUP938Ej
         5z1cE6N7eSYa6IoHPFIaEmnupyJK+V4Rj/yQEcjoMoYXUHv2MjFPHF9PCZxxaKQRE7bf
         0/KA==
X-Gm-Message-State: AOJu0YxBlBiAVmZRlQEhhNgB0UEsmNOZoCTrE6qyDZgDNuWvCL4rG3vI
	RGkjFxFDQF6dsji0+xNOiA45J6ysqbHNOIjy/VSwFYXUE1wd33XGS/KsdJRoLam89ZDguS3Zili
	aJaoTXS8WAi+e9vH1eHL6E+uw6U3txg/LfyZV5WMpN4/PRuI+Uh87Ub23lWRLhQspLds=
X-Gm-Gg: ASbGncsQGituayqVEHO4XgWAW+cdMaTd/EraNc8kHcB++T0xVon9+zlHC/w9PQY40fY
	hl4zmbi4pWVZ7s5uxgb7ZSTUICWFqOFWUTntPbdcydErilCGc8g62J+/wTdcqCpdaQTXiJuFIhN
	Shke0etbz8/ZWrSgmNRt/I3rToAW5g9iMb2JV4+U8KtgR2Tf96bpuEdZ1s0bzpRDrmbDwLH3P9w
	Dhi2OvuOLN45IARXRpPOwLM
X-Google-Smtp-Source: AGHT+IF9p/Vk9hBagqlH0ejW1INRFKq9VFCCHdEBxMHhLNqOc29Rt7OYge24foh+THkGfa5X+tEs//zmFLcC0ULmHb8=
X-Received: by 2002:a05:6512:4c7:b0:55f:6aa7:c20 with SMTP id
 2adb3069b0e04-584326d10c5mr428290e87.2.1758916480268; Fri, 26 Sep 2025
 12:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOdxtTYQye1Rtp-sG48Re+_ihD637NDXTG_V_uLkerg=m1Nbtw@mail.gmail.com>
In-Reply-To: <CAOdxtTYQye1Rtp-sG48Re+_ihD637NDXTG_V_uLkerg=m1Nbtw@mail.gmail.com>
From: Chenglong Tang <chenglongtang@google.com>
Date: Fri, 26 Sep 2025 12:54:29 -0700
X-Gm-Features: AS18NWAn31xRvapqJUiXH-hfN9tbWp6MkQfkrW8U3FsmNfI4-_A_-vBbYm2-64Q
Message-ID: <CAOdxtTYKrMhjW9JiOCDBia+s=2tob1HF6yfAytYnajYsSoX5Kg@mail.gmail.com>
Subject: Re: [REGRESSION] workqueue/writeback: Severe CPU hang due to kworker
 proliferation during I/O flush and cgroup cleanup
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, tj@kernel.org, roman.gushchin@linux.dev, 
	linux-mm@kvack.org, lakitu-dev@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just did more testing here. Confirmed that the system hang's still
there but less frequently(6/40) with the patches
http://lkml.kernel.org/r/20250912103522.2935-1-jack@suse.cz appied to
v6.17-rc7. In the bad instances, the kworker count climbed to over
600+ and caused the hang over 80+ seconds.

So I think the patches didn't fully solve the issue.

On Wed, Sep 24, 2025 at 5:29=E2=80=AFPM Chenglong Tang <chenglongtang@googl=
e.com> wrote:
>
> Hello,
>
> This is Chenglong from Google Container Optimized OS. I'm reporting a
> severe CPU hang regression that occurs after a high volume of file
> creation and subsequent cgroup cleanup.
>
> Through bisection, the issue appears to be caused by a chain reaction
> between three commits related to writeback, unbound workqueues, and
> CPU-hogging detection. The issue is greatly alleviated on the latest
> mainline kernel but is not fully resolved, still occurring
> intermittently (~1 in 10 runs).
>
> How to reproduce
>
> The kernel v6.1 is good. The hang is reliably triggered(over 80%
> chance) on kernels v6.6 and 6.12 and intermittently on
> mainline(6.17-rc7) with the following steps:
>
> Environment: A machine with a fast SSD and a high core count (e.g.,
> Google Cloud's N2-standard-128).
>
> Workload: Concurrently generate a large number of files (e.g., 2
> million) using multiple services managed by systemd-run. This creates
> significant I/O and cgroup churn.
>
> Trigger: After the file generation completes, terminate the
> systemd-run services.
>
> Result: Shortly after the services are killed, the system's CPU load
> spikes, leading to a massive number of kworker/+inode_switch_wbs
> threads and a system-wide hang/livelock where the machine becomes
> unresponsive (20s - 300s).
>
> Analysis and Problematic Commits
>
> 1. The initial commit: The process begins with a worker that can get
> stuck busy-waiting on a spinlock.
>
> Commit: ("writeback, cgroup: release dying cgwbs by switching attached in=
odes")
>
> Effect: This introduced the inode_switch_wbs_work_fn worker to clean
> up cgroup writeback structures. Under our test load, this worker
> appears to hit a highly contended wb->list_lock spinlock, causing it
> to burn 100% CPU without sleeping.
>
> 2. The Kworker Explosion: A subsequent change misinterprets the
> spinning worker from Stage 1, leading to a runaway feedback loop of
> worker creation.
>
> Commit: 616db8779b1e ("workqueue: Automatically mark CPU-hogging work
> items CPU_INTENSIVE")
>
> Effect: This logic sees the spinning worker, marks it as
> CPU_INTENSIVE, and excludes it from concurrency management. To handle
> the work backlog, it spawns a new kworker, which then also gets stuck
> on the same lock, repeating the cycle. This directly causes the
> kworker count to explode from <50 to 100-2000+.
>
> 3. The System-Wide Lockdown: The final piece allows this localized
> worker explosion to saturate the entire system.
>
> Commit: 8639ecebc9b1 ("workqueue: Implement non-strict affinity scope
> for unbound workqueues")
>
> Effect: This change introduced non-strict affinity as the default. It
> allows the hundreds of kworkers created in Stage 2 to be spread by the
> scheduler across all available CPU cores, turning the problem into a
> system-wide hang.
>
> Current Status and Mitigation
>
> Mainline Status: On the latest mainline kernel, the hang is far less
> frequent and the kworker counts are reduced back to normal (<50),
> suggesting other changes have partially mitigated the issue. However,
> the hang still occurs, and when it does, the kworker count still
> explodes (e.g., 300+), indicating the underlying feedback loop
> remains.
>
> Workaround: A reliable mitigation is to revert to the old workqueue
> behavior by setting affinity_strict to 1. This contains the kworker
> proliferation to a single CPU pod, preventing the system-wide hang.
>
> Questions
>
> Given that the issue is not fully resolved, could you please provide
> some guidance?
>
> 1. Is this a known issue, and are there patches in development that
> might fully address the underlying spinlock contention or the kworker
> feedback loop?
>
> 2. Is there a better long-term mitigation we can apply other than
> forcing strict affinity?
>
> Thank you for your time and help.
>
> Best regards,
>
> Chenglong

