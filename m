Return-Path: <stable+bounces-256657-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mATRMoTJGWpXzAgAu9opvQ
	(envelope-from <stable+bounces-256657-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:14:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2908B6063C1
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BEEC33C69CC
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58343F4DC5;
	Fri, 29 May 2026 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+6m3z+x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C10D3F1673;
	Fri, 29 May 2026 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073133; cv=none; b=L4lk5dpCVOZufMoboURr2uzKJkDeLVPVp7TOFYczohrFILQi8uzIUx4cSSVbDBRZrCeAnVXQ3Ijpb7Mv/Fm3YU3Ssbi/PM3pwa92oRgt0F1Czkj4fzvlf9+7c+SxjLi3HHeCnC2VlaHlbyGqyV8lEuVxO5EnJorjSLqPRw+cXxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073133; c=relaxed/simple;
	bh=adm4Xg68sOp6Hdjli3T7/GamU7ER4+2eHQAszvxhcg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USMSMMqJj0yWdvTrV0eAJRgMmqR0aV14hn8Oe+g//pky7TbuzVrUJ37C94RKv4ZCsWeZN5N8HJ11zsXpcGL9BMX+N+LKTm/HAM9cbq1IvmJmKSWN5+wplw4Ew1lLH9LDO7BtpMBP4i5GvbwMuQPvQrTNRfpUjsLUDziQm/2wtfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+6m3z+x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8389C1F00899;
	Fri, 29 May 2026 16:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780073132;
	bh=GI/3CxbtRcVE+9zBOcv6zZDBqjLvSiyQcrxy+I1s2kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F+6m3z+xQ394skheiMjunzJhlBgB+CzilkptCdn5ktna0OC9prPxP1/JKJw82p+YI
	 UXVqD0hCer/BB0QybutXjH03Y5iQs+hfrBjQIOsoUaUwmy4zCcGVTKTiD+3qLFeILI
	 dJosqiE6T+i1kzFoqbVlDw9pf1t0BnX6hulULUji5sihczml9EFhDc/VCXiPMlB47N
	 nn0n2fVF7KDRNWHHf6uD4hn09Uo+C96XSmN4PRA67PjSlObXIW+qgLxqzYFOm82NRZ
	 x+UgPpKrUPQW82c2RprpiyLwOu2aYKuxRl1lSijFKgSHKXlSixB2r4swYDEj+GDr4H
	 7sD6NQXv88zBg==
Date: Fri, 29 May 2026 17:45:24 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, jgg@ziepe.ca, 
	leon@kernel.org, david@kernel.org, shuah@kernel.org, vbabka@kernel.org, 
	jannh@google.com, pfalcato@suse.de, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, balbirs@nvidia.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	ryan.roberts@arm.com, anshuman.khandual@arm.com, stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: do not warn on seeing non-migration
 pmd entry
Message-ID: <ahmdJFCw2arBdsd9@lucifer>
References: <20260529111704.1078346-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529111704.1078346-1-dev.jain@arm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256657-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:email]
X-Rspamd-Queue-Id: 2908B6063C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 11:17:03AM +0000, Dev Jain wrote:
> pagemap_pmd_range_thp() warns if a non-present PMD is not a migration
> entry. This became false once device-private entries at the PMD level were
> added.
>
> One can hit the warning by patching hmm-tests.c with the following:
>
> diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
> index e1c8a679a4cf3..7f0a3384f3c5f 100644
> --- a/tools/testing/selftests/mm/hmm-tests.c
> +++ b/tools/testing/selftests/mm/hmm-tests.c
> @@ -209,6 +209,37 @@ static int hmm_dmirror_cmd(int fd,
>  	return 0;
>  }
>
> +static int hmm_read_self_pagemap(void *addr, unsigned long npages,
> +				 unsigned long page_size)
> +{
> +	const size_t entry_size = sizeof(uint64_t);
> +	const off_t offset = ((uintptr_t)addr / page_size) * entry_size;
> +	uint64_t *entries;
> +	ssize_t nread;
> +	int fd;
> +
> +	entries = malloc(npages * entry_size);
> +	if (!entries)
> +		return -ENOMEM;
> +
> +	fd = open("/proc/self/pagemap", O_RDONLY);
> +	if (fd < 0) {
> +		free(entries);
> +		return -errno;
> +	}
> +
> +	nread = pread(fd, entries, npages * entry_size, offset);
> +	close(fd);
> +	free(entries);
> +
> +	if (nread < 0)
> +		return -errno;
> +	if ((size_t)nread != npages * entry_size)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
>  static void hmm_buffer_free(struct hmm_buffer *buffer)
>  {
>  	if (buffer == NULL)
> @@ -2314,6 +2345,10 @@ TEST_F(hmm, migrate_anon_huge_fault)
>  	ASSERT_EQ(ret, 0);
>  	ASSERT_EQ(buffer->cpages, npages);
>
> +	/* Exercise pagemap on a PMD device-private entry. */
> +	ret = hmm_read_self_pagemap(buffer->ptr, npages, self->page_size);
> +	ASSERT_EQ(ret, 0);
> +
>  	/* Check what the device read. */
>  	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
>  		ASSERT_EQ(ptr[i], i);

Thanks for this!

though, hmm it really feels like you maybe want to add this as a test and
make this a series :)

Andrew is usually fine with adding tests as part of a fix I believe!

>
>
> Therefore, remove the stale migration-only assertion.
>
> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dev Jain <dev.jain@arm.com>

The logic does seem sense, it does seem like something of an oversight here
and I can repro the assert (though I have to fix something else first on my
system, patch incoming for that...!)

> ---
> Applies on mm-unstable (404fb4f38e8f).
>
>  fs/proc/task_mmu.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 1e3a15bf46f4e..58938e62154d9 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2129,7 +2129,6 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
>  			flags |= PM_SOFT_DIRTY;
>  		if (pmd_swp_uffd_wp(pmd))
>  			flags |= PM_UFFD_WP;
> -		VM_WARN_ON_ONCE(!pmd_is_migration_entry(pmd));
>  		page = softleaf_to_page(entry);

>  	}
>
> --
> 2.43.0
>

Cheers, Lorenzo

