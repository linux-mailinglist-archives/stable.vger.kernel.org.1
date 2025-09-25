Return-Path: <stable+bounces-181662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DFDB9CE55
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 02:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 404C44E178B
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 00:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE27B27E054;
	Thu, 25 Sep 2025 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KVYm0K63"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DF3849C
	for <stable@vger.kernel.org>; Thu, 25 Sep 2025 00:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758760186; cv=none; b=du2PKNF3EUhxTiauPat99yD44Xx6ZFy2oeRRi7syPzK1KNdEo6ocD3Y9iNljsobxvMG+hdwSeao4RSWbfP4WTEQ4BgxpvkwtkgiC3gfCDJZFUnF6m3bHDQtyCJxez/hQnhtKCxO+pAIV9zL6D6t+ntfbtwiys9Z5QMTM4szkmXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758760186; c=relaxed/simple;
	bh=rGrJhkEhVL8fDzcbwtX0Nlx0/Ial1/o06KA95F1aKyE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=j9uuZc5vt5Wcde3wwy9QHUIPW90ynafBnyB1vlh+kFhFDdzI55vvtJDfEVgQ4DUrRBg2gXRoUqp4mHBPLXIytaLE9P4u1HxV9ztuY7CARQNYVybppG/dQX5amSJcdr4PMzEy2K/yrDdu0swexKpT8moSdOeLTMx5eZvGCu89gh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KVYm0K63; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57d97bac755so12377e87.0
        for <stable@vger.kernel.org>; Wed, 24 Sep 2025 17:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758760183; x=1759364983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rGrJhkEhVL8fDzcbwtX0Nlx0/Ial1/o06KA95F1aKyE=;
        b=KVYm0K63p0Y8NY1jkR20LfJx7/NJEz1PKubhytlDzeJANIb5ff9IFnY2Q+bPTBXICU
         ho2fPXdCWBCjllzzdUwAzwVkk5biKrjyLXum3Wqectr4pj5hH+XHUWvQ2lwN17ugyFNY
         lONtSqeI4YsM1vnxaFlgp9x/XN3gY1Au3sdOXWlrQi2JqQPtWWh+Bnb5diA4Tvzcoj6Y
         zRkZYP+1BkC8DDIUdOHEAyZXdOolaTpaopCb7Df+esiqNhowSSIUbvRBHY6UMHNPUqLG
         AFmZfc0ouKotiu4sUps7JPJUDB9HsVYqv8FuEbYAvM6PpxAuIv+PwiCu34YKN1kE+lt0
         CwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758760183; x=1759364983;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rGrJhkEhVL8fDzcbwtX0Nlx0/Ial1/o06KA95F1aKyE=;
        b=SPE43iau13d0gAFldcjIYK89YLepW8yB6QLR9ffdPgnHczFzwGmmW976FlvPZcvE05
         szTa7NIhWIDKZNk2A7YopETIws/RyDkoGw3zP74/mxdnYO92/tvw1h6joZtNz+MBRCod
         mjBBk5uRER7QI4tV8j75YzC3eALCkCVpmgpK7DyjSfC8TV+MeKh+Dzhd3MgUUYOYPizT
         ugUAw7QQXNQXz9eOh9K07A0fBj9wwNdUTRQKBN/6x7I0E9ibj78qKtwyNU+4d+i6317w
         n9ryZ3KaYH5+NNoO49PG+3cfN+5bVUbr9z8bZ25zrIQE4NfYFaQFs58f417qfAb/AYvf
         a+gQ==
X-Gm-Message-State: AOJu0YwDX7k+IZ9Z9LX74iIs2VviffS/bJ/0ugGOWdIWDpVxf2Ast7N2
	rfwDkN9HEMOZ1nmwbDikbLANO2TN55XUkglEeTijdHSmZjYaPnSvdYanebK7PvQu8Bj1Lw+Qo5G
	mSZ8Cg8F88qqY5evgljS0udc9gsiF9EPWEN7LkJHOVY22Fa5Retkal8WT69CWSg==
X-Gm-Gg: ASbGnctsC2IdiD/9doYmCNz4c/r70CVw9Q/PWUOqeign8GmRQUTeoYIC7lFgAm5kf33
	JWwZYmStJYStbBsk6LqizQQfvgT8bQ5bCKlQatC72q3pIhKBeyPd5AY6uAHENMdkZPHhToxkE1k
	mr3uSpcdlR+IXPcX1cJEEjfg0X6Vss+8mmkOZBaRPSvRP48mKf6OLCZlQM4IibyAbyX1C63WOQA
	7HJoHaCbaHuw2d8e7u63pS/
X-Google-Smtp-Source: AGHT+IF29hX9gih8LwttPUfoJ3ziAEqxYld5pZxsEuTKcsm+ojcC4pZPrneDxgNLw1hROYWi7BymTX+vJ5G4M6w8ZGA=
X-Received: by 2002:a05:6512:6092:b0:576:4ceb:a167 with SMTP id
 2adb3069b0e04-582b1552a7emr239612e87.5.1758760182481; Wed, 24 Sep 2025
 17:29:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chenglong Tang <chenglongtang@google.com>
Date: Wed, 24 Sep 2025 17:29:31 -0700
X-Gm-Features: AS18NWBhdBOTvWF0Ty1kP-ZkTeb619FZATRTEkhft-g2-Fo8clpTokAq1JhLagM
Message-ID: <CAOdxtTYQye1Rtp-sG48Re+_ihD637NDXTG_V_uLkerg=m1Nbtw@mail.gmail.com>
Subject: [REGRESSION] workqueue/writeback: Severe CPU hang due to kworker
 proliferation during I/O flush and cgroup cleanup
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, tj@kernel.org, roman.gushchin@linux.dev, 
	linux-mm@kvack.org, lakitu-dev@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

This is Chenglong from Google Container Optimized OS. I'm reporting a
severe CPU hang regression that occurs after a high volume of file
creation and subsequent cgroup cleanup.

Through bisection, the issue appears to be caused by a chain reaction
between three commits related to writeback, unbound workqueues, and
CPU-hogging detection. The issue is greatly alleviated on the latest
mainline kernel but is not fully resolved, still occurring
intermittently (~1 in 10 runs).

How to reproduce

The kernel v6.1 is good. The hang is reliably triggered(over 80%
chance) on kernels v6.6 and 6.12 and intermittently on
mainline(6.17-rc7) with the following steps:

Environment: A machine with a fast SSD and a high core count (e.g.,
Google Cloud's N2-standard-128).

Workload: Concurrently generate a large number of files (e.g., 2
million) using multiple services managed by systemd-run. This creates
significant I/O and cgroup churn.

Trigger: After the file generation completes, terminate the
systemd-run services.

Result: Shortly after the services are killed, the system's CPU load
spikes, leading to a massive number of kworker/+inode_switch_wbs
threads and a system-wide hang/livelock where the machine becomes
unresponsive (20s - 300s).

Analysis and Problematic Commits

1. The initial commit: The process begins with a worker that can get
stuck busy-waiting on a spinlock.

Commit: ("writeback, cgroup: release dying cgwbs by switching attached inodes")

Effect: This introduced the inode_switch_wbs_work_fn worker to clean
up cgroup writeback structures. Under our test load, this worker
appears to hit a highly contended wb->list_lock spinlock, causing it
to burn 100% CPU without sleeping.

2. The Kworker Explosion: A subsequent change misinterprets the
spinning worker from Stage 1, leading to a runaway feedback loop of
worker creation.

Commit: 616db8779b1e ("workqueue: Automatically mark CPU-hogging work
items CPU_INTENSIVE")

Effect: This logic sees the spinning worker, marks it as
CPU_INTENSIVE, and excludes it from concurrency management. To handle
the work backlog, it spawns a new kworker, which then also gets stuck
on the same lock, repeating the cycle. This directly causes the
kworker count to explode from <50 to 100-2000+.

3. The System-Wide Lockdown: The final piece allows this localized
worker explosion to saturate the entire system.

Commit: 8639ecebc9b1 ("workqueue: Implement non-strict affinity scope
for unbound workqueues")

Effect: This change introduced non-strict affinity as the default. It
allows the hundreds of kworkers created in Stage 2 to be spread by the
scheduler across all available CPU cores, turning the problem into a
system-wide hang.

Current Status and Mitigation

Mainline Status: On the latest mainline kernel, the hang is far less
frequent and the kworker counts are reduced back to normal (<50),
suggesting other changes have partially mitigated the issue. However,
the hang still occurs, and when it does, the kworker count still
explodes (e.g., 300+), indicating the underlying feedback loop
remains.

Workaround: A reliable mitigation is to revert to the old workqueue
behavior by setting affinity_strict to 1. This contains the kworker
proliferation to a single CPU pod, preventing the system-wide hang.

Questions

Given that the issue is not fully resolved, could you please provide
some guidance?

1. Is this a known issue, and are there patches in development that
might fully address the underlying spinlock contention or the kworker
feedback loop?

2. Is there a better long-term mitigation we can apply other than
forcing strict affinity?

Thank you for your time and help.

Best regards,

Chenglong

