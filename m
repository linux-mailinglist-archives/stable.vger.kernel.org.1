Return-Path: <stable+bounces-176470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0386B37DF8
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 10:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6022D1BA3529
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 08:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2906A33EAF9;
	Wed, 27 Aug 2025 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2DtpxI1t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gJKtCpQW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2DtpxI1t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gJKtCpQW"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B92338F26
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756284024; cv=none; b=sC73WlU0ny40v9m9iylhznUCWbr2wqwrljaLj9XmVd3SpBKAQkqhEOIgtopD+g5VARXsCLZnr5cIoV6XhvRnioRv6xWNaGLhV1hRRLvcJcXXy57vPF0Xg2fvRWraw2mHEgPfPLAFDY1HNfYllx74fYQ2863pU90jtOX+xtKbh8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756284024; c=relaxed/simple;
	bh=wGJ4vs4u2pQ6wogbWmRisX42cZBt/j4aVkpYmPmBQdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4xaj0qxbUK6KNCe6HWaTL3sxDnMNL05SG2MABzaMoORzlMJhJ595xhEYDT1rDqodg82uig6eLClMfZO3o/yGE69DS/PpvF9HGPkHFK6swJXDbgPRvw7IZd0hjGeotfEpKXrbd4pLXNkMYBCQtEVy/1lE55L/IESdqlUjUGFHbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2DtpxI1t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gJKtCpQW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2DtpxI1t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gJKtCpQW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A809834241;
	Wed, 27 Aug 2025 08:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756284021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M/tOzaXU/v30nyaJclkRa9DTMfAcxqf3+f7uGHrzdOY=;
	b=2DtpxI1tNUP1aErxnD1LtBf1D+4YFDJD788uwNaFkQfNuuljvMGyzRZjJxgXj9YpuRsoxI
	9BZu/xdj6ou9K4r7yv3PHFaI1olIewBRhTK+oumwCNl0eomGbxfyfaeuZFs01PBoI82/pn
	cD3UK5yYxrOmk8sZ9oKkwaVd+PDDuZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756284021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M/tOzaXU/v30nyaJclkRa9DTMfAcxqf3+f7uGHrzdOY=;
	b=gJKtCpQWW9IlsSW0Cl8FuQd56yskrl1nGy2WyOdSjwPIWlZ1QrXJVrLjPYXMDefs7G5cNb
	C1NL7e75Y0/9PdCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756284021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M/tOzaXU/v30nyaJclkRa9DTMfAcxqf3+f7uGHrzdOY=;
	b=2DtpxI1tNUP1aErxnD1LtBf1D+4YFDJD788uwNaFkQfNuuljvMGyzRZjJxgXj9YpuRsoxI
	9BZu/xdj6ou9K4r7yv3PHFaI1olIewBRhTK+oumwCNl0eomGbxfyfaeuZFs01PBoI82/pn
	cD3UK5yYxrOmk8sZ9oKkwaVd+PDDuZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756284021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M/tOzaXU/v30nyaJclkRa9DTMfAcxqf3+f7uGHrzdOY=;
	b=gJKtCpQWW9IlsSW0Cl8FuQd56yskrl1nGy2WyOdSjwPIWlZ1QrXJVrLjPYXMDefs7G5cNb
	C1NL7e75Y0/9PdCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EBF713310;
	Wed, 27 Aug 2025 08:40:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Krt8InXErmhgBAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 27 Aug 2025 08:40:21 +0000
Message-ID: <fc6f7372-efb4-48e3-b217-c8bec0065b97@suse.cz>
Date: Wed, 27 Aug 2025 10:40:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: slub: avoid wake up kswapd in set_track_prepare
Content-Language: en-US
To: yangshiguang <yangshiguang1011@163.com>, Harry Yoo <harry.yoo@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
 cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev,
 glittao@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 yangshiguang <yangshiguang@xiaomi.com>, stable@vger.kernel.org
References: <20250825121737.2535732-1-yangshiguang1011@163.com>
 <aKxZp_GgYVzp8Uvt@casper.infradead.org>
 <54d9e5ac-5a51-4901-9b13-4c248aada2d7@suse.cz> <aK6U61xNpJS0qs15@hyeyoo>
 <6e1ab9d8.6595.198ea7d7a78.Coremail.yangshiguang1011@163.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <6e1ab9d8.6595.198ea7d7a78.Coremail.yangshiguang1011@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com,oracle.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,linux-foundation.org,gentwo.org,google.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,xiaomi.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 8/27/25 09:45, yangshiguang wrote:
> 
> 
> 
> 
> At 2025-08-27 13:17:31, "Harry Yoo" <harry.yoo@oracle.com> wrote:
>>On Mon, Aug 25, 2025 at 05:42:52PM +0200, Vlastimil Babka wrote:
>>> On 8/25/25 14:40, Matthew Wilcox wrote:
>>> > On Mon, Aug 25, 2025 at 08:17:37PM +0800, yangshiguang1011@163.com wrote:
>>> >> Avoid deadlock caused by implicitly waking up kswapd by
>>> >> passing in allocation flags.
>>> > [...]
>>> >> +	/* Preemption is disabled in ___slab_alloc() */
>>> >> +	gfp_flags &= ~(__GFP_DIRECT_RECLAIM);
>>> > 
>>> > If you don't mean __GFP_KSWAPD_RECLAIM here, the explanation needs to
>>> > be better.
>>> 
>>> It was suggested by Harry here:
>>> https://lore.kernel.org/all/aKKhUoUkRNDkFYYb@harry
>>> 
>>> I think the comment is enough? Disabling preemption means we can't direct
>>> reclaim, but we can wake up kswapd. If the slab caller context is such that
>>> we can't, __GFP_KSWAPD_RECLAIM already won't be in the gfp_flags.
>>
>>To make it a little bit more verbose, this ^^ explanation can be added to the
> 
>>changelog?
> 
> 
> ok, will be easier to understand.
> 
>>
>>> But I think we should mask our also __GFP_NOFAIL and add __GFP_NOWARN?
>>
> 
>>That sounds good.>
>>> (we should get some common helpers for these kinds of gfp flag manipulations
>>> already)
>>
>>Any ideas for its name?
>>
>>gfp_dont_try_too_hard(),
>>gfp_adjust_lightweight(),
>>gfp_adjust_mayfail(),
>>...
>>
>>I'm not good at naming :/
> 
>>
> 
> How about this? 
> 
>         /* Preemption is disabled in ___slab_alloc() */
> -       gfp_flags &= ~(__GFP_DIRECT_RECLAIM);
> +       gfp_flags = (gfp_flags & ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL)) |
> +                                       __GFP_NOWARN;

I'd suggest using gfp_nested_flags() and & ~(__GFP_DIRECT_RECLAIM);

>  >-- 
>>Cheers,
>>Harry / Hyeonggon


