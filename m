Return-Path: <stable+bounces-212910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHywILcWfWkGQQIAu9opvQ
	(envelope-from <stable+bounces-212910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 21:38:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD854BE743
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 21:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D58C5300A106
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 20:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A5132C312;
	Fri, 30 Jan 2026 20:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="pBile50Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8FB329E7F
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 20:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769805491; cv=none; b=HIGmKMrt0v77i98Vi290Rf2JrFW8UIj6319BM69KacGuij9SVEVoGqZMg4CHZ360Dpj0AKuxBxwoaWlz6eBy9VTD7ZT8EsdTjr/w5cc1yaJaaBeVa2wCoWh8yHs0eYgAP79y49yyex6yweorEkMrGhLd/MgyWU7zoXWUvAyWdlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769805491; c=relaxed/simple;
	bh=ZtMtrB2Y+G7ZscbAHQAFYF5f2VD5t3/mtZEyvZca4WU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=T73BRGYOhjfhwf+avfKQhpmJ/DuMdQdQ3Zchcv9N19R2CesNnJPgOZRXJxuYU+1HLPEcS4zFY6kliv3pBPUAn8HINMiKlhGeCKceo01Hp1mIsD8iz+PldQ7b0JC8M4kP1bkgzlfyM0FuT4YXhQHETcUHL8F1iE5WZr3JLHxsT5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=pBile50Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9694EC4CEF7;
	Fri, 30 Jan 2026 20:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769805491;
	bh=ZtMtrB2Y+G7ZscbAHQAFYF5f2VD5t3/mtZEyvZca4WU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pBile50QnlGw8x75Ig9U45/zvrTbeGA0ov5UjecXOYj8eYIHEOhIX+dMpbkvVuR0W
	 KaxG0ErlZlPaC9kxvgycPVLALXmhDSQoT1+nQjyuzLDUT5H8vJmsc62X6Y0T9uQaHR
	 4Qo3+b9PwRuH9v2n3d6JoxuwZYR/0fN/oL8ep4/Q=
Date: Fri, 30 Jan 2026 12:38:10 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, Ralph Campbell <rcampbell@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@mellanox.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>, linux-mm@kvack.org, stable@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] mm/hmm: Fix a hmm_range_fault() livelock / starvation
 problem
Message-Id: <20260130123810.61dde600422a8fe01cff8296@linux-foundation.org>
In-Reply-To: <b9dd97e7d9e62ebc33c4dfef53a9fd3f51352d3a.camel@linux.intel.com>
References: <20260130144529.79909-1-thomas.hellstrom@linux.intel.com>
	<20260130100013.fb1ce1cd5bd7a440087c7b37@linux-foundation.org>
	<b9dd97e7d9e62ebc33c4dfef53a9fd3f51352d3a.camel@linux.intel.com>
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
	TAGGED_FROM(0.00)[bounces-212910-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD854BE743
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 20:56:31 +0100 Thomas Hellstr=F6m <thomas.hellstrom@lin=
ux.intel.com> wrote:

> >=20
> > > --- a/mm/hmm.c
> > > +++ b/mm/hmm.c
> > > @@ -674,6 +674,13 @@ int hmm_range_fault(struct hmm_range *range)
> > > =A0			return -EBUSY;
> > > =A0		ret =3D walk_page_range(mm, hmm_vma_walk.last,
> > > range->end,
> > > =A0				=A0=A0=A0=A0=A0 &hmm_walk_ops,
> > > &hmm_vma_walk);
> > > +		/*
> > > +		 * Conditionally reschedule to let other work
> > > items get
> > > +		 * a chance to unlock device-private pages whose
> > > locks
> > > +		 * we're spinning on.
> > > +		 */
> > > +		cond_resched();
> > > +
> > > =A0		/*
> > > =A0		 * When -EBUSY is returned the loop restarts with
> > > =A0		 * hmm_vma_walk.last set to an address that has
> > > not been stored
> >=20
> > If the process which is running hmm_range_fault() has
> > SCHED_FIFO/SHCED_RR then cond_resched() doesn't work.=A0 An explicit
> > msleep() would be better?
>=20
> Unfortunately hmm_range_fault() is typically called from a gpu
> pagefault handler and it's crucial to get the gpu up and running again
> as fast as possible.

Would a millisecond matter?  Regular old preemption will often cause
longer delays.

> Is there a way we could test for the cases where cond_resched() doesn't
> work and in that case instead call sched_yield(), at least on -EBUSY
> errors?

kernel-internal sched_yield() was taken away years ago and I don't
think there's a replacement, particularly one which will cause a
realtime-policy task to yield to a non-rt-policy one.

It's common for kernel code to forget that it could have realtime
policy - we probably have potential lockups in various places.

I suggest you rerun your testcase with this patch using `chrt -r', see
if my speculation is correct.

