Return-Path: <stable+bounces-214901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHXhMDrBiWk/BgUAu9opvQ
	(envelope-from <stable+bounces-214901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 12:12:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E9F10E8B9
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 12:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 088C7302BA40
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 11:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A4636C0DE;
	Mon,  9 Feb 2026 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NyVcXt2o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9qYrvHqP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NyVcXt2o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9qYrvHqP"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6929836C5A5
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770635492; cv=none; b=gojyHH5u2vcWaIbcIHn9AJyY3bEY8IkcsPVvXr/vA35Tfo8olmXRcWsxWXSUpstZ6s2cef8IuK6KMqMhgu1ITTImF1uTAljYLK7p4EJpfpLXzR8JZzfok8lrJ8dkz6th8p1cfJkB8rVb0sGrwGqruMFdv59Ye+uKwB7XqF3rELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770635492; c=relaxed/simple;
	bh=X8ZEnbisnHFDug0RdkwoZLOVc840MUlx1wmtJ/ZBTtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STQe1P7BzQJnGl8tVwU/GNEidNS2b+ytTryZyMZuiZyKG0yXv1vR+eUHNA2Dve2XS+CHoYA5/TqN1MjZMyVjSYqHnUESxh9yd3sg14ObWnqNSeyB5cf9/8plWfxNQkOKYNECs0tHri08xABDyaP5dT25NVdCc+izjKdiZl4euFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NyVcXt2o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9qYrvHqP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NyVcXt2o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9qYrvHqP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A19F43E6F2;
	Mon,  9 Feb 2026 11:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770635490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=t8qLFZbNZpSrx4c68k5jQfZ+EN35t8S+8YIiD1pqagE=;
	b=NyVcXt2ocC1CVQAT2MPh2t32BXjCv7vkaP3a0lu3iDhzxYu/z2h3IG7qianf+MrpON5MXE
	TcW8J5gfMgI1dkXFWaAXM7ZbY82FY3HXcAXm2p4UoAubsqjHUbTr7cFnewm5AECj9OGmoZ
	+xdWcEyC3sP2MMiBBp0IUeaWgoMKCf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770635490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=t8qLFZbNZpSrx4c68k5jQfZ+EN35t8S+8YIiD1pqagE=;
	b=9qYrvHqPlk3lkMfiMYtY7WmM5BFDggncyDFM6w9yLq2+8cw2wAcFKFiPxFSp2ov8WpNjlE
	MO6BDDkcPrGDXYAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770635490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=t8qLFZbNZpSrx4c68k5jQfZ+EN35t8S+8YIiD1pqagE=;
	b=NyVcXt2ocC1CVQAT2MPh2t32BXjCv7vkaP3a0lu3iDhzxYu/z2h3IG7qianf+MrpON5MXE
	TcW8J5gfMgI1dkXFWaAXM7ZbY82FY3HXcAXm2p4UoAubsqjHUbTr7cFnewm5AECj9OGmoZ
	+xdWcEyC3sP2MMiBBp0IUeaWgoMKCf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770635490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=t8qLFZbNZpSrx4c68k5jQfZ+EN35t8S+8YIiD1pqagE=;
	b=9qYrvHqPlk3lkMfiMYtY7WmM5BFDggncyDFM6w9yLq2+8cw2wAcFKFiPxFSp2ov8WpNjlE
	MO6BDDkcPrGDXYAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B7393EA63;
	Mon,  9 Feb 2026 11:11:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wlXuFOLAiWlPSgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 09 Feb 2026 11:11:30 +0000
Message-ID: <dc4c016c-90e7-4e60-a73a-a2515ad2f6e8@suse.cz>
Date: Mon, 9 Feb 2026 12:11:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/page_alloc: clear page->private in
 free_pages_prepare()
Content-Language: en-US
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, chrisl@kernel.org, kasong@tencent.com,
 hughd@google.com, ryncsn@gmail.com, ziy@nvidia.com, stable@vger.kernel.org
References: <17A126A7-BACA-49E5-8A89-F8E665981136@nvidia.com>
 <20260207153716.59302-1-mikhail.v.gavrilov@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20260207153716.59302-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214901-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,google.com,gmail.com,nvidia.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_TO(0.00)[gmail.com,kvack.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.cz,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Queue-Id: 23E9F10E8B9
X-Rspamd-Action: no action

On 2/7/26 16:37, Mikhail Gavrilov wrote:
> Several subsystems (slub, shmem, ttm, etc.) use page->private but don't
> clear it before freeing pages. When these pages are later allocated as
> high-order pages and split via split_page(), tail pages retain stale
> page->private values.
> 
> This causes a use-after-free in the swap subsystem. The swap code uses
> page->private to track swap count continuations, assuming freshly
> allocated pages have page->private == 0. When stale values are present,
> swap_count_continued() incorrectly assumes the continuation list is valid
> and iterates over uninitialized page->lru containing LIST_POISON values,
> causing a crash:
> 
>   KASAN: maybe wild-memory-access in range [0xdead000000000100-0xdead000000000107]
>   RIP: 0010:__do_sys_swapoff+0x1151/0x1860
> 
> Fix this by clearing page->private in free_pages_prepare(), ensuring all
> freed pages have clean state regardless of previous use.
> 
> Fixes: 3b8000ae185c ("mm/vmalloc: huge vmalloc backing pages should be split rather than compound")
> Cc: stable@vger.kernel.org
> Suggested-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Seems cheap enough and robust to just do it. Could be different for tail
pages (although we do modify them too anyway).

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cbf758e27aa2..24ac34199f95 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1430,6 +1430,7 @@ __always_inline bool free_pages_prepare(struct page *page,
>  
>  	page_cpupid_reset_last(page);
>  	page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
> +	page->private = 0;
>  	reset_page_owner(page, order);
>  	page_table_check_free(page, order);
>  	pgalloc_tag_sub(page, 1 << order);


