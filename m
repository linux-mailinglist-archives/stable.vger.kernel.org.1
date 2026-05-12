Return-Path: <stable+bounces-246656-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ot8ITaJA2pN7AEAu9opvQ
	(envelope-from <stable+bounces-246656-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:10:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F9E528F7A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D1AD3049295
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CEB3A75BB;
	Tue, 12 May 2026 20:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHo6tTTp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c86OhUHd"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4343ABD91
	for <stable@vger.kernel.org>; Tue, 12 May 2026 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616625; cv=none; b=a9qBqRn4WxQFNLGxXkJeAFbRGFp+FxV8qJv0bjkIw860yJNqKGKxnxTeUtCfPT+gZCIICf06GXQHaTDTEhLYtnp2uN2/JQQbmhqADcxc00s9zCgDsiG+vsTwXRpd4N5dYMlDFL8OI9OYW6nieKSSc9T9eGr/hTD7RaHWmLZoKRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616625; c=relaxed/simple;
	bh=+JCrXZhZYw+RI/HVQxcPYXVfM8JoeJKwt7zyODuIkGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T1CjQZiNnFIvrOzSp6UjR/rtG2rI12MtJW4uxXpBFbjpHRpDRVHjvLHsrrnaG97mJWIlYpa1rxPHjSB971HhfyFfDATGqQ1AcOQ77TDe8isHC0o58mk0GgishdR2y0zgrar25MfbJgOAUi6d0B0DuwjFV1oBo+hukm5NxxACSLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHo6tTTp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c86OhUHd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778616623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TPYnN5bYSdRlPVznuXaA8Mz0mx5Mw6QHeHl/iOKTNFo=;
	b=BHo6tTTpjps0udrVZiKw0dRqID/2c7dwl80pgL3ggTy9dZOKqT3r/eJDP6Cqd8rpkLfqYr
	pl/pxH5EDx3PymEhIlCGMh8w+ILk6TGaWI9fDyh1UDtn89YT3sTZcUofIPcyyevCCpENDc
	QloxjjUcN9jxzum2is9Tv0m+ghgxz2M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-WuWxdSvnPDOV9zUXDBbcBA-1; Tue, 12 May 2026 16:10:22 -0400
X-MC-Unique: WuWxdSvnPDOV9zUXDBbcBA-1
X-Mimecast-MFC-AGG-ID: WuWxdSvnPDOV9zUXDBbcBA_1778616621
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4411a1f9601so4524805f8f.0
        for <stable@vger.kernel.org>; Tue, 12 May 2026 13:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778616621; x=1779221421; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TPYnN5bYSdRlPVznuXaA8Mz0mx5Mw6QHeHl/iOKTNFo=;
        b=c86OhUHdIjCP3lFZNMgO6sMdP0gDRmGWezSpBCwuRTahG5XJiBLmwI7UkKiRoWI3Z+
         F4K7xdpZ9/fpOgOlA+dx8bFmAl04R7lTw1pWrfj/rwTzmvxPqvu4msMR9l/riAsTeBo0
         KX61dYQ/1FhsDo3KewrQuJzLQ8Gml0hh334ArFDubGsU6qPTGuXg0SkjUQaouTrt/evB
         a48baDdYQGN+BadQEgZaDDURVZS3uVJP/BnQVPCDOT41kxcU6quhVMlVLSQ0OI2fLC5Y
         cTn2aEAvswkvA16c9EEXouAfJDnt11iqyfe98tS5XJYfC3fy1JLQvdfFsj+Vw6iWWmTg
         k/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778616621; x=1779221421;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPYnN5bYSdRlPVznuXaA8Mz0mx5Mw6QHeHl/iOKTNFo=;
        b=KX8PSC/Xn9mgySkcANqtipyZZ9J/LbGzhhIr2k9bQS5YGghWRY4zRIIbFR9SF/j64s
         f58x6siuBnkZuO3p0b9+NILg5bpAUTHaRVjmFW9IeglNJBHzsKM8JD3flcZtYv/qd8DS
         pDzvpdR5tFzxwO3cNOkqct919zXc+eZuWrSbRUaupqo3iXBYbNvzlP05mhWfyIIcbqTe
         z4saAFh99A0oCbrg56E698JvQVlo/iKEcqN7lZ2MeRP7QX0dvgveLMTD6/bzmpLgtlvQ
         gjtH/RcfVs10TLM8YSGJvnxTne8Az++55gilrkSOYCHiIke3VlqflBwHHNFoC0uCu7By
         QUPw==
X-Forwarded-Encrypted: i=1; AFNElJ+TxFou74vJk+Ul1+zuNlW5rdGDX9hGLebbPaMOpIZr0VIj4NPamS9Ij4gEb/xMCKIT1qQditM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKuYk//Xj7stRT03pebdSXd9X3Ig+JUOpUV/xR7nei814S0PFD
	9odFI5xxAOdQHN6wYKnaP93aPDhrq2sRImUOZQEz0epLgkdUwfIAD/KVugefuMkV3Rv4OYdu7jc
	3crG2VluPzQvjV8B+ftbg4xv1GCFG9jXFCv6eHCINesTc20WWvtKRL8vGaw==
X-Gm-Gg: Acq92OGSD77MSsWUU3fDNy2WmjNSbA+cl7/1apsKUMQNZEbLQzFAjpfgyrN7msAweIA
	cdDmcLo9qDveRzuyu9BUfCV1zADI5/CnUJrzZQDAQvGelq/rBMtBbzi9xPeWXXM7FoZAt2J1a+M
	m9HnQr0Wsl0olqZSfnmiGLl+O/HbvL3Lc4u1uyTYhZzlQXJn5pKEiQIxG/LU6YLMckSi1UauUeV
	wm0DBU4W4MyqfTdLeoWZtO+jiUAqElCWe8Fpov9ADOYv8t7/+QmtcAFKZkvlj1MCdlxZuS9jfYC
	RZ9wVZUmrhrdeU+V6M+XBKMv7r+yiyLEhumOeQ3jDCDLdmVPkzegrNKBZvQKypjvmtY8hWE7KGn
	jwZIX0onp0Mh4y+xJVkiVCtsYXIzhXKXyar5eCTy+WSpz/OHIf/T2+kJyr34sTA14Xjl8u1lnmL
	9iySFOiWg=
X-Received: by 2002:a5d:5d83:0:b0:43b:4982:fc73 with SMTP id ffacd0b85a97d-45c599eaf6amr316140f8f.25.1778616620542;
        Tue, 12 May 2026 13:10:20 -0700 (PDT)
X-Received: by 2002:a5d:5d83:0:b0:43b:4982:fc73 with SMTP id ffacd0b85a97d-45c599eaf6amr315829f8f.25.1778616615280;
        Tue, 12 May 2026 13:10:15 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491da03a7sm35256124f8f.33.2026.05.12.13.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:10:14 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Kyle
 McMartin <jkkm@meta.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Linux RT Development
 <linux-rt-devel@lists.linux.dev>, Clark Williams <williams@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Kacur
 <jkacur@redhat.com>
Subject: Re: [PATCH sched/core] sched/rt: Fix RT_PUSH_IPI soft lockup loop
In-Reply-To: <20260512113754.448c1f5b@gandalf.local.home>
References: <20260506235716.2530720-1-tj@kernel.org>
 <20260507141437.GJ3102624@noisy.programming.kicks-ass.net>
 <20260512113754.448c1f5b@gandalf.local.home>
Date: Tue, 12 May 2026 22:10:13 +0200
Message-ID: <xhsmh8q9o2xui.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: D6F9E528F7A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246656-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vschneid@redhat.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 12/05/26 11:37, Steven Rostedt wrote:
> [ Adding some RT folks ]
>
> Also, Valentin, can you look at this, because I believe the issue was
> introduced by your change (see below).
>

Woops!

> IIRC, the test we had was simply cyclictest that we ran with the following
> parameters. From commit b6366f048e0ca ("sched/rt: Use IPI to trigger RT
> task push migration instead of pulling"), it states it runs:
>
>    cyclictest --numa -p95 -m -d0 -i100
>
> The above runs a thread on each CPU at priority 95 and will sleep for
> 100us. Each thread should wake up at the same time. You can read the commit
> message for more details but the tl;dr; is that without the IPI push
> request, if one of the CPUs ran another RT task besides cyclictest, then
> all the others would then ask to pull from it when the other CPUs
> cyclictest would sleep. Having over 100 CPUs send an IPI to pull a task
> when only the first one would get it, caused a large latency. Especially
> since it took the rq lock over and over again.
>
> But, the code being fixed wasn't due to that commit, but due to the commit
> that added the short cut of the logic. That commit fixes a race with the
> normal call to push_rt_task() and I think the pull logic issue was a side
> effect.
>
> I agree with Tejun's change, it actually puts the logic for the IPI pull
> back to what it was before commit 49bef33e4b87b. The bug was added by the
> shortcut case to push_rt_task() that was only meant for the !pull scenario.
> Adding !pull to the if conditional seems like the correct change.
>
> Valentin, can you confirm please.
>

So looking back at the original report for my patch:

  https://lore.kernel.org/all/Yb3vXx3DcqVOi+EA@donbot/

the splat happened through rto_push_irq_work_func(), i.e. with pull=true
(that naming always causes me to shuffle through my notes; AFAICT that's
because it's when push_rt_task() is invoked due to a pull_rt_task() call
but urgh).

So IIUC I'm afraid the suggested fix would cause the original issue to
resurface, but that still leaves us with the reported softlock issue. I
don't have any inspiration so far, I'll sleep on it.

> Please update the Fixes tag to point to the appropriate commit as well as
> update the change log. With that:
>
> Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
>
> -- Steve


