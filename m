Return-Path: <stable+bounces-181753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9A8BA205C
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 02:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D444A29BB
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 00:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B082034BA48;
	Fri, 26 Sep 2025 00:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QiPchGwC"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E78634
	for <stable@vger.kernel.org>; Fri, 26 Sep 2025 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758845157; cv=none; b=O7si8OPnnTEuiVMvOxxdXN3O2wmslxcT+9fJ6VnRNtJXM8Gc4iLWAs9zJMGJhrCB9idP5KERzNFZYPa0J0F0oLA5PdMpd25JNvn08ZH1CNDv44XG5lw0WKso4wBzEEq6MGO3gLSE47dzF4yTvhJEv1TzBlf3LmLhQm4RuUAQ50I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758845157; c=relaxed/simple;
	bh=mkisGz3UU5OhYClBkPSgDD1nrC4IgdFnh7r/UhmAJXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOmdXq0P2Dg+U2BlJtlDZwIvL/7w7J18BXLAE01vNgQP9uuuBqPciArmiB5P39ai3SRsxIudJTpcu/+PUf8KqMaNlv3IrnLdr9Gypm4p17XypVbanK6QhoPYT9UAfUvX+MydpxoxzHqiP5niLBqeVeSnvImNLZGRmLhHyaxeDc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QiPchGwC; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57edfeaa05aso1677890e87.0
        for <stable@vger.kernel.org>; Thu, 25 Sep 2025 17:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758845154; x=1759449954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cp5tcC8TMHe2cJtq+fJR2KXIS8K2iwId/v9FeWmSi5Q=;
        b=QiPchGwCWFSNOUIZ6eHze0L+1onG3JWIeyzndENlaELKuwcVGeRfW8fXSRM6GVi411
         bPTVF4HUSD5TPeY3wJLxqvah/ohNIyGe0iddSQ5mwMSUka/aT4UDcNfig95hb8RlQK3w
         6yYEN2rxTL03xUHH3oJ1NZmZPeHkQW0nEH99hspfIYvkNroupFySzW0tTYs1ykDCJ0sz
         NBgwfPwbiawic4955i0CdqABeHF3SMIx5hSRqLGiD0BUrAAIznCpCglsTdCrNSaKFuTQ
         8HZj6Rf27v3J0R7vEVM90gCuqITlwAtyiIsYsC5cyXwO+01kRjNhrXzAUxtc8Hxny5u9
         NchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758845154; x=1759449954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cp5tcC8TMHe2cJtq+fJR2KXIS8K2iwId/v9FeWmSi5Q=;
        b=GKByceNAjpB783ZKnMR2NabTbpnU91lbr+1rlhkwQSEl8KMpOJySOxg0cfPcli98pB
         KdzLs4FKo/aAkDMciEHOZ1G+/RU4E5AKskESJOFl87CorzOaNnTNU0m6Luf1C12WEhjw
         j44u71EBa+dgvtgJI5SVogd3+U5uPr8jiEnRC8uYFmfz3piH1Xkw9CoVoEnzP216UanP
         BwNnPf0xIrmvQ8+V427sWrdud+ouKUN7ORUvZxv7rt7LVDR9EogAilmJafMlLNgXRJv+
         z9SFOSLMZ/zmekPPPkdSj1o+B+m6XZQH3eRvK1GgmG4tKBJuHJU7sKwiTEdx3PqFjfvA
         nL8g==
X-Forwarded-Encrypted: i=1; AJvYcCXo1YdO7gD/xw95mUjhiy4r8ntCRNv3RYumDguWardu4+Z+UE64ThgW5yjejtj0F5vTDRWstJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTKwPBiRi6hbjqBo9SXlT+bZ909jQQks5kb4LsF9Xek7Rc3WX8
	aYdar8RjBREUW85aFDvgnoutVld5Qc2lPLYEgsSpnHw9dccXwgPBkNEij1uQUa6QHQpr2DSb0Y/
	Uui81lC/wfGEQqF3QmwURUYFSaGgOIeO0Oc6zrSw=
X-Gm-Gg: ASbGncsikBUjUXZetiOj78h1GRTDqjvPZqFpjeUi8eKNAewJze/6YmL4EqUtwWagVeC
	6nrSEXCI+litQZLjcL8XPc49c0GcUn06Oy10itwIQ2yRMeoDol2Z9wfwINfI0F5OZPuvBtksxsg
	MDG+B2rlOs26aXyJKN1ZWFa19N6pc157PRojdDnxHe8QnJHj7885/vgyT1qu/F6v+GCifpXY1e+
	E4zx2in5VVmu9rm6ymm20Fh9Q/PWcYkm8l1KqYSZNAy8IP+UC8xcg==
X-Google-Smtp-Source: AGHT+IECFDWxoexEEw8mihr5z2g02WUmVMaFysoilJ92DTUBSLarKqHikWFEw7Ks29UnfgFLHaKltBp25icjbttX9Jg=
X-Received: by 2002:a05:6512:3e0f:b0:569:f345:4dda with SMTP id
 2adb3069b0e04-582d25845eemr1726529e87.36.1758845153512; Thu, 25 Sep 2025
 17:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925133310.1843863-1-matt@readmodwrite.com>
In-Reply-To: <20250925133310.1843863-1-matt@readmodwrite.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 25 Sep 2025 17:05:40 -0700
X-Gm-Features: AS18NWACyca0qGov86B7zy0-toK5Y5ugLlWv9dV_b-Di8Fm9ztljutU8zvbW05M
Message-ID: <CANDhNCr+Q=mitFLQ0Xr8ZkZrJPVtgtu8BFaUSAVTZcAFf+VgsA@mail.gmail.com>
Subject: Re: [PATCH] Revert "sched/core: Tweak wait_task_inactive() to force
 dequeue sched_delayed tasks"
To: Matt Fleming <matt@readmodwrite.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>, 
	Oleg Nesterov <oleg@redhat.com>, Chris Arges <carges@cloudflare.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 6:33=E2=80=AFAM Matt Fleming <matt@readmodwrite.com=
> wrote:
>
> From: Matt Fleming <mfleming@cloudflare.com>
>
> This reverts commit b7ca5743a2604156d6083b88cefacef983f3a3a6.
>
> If we dequeue a task (task B) that was sched delayed then that task is
> definitely no longer on the rq and not tracked in the rbtree.
> Unfortunately, task_on_rq_queued(B) will still return true because
> dequeue_task() doesn't update p->on_rq.

Hey!
  Sorry again my patch has been causing you trouble. Thanks for your
persistence in chasing this down!

It's confusing as this patch uses the similar logic as logic
pick_next_entity() uses when a sched_delayed task is picked to run, as
well as elsewhere in __sched_setscheduler() and in sched_ext, so I'd
fret that similar

And my impression was that dequeue_task() on a sched_delayed task
would update p->on_rq via calling __block_task() at the end of
dequeue_entities().

However, there are two spots where we might exit dequeue_entities()
early when cfs_rq_throttled(rq), so maybe that's what's catching us
here?

Peter: Those cfs_rq_throttled() exits in dequeue_entities() seem a
little odd, as the desired dequeue didn't really complete, but
dequeue_task_fair() will still return true indicating success - not
that too many places are checking the dequeue_task return. Is that
right?

thanks
-john

