Return-Path: <stable+bounces-146180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E25FDAC1EF7
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 10:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD47A2419F
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 08:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C031CBA02;
	Fri, 23 May 2025 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wP9Fm5hC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S8ite3rl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wP9Fm5hC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S8ite3rl"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F7D1AAA29
	for <stable@vger.kernel.org>; Fri, 23 May 2025 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747990478; cv=none; b=M25ixAc9RaPkZ/x0ONBA2idYE+anel7qcBedJpGEZH7EJ/iWEpHoGRDXYy+IdMcDGPphZsmhUML8H6VXlSDXQ5nlFmEADE3zBTiopiuZLyPOujSU0sQohgJ2GdEf0LiHTUcQdYcCoWfjpFAbjJLKOMm90YXH1ho+kCmE2tLHVUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747990478; c=relaxed/simple;
	bh=5xvC92xzCWbLsUeATCMyjU2gdYrnqJyog3pL7E7ODIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I86bUrhaGI5pH5Lwck6SfxKVFRZ5Z2ibBWKr8A0NKPZ7Q4miW8eihO323jg9a3leeJxqEhWZclDnPpZT97OlIOxCbIlnVIv0LFiSUz2lIW7jEES06FoNIK+0KpTbQvFNynEIbPxCT0WeVo/ZQ8KSN79r8fC/xU5Mh1KlkvwMKmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wP9Fm5hC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S8ite3rl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wP9Fm5hC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S8ite3rl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6974421BD9;
	Fri, 23 May 2025 08:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747990474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T82g3E2LV6xN7hQyvivoFGKg/UjdiqSAW5PZAXTFRHA=;
	b=wP9Fm5hCwE6PDo/RpdBpAQk1d9iWdAN6DLYAcZR8aeYbWkSb9wDZFUUhBA5/NAHiRi+aWl
	DukagYzz/GP2jf6eSuov2hP8lAMQK1CywbcP3wS1BZ4iDCrojVXEZdXmbvdLUqCWBlsTyD
	t/TTQaXbqjaqHwElZcvr/ny8rgNzBaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747990474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T82g3E2LV6xN7hQyvivoFGKg/UjdiqSAW5PZAXTFRHA=;
	b=S8ite3rlhC1mmIGHdwWYL0zKOj7ceXDo9A/4+p+Y/YpaJHNd6DCW05Xuz5Io6Qxd2rumGW
	LibhgAH3FmGu/vBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747990474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T82g3E2LV6xN7hQyvivoFGKg/UjdiqSAW5PZAXTFRHA=;
	b=wP9Fm5hCwE6PDo/RpdBpAQk1d9iWdAN6DLYAcZR8aeYbWkSb9wDZFUUhBA5/NAHiRi+aWl
	DukagYzz/GP2jf6eSuov2hP8lAMQK1CywbcP3wS1BZ4iDCrojVXEZdXmbvdLUqCWBlsTyD
	t/TTQaXbqjaqHwElZcvr/ny8rgNzBaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747990474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T82g3E2LV6xN7hQyvivoFGKg/UjdiqSAW5PZAXTFRHA=;
	b=S8ite3rlhC1mmIGHdwWYL0zKOj7ceXDo9A/4+p+Y/YpaJHNd6DCW05Xuz5Io6Qxd2rumGW
	LibhgAH3FmGu/vBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4D54137B8;
	Fri, 23 May 2025 08:54:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 81hnKck3MGhTNgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 23 May 2025 08:54:33 +0000
Date: Fri, 23 May 2025 10:54:24 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Ricardo =?iso-8859-1?Q?Ca=F1uelo?= Navarro <rcn@igalia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, revest@google.com,
	kernel-dev@igalia.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: fix copy_vma() error handling for hugetlb mappings
Message-ID: <aDA3wBqriEEp_kWT@localhost.localdomain>
References: <20250523-warning_in_page_counter_cancel-v1-1-b221eb61a402@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250523-warning_in_page_counter_cancel-v1-1-b221eb61a402@igalia.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,imap1.dmz-prg2.suse.org:helo,igalia.com:email,igalia.com:url]

On Fri, May 23, 2025 at 09:56:18AM +0200, Ricardo Cañuelo Navarro wrote:
> If, during a mremap() operation for a hugetlb-backed memory mapping,
> copy_vma() fails after the source vma has been duplicated and
> opened (ie. vma_link() fails), the error is handled by closing the new
> vma. This updates the hugetlbfs reservation counter of the reservation
> map which at this point is referenced by both the source vma and the new
> copy. As a result, once the new vma has been freed and copy_vma()
> returns, the reservation counter for the source vma will be incorrect.
> 
> This patch addresses this corner case by clearing the hugetlb private
> page reservation reference for the new vma and decrementing the
> reference before closing the vma, so that vma_close() won't update the
> reservation counter.
> 
> The issue was reported by a private syzbot instance, see the error
> report log [1] and reproducer [2]. Possible duplicate of public syzbot
> report [3].
> 
> Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>
> Cc: stable@vger.kernel.org # 6.12+
> Link: https://people.igalia.com/rcn/kernel_logs/20250422__WARNING_in_page_counter_cancel.txt [1]
> Link: https://people.igalia.com/rcn/kernel_logs/20250422__WARNING_in_page_counter_cancel__repro.c [2]
> Link: https://lore.kernel.org/all/67000a50.050a0220.49194.048d.GAE@google.com/ [3]
> ---
>  mm/vma.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index 839d12f02c885d3338d8d233583eb302d82bb80b..9d9f699ace977c9c869e5da5f88f12be183adcfb 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1834,6 +1834,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>  	return new_vma;
>  
>  out_vma_link:
> +	if (is_vm_hugetlb_page(new_vma))
> +		clear_vma_resv_huge_pages(new_vma);
>  	vma_close(new_vma);
>  
>  	if (new_vma->vm_file)

Sigh, I do not think Lorenzo will be happy about having yet another
hugetlb check around vma code :-).
Maybe this is good as is as a quick fix, but we really need to
re-assest this situation
.
I will have a look once I managed to finish a couple of other things.

 

-- 
Oscar Salvador
SUSE Labs

