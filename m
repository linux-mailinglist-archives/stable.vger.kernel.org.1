Return-Path: <stable+bounces-112320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763E2A28B2B
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2EE6162CF4
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D67F10A3E;
	Wed,  5 Feb 2025 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HdJY9t/X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/5HMX24D";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HdJY9t/X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/5HMX24D"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874EBBA2E
	for <stable@vger.kernel.org>; Wed,  5 Feb 2025 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760708; cv=none; b=LyuFmZXCEYPUJeQIoa8GUdbbneUu2cLCB2RfHxA27JaLqL46abH7sOyFHG/yD5xGwy3ghWrp0CxpBtKAdBHt0h5AgiOAtI3d8lZbCwtEO4bMMxTV3GspbM3BtR69JHlvgBt6Hr5AFJ2eaqsao923qVYp3n+4tm6gGi8bRMVgaQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760708; c=relaxed/simple;
	bh=N9+qw1jXD9Kv0oJ9KaaEWoZaIpcoiMZXBbQx8HW3qsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7oG7G5pjemLGnWzmepEfsHjZ/dKsdwlY3hyMLed0VYa8RZtyGHv9iabkuWPubbZlUJnhHe0kEp9ERPWKqaPYZ0e+BawSnelh4AzknjdFL4dyK/vrmxl1n3ZUxYw/b7nOcn9pesyz0W6HI8cKZfO1gShGlDT4S3Rg5gYHRDiib4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HdJY9t/X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/5HMX24D; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HdJY9t/X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/5HMX24D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A79D02122A;
	Wed,  5 Feb 2025 13:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738760704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T1hxKKTF2Tkd7wwVqx/X9ElblRcEFK/OJz6T2RxwZI8=;
	b=HdJY9t/XmEGE5vxCf96Fi2/lPyzryQnWahjdjSMpka9Kvk7ZPd84qQDgkL1wOimqFC6+UX
	rXLz/WfePss+b3KaRIv0VEc6Zl0s/fSM/yUOULi7Ye5IGTvs+X83Bul8IOHgTA2HgpBZF4
	OWKeKTehLkEr0ufbsbHFYrL/WgoWzWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738760704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T1hxKKTF2Tkd7wwVqx/X9ElblRcEFK/OJz6T2RxwZI8=;
	b=/5HMX24DVRsNeFjzfJfdW4VsGp99IwnIl1AqrUMbi8nfNLpv6ibRywwcB1coqZR8jkltNC
	VYU6Ym+CPA7FMSBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="HdJY9t/X";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/5HMX24D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738760704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T1hxKKTF2Tkd7wwVqx/X9ElblRcEFK/OJz6T2RxwZI8=;
	b=HdJY9t/XmEGE5vxCf96Fi2/lPyzryQnWahjdjSMpka9Kvk7ZPd84qQDgkL1wOimqFC6+UX
	rXLz/WfePss+b3KaRIv0VEc6Zl0s/fSM/yUOULi7Ye5IGTvs+X83Bul8IOHgTA2HgpBZF4
	OWKeKTehLkEr0ufbsbHFYrL/WgoWzWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738760704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T1hxKKTF2Tkd7wwVqx/X9ElblRcEFK/OJz6T2RxwZI8=;
	b=/5HMX24DVRsNeFjzfJfdW4VsGp99IwnIl1AqrUMbi8nfNLpv6ibRywwcB1coqZR8jkltNC
	VYU6Ym+CPA7FMSBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CD72139D8;
	Wed,  5 Feb 2025 13:05:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cD6bBwBio2etcgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 05 Feb 2025 13:05:04 +0000
Date: Wed, 5 Feb 2025 14:05:02 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Ricardo =?iso-8859-1?Q?Ca=F1uelo?= Navarro <rcn@igalia.com>
Cc: akpm@linux-foundation.org, riel@surriel.com, linux-mm@kvack.org,
	stable@vger.kernel.org, kernel-dev@igalia.com, revest@google.com
Subject: Re: [PATCH v2] mm,madvise,hugetlb: check for 0-length range after
 end address adjustment
Message-ID: <Z6Nh_tNoy-E7KXsI@localhost.localdomain>
References: <20250203075206.1452208-1-rcn@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250203075206.1452208-1-rcn@igalia.com>
X-Rspamd-Queue-Id: A79D02122A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,igalia.com:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Mon, Feb 03, 2025 at 08:52:06AM +0100, Ricardo Cañuelo Navarro wrote:
> Add a sanity check to madvise_dontneed_free() to address a corner case
> in madvise where a race condition causes the current vma being processed
> to be backed by a different page size.
> 
> During a madvise(MADV_DONTNEED) call on a memory region registered with
> a userfaultfd, there's a period of time where the process mm lock is
> temporarily released in order to send a UFFD_EVENT_REMOVE and let
> userspace handle the event. During this time, the vma covering the
> current address range may change due to an explicit mmap done
> concurrently by another thread.
> 
> If, after that change, the memory region, which was originally backed by
> 4KB pages, is now backed by hugepages, the end address is rounded down
> to a hugepage boundary to avoid data loss (see "Fixes" below). This
> rounding may cause the end address to be truncated to the same address
> as the start.
> 
> Make this corner case follow the same semantics as in other similar
> cases where the requested region has zero length (ie. return 0).
> 
> This will make madvise_walk_vmas() continue to the next vma in the
> range (this time holding the process mm lock) which, due to the prev
> pointer becoming stale because of the vma change, will be the same
> hugepage-backed vma that was just checked before. The next time
> madvise_dontneed_free() runs for this vma, if the start address isn't
> aligned to a hugepage boundary, it'll return -EINVAL, which is also in
> line with the madvise api.
> 
> From userspace perspective, madvise() will return EINVAL because the
> start address isn't aligned according to the new vma alignment
> requirements (hugepage), even though it was correctly page-aligned when
> the call was issued.
> 
> Fixes: 8ebe0a5eaaeb ("mm,madvise,hugetlb: fix unexpected data loss with MADV_DONTNEED on hugetlbfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
> Changes in v2:
> - Added documentation in the code to tell the user how this situation
>   can happen. (Andrew)
> ---
>  mm/madvise.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 49f3a75046f6..08b207f8e61e 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -933,7 +933,16 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
>  			 */
>  			end = vma->vm_end;
>  		}
> -		VM_WARN_ON(start >= end);
> +		/*
> +		 * If the memory region between start and end was
> +		 * originally backed by 4kB pages and then remapped to
> +		 * be backed by hugepages while mmap_lock was dropped,
> +		 * the adjustment for hugetlb vma above may have rounded
> +		 * end down to the start address.
> +		 */
> +		if (start == end)
> +			return 0;
> +		VM_WARN_ON(start > end);

The change itself looks fine to me, although I am wondering whether it would make
more sense to place the check right after the call to
madvise_dontneed_free_valid_vma().
It looks kind of more logical to me, but not a big deal.
 

-- 
Oscar Salvador
SUSE Labs

