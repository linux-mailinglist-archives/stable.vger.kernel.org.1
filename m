Return-Path: <stable+bounces-124310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC4DA5F5DD
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 14:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74F319C2901
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CED267AF8;
	Thu, 13 Mar 2025 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4XDZXka"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AB3267AF5
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872108; cv=none; b=qZZDKODJ2tOzBtt4SwT68U+CLKLFNICkAzKf3cTZ3/60LvwaIBMb/rUkYKtNhEby+iD/55RkCBTnhY23laUhxjiMkYCnr7FA2qCpaTdgTXwiUwUr/PPEyGrQF7DZ46AmkpYK5UZE/IUNzXdoGnXCv3CB9CxvpX3Kp2CQW2HmWtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872108; c=relaxed/simple;
	bh=NzgzTyi8Zp31j/MxiJYX8O0vM08HqIVdJ8gqDLXE+SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Su3gUl4zo9nI1GFhqaBfzAr721xRBBeS+DICUYYwPdD7P5Hwdq7Op8+LzQZwkC/70RntfP7/g809/4mf0XPhbmM2oR3BoFVe6Db9hb5xHlJc0HOQ8l6j5wkCihdpafuaIWmctZIwQzsY9dcpSKW6bvz52rAWnENU3kSnL7K92OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R4XDZXka; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741872105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sr12YOz6b+Wdc4ncvk9yUKUep9d7avEpDYfmzKprqkk=;
	b=R4XDZXkaAvPgT64Hnsqt+S4DwCMkrhczGp1iHT6djg3R3DsoVWegpoj3EbUDiD6eMNR3Hl
	R9PkhRhuv7iiDc4k1i/oabLeDJi/VZQuY9d/Pk4XFil3dgK/NXK8rQilljhQZWcw9ArlGW
	gjXP7Qtm9fi8l1M+1TW11j9AhXKQ2Dg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-gtHb6H0oPXOxwSRTSULVpQ-1; Thu, 13 Mar 2025 09:21:44 -0400
X-MC-Unique: gtHb6H0oPXOxwSRTSULVpQ-1
X-Mimecast-MFC-AGG-ID: gtHb6H0oPXOxwSRTSULVpQ_1741872103
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912aab7a36so409320f8f.0
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 06:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741872103; x=1742476903;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sr12YOz6b+Wdc4ncvk9yUKUep9d7avEpDYfmzKprqkk=;
        b=Kbc+tHcWLdUYFlH2Kvwei62ghWEqO4gQHHY2rQnGQ54fGrAMedCtil1u/8LzMf4jfG
         kY67KtnrHPVEtbDD5//Hl+yazoYlILF5jlErk2jljIc6bbECiUSoy/hvegZ/uA1wrpjn
         RnyUblAyF4g3Dz/KJVMDmqiSQUBJxZOKpiEa0wPEHUFSdsOuYiz3ZovRcJy8UhU8LLTq
         PUvNvRvpTTvBLRCjVPPcwHcwmg9A8lDt0ltrnXdx/gsGA1teuNXnts5fGrcI965puRkb
         Y3N6wzh1UdwW9Sjw7uLAkwRVq8f+Gn9IonD3P8/ylOSG1XbBNZI+buBS1HN7LkviRJ7u
         DPjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgzr7IFyu9sqGpeOkhRLbAf0iSF58D0UWTwjdPjISiXfBiNvKEls68IHSkkNRScP5K5HlT3fE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5kdVK1NqzATdY2RRlM1UgzaPjZF0vGZYrRUejqSc2Qrqolbgu
	E+9zqiO5JZOLn/O4+It2OWp1YwMEBNs0mfvnWihwN7vDH+FmtFdmqelOZt5bKcxirjJBWmJ3fwA
	cSWKud+fQOEppUWzOq6KQGiQ85Z556L3WjVPt63mypdVywiWt/LX9Lw==
X-Gm-Gg: ASbGnctDCMbJaqkbq9BpiWNCu/hFhHtqwKaM7nS+MuuhSSLhUqMuN/8J4PWcN0ToD9G
	IslCwbEviqdjKBBKdbOpflo5Z3J3d/YVi8XSZ5JXAjdnMEJ6QOhrUkwn/g3Euo6EnD4y+7ckiSr
	QrHKNVbl4ht6z7zmWK1Ob6qW0S+68AjyVwLo+eK/TBsrC32DMpV3PkLluIeQK+GL5WVkFXl9o+5
	ZHXnJZmap/kNaw7eW/jvAfhhZ9D/S8pe6CmsjBCqnuDmh2hZEb+3yg/bMAWfe6Q8XpkrH0bcg0/
	Lv48UKQXoB907s6boBFwVZQKkp5aGzw9RJ4moWGHjto=
X-Received: by 2002:a05:6000:1541:b0:38f:3c01:fb1f with SMTP id ffacd0b85a97d-39132d7ed99mr18293811f8f.30.1741872102792;
        Thu, 13 Mar 2025 06:21:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfH6My/OYYnn4ivMgF2lOD1PwxUg7kd5/ME50Z6QRYoQsn2H+AyfQZYmsIkGUqPz5lQV49QA==
X-Received: by 2002:a05:6000:1541:b0:38f:3c01:fb1f with SMTP id ffacd0b85a97d-39132d7ed99mr18293792f8f.30.1741872102411;
        Thu, 13 Mar 2025 06:21:42 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdc5sm2098207f8f.80.2025.03.13.06.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 06:21:41 -0700 (PDT)
Date: Thu, 13 Mar 2025 14:21:39 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Harshit Agarwal <harshit@nutanix.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] sched/deadline: Fix race in push_dl_task
Message-ID: <Z9Lb496DoMcu9hk_@jlelli-thinkpadt14gen4.remote.csb>
References: <20250307204255.60640-1-harshit@nutanix.com>
 <Z9FXC7NMaGxJ6ai6@jlelli-thinkpadt14gen4.remote.csb>
 <8B627F86-EF5F-4EA2-96F4-E47B0B3CAD38@nutanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8B627F86-EF5F-4EA2-96F4-E47B0B3CAD38@nutanix.com>

Hi,

On 12/03/25 18:46, Harshit Agarwal wrote:
> Thanks Juri, for taking a look.

Of course! Thanks to you for working on this.

> > On Mar 12, 2025, at 2:42 AM, Juri Lelli <juri.lelli@redhat.com> wrote:
> > 
> > Hi Harshit,
> > 
> > Thanks for this!
> > 
> > I don't think we want this kind of URLs in the changelog, as URL might
> > disappear while the history remains (at least usually a little longer
> > :). Maybe you could add a very condensed version of the description of
> > the problem you have on the other fix?
> 
> Sorry about this and thanks for pointing it out. I will fix it in the
> next version of the patch.

No worries and thanks.

> >> In this fix we bail out or retry in the push_dl_task, if the task is no
> >> longer at the head of pushable tasks list because this list changed
> >> while trying to lock the runqueue of the other CPU.
> >> 
> >> Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
> >> Cc: stable@vger.kernel.org
> >> ---
> >> kernel/sched/deadline.c | 25 +++++++++++++++++++++----
> >> 1 file changed, 21 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> >> index 38e4537790af..c5048969c640 100644
> >> --- a/kernel/sched/deadline.c
> >> +++ b/kernel/sched/deadline.c
> >> @@ -2704,6 +2704,7 @@ static int push_dl_task(struct rq *rq)
> >> {
> >> struct task_struct *next_task;
> >> struct rq *later_rq;
> >> + struct task_struct *task;
> >> int ret = 0;
> >> 
> >> next_task = pick_next_pushable_dl_task(rq);
> >> @@ -2734,15 +2735,30 @@ static int push_dl_task(struct rq *rq)
> >> 
> >> /* Will lock the rq it'll find */
> >> later_rq = find_lock_later_rq(next_task, rq);
> >> - if (!later_rq) {
> >> - struct task_struct *task;
> >> + task = pick_next_pushable_dl_task(rq);
> >> + if (later_rq && (!task || task != next_task)) {
> >> + /*
> >> + * We must check all this again, since
> >> + * find_lock_later_rq releases rq->lock and it is
> >> + * then possible that next_task has migrated and
> >> + * is no longer at the head of the pushable list.
> >> + */
> >> + double_unlock_balance(rq, later_rq);
> >> + if (!task) {
> >> + /* No more tasks */
> >> + goto out;
> >> + }
> >> 
> >> + put_task_struct(next_task);
> >> + next_task = task;
> >> + goto retry;
> > 
> > I fear we might hit a pathological condition that can lead us into a
> > never ending (or very long) loop. find_lock_later_rq() tries to find a
> > later_rq for at most DL_MAX_TRIES and it bails out if it can't.
> 
> This pathological case exists today as well and will be there even
> if we move this check inside find_lock_later_rq. This check is just
> broadening the scenarios where we would retry, where we would
> have panicked otherwise (the bug).
> If this check is moved inside find_lock_later_rq then function will
> return null and then the caller here will do the same which is retry
> or bail out if no tasks are available. Specifically, tt will execute
> the if (!later_rq) block here.
> The number of retries will be bound by the number of tasks in 
> the pushable tasks list.
> 
> > 
> > Maybe to discern between find_lock_later_rq() callers we can use
> > dl_throttled flag in dl_se and still implement the fix in find_lock_
> > later_rq()? I.e., fix similar to the rt.c patch in case the task is not
> > throttled (so caller is push_dl_task()) and not rely on pick_next_
> > pushable_dl_task() if the task is throttled.
> > 
> 
> Sure I can do this as well but like I mentioned above I don’t think
> it will be any different than this patch unless we want to
> handle the race for offline migration case or if you prefer
> this in find_lock_later_rq just to keep it more inline with the rt
> patch. I just found the current approach to be less risky :)

What you mean with "handle the race for offline migration case"?

And I am honestly conflicted. I think I like the encapsulation better if
we can find a solution inside find_lock_later_rq(), as it also aligns
better with rt.c, but you fear it's more fragile?

Best,
Juri


