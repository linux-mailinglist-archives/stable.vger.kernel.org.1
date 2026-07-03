Return-Path: <stable+bounces-271790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C79RHzG/R2p1egAAu9opvQ
	(envelope-from <stable+bounces-271790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 15:54:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB9B7031BE
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 15:54:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Un1KjgIk;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271790-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271790-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE5F33012C9A
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 13:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F264E3D16F9;
	Fri,  3 Jul 2026 13:54:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC96F10785;
	Fri,  3 Jul 2026 13:54:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086889; cv=none; b=NphcS5aBPkJOeAApvsRYY70VCxJ/i62aowfYlGJCorcng8cPJ47nifVrMgNcU4orfrz/pcLRVhdLrHwSYX2gv8sgfqtVHjke+lJhPFOi30RFEGHBsr3Mm7d98Vl60Ypye5aknweDlFsK3VsCVwvSbMWS7u5qx1feqJpUxRFllk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086889; c=relaxed/simple;
	bh=/CtZ3Exkjc6idb1NSE6jDuYoj19Za6xd4nFYiO/AITs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6Yx+Rx47Q/whrAWFrplkAHlVziK8R1ISx05td02rHKBwVu0ek8ZXCtyr0qvtpIapadzle/A8GvIsNEatiYvDKWHVMyfB5NTI9h/DIkOUHR1ULgKU4gQ8T24n3uMi75u8NSMoNAnh86ELbsuBngIWQU91cmo6C6NKdYWQzF2+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un1KjgIk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65891F000E9;
	Fri,  3 Jul 2026 13:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783086888;
	bh=J7lXeUh6QUNy9Z3dsTupqf3hFsqiT1T6e75ZkSXnH6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Un1KjgIkbys6cN/Ii43o3pl8ddXkKk6LxBp1QYwYHVqAumvwlkRdXioMPGIN73xeO
	 0xk4NWKagLR/ZCxwnwzAc9l/4JEU6U6ODbg4IgW3LPAjFRC1bwK9Oo3RkCQIbtqo70
	 BaiHodMnXNQjWymSuQbrfD/LEMSd+0awXY8eztt5DK3e36nZ01Lq0GYK3ETzo4dRpe
	 O/ogiFKynuZcJMJwJY8qEx/r70lwjCf7kVWcKreUbYBDIbY2fp2zmMEtxwIEIj7fCs
	 34e0oGkdAAfjBshDpXVqlbYjplyBtc8Jt0vwD7THDyxyrACXBBSoktmOYJHngsoo6U
	 1tHF48iLRtTgQ==
Date: Fri, 3 Jul 2026 14:54:41 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, Jan Kara <jack@suse.cz>, 
	Oleg Nesterov <oleg@redhat.com>, Peter Xu <peterx@redhat.com>, 
	vova tokarev <vladimirelitokarev@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] userfaultfd: prevent registration of special VMAs
Message-ID: <ake8LUosdwCdleHe@lucifer>
References: <20260618095017.2553004-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618095017.2553004-1-rppt@kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rppt@kernel.org,m:akpm@linux-foundation.org,m:torvalds@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:david@kernel.org,m:jack@suse.cz,m:oleg@redhat.com,m:peterx@redhat.com,m:vladimirelitokarev@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-271790-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,linuxfoundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,redhat.com,gmail.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lucifer:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAB9B7031BE

On Thu, Jun 18, 2026 at 12:50:17PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Vova Tokarev says:
>
>   userfaultfd allows registration on shadow stack VMAs.  With userfaultfd
>   access, you can register on the shadow stack, discard a page ... and
>   inject a page with chosen return addresses via UFFDIO_COPY.
>
> Update vma_can_userfault() to reject VM_SHADOW_STACK.
>
> While on it, also reject VM_SPECIAL so that if a driver would implement
> vm_uffd_ops, it wouldn't be possible to register special VMAs with
> userfaultfd.
>
> Since VM_SPECIAL includes VM_DONTEXPAND which is set but hugetlb,
> exclude hugetlb VMAs from the check for VM_SPECIAL.
>
> Reported-by: vova tokarev <vladimirelitokarev@gmail.com>
> Fixes: 54007f818206 ("mm: Introduce VM_SHADOW_STACK for shadow stack memory")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

I'm working on a series to take care of the issues discussed at [0].

[0]:https://lore.kernel.org/all/20260618183442.BBCD71F000E9@smtp.kernel.org

> ---
>
> v2 changes:
> * reject all VM_SPECIAL except hugetlb
>
> v1: https://lore.kernel.org/all/20260617194059.2529406-1-rppt@kernel.org
>
>  mm/userfaultfd.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 246af12bf801..c3adedaaf7d5 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -2111,7 +2111,10 @@ static bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
>  {
>  	const struct vm_uffd_ops *ops = vma_uffd_ops(vma);
>
> -	if (vma->vm_flags & VM_DROPPABLE)
> +	if (vma->vm_flags & (VM_DROPPABLE | VM_SHADOW_STACK))
> +		return false;
> +
> +	if (!is_vm_hugetlb_page(vma) && (vma->vm_flags & VM_SPECIAL))
>  		return false;
>
>  	vm_flags &= __VM_UFFD_FLAGS;
>
> base-commit: e3d8707358ea76b78bdec9928937bb9a797f2c8f
> --
> 2.53.0
>
>

Cheers, Lorenzo

