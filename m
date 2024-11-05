Return-Path: <stable+bounces-89893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1053C9BD2C9
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7029CB21063
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357291DB344;
	Tue,  5 Nov 2024 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NYRuPq++";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DGcF5vDa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QIqfceDT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JMNuDVt1"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42471DAC97;
	Tue,  5 Nov 2024 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730825344; cv=none; b=tj6d9w3lE1yugQhnwsMUVFj7+HCVXKKbF7ctWPfOj2gWbUsFpolF5f7QL+Tc7hqqzF8v6sVoY21sqW1a+kuV+fe2dSK/OAJNHQY9PNXnF8RgBlW4Gfob9s0NASoBa50A1XBngvw88v54zqSdJ9TlQEUqv69Yexkvlvqt5WwOk+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730825344; c=relaxed/simple;
	bh=n1M8eYvcy4vxaYE3aT/vYOheUF89T8PxeiDu4aXuYrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMfrMEdzga63529VEktbbNcSMNAd8vt2ZM6VwZIIN6WLqZ7KWz6nGUrkaLZXsZZvS1I6X5+jQvD1vnkJmIUTrpbPyGBiC1bqky+xAplC0t8mwF4aWePlKPPPthcUz9DWNxDCkcQhs73QtCqTLRczcTbHA32wEPT5x0gls47lAc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NYRuPq++; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DGcF5vDa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QIqfceDT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JMNuDVt1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0D5A21A59;
	Tue,  5 Nov 2024 16:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730825337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y8W9ITZ5CUh56ymy7dmK9dmRxQpo2pX2hbTgzLCk+ms=;
	b=NYRuPq++xd6m/mtCgAyZo3PSvIgKq+2jyN21E98rf3HBEe6nOTSSyPULnrGG7CB+GAzg+c
	T413kIQYwSKBcb6WpS0ysljYULMKdhgZQR8q8GLbGIY7kygpVf56HXQXxIYJJEbMopeRH4
	Vmjnk4dHZ7jAk8nbQUd+sxXEwIBY1eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730825337;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y8W9ITZ5CUh56ymy7dmK9dmRxQpo2pX2hbTgzLCk+ms=;
	b=DGcF5vDaukPT1PbNedp149RPizSd0JiXm4jiLMrFjGcp/paJ+t3fCLfc6CVOChdtP6BxdW
	O9zks+3SV/LUTvDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730825336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y8W9ITZ5CUh56ymy7dmK9dmRxQpo2pX2hbTgzLCk+ms=;
	b=QIqfceDTRuQrQRkwis0I5B9MSJbLZ7Xb1UC1Xkg6kducn2rGMjZ2GayduIcJZ+A/NN8+sa
	7/Qm0Hz+HTZ7b5TJeZ7KJR18NLteGu3oZ+4ySzlZW+CBl4c6TbuUWnEs4puoxLxfzS3YFc
	ovAGzgWJOvq37Vt1NGAiOLzrCASxpC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730825336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y8W9ITZ5CUh56ymy7dmK9dmRxQpo2pX2hbTgzLCk+ms=;
	b=JMNuDVt1O/nnonqFDO2eVc7yA3jiThGJcpDQXqzsO8C9jeO+bfyk/OrjTqm9u3cE8nM7bP
	t/mddX4mxEw4InDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2DF713964;
	Tue,  5 Nov 2024 16:48:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h5XvMnhMKmceUAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 05 Nov 2024 16:48:56 +0000
Message-ID: <6125f047-7326-49f7-a568-9cabf80f51c7@suse.cz>
Date: Tue, 5 Nov 2024 17:48:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/slab: fix warning caused by duplicate kmem_cache
 creation in kmem_buckets_create
Content-Language: en-US
To: Koichiro Den <koichiro.den@gmail.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, kees@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241105022747.2819151-1-koichiro.den@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJkBREIBQkRadznAAoJECJPp+fMgqZkNxIQ
 ALZRqwdUGzqL2aeSavbum/VF/+td+nZfuH0xeWiO2w8mG0+nPd5j9ujYeHcUP1edE7uQrjOC
 Gs9sm8+W1xYnbClMJTsXiAV88D2btFUdU1mCXURAL9wWZ8Jsmz5ZH2V6AUszvNezsS/VIT87
 AmTtj31TLDGwdxaZTSYLwAOOOtyqafOEq+gJB30RxTRE3h3G1zpO7OM9K6ysLdAlwAGYWgJJ
 V4JqGsQ/lyEtxxFpUCjb5Pztp7cQxhlkil0oBYHkudiG8j1U3DG8iC6rnB4yJaLphKx57NuQ
 PIY0Bccg+r9gIQ4XeSK2PQhdXdy3UWBr913ZQ9AI2usid3s5vabo4iBvpJNFLgUmxFnr73SJ
 KsRh/2OBsg1XXF/wRQGBO9vRuJUAbnaIVcmGOUogdBVS9Sun/Sy4GNA++KtFZK95U7J417/J
 Hub2xV6Ehc7UGW6fIvIQmzJ3zaTEfuriU1P8ayfddrAgZb25JnOW7L1zdYL8rXiezOyYZ8Fm
 ZyXjzWdO0RpxcUEp6GsJr11Bc4F3aae9OZtwtLL/jxc7y6pUugB00PodgnQ6CMcfR/HjXlae
 h2VS3zl9+tQWHu6s1R58t5BuMS2FNA58wU/IazImc/ZQA+slDBfhRDGYlExjg19UXWe/gMcl
 De3P1kxYPgZdGE2eZpRLIbt+rYnqQKy8UxlszsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZAUSmwUJDK5EZgAKCRAiT6fnzIKmZOJGEACOKABgo9wJXsbWhGWYO7mD
 8R8mUyJHqbvaz+yTLnvRwfe/VwafFfDMx5GYVYzMY9TWpA8psFTKTUIIQmx2scYsRBUwm5VI
 EurRWKqENcDRjyo+ol59j0FViYysjQQeobXBDDE31t5SBg++veI6tXfpco/UiKEsDswL1WAr
 tEAZaruo7254TyH+gydURl2wJuzo/aZ7Y7PpqaODbYv727Dvm5eX64HCyyAH0s6sOCyGF5/p
 eIhrOn24oBf67KtdAN3H9JoFNUVTYJc1VJU3R1JtVdgwEdr+NEciEfYl0O19VpLE/PZxP4wX
 PWnhf5WjdoNI1Xec+RcJ5p/pSel0jnvBX8L2cmniYnmI883NhtGZsEWj++wyKiS4NranDFlA
 HdDM3b4lUth1pTtABKQ1YuTvehj7EfoWD3bv9kuGZGPrAeFNiHPdOT7DaXKeHpW9homgtBxj
 8aX/UkSvEGJKUEbFL9cVa5tzyialGkSiZJNkWgeHe+jEcfRT6pJZOJidSCdzvJpbdJmm+eED
 w9XOLH1IIWh7RURU7G1iOfEfmImFeC3cbbS73LQEFGe1urxvIH5K/7vX+FkNcr9ujwWuPE9b
 1C2o4i/yZPLXIVy387EjA6GZMqvQUFuSTs/GeBcv0NjIQi8867H3uLjz+mQy63fAitsDwLmR
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241105022747.2819151-1-koichiro.den@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com,arm.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On 11/5/24 03:27, Koichiro Den wrote:
> Commit b035f5a6d852 ("mm: slab: reduce the kmalloc() minimum alignment
> if DMA bouncing possible") reduced ARCH_KMALLOC_MINALIGN to 8 on arm64.
> However, with KASAN_HW_TAGS enabled, arch_slab_minalign() becomes 16.
> This causes kmalloc_caches[*][8] to be aliased to kmalloc_caches[*][16],
> resulting in kmem_buckets_create() attempting to create a kmem_cache for
> size 16 twice. This duplication triggers warnings on boot:
> 
> [    2.325108] ------------[ cut here ]------------
> [    2.325135] kmem_cache of name 'memdup_user-16' already exists
> [    2.325783] WARNING: CPU: 0 PID: 1 at mm/slab_common.c:107 __kmem_cache_create_args+0xb8/0x3b0
> [    2.327957] Modules linked in:
> [    2.328550] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc5mm-unstable-arm64+ #12
> [    2.328683] Hardware name: QEMU QEMU Virtual Machine, BIOS 2024.02-2 03/11/2024
> [    2.328790] pstate: 61000009 (nZCv daif -PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [    2.328911] pc : __kmem_cache_create_args+0xb8/0x3b0
> [    2.328930] lr : __kmem_cache_create_args+0xb8/0x3b0
> [    2.328942] sp : ffff800083d6fc50
> [    2.328961] x29: ffff800083d6fc50 x28: f2ff0000c1674410 x27: ffff8000820b0598
> [    2.329061] x26: 000000007fffffff x25: 0000000000000010 x24: 0000000000002000
> [    2.329101] x23: ffff800083d6fce8 x22: ffff8000832222e8 x21: ffff800083222388
> [    2.329118] x20: f2ff0000c1674410 x19: f5ff0000c16364c0 x18: ffff800083d80030
> [    2.329135] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [    2.329152] x14: 0000000000000000 x13: 0a73747369786520 x12: 79646165726c6120
> [    2.329169] x11: 656820747563205b x10: 2d2d2d2d2d2d2d2d x9 : 0000000000000000
> [    2.329194] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> [    2.329210] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> [    2.329226] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> [    2.329291] Call trace:
> [    2.329407]  __kmem_cache_create_args+0xb8/0x3b0
> [    2.329499]  kmem_buckets_create+0xfc/0x320
> [    2.329526]  init_user_buckets+0x34/0x78
> [    2.329540]  do_one_initcall+0x64/0x3c8
> [    2.329550]  kernel_init_freeable+0x26c/0x578
> [    2.329562]  kernel_init+0x3c/0x258
> [    2.329574]  ret_from_fork+0x10/0x20
> [    2.329698] ---[ end trace 0000000000000000 ]---
> 
> [    2.403704] ------------[ cut here ]------------
> [    2.404716] kmem_cache of name 'msg_msg-16' already exists
> [    2.404801] WARNING: CPU: 2 PID: 1 at mm/slab_common.c:107 __kmem_cache_create_args+0xb8/0x3b0
> [    2.404842] Modules linked in:
> [    2.404971] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.12.0-rc5mm-unstable-arm64+ #12
> [    2.405026] Tainted: [W]=WARN
> [    2.405043] Hardware name: QEMU QEMU Virtual Machine, BIOS 2024.02-2 03/11/2024
> [    2.405057] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    2.405079] pc : __kmem_cache_create_args+0xb8/0x3b0
> [    2.405100] lr : __kmem_cache_create_args+0xb8/0x3b0
> [    2.405111] sp : ffff800083d6fc50
> [    2.405115] x29: ffff800083d6fc50 x28: fbff0000c1674410 x27: ffff8000820b0598
> [    2.405135] x26: 000000000000ffd0 x25: 0000000000000010 x24: 0000000000006000
> [    2.405153] x23: ffff800083d6fce8 x22: ffff8000832222e8 x21: ffff800083222388
> [    2.405169] x20: fbff0000c1674410 x19: fdff0000c163d6c0 x18: ffff800083d80030
> [    2.405185] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [    2.405201] x14: 0000000000000000 x13: 0a73747369786520 x12: 79646165726c6120
> [    2.405217] x11: 656820747563205b x10: 2d2d2d2d2d2d2d2d x9 : 0000000000000000
> [    2.405233] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> [    2.405248] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> [    2.405271] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> [    2.405287] Call trace:
> [    2.405293]  __kmem_cache_create_args+0xb8/0x3b0
> [    2.405305]  kmem_buckets_create+0xfc/0x320
> [    2.405315]  init_msg_buckets+0x34/0x78
> [    2.405326]  do_one_initcall+0x64/0x3c8
> [    2.405337]  kernel_init_freeable+0x26c/0x578
> [    2.405348]  kernel_init+0x3c/0x258
> [    2.405360]  ret_from_fork+0x10/0x20
> [    2.405370] ---[ end trace 0000000000000000 ]---
> 
> To address this, alias kmem_cache for sizes smaller than min alignment
> to the aligned sized kmem_cache, as done with the default system kmalloc
> bucket.
> 
> Cc: <stable@vger.kernel.org> # 6.11.x
> Fixes: b32801d1255b ("mm/slab: Introduce kmem_buckets_create() and family")
> Signed-off-by: Koichiro Den <koichiro.den@gmail.com>

Thanks. Given this warning was introduced in 6.12, I'm adding it to the
slab/for-6.12-rc7/fixes branch so we fix it before 6.12 is final.

> @@ -427,18 +426,29 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
>  			cache_useroffset = useroffset;
>  			cache_usersize = min(size - cache_useroffset, usersize);
>  		}
> -		(*b)[idx] = kmem_cache_create_usercopy(cache_name, size,
> -					0, flags, cache_useroffset,
> -					cache_usersize, ctor);
> -		kfree(cache_name);
> -		if (WARN_ON(!(*b)[idx]))
> -			goto fail;
> +
> +		aligned_idx = __kmalloc_index(size, false);
> +		if (!(*b)[aligned_idx]) {
> +			cache_name = kasprintf(GFP_KERNEL, "%s-%s", name, short_size + 1);
> +			if (WARN_ON(!cache_name))
> +				goto fail;
> +			(*b)[aligned_idx] = kmem_cache_create_usercopy(cache_name, size,
> +						0, flags, cache_useroffset,
> +						cache_usersize, ctor);
> +			if (WARN_ON(!(*b)[aligned_idx])) {
> +				kfree(cache_name);

Note we need to free cache_name always, because kmem_cache_create() does a
kstrdup_const(), so your change would be creating a memory leak. I've fixed
it up locally.

Vlastimil

> +				goto fail;
> +			}
> +			set_bit(aligned_idx, &mask);
> +		}
> +		if (idx != aligned_idx)
> +			(*b)[idx] = (*b)[aligned_idx];
>  	}
>  
>  	return b;
>  
>  fail:
> -	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++)
> +	for_each_set_bit(idx, &mask, ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]))
>  		kmem_cache_destroy((*b)[idx]);
>  	kmem_cache_free(kmem_buckets_cache, b);
>  


