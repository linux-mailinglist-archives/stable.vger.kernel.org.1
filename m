Return-Path: <stable+bounces-212897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI9MI7XxfGndPQIAu9opvQ
	(envelope-from <stable+bounces-212897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 19:00:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 305E7BD907
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 19:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FF04300DDC7
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 18:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBB136A002;
	Fri, 30 Jan 2026 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gB6I7Wum"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C407A1CAA79
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769796014; cv=none; b=EoeB3TH2P0Gmxgfdd1mJp3fHqLiBgHu/FV7avCpJ1GveieIlGzOnjwgaFfrPKB2mrH5A6K9gFMqIsCCyKW/4Yi7UVN/yY5qZ4ceNCBLC5NNnt4KyJq56vm6usuYT0/69Xhyp7sgQvgRIqRTPd0KUr1/UsMhwrGHMqsEwj94sRjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769796014; c=relaxed/simple;
	bh=AFVyapZz7+rnLVcwl8jFcNdohlBEAdutFNruQ1aqrP4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J9F/OC85V5vG3r5bwLLVgiLeBk17/CQqoCU7BAWE2a7SBFu+ypfMHrIeVUQ6ufGSCGkHQxAOfpZGaoylhkwpx3tIUyHe//s70Pj8f/ZdJ1GdgzzElOAqCriLV7F3ZPGJjm8VOIV6+31QjTfcKcCNv2S4HeL97l2WjGL/0rGUgv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gB6I7Wum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30691C4CEF7;
	Fri, 30 Jan 2026 18:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769796014;
	bh=AFVyapZz7+rnLVcwl8jFcNdohlBEAdutFNruQ1aqrP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gB6I7WumOiVus7/WSV+qgJ8RC4GHJIMv0c9/bfPssW0cj2v2O8c2Vr1yOFpxpaIfL
	 606t/2u3ouWNJ6bwa1u+fRQUs4MTsPyVqGrH/GnFVGUoyC9tpvjpwO2XIha24hfAd9
	 UozEq6LX5GI/tCl7U2fq5VpTpS4xqDqTcHxIavIk=
Date: Fri, 30 Jan 2026 10:00:13 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, Ralph Campbell <rcampbell@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@mellanox.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>, linux-mm@kvack.org, stable@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] mm/hmm: Fix a hmm_range_fault() livelock / starvation
 problem
Message-Id: <20260130100013.fb1ce1cd5bd7a440087c7b37@linux-foundation.org>
In-Reply-To: <20260130144529.79909-1-thomas.hellstrom@linux.intel.com>
References: <20260130144529.79909-1-thomas.hellstrom@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212897-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:mid,linux-foundation.org:dkim,intel.com:email]
X-Rspamd-Queue-Id: 305E7BD907
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 15:45:29 +0100 Thomas Hellstr=F6m <thomas.hellstrom@lin=
ux.intel.com> wrote:

> If hmm_range_fault() fails a folio_trylock() in do_swap_page,
> trying to acquire the lock of a device-private folio for migration,
> to ram, the function will spin until it succeeds grabbing the lock.
>=20
> However, if the process holding the lock is depending on a work
> item to be completed, which is scheduled on the same CPU as the
> spinning hmm_range_fault(), that work item might be starved and
> we end up in a livelock / starvation situation which is never
> resolved.
>=20
> This can happen, for example if the process holding the
> device-private folio lock is stuck in
>    migrate_device_unmap()->lru_add_drain_all()
> The lru_add_drain_all() function requires a short work-item
> to be run on all online cpus to complete.

This is pretty bad behavior from lru_add_drain_all().

> A prerequisite for this to happen is:
> a) Both zone device and system memory folios are considered in
>    migrate_device_unmap(), so that there is a reason to call
>    lru_add_drain_all() for a system memory folio while a
>    folio lock is held on a zone device folio.
> b) The zone device folio has an initial mapcount > 1 which causes
>    at least one migration PTE entry insertion to be deferred to
>    try_to_migrate(), which can happen after the call to
>    lru_add_drain_all().
> c) No or voluntary only preemption.
>=20
> This all seems pretty unlikely to happen, but indeed is hit by
> the "xe_exec_system_allocator" igt test.
>=20
> Resolve this using a cond_resched() after each iteration in
> hmm_range_fault(). Future code improvements might consider moving
> the lru_add_drain_all() call in migrate_device_unmap() out of the
> folio locked region.
>=20
> Also, hmm_range_fault() can be a very long-running function
> so a cond_resched() at the end of each iteration can be
> motivated even in the absence of an -EBUSY.
>=20
> Fixes: d28c2c9a4877 ("mm/hmm: make full use of walk_page_range()")

Six years ago.

> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -674,6 +674,13 @@ int hmm_range_fault(struct hmm_range *range)
>  			return -EBUSY;
>  		ret =3D walk_page_range(mm, hmm_vma_walk.last, range->end,
>  				      &hmm_walk_ops, &hmm_vma_walk);
> +		/*
> +		 * Conditionally reschedule to let other work items get
> +		 * a chance to unlock device-private pages whose locks
> +		 * we're spinning on.
> +		 */
> +		cond_resched();
> +
>  		/*
>  		 * When -EBUSY is returned the loop restarts with
>  		 * hmm_vma_walk.last set to an address that has not been stored

If the process which is running hmm_range_fault() has
SCHED_FIFO/SHCED_RR then cond_resched() doesn't work.  An explicit
msleep() would be better?

