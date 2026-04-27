Return-Path: <stable+bounces-241260-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAClAtMa72lx6gAAu9opvQ
	(envelope-from <stable+bounces-241260-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:14:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B5A46EE54
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B8793008765
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C67829ACC5;
	Mon, 27 Apr 2026 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seMxTGJN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29169397E86;
	Mon, 27 Apr 2026 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277605; cv=none; b=fqjSX8OMnZvxGo2oWenDYwJb90KIKip3VDSSzfeQzUF083Em59G4qblcD7Yne6SGzLU96PTnVS46vcv3C8m3Fvv9X2FCI5Behu3gbmFr8+2cDbWReovLLoHgkFBfOE68jDvCP6hFgN8Fcj+QAuZuDeS6hlcmtiLpEXv7aK6psdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277605; c=relaxed/simple;
	bh=WmHusDz6RAwttLki4w/qj6U6yTjKSQFS4mC/99h4CTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQvkzpn02D9A+UuEfMIT/8ZrinWrQOgRJLVNvg1WfYKWNq3/QUGhbMsdAFw9dr0//4oWfsCci9sRwGs3O8D9aJsw27K9RXA4zMXoLcF1tCJA7KewlYTC8MQQKmjDnxQhp96buhgOlTTPPfnMEgwazk+mj1a6cZmJuoOtrrgle38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seMxTGJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980A0C19425;
	Mon, 27 Apr 2026 08:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777277605;
	bh=WmHusDz6RAwttLki4w/qj6U6yTjKSQFS4mC/99h4CTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=seMxTGJN4uv6l+RdFXYx1uMxe4oufBuf9DmTpU6mefMKEkq+nUS6OyD2tYH7tZSaL
	 1vn27hcMwt7dXLXkBuElGqXmIzggyVJ6sdLXMnWiu/H6CE12CIjmUjzrmx0LtbjQmq
	 jI6yj6Ssost+fkqK/jzHRdUeyG6QZSTsWSohW5PyHVuHQpq0FKcSd41j00KlT+FWcx
	 7D24Iw8X+d33WTN9Fe0+BYDDpEp6Ouhn65cgeU/Q5uwPqJWAyTZOyvwtNEGazy6MAN
	 YUhOGaOVGw+W5rh4DGRABMMv/aiCeR4u9gTptrIF/+5l5aKNyptCW21EF6AMac48Yd
	 6hRJnhdAu3tGQ==
Date: Mon, 27 Apr 2026 17:13:22 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>, Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH mm-hotfixes v2 0/2] mm/page_alloc,slab: return NULL early
 from *_nolock() memory allocation APIs in NMI on UP
Message-ID: <ae8aojxbv4PHq_C3@desktop.tail10959e.ts.net>
References: <20260427-nolock-api-fix-v2-0-a6b83a92d9a4@kernel.org>
 <c3f7b8e4-85ae-4e80-bb02-a7b205cec88e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3f7b8e4-85ae-4e80-bb02-a7b205cec88e@kernel.org>
X-Rspamd-Queue-Id: 50B5A46EE54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241260-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 10:00:16AM +0200, Vlastimil Babka (SUSE) wrote:
> On 4/27/26 09:09, Harry Yoo (Oracle) wrote:
> > Due to my mistake, V1 was sent twice w/o proper cover letter and
> > Cc: stable. Please ignore V1. Apologies for the noise. 
> > 
> > Changes since V1:
> > - used b4 to send patch series (w/ a proper cover letter) instead of
> >   my broken git send-email script (Thanks Vlastimil)
> > - added Cc: stable to patches 1 and 2
> > 
> > On UP kernels (!CONFIG_SMP), spin_trylock() is a no-op that
> > unconditionally succeeds even when the lock is already held.
> > As a result, alloc_frozen_pages_nolock() and kmalloc_nolock() called
> > from an NMI context can successfully re-acquire the lock that the
> > page/slab allocators are already holding (no deadlock because it's
> > trylock,  but leads to e.g., allocating the same page/object twice and
> > causing use-after-free).
> > 
> > It was discovered while testing the new kmalloc/kfree_nolock() test case
> > in the slub_kunit test module with CONFIG_DEBUG_SPINLOCK=y on a UP
> > kernel.
> > 
> > Patch 1 fixes alloc_frozen_pages_nolock() and
> > patch 2 fixes kmalloc_nolock().
> 
> Thanks. Given the problem exposed is in a slab kunit test I think it's
> better to handle this in the slab tree.

Ack, I'm fine either way.

> The page_alloc change is small and
> should not cause conflicts.

Right.

> So I've merged both in slab/for-next.

Thanks! (I see it's been added to slab/for-next-fixes)

-- 
Cheers,
Harry / Hyeonggon

