Return-Path: <stable+bounces-247723-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFuWGMEOB2oLrAIAu9opvQ
	(envelope-from <stable+bounces-247723-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:17:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA3754F4E9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51FB5320701C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B1547DF96;
	Fri, 15 May 2026 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pB3rLOif"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C5C25B0BD
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846452; cv=none; b=Sf+2Yi9e9iEQHUmpb/kmZWcbEpZk9wQVOxX35JUx/N8s47CkNQdhltmCZ9QxDBOYRZVjP8mAdezQljEfQLIKDoo0nwY0eOSpUAiE7Y5INT2YqSeGAYljQsRrwbVhYTMW9q++P7hOQFIRW6Pgp7E1RGFYdEuTyUjAzI3PcLANBX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846452; c=relaxed/simple;
	bh=WZnNIBt2urPbxa47troMlcZGn0NLvkjQIUasM9GRgDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mz2mw/eiDFLokHgBuPmZW0CsAZf35pzEWgVhSQgVZEzUINxRlXCeTbSa1zJZV8iQY0jDqKk/tlF2PTFKFszcQLzg49C9GP2nOo/PVNhI/rnpI+ejSUt/z8WYkoWlnxw7mNCdwFnmB6oI4UGvg3cB3/rtN+DdVY6RYl4vOTzV3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pB3rLOif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE650C2BCB0;
	Fri, 15 May 2026 12:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778846451;
	bh=WZnNIBt2urPbxa47troMlcZGn0NLvkjQIUasM9GRgDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pB3rLOifn+WsvWCUeIEWFVrzDnBFP4vrbr8hMs4KYBxS2XnLrog6MEqkDcp4FQLIc
	 zm/bM7qiiMq4uXt65cFCJsVRjS9noXKUIiq+/jwYxAA7tFbx7BmKoVtw107p2oGWdt
	 6lWwc7skpeyKCzN7kxK6s0e8YGxgoj9UTw5ltuDMPh0ycOCP+5MC8QQIdReSlLUl8/
	 v2J5GJvth2iHMhrTD/koTwXvdhg4xUMWOWJrhcRPPb01UU2BM+HfTx7jg+gvrWFDCU
	 aDthO+bSzv1GfuhfSUQMLV0C408bAuhwmBsHvpHUFPjDkUeEZTqWb1lZljQfbyqyxH
	 t4NEn0c7otwOA==
Date: Fri, 15 May 2026 13:00:47 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Ahmed Elaidy <elaidya225@gmail.com>
Cc: stable@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	avagin@gmail.com
Subject: Re: [PATCH 6.18.y v1 0/9] mm: backport sticky VMA flags and
 soft-dirty fix
Message-ID: <agcK1mzmGbB5KSpP@lucifer>
References: <20260424211315.1072123-1-elaidya225@gmail.com>
 <agcG2uKHhlt85FaV@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agcG2uKHhlt85FaV@lucifer>
X-Rspamd-Queue-Id: CBA3754F4E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247723-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux-foundation.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 12:44:55PM +0100, Lorenzo Stoakes wrote:
> Hi,
>
> Just a heads up that I generally don't read kernel mail sent to my work address,
> as I changed my email setup significantly and use ljs@kernel.org for everything
> upstream!
>
> Understandable given the original patches obviously used it but just FYI :)
>
> Cheers, Lorenzo
>
> On Sat, Apr 25, 2026 at 12:12:34AM +0300, Ahmed Elaidy wrote:
> > This series backports the sticky VMA flags infrastructure and the
> > VM_SOFTDIRTY-on-merge fix to linux-6.18.y.
> >
> > Motivation: CRIU incremental dump/restore can hit a missing-parent-pagemap
> > failure when VM_SOFTDIRTY is lost during VMA merge operations.
> >
> > Patch 8 is the target fix:
> >   mm: propagate VM_SOFTDIRTY on merge
> >
> > The preceding patches provide required dependencies on 6.18.y and are included
> > to preserve upstream behavior.
> >
> > Backport notes:
> >   - Non-trivial context conflicts were resolved in:
> >     - mm/mseal.c
> >     - mm/vma.c
> >   - Conflict resolution keeps upstream semantics; no intentional behavior
> >     changes beyond context adaptation for 6.18.y.

Thanks for doing this, had a quick look through the series and all LGTM!

Cheers, Lorenzo

> >
> > Cc: stable@vger.kernel.org
> >
> >
> >
> > Lorenzo Stoakes (9):
> >   mm: introduce VM_MAYBE_GUARD and make visible in /proc/$pid/smaps
> >   mm: add atomic VMA flags and set VM_MAYBE_GUARD as such
> >   mm: update vma_modify_flags() to handle residual flags, document
> >   mm: implement sticky VMA flags
> >   mm: introduce copy-on-fork VMAs and make VM_MAYBE_GUARD one
> >   mm: set the VM_MAYBE_GUARD flag on guard region install
> >   tools/testing/vma: add VMA sticky userland tests
> >   mm: propagate VM_SOFTDIRTY on merge
> >   testing/selftests/mm: add soft-dirty merge self-test
> >
> >  Documentation/filesystems/proc.rst      |   5 +-
> >  fs/proc/task_mmu.c                      |   1 +
> >  include/linux/mm.h                      | 100 +++++++++++++++++
> >  include/trace/events/mmflags.h          |   1 +
> >  mm/khugepaged.c                         |  71 +++++++-----
> >  mm/madvise.c                            |  24 +++--
> >  mm/memory.c                             |  14 +--
> >  mm/mlock.c                              |   2 +-
> >  mm/mprotect.c                           |   2 +-
> >  mm/mseal.c                              |   7 +-
> >  mm/vma.c                                |  81 +++++++-------
> >  mm/vma.h                                | 138 +++++++++++++++++-------
> >  tools/testing/selftests/mm/soft-dirty.c | 127 +++++++++++++++++++++-
> >  tools/testing/vma/vma.c                 |  92 ++++++++++++++--
> >  tools/testing/vma/vma_internal.h        |  49 +++++++++
> >  15 files changed, 579 insertions(+), 135 deletions(-)
> >
> > --
> > 2.53.0

