Return-Path: <stable+bounces-253653-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEv9DuKlD2ocOQYAu9opvQ
	(envelope-from <stable+bounces-253653-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:40:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A845AD82E
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34C6E301A711
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 00:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E7F1E1E16;
	Fri, 22 May 2026 00:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="z5SgS/6S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663AD24E4C3;
	Fri, 22 May 2026 00:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410245; cv=none; b=jMkJlAkjym/5QT2YBbq25OfUZyNAPc7EuTalee8JBLkGLntx0wZd5Bu6POwRZxNfZ6wpgxiK3n/vlMlpBYNmkq+kiR7P8wZUutP7tdO3HBps3wEE0iJDONfzPYW7eZL65ffXQX9u8Jyn0344BOP+BDH6ehK53t3numaTcCyiVYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410245; c=relaxed/simple;
	bh=PQlWfCYvLnhIfnTG3bXKLYMYsmGiuaS1LK0za3FsnpA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=U0lm2cZn23xYI50idSS23vLntzWdLCPLhKp/lumNc5KAPc5dNGStkRc0s0xBIZm6wxQvEhhsz6hCe2TBibRChh2ru+A7+LoZHSq/kFNFHJz+kR9lF2Zk/0kH+KRU4G6uQIJHcCDTYWpqftvxdxyiIhZ3jMNEfOjdCKjra74Hecw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=z5SgS/6S; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876041F000E9;
	Fri, 22 May 2026 00:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779410244;
	bh=vb/NSjxWzcfzykw7RUnxGmgm9FcNB+S5bWotyUmGLbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=z5SgS/6Scs6gzwAzXAZZj1I45LFxR/DzznVoUZCb+cdL3nccZjKp7KpekCUjegkEd
	 /20d6Ebtmf0sLshuUdhOu+VOqnZDAk67uMPWyLjF8bNcvmYBlxAW2ifoZUHhoXwIQo
	 x9V50ZEJUNAglos3nfAHHnv0vxWhBq3joMNAgv6I=
Date: Thu, 21 May 2026 17:37:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Juhyung Park
 <qkrwngud825@gmail.com>, linux-mm@kvack.org, stable@vger.kernel.org, Lu
 Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Oscar Salvador
 <osalvador@suse.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dan Williams <djbw@kernel.org>, Dave Jiang
 <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH] x86/mm: fix vmemmap leak on memory hot-remove
Message-Id: <20260521173723.ab1637d13848fcd2738be480@linux-foundation.org>
In-Reply-To: <78ef8003-9c86-4969-95b9-589127b30be2@intel.com>
References: <20260519151008.1399226-1-qkrwngud825@gmail.com>
	<e9a08bed-3d5f-4606-8d17-80a16a4c82f1@kernel.org>
	<CAD14+f316+wMZNm_sJF6ULRDUD9EbkdecdDwhGQKcsu70Bdp0w@mail.gmail.com>
	<9c0e3e53-d284-4675-89d8-943f93436e07@kernel.org>
	<78ef8003-9c86-4969-95b9-589127b30be2@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253653-lists,stable=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,kvack.org,vger.kernel.org,linux.intel.com,nvidia.com,suse.de,infradead.org,redhat.com,alien8.de,intel.com,lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-foundation.org:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 82A845AD82E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 14:54:30 -0700 Dave Hansen <dave.hansen@intel.com> wrote:

> On 5/20/26 14:52, David Hildenbrand (Arm) wrote:
> > On 5/20/26 12:33, Juhyung Park wrote:
> >> Neat. Any sign of it getting merged?
> > I hope it will catch the attention of more x86 maintainers soon 🙂
> 
> David, thanks a ton for that patch. It's in the queue behind a couple of
> other things, but I'll definitely take a look.
> 
> Attention caught, I promise! ;)

Oh, there it is.  I'll add a note to my copy reminding myself that
it'll be upstreamed via the x86 tree.

