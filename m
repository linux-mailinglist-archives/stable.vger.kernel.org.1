Return-Path: <stable+bounces-230723-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJi6D2f1xmnaQgUAu9opvQ
	(envelope-from <stable+bounces-230723-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 22:23:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 868CF34BA4A
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 22:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 766BC300E716
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 21:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55856391E58;
	Fri, 27 Mar 2026 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtrcpsyN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nNy5HERm"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B75433555B
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774646424; cv=none; b=PeZs7FiFBxnI3a5hVBPTHfN0lmrkpSQw7uKPuw6T3APeHdWJ3oyEJGztcGOQ+FQ57GTC9RXe43X8Zh+U2dOVLVvzdCGSAp2aqgwudWMI8bk+pbvItMVeQ82Jd6QRIKBGhb+R4/KpjFnoW5x4JtJI378kYcuX8XArDdnEvo9dyPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774646424; c=relaxed/simple;
	bh=zO5ZQduTxTCmSDqyTGew3zVq4QVTM0kkUNYM6Qjch50=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cNOMsSXXbRhsBqeiypPwc7WnlgALXo6STOxKHayAOPgb4aAkdaqpXXxnS7kuTMdM35ewhTJAvdb2QvLysFR1IM8KkE6mGE6EeatNxmwKUSZR+uj26Js7FZNA9yzJn3ool/e2hICm9DBDMYI9qvoZeujeqsDDs4wzAwPgYBMbIXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DtrcpsyN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nNy5HERm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774646421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kcY/ZAkLvNE5jmsW6XKb47cOytwFbrLwLeYAjxJQGVc=;
	b=DtrcpsyNOmTLxAhy/tRjkOpJ8Babfe8LkjpceKd9mFdTQ5Obw1Jv2+U/Tg2gXuGJyEV0lJ
	3Qoi6h7ocuFDbFl5JFdFz8pvEOsDecsHrRL0H7pISHXcDS3wLkq+Jv0O1mmNAh5ib64rJj
	glRmgplAJTM+t1ZkrmIWwjULnt2WNso=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-x6BWP3MCM66OZLdANSzP4g-1; Fri, 27 Mar 2026 17:20:20 -0400
X-MC-Unique: x6BWP3MCM66OZLdANSzP4g-1
X-Mimecast-MFC-AGG-ID: x6BWP3MCM66OZLdANSzP4g_1774646420
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5093787e2fdso120067851cf.2
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 14:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774646420; x=1775251220; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kcY/ZAkLvNE5jmsW6XKb47cOytwFbrLwLeYAjxJQGVc=;
        b=nNy5HERmmtLtI52xPFO8uCgsoy40P2OXG4O7yWiNPVDB6ZdGIxHyee2VDCsKXqq7jY
         KiAGCWsBQO+z4A+m0G53USxTtXvJWdKt25cYKRscKYg8VfoPhGbHq5G61JJstynia+bJ
         S1pSfZjWPoEPcBUGgTzdhBexT1YEPijSusai43nElhuSBplHa30koUdfvjs0I5kbjFLT
         L1IOLv5ZWEnIdI+/4Yue+NESSeB14K+1tNpx7fL5XBib/uIH5ILCpLaEPg5x+Um6Iyob
         fWqznnpdr5Hxrf5E39Gv/Y35oiszucBbPp0O0Zh+qsD0cUdeQoOszGpHP5QOYC9+wYW9
         M7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774646420; x=1775251220;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kcY/ZAkLvNE5jmsW6XKb47cOytwFbrLwLeYAjxJQGVc=;
        b=p8bZv4HyzhAnmLcHdFqbiNCcXqW/Tc2/zghpZNvYAvq5qzOfKezhX2SIC1l28/AQAq
         JruX7NLjHqclrtDTZSzOOmVvEG3aVz8mfoG2ufJGPsMxj+iNEJf1HWYgfVXAU/y6dRnN
         Kv3JocSmeeEX0DkrxzY1TQeOczvpR4eXQY16TVhmtKk830wrEorjW/SSh1J+WfTPNth2
         uPlf4THIcx/qeTyqjv6a3M34syj4vUD3zl8ahkdFNAynNBctvnqTw69o2LAFMM+kUxPo
         CP/5K26y6t/ZVbkV/Ldnh53SW8CTRAPsd2fLiesTwmICReIXq8lQZm2Cuk+6mz6G3Sso
         mJ2A==
X-Forwarded-Encrypted: i=1; AJvYcCUMpVh3YUZLGMyGG98Hg3QkAseJFwT0kFUsBK4HA1YwapPcd3TRhsziawinxQ67DadoY02TVrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvN3y5rfvtGCYHPFBHH44tNlSEOBe3gKjo73vuepN8HcbUbrSv
	9FRBhM+s74dSLnVanXX/L+63bzND/3LNjtIRQ5MbQ4X8przsLxubXDhbjJUH76kTkHQiwjFYleI
	ewJQQC8rXu8FgNDsffyU+eHbhW2Z5oqr7QgQYGQ+kREu7ojmsFOc+qsJVyw==
X-Gm-Gg: ATEYQzy7DrQgl6svLYlV9hejrZl1rO8DDh9w12gorVKI4o8JJ/ZKPxv7R7lBcUvsNj4
	x9OOOy2AWEl1wawWB1r658s3gPyAtxFW9mYuMUCM6TyWQpzxPdUiLIvx7N3q8ezmeBWVtef6svt
	KN5EoZ8Cy9vJ26H4gElCyHMUhusP+7tNz6oweMVlT0ouFTqduN3NgaSPHBKu5mVVpBqC9m94CaL
	kZGmUrddaWyIPmxQnAv2w4i/eCq+uw5jvmqdyQR1Dr6hwMAj6Krys4kXkz3dqdPvpcwz2mG6Qc8
	PZdF+C5GwDKmlfN1xPq+Nb9hU0p3TitfCbT1Vp3TmmWWwRUN6paIn8MPH5KsJA1lk+VfO9dVVD0
	x5kuJP75JnEHvdBI4OWwhxScoyj/n92hI24qsD/WPYuj9/knMpG8=
X-Received: by 2002:a05:622a:11c1:b0:509:2b5a:7ff with SMTP id d75a77b69052e-50ba37d1cd0mr57723331cf.10.1774646419741;
        Fri, 27 Mar 2026 14:20:19 -0700 (PDT)
X-Received: by 2002:a05:622a:11c1:b0:509:2b5a:7ff with SMTP id d75a77b69052e-50ba37d1cd0mr57722851cf.10.1774646419246;
        Fri, 27 Mar 2026 14:20:19 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2cc79d8sm3941081cf.12.2026.03.27.14.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 14:20:18 -0700 (PDT)
Message-ID: <279cd4c6b4eece55a63936f2ad0912e41be7838b.camel@redhat.com>
Subject: Re: [REGRESSION] osnoise: "eventpoll: Replace rwlock with spinlock"
 causes ~50us noise spikes on isolated PREEMPT_RT cores
From: Crystal Wood <crwood@redhat.com>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>, 
	florian.bezdeka@siemens.com
Cc: namcao@linutronix.de, brauner@kernel.org, linux-fsdevel@vger.kernel.org,
 	linux-rt-users@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, frederic@kernel.org, vschneid@redhat.com, 
	gregkh@linuxfoundation.org, chris.friesen@windriver.com, 
	viorel-catalin.rapiteanu@windriver.com, iulian.mocanu@windriver.com, 
	jan.kiszka@siemens.com
Date: Fri, 27 Mar 2026 16:20:17 -0500
In-Reply-To: <20260327183610.594667-1-ionut.nechita@windriver.com>
References: <480f889c1744132f39983178fbad90ad11e081ed.camel@siemens.com>
	 <20260327183610.594667-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-230723-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[crwood@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.com:url]
X-Rspamd-Queue-Id: 868CF34BA4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-03-27 at 20:36 +0200, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
>=20
> On Thu, 2026-03-27 at 08:44 +0100, Florian Bezdeka wrote:
> > A revert alone is not an option as it would bring back [1] and [2]
> > for all LTS releases that did not receive [3].
>=20
> Florian, Crystal, thanks for the feedback.
>=20
> I understand the revert concern regarding the CFS throttle deadlock.
> However, I want to clarify that the noise regression on isolated cores
> is a separate issue from the deadlock fixed by [3], and it remains
> unfixed even on linux-next which has [3] merged or not.

Nobody's saying that [3] would fix your issue.  They're saying that the
deadlock issue is the reason why simply reverting the epoll change is
not acceptable, at least on kernels without [3].

> I've done extensive testing across multiple kernels to identify the
> exact mechanism. Here are the results.
>=20
> Tool: eBPF-based osnoise tracer (https://gitlab.com/rt-linux-tools/eosnoi=
se)
> which uses perf_event_open() + epoll on each monitored CPU, combined
> with /proc/interrupts delta measurement.

I recommend sticking with the kernel's osnoise (with or without rtla).

Besides the IPI issue, it doesn't look like eosnoise is being
maintained anymore, ever since osnoise went into the kernel.

> Setup:
>   - Hardware: x86_64, SMT/HT enabled (CPUs 0-63)
>   - Boot: nohz_full=3D1-16,33-48 isolcpus=3Dnohz,domain,managed_irq,1-16,=
33-48
>     rcu_nocbs=3D1-31,33-63 kthread_cpus=3D0,32 irqaffinity=3D17-31,49-63
>   - Duration: 120s per test
>=20
> IRQ delta on isolated CPUs (representative CPU1, 120s sample):
>=20
>                     6.12.79-rt    6.18.20-rt    7.0-rc5-next-rt   6.18.19=
-rt    7.0-rc5-next-rt
>                     spinlock      spinlock      spinlock           rwlock=
(rev)   rwlock(rev)
>   RES (IPI):        324,279       323,864       321,594            0     =
        1
>   LOC (timer):       50,827        53,995        59,793           125,791=
       125,791
>   IWI (irq work):  359,590       357,289       357,798           588,245 =
      588,245
>=20
> osnoise on isolated CPUs (per 950ms sample):
>=20
>                     6.12.79-rt    6.18.20-rt    7.0-rc5-next-rt   6.18.19=
-rt    7.0-rc5-next-rt
>                     spinlock      spinlock      spinlock           rwlock=
(rev)   rwlock(rev)
>   MAX noise (ns):   ~57,000       ~57,000       ~57,000            ~9    =
        ~140
>   IRQ/sample:       ~7,280        ~7,030        ~7,020             ~1    =
        ~961
>   Thread/sample:    ~6,330        ~6,090        ~6,090             ~1    =
        ~1
>   Availability:     ~93.5%        ~93.5%        ~93.5%             ~100% =
        ~99.99%
>=20
> The smoking gun is RES (reschedule IPI): ~322,000 on every isolated CPU
> in 120 seconds with the spinlock, essentially zero with rwlock. That is
> ~2,680 reschedule IPIs per second hitting each isolated core.
>=20
> The mechanism: on PREEMPT_RT, spinlock_t becomes rt_mutex. When the
> eBPF osnoise tool (or any BPF/perf tool using epoll) calls
> epoll_ctl(EPOLL_CTL_ADD) for perf events on each CPU,=20

I don't see BPF calls from the inner loop of osnoise_main().  There are
BPF hooks for various interruptions...  I'm guessing there's a loop
where each hook causes an IPI that causes another BPF hook.  I
wouldn't have expected a wakeup for every sample, but it seems like
that's the default specified by libbpf (eosnoise doesn't set
sample_period).

> ep_poll_callback()
> runs under ep->lock (now rt_mutex) in IRQ context. The rt_mutex PI
> mechanism sends reschedule IPIs to wake waiters, which hit isolated
> cores. With rwlock, read_lock() in ep_poll_callback() does not generate
> cross-CPU IPIs.

Because it doesn't need to block in the first place (unless there's a
writer).

> Note on the tool: the eBPF osnoise tracer itself creates epoll activity
> on all CPUs via perf_event_open() + epoll_ctl(). This is representative
> of real-world scenarios where any BPF/perf monitoring tool, or system
> services like systemd/journald using epoll, would trigger the same
> regression on isolated cores.

Using BPF to hook IRQ entry/exit isn't representative of real-world
scenarios.  Assuming I'm right about the underlying cause, this is an
issue with eosnoise, that the epoll change exacerbates.

> When using the kernel's built-in osnoise tracer (which does not use
> epoll), isolated cores show 1ns noise / 1 IRQ per sample on all kernels
> regardless of spinlock vs rwlock =E2=80=94 confirming the noise source is
> specifically the epoll spinlock contention path.
>
> Key finding: the task-based CFS throttle series [3] (Aaron Lu, merged
> in 6.18/linux-next) does NOT fix this issue. The regression is identical
> on 6.12, 6.18, and linux-next 7.0-rc5 with the spinlock. Only reverting
> to rwlock eliminates it.
>=20
> To answer Crystal's question "when would you ever reach that path on an
> isolated CPU?" =E2=80=94 the answer is: any tool or service that uses
> perf_event_open() + epoll across all CPUs (BPF tools, perf, monitoring
> agents) will trigger ep_poll_callback() on isolated CPUs. On RT with the
> spinlock, this generates ~2,680 reschedule IPIs/s per isolated core.

Keep in mind that if you use kernel services, you can't expect perfect
isolation, or to never block on a mutex or get a callback -- but this
eosnoise issue does not mean that any perf_event_open() + epoll user
will be getting thousands of IPIs per second.

> The eventpoll spinlock noise regression needs its own fix =E2=80=94 perha=
ps=20
> a lockless path in ep_poll_callback() for the RT case, or=20

Again, if you mean the old lockless path, RT is exactly where we don't
want that.  What would be the reason to do this *only* for RT?

> converting ep->lock to a raw_spinlock with trylock semantics to avoid=20
> the rt_mutex IPI overhead.

Among other problems (what happens if the trylock fails?  why a trylock
in the first place?), you can't call wake_up() with a raw lock held.=20
It has its own non-raw spinlock.

-Crystal


