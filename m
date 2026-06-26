Return-Path: <stable+bounces-268865-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jW4SEtBqPmrlFgkAu9opvQ
	(envelope-from <stable+bounces-268865-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 14:04:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8176CCC3D
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 14:04:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lrjUtRkm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268865-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268865-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48D493020A79
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 12:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8894C3F39D3;
	Fri, 26 Jun 2026 12:03:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B883CC330
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 12:03:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782475422; cv=none; b=lUCA5nSzIW8YFUA22RrEuqPFuXXag9MetSdzgs7FZwGEX//u93Ihnpiwvt+JvTqTh23LVRyxJvkvv3QHN7OLTQ50C89R5rI5qg+SIjRivPBumFqTUYOVPnph78Sj11NjZNlyl82BQqCPQHjeMYU7iYQt+4F9yREl8cmHmgXPk+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782475422; c=relaxed/simple;
	bh=CWXb+4thCgNlHUqML3azUtSDuVlrACHoggD+fOCUJeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaSHkVxxX3zItBWyaNTLnYMhnwnBgoqYiqGerJc3J1d7e7yhkP5D5/J3KT9v+GsEqFf/vOzWeiaf0nh0zyi4le1TiUy8n4h2IVHPz8zo4YV+L4KikU/4fX5cGcRx8NHNPb7uvLvPbAoxhaSX8zKm3v1WYYkfkfKRYIVMV5oOqNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrjUtRkm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C7A1F000E9;
	Fri, 26 Jun 2026 12:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782475421;
	bh=M+O8tsJQndsfmCOxVs6WQWK/G9XK0qBCLMq98dP4CqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lrjUtRkmeDylsGTxNEHtOePh1aCK2XrzEsz80+cPPLy//PrX/DOiRdcA9ztD8Md/w
	 NfAcljoHZ3BdbxP/RVqVi7l6WlnDXuA9nZbKjUogzfnNjGBib0WzuEL+0A410/6UVZ
	 7I8GeVMpXxsd8ax4WXlp3mHW4kT8l1REahR0Q/EU2oQaX9MNYdAt/J3DKZWYPRMZ1w
	 cZ1QBH5Z4Kdcs4TBL9IATQLTEwfoCFrByobdGBp1r6MwR7HU0v0qi0r3G2wF+ygXV3
	 yvYSTl77eWn6mjhm3HY5KO8EtxnhGEQKt31LOS8VXaBi7kMwhpHoF21ht+TvHzo39B
	 zFLEFRJu9KeIg==
Date: Fri, 26 Jun 2026 13:03:33 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Alice Ryhl <aliceryhl@google.com>, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: fix CONFIG_STACK_GROWSUP typo in
 tools/testing/vma/include/dup.h
Message-ID: <aj5qQA1Hj_M8sEb3@lucifer>
References: <20260611012258.432043-1-enelsonmoore@gmail.com>
 <8fc34141-b8a7-43fd-8c84-f843bd34fb9f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fc34141-b8a7-43fd-8c84-f843bd34fb9f@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268865-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,suse.de,linux-foundation.org,infradead.org,kvack.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:enelsonmoore@gmail.com,m:vbabka@kernel.org,m:jannh@google.com,m:pfalcato@suse.de,m:akpm@linux-foundation.org,m:liam@infradead.org,m:aliceryhl@google.com,m:linux-mm@kvack.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lucifer:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD8176CCC3D

On Wed, Jun 17, 2026 at 01:09:26PM +0200, David Hildenbrand (Arm) wrote:
> On 6/11/26 03:22, Ethan Nelson-Moore wrote:
> > Commit 2b6a3f061f11 ("mm: declare VMA flags by bit") significantly
> > refactored the header file include/linux/mm.h.  In that step, it introduced
> > a typo in an ifdef, referring to a non-existing config option
> > STACK_GROWS_UP, whereas the actual config option is called STACK_GROWSUP.
> > 
> > Commit 40a4af52e047 ("mm: fix CONFIG_STACK_GROWSUP typo in mm.h") fixed
> > this typo in the mm.h header file, but did not update the copy of the
> > code in tools/testing/vma/include/dup.h. Update this copy as well.
> > 
> > Commit message adapted from the above-referenced fix to mm.h.
> > 
> > Fixes: 2b6a3f061f11 ("mm: declare VMA flags by bit")
> > Cc: stable@vger.kernel.org # 7.0+
> 
> This is in tools/testing/vma. Why does this require a stable tag?
> 
> What is the resulting problem (in the test!) that we even care about the Fixes: tag?

Yeah I doubt very much that stable users are running VMA userland tests on
parisc :))

> 
> If there is no user visible (test!) problem, then this is merely a cleanup, not
> a bugfix.

Yeah I think moreso this.

> 
> Change itself LGTM.
> 
> > Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> > ---
> >  tools/testing/vma/include/dup.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
> > index 9e0dfd3a85b0..adbc3179085d 100644
> > --- a/tools/testing/vma/include/dup.h
> > +++ b/tools/testing/vma/include/dup.h
> > @@ -243,7 +243,7 @@ enum {
> >  #define VM_NOHUGEPAGE	INIT_VM_FLAG(NOHUGEPAGE)
> >  #define VM_MERGEABLE	INIT_VM_FLAG(MERGEABLE)
> >  #define VM_STACK	INIT_VM_FLAG(STACK)
> > -#ifdef CONFIG_STACK_GROWS_UP
> > +#ifdef CONFIG_STACK_GROWSUP
> >  #define VM_STACK_EARLY	INIT_VM_FLAG(STACK_EARLY)
> >  #else
> >  #define VM_STACK_EARLY	VM_NONE
> 
> 
> -- 
> Cheers,
> 
> David

Thanks, Lorenzo

