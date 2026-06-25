Return-Path: <stable+bounces-268571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1z/XKFA5PWrPzQgAu9opvQ
	(envelope-from <stable+bounces-268571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:21:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 121476C68FB
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:21:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WlZL41Uz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268571-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268571-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EBF8300517E
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A423191BD;
	Thu, 25 Jun 2026 14:16:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D4E31F9BA
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 14:16:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396973; cv=none; b=R0Zj2dueZHGYp6njsvuV5jIUrvX+ftmH+5hbCmaSXbxjOY91lpGDmTaRdzdhX30Mpw4CRrh1z3/4G8LmiseW8f9nGHz4WSYcVL7JeCYie9x60f4m2WMorO1aVaR8C8JiAmB6eRNvQVKPxW1H8Am4PIBBKlG2fSxdurGY/2p1nAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396973; c=relaxed/simple;
	bh=Q9k/XlLYpxa2dXDqx64ywoysOqzd/EJtWWo4INr6ctA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWbdAsD2nA0KxiJtqsuLS9iRtnXuERQYrm9QkRrSkoY68Ith9Nqwdh5vKKgIxPFZ2Ka8XTlVPn8OJ0xTBCB1Menyg3j1GNaYE7RMV0SMsV4MpKikfkJXbmuvnAqToJ1RtKUb7ctWTIKHHs5w97lLW/CirQj+7SG3yt6BpW8MLxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlZL41Uz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE95B1F000E9;
	Thu, 25 Jun 2026 14:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782396972;
	bh=P1wRyU/uVNwsp5kIpSXtq4B2ItLSS4KA+rDnr/bqKuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WlZL41UzRiX8cjHL5fclbP1oUeUmu/npCkFYFOd7GhvuS2aoGlVBfLYYz+laPX0Qi
	 KZ6mlLuIS7Vz4izOYCLsDds6pS8bhhv0Di9gJfWZTvGEggBRfcqdv4OEZpU5c4xs6Y
	 sfFaHf8RFGZfQqyQTyE9qvz/0zW7DVOXmZGpaJUhdA8rkvemH8791TLDOs/c5lm8Cp
	 DseI9ZRnZRBdbKeTNC+afmL2Wv3zHc4xtU4Kzf6SoH8oBzaVM3tdjyYUo+/5Z96hxX
	 Gc83tx63B3ZdKYuVBHqItKnYkeFpWWCqsqOVBPIBF/cEl6MYG8+FkN5pmo+naq1/oi
	 5Rbvj39cy/Hpw==
Date: Thu, 25 Jun 2026 15:16:05 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Ahmed Elaidy <elaidya225@gmail.com>
Cc: stable@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	avagin@gmail.com
Subject: Re: [PATCH 6.18.y v4 0/9] mm: backport sticky VMA flags and
 soft-dirty fix
Message-ID: <aj04FzkKa-9kqVrJ@lucifer>
References: <20260515124218.151966-2-elaidya225@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515124218.151966-2-elaidya225@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:elaidya225@gmail.com,m:stable@vger.kernel.org,m:linux-mm@kvack.org,m:akpm@linux-foundation.org,m:avagin@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268571-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux-foundation.org,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,lucifer:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 121476C68FB

On Fri, May 15, 2026 at 03:42:10PM +0300, Ahmed Elaidy wrote:
> This series backports the sticky VMA flags infrastructure and the
> VM_SOFTDIRTY-on-merge fix to linux-6.18.y.

Thanks again for doing this Ahmed! :)

Cheers, Lorenzo

>
> Motivation: CRIU incremental dump/restore can hit a missing-parent-pagemap
> failure when VM_SOFTDIRTY is lost during VMA merge operations.
>
> Patch 8 is the target fix:
>   mm: propagate VM_SOFTDIRTY on merge
>
> The preceding patches provide required dependencies on 6.18.y and are included
> to preserve upstream behavior, as requested by maintainers for stable backports.
>
> Changes since v3:
>   - Reverted to sending the full 9-patch series as requested by Greg KH and Lorenzo.
>   - Updated Lorenzo's email to ljs@kernel.org across all patches.
>   - Added Cc: stable@vger.kernel.org # 6.18.x to all patches.
>   - Added Fixes tag for soft-dirty merging in Patch 8.
>
> Lorenzo Stoakes (9):
>   mm: introduce VM_MAYBE_GUARD and make visible in /proc/$pid/smaps
>   mm: add atomic VMA flags and set VM_MAYBE_GUARD as such
>   mm: update vma_modify_flags() to handle residual flags, document
>   mm: implement sticky VMA flags
>   mm: introduce copy-on-fork VMAs and make VM_MAYBE_GUARD one
>   mm: set the VM_MAYBE_GUARD flag on guard region install
>   tools/testing/vma: add VMA sticky userland tests
>   mm: propagate VM_SOFTDIRTY on merge
>   testing/selftests/mm: add soft-dirty merge self-test
>
>  Documentation/filesystems/proc.rst      |   5 +-
>  fs/proc/task_mmu.c                      |   1 +
>  include/linux/mm.h                      | 100 +++++++++++++++++
>  include/trace/events/mmflags.h          |   1 +
>  mm/khugepaged.c                         |  71 +++++++-----
>  mm/madvise.c                            |  24 +++--
>  mm/memory.c                             |  14 +--
>  mm/mlock.c                              |   2 +-
>  mm/mprotect.c                           |   2 +-
>  mm/mseal.c                              |   7 +-
>  mm/vma.c                                |  81 +++++++-------
>  mm/vma.h                                | 138 +++++++++++++++++-------
>  tools/testing/selftests/mm/soft-dirty.c | 127 +++++++++++++++++++++-
>  tools/testing/vma/vma.c                 |  92 ++++++++++++++--
>  tools/testing/vma/vma_internal.h        |  49 +++++++++
>  15 files changed, 579 insertions(+), 135 deletions(-)
>
> --
> 2.54.0
>

