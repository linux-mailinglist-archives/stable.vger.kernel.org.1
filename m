Return-Path: <stable+bounces-230473-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCI3A1FHxWkU8wQAu9opvQ
	(envelope-from <stable+bounces-230473-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 15:48:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAAB337031
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 15:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 208A5319805F
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 14:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FDC401A05;
	Thu, 26 Mar 2026 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rrcvDGkn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IcfKReEs"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287AB3FE346;
	Thu, 26 Mar 2026 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535514; cv=none; b=i7sKiEz0iFbbObACZIWrHGAwG8pMk+oj1qV9QN69fiUOo1Bw9zIcx2IfOP2XQmgquIgKtTIVgqQGn/Ijh4w3Nenb0humnnItsa50cJlZLws1zoRrB6uI/ZNy5yXfADGyWRsczxplWJ0FSaAQfB9fkXlWZ88NNNBSLnG97l5HvZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535514; c=relaxed/simple;
	bh=BHmdpxEbzLCqW2m5QZyz7fL+oBEjUeONGcHmEWrJz5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/pCfEhwUXqJTHc8METoN48Kwl096rVtwiO0dBTWLUSbaqUexEJyJ+WajMG84w463VPnj/jGCNSXwgNI77zN0l517NXGPw8doLvYrKzD9ytDzgNPD67HLYeK3V6RgxFNY6wm4ULwOOf2dG/OZRKHgUmJm7OZKj/9e2Mep0gfuYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rrcvDGkn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IcfKReEs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Mar 2026 15:31:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774535510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FmibA3BK/FNElbRT3n9Nme/rbnKB/b1nw1TIVlzRQCY=;
	b=rrcvDGknLf7Iz/fRUI/5AcanxZLH/8SOWDEeayaeNPPzvPZqCrziFuuWQv/XlfqfqnWw+n
	o+GTcr0quJ3vNNKARm0h6iUN3odA9AXG/+dfH8G4Eouwv3dIPOaFqZTSCZU1i5PozxAlIz
	Os6P+c9uMrZ/dbOv9ulhBEDoQ0T2clM6s8gRLVUKo55aPkl21cyT5gTkEFHsY2USXhTDIW
	Z2CEqzybu+1/zL+pP+DtQJUWs35TzQaAeZdxtBiuW68w9KyYIMdEnFqkFwU5lhUX0k+xkX
	smp6AC1ib7bAXg8u7a4eI+PpZNE8yuZHMYN1qM8fsjE17U8hwiodII+e/f5fMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774535510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FmibA3BK/FNElbRT3n9Nme/rbnKB/b1nw1TIVlzRQCY=;
	b=IcfKReEsnAei/28ODHpj/d1VAnMfv7Q0CuXUyAdFSudJAtOXfLzicqy6+gFsxcaj3uFz3q
	6mI+jvsIWjTIbNBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: namcao@linutronix.de, brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, frederic@kernel.org,
	vschneid@redhat.com, gregkh@linuxfoundation.org,
	chris.friesen@windriver.com, viorel-catalin.rapiteanu@windriver.com,
	iulian.mocanu@windriver.com
Subject: Re: [REGRESSION] osnoise: =?utf-8?Q?=22eve?=
 =?utf-8?Q?ntpoll=3A_Replace_rwlock_with_spinlock=22_causes_~50=C2=B5?=
 =?utf-8?Q?s?= noise spikes on isolated PREEMPT_RT cores
Message-ID: <20260326143149.lYgaWmMp@linutronix.de>
References: <20260326140058.272854-1-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260326140058.272854-1-ionut.nechita@windriver.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230473-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9CAAB337031
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-26 16:00:57 [+0200], Ionut Nechita (Wind River) wrote:
> Summary across all isolated cores (32 CPUs):
> 
>                           With spinlock       With rwlock (reverted)
>   MAX noise (ns):         44,343 - 51,869     0 - 10
>   IRQ count/sample:       ~6,650 - 6,870      3 - 7
>   Thread noise/sample:    ~5,700 - 5,940      0 - 1
>   CPU availability:       94.5% - 95.3%       ~100%

is there some load or just idle with osnoise?

> My understanding of the root cause: the original rwlock allowed
> ep_poll_callback() (producer side, running from IRQ context on any CPU)
> to use read_lock, which does not cause cross-CPU contention on isolated
> cores when no local epoll activity exists. With the spinlock conversion,
> on PREEMPT_RT spinlock_t becomes an rt_mutex. This means that even if
> the isolated core is not involved in any epoll activity, the lock's
> cacheline bouncing and potential PI-boosted wakeups from housekeeping
> CPUs can inject noise into the isolated cores via IPI or cache
> invalidation traffic.

With the read_lock() you can acquire the lock with multiple readers.
Each read will increment the "reader counter" so there is cache line
activity. If a isolated CPU does not participate, it does not
participate. With the change to spinlock_t there can be only one user at
a time. So the other have to wait and again, isolated core which don't
participate are not affected.

> The commit message acknowledges the throughput regression but argues
> real workloads won't notice. However, for RT/latency-sensitive
> deployments with CPU isolation, the impact is severe and measurable
> even with zero local epoll usage.
> 
> I believe this needs either:
>   a) A revert of the backport for stable RT trees, or

I highly doubt since it affected RT loads.

>   b) A fix that avoids the spinlock contention path for isolated CPUs
> 
> I can provide the full osnoise trace data if needed.

So the question is why are the isolated core affected if they don't
participate is epoll.

> Tested on:
>   Linux system-0 6.12.78-vanilla-{0,1} SMP PREEMPT_RT x86_64
>   Linux system-0 6.12.57-vanilla-{0,1} SMP PREEMPT_RT x86_64
> 
> Thanks,
> Ionut.

Sebastian

