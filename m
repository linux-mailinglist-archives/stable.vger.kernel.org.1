Return-Path: <stable+bounces-235579-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJzfOmat2GljgwgAu9opvQ
	(envelope-from <stable+bounces-235579-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 09:57:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFA43D3A8A
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 09:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02B07302DF78
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 07:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7963A5E66;
	Fri, 10 Apr 2026 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbmvvTsT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909D03A16BD;
	Fri, 10 Apr 2026 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775807711; cv=none; b=I8YUlXQ9ig3TR+6B+rhniVsrGRKabTOuhILPQjS82lD4VIzqC2Bmsuien6MDdZ74M2BGWEbsxg1NnkdFrk6lm7VJP1KRG+PobEwlMYuH4A3L/L6bHp3K1x2WDcxdBaae7N+N3qgrn4t20eaIsZzX1UNLq8081nUXQ0zYleUK7d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775807711; c=relaxed/simple;
	bh=V2WaGIwNQByyApdD9rJsZSORL3u2V1EnnabUeYS07DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWoYa1B7BgSpen0lDjyL+T5ILxtkS0Xef5gc1onfcEndUC0WQ33SWmwbGz/OB31PWJ6dkeWvujBQoKY6jOQra7b5hvnbeKLdymrtknysNwkfzqLJCeH9UvRR6vivIxnuD1aqFhl2hVSo3bnZENA6O+dwG/9LmQ9A2s7RO3NiDrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbmvvTsT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53431C19424;
	Fri, 10 Apr 2026 07:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775807711;
	bh=V2WaGIwNQByyApdD9rJsZSORL3u2V1EnnabUeYS07DE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qbmvvTsT63xwWfUSuuYpx96wf2awcOteh5/4PqhMIVYARDxVzvSTWkM9OP7KY+PCt
	 Vcy4Lw9hQjH+DGQVJ9+R9jxxYPrOhBpYQpG9e+FeUWsjxuNQQk5r+RTfwfVz/Kxh6a
	 Ai61m315lOGNCcw7UjcoQX4wfeg41Bbwom4Z86O/3EExnEIUmNvG+dUrBwy8xLDrey
	 P3oL+QPdyYpwUSBGf1pdWvuJi12t5zqskKHezNe2+cXp/ZSmfQeQZgnCX2rAtU2Vz+
	 NkUHMpLvG1LkAml+hatPUafZqtkHi8/vNbVxYKdicJh9FyY4+9G/wKKVUwecVDwmid
	 uFjL4toXO7izQ==
Date: Fri, 10 Apr 2026 10:55:04 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, peterx@redhat.com, surenb@google.com,
	aarcange@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: preserve write protection across UFFDIO_MOVE
Message-ID: <adis2GsC6q29ijL_@kernel.org>
References: <20260409152822.1073083-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409152822.1073083-1-gourry@gourry.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-235579-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3AFA43D3A8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 11:28:22AM -0400, Gregory Price wrote:
> move_present_ptes() unconditionally makes the destination PTE writable,
> dropping uffd-wp write-protection from the source PTE.
> 
> The original intent was to follow mremap() behavior, but mremap()'s
> move_ptes() preserves the source write state unconditionally.
> 
> Modify uffd to preserve the source write state and check the uffd-wp
> condition of the source before setting writable on the destination.
> 
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/userfaultfd.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index e6dfd5f28acd..783ca68aed88 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1123,7 +1123,10 @@ static long move_present_ptes(struct mm_struct *mm,
>  			orig_dst_pte = pte_mksoft_dirty(orig_dst_pte);
>  		if (pte_dirty(orig_src_pte))
>  			orig_dst_pte = pte_mkdirty(orig_dst_pte);
> -		orig_dst_pte = pte_mkwrite(orig_dst_pte, dst_vma);
> +		if (pte_write(orig_src_pte))
> +			orig_dst_pte = pte_mkwrite(orig_dst_pte, dst_vma);
> +		if (pte_uffd_wp(orig_src_pte))
> +			orig_dst_pte = pte_mkuffd_wp(orig_dst_pte);
>  		set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
>  
>  		src_addr += PAGE_SIZE;
> -- 
> 2.52.0
> 

-- 
Sincerely yours,
Mike.

