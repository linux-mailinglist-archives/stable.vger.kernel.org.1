Return-Path: <stable+bounces-263737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +0aBBwxOMWpmgQUAu9opvQ
	(envelope-from <stable+bounces-263737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:22:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A146768FDF2
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:22:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ICGfevQB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263737-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263737-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42D613026220
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 13:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11C63195FC;
	Tue, 16 Jun 2026 13:22:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957842EC0AE
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 13:22:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616122; cv=none; b=SzJA5KWOqJLFO7AbBQXS7Lw6XGmIdWOdxD+KKl1PICwfqSkHReKkc0O8lfzMJAayMLiOUwHwXP+Kww0/IOeAX1fcPLRB5jnJyu42Kpaj20PB7gr9iWdPoTWDDNUzvNj29I1wywN/nL/f6jBVnt1r619xyJUdkwr4gXHDS6QUMjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616122; c=relaxed/simple;
	bh=KRJ/LSYMqs/prOMG2KURVN0AKL9/cb2SXXvclwcslJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUlv5cfXp8J5XWkp79tAudVAYFIt7Jq4XV+UwNKOvet8uW//8WqQZfot2YOkB9jMC/D6K47o2F0pBTwK1HxCEcybthgFiKQMpKV5t4goMpa5e92Z4EaMFC0aBxlM/flwd2Z9iDuqMdjVI3l4tx+JDOJ4R6NGrg2B0RSD9Dn5bfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ICGfevQB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F38F1F000E9;
	Tue, 16 Jun 2026 13:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781616121;
	bh=6iG/EZwHxHHh0z5qkMGs9418TozMjPRUI7JpdzRblKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ICGfevQBzKSD6N/KOnlRzRCCg7n0ogl8WzSdy9L+XqrU5djvjM/jYL44K9tl2DdL+
	 mx8ioDik6occBaii5exWSqF464VVxyulDO0P4rML5oYp8x133+ClmNIUq4FKoqPjas
	 ZsaooKRwkcZ91Ww1eb7AfuxbJ1hNIso7oWcT9chk=
Date: Tue, 16 Jun 2026 18:50:56 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org, christian.koenig@amd.com,
	Honglei Huang <honghuan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: drop retry loop in amdgpu_hmm_range_get_pages
Message-ID: <2026061646-ship-culpable-1e01@gregkh>
References: <20260616130531.738887-1-alexander.deucher@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616130531.738887-1-alexander.deucher@amd.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263737-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alexander.deucher@amd.com,m:stable@vger.kernel.org,m:christian.koenig@amd.com,m:honghuan@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A146768FDF2

On Tue, Jun 16, 2026 at 09:05:31AM -0400, Alex Deucher wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> Since commit c08972f55594 ("drm/amdgpu: fix amdgpu_hmm_range_get_pages")
> moved mmu_interval_read_begin() out of the per-chunk loop, the
> captured notifier_seq is no longer refreshed across retries. As a
> result, the existing -EBUSY retry path can never make progress:
> 
>   hmm_range_fault() returns -EBUSY only when
>   mmu_interval_check_retry(notifier, notifier_seq) reports that the
>   sequence is stale. Once the sequence has advanced, the stored seq
>   will never match again, so every subsequent call within the same
>   invocation returns -EBUSY immediately.
> 
> The "goto retry" therefore degenerates into a busy spin that simply
> burns CPU for the full HMM_RANGE_DEFAULT_TIMEOUT (~1s) window before
> finally bailing out with -EAGAIN. This is pure latency with no chance
> of recovery, and it actively hurts the KFD userptr stack: the caller
> ends up blocked for a second while holding mmap_lock, only to return
> -EAGAIN to the restore worker (or to userspace) which would have
> re-driven the operation immediately anyway.
> 
> Drop the retry/timeout entirely and let -EBUSY propagate straight to
> out_free_pfns, where it is already translated to -EAGAIN. Recovery is
> handled at a higher level: the KFD restore_userptr_worker reschedules
> itself, and the userptr ioctl path returns -EAGAIN to userspace.
> 
> No functional regression: the previous behaviour on -EBUSY was already
> to fail with -EAGAIN after a 1s stall; we just skip the stall.
> 
> Fixes: c08972f55594 ("drm/amdgpu: fix amdgpu_hmm_range_get_pages")

This commit is not anywhere...


