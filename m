Return-Path: <stable+bounces-119950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E63A49C48
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 15:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9253A7BE8
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 14:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FB6270052;
	Fri, 28 Feb 2025 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X9Nz2mFt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BWBXdHZa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X9Nz2mFt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BWBXdHZa"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433B726FDB6
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753728; cv=none; b=UyV9k9fXDoOsCgwad2xXwJg4nsRHGei4psjkCG+AxSwrjY9MA6lDegckiWCfZ+ycWaes1e0uYeGCrIGk0NM2Du8CA2BRQ4SZPmVwz3DSO62ToCX0B1LOHwx4sJeg7p4GQwKAbwgzmssaFUbceW6FymaBUtid3SDKqBvRAdE/ous=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753728; c=relaxed/simple;
	bh=WBmnMvMq3sMh5/Nio2wuZIj+yRIzX08Sgl4di7WpdVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alRZgt/qwYcSZSe7TRS1cyj5RYRHNHouWDZo3XZkSBy48uBgx/8f6y/frMmRXt3BkWdg+IemW74lrR7aP7msw8ATqK+zvrPoQtLjfZu/ecY7l0zs+KODDxEDqOjdsa9rf5SE03GKyGDSWVi3o2RgLq3GsKuh3q8WzZ54jtqSfCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X9Nz2mFt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BWBXdHZa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X9Nz2mFt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BWBXdHZa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 453B01F38F;
	Fri, 28 Feb 2025 14:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740753723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MytUvU3RI7DRBJltO6l/dBaxsuM8bLTg2W92VqPhqcM=;
	b=X9Nz2mFtWSZ7MehiT0TqpIxzVpBl/UJ8TjhTeCOlpCk05dxU6tblLP7mPRQj8lywZ3rfq+
	zMYEMaBmH03nGiV4r9Y+8CF8JdKHJGUkRhNJuDbofE3gGqgjL9dagPhoH/7BirtLAhYPV1
	k9RplJUbS5+/cPxgZnpsZZHvpv711Wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740753723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MytUvU3RI7DRBJltO6l/dBaxsuM8bLTg2W92VqPhqcM=;
	b=BWBXdHZaYTqumZfQfBpPWmcmJHMmDOKZJXpc2ybe74TtzeTx3vNE41bJrv6MNDchRZvJ2F
	BF+8e0cTNX5zRqCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=X9Nz2mFt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BWBXdHZa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740753723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MytUvU3RI7DRBJltO6l/dBaxsuM8bLTg2W92VqPhqcM=;
	b=X9Nz2mFtWSZ7MehiT0TqpIxzVpBl/UJ8TjhTeCOlpCk05dxU6tblLP7mPRQj8lywZ3rfq+
	zMYEMaBmH03nGiV4r9Y+8CF8JdKHJGUkRhNJuDbofE3gGqgjL9dagPhoH/7BirtLAhYPV1
	k9RplJUbS5+/cPxgZnpsZZHvpv711Wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740753723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MytUvU3RI7DRBJltO6l/dBaxsuM8bLTg2W92VqPhqcM=;
	b=BWBXdHZaYTqumZfQfBpPWmcmJHMmDOKZJXpc2ybe74TtzeTx3vNE41bJrv6MNDchRZvJ2F
	BF+8e0cTNX5zRqCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25504137AC;
	Fri, 28 Feb 2025 14:42:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GZLICDvLwWfLOgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 28 Feb 2025 14:42:03 +0000
Message-ID: <c4d0005d-ae34-40d4-80a0-67ca904cdae1@suse.cz>
Date: Fri, 28 Feb 2025 15:42:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq
Content-Language: en-US
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Keith Busch <kbusch@kernel.org>
References: <20250228121356.336871-1-urezki@gmail.com>
 <20250228121356.336871-2-urezki@gmail.com>
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
In-Reply-To: <20250228121356.336871-2-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 453B01F38F
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kvack.org,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.com,kernel.org,google.com,lge.com,linux.dev,gmail.com,sony.com,linuxfoundation.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 2/28/25 13:13, Uladzislau Rezki (Sony) wrote:
> Currently kvfree_rcu() APIs use a system workqueue which is
> "system_unbound_wq" to driver RCU machinery to reclaim a memory.
> 
> Recently, it has been noted that the following kernel warning can
> be observed:
> 
> <snip>
> workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_scan_work is flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
>   WARNING: CPU: 21 PID: 330 at kernel/workqueue.c:3719 check_flush_dependency+0x112/0x120
>   Modules linked in: intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) ...
>   CPU: 21 UID: 0 PID: 330 Comm: kworker/u144:6 Tainted: G            E      6.13.2-0_g925d379822da #1
>   Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive MP, BIOS YMM20 02/01/2023
>   Workqueue: nvme-wq nvme_scan_work
>   RIP: 0010:check_flush_dependency+0x112/0x120
>   Code: 05 9a 40 14 02 01 48 81 c6 c0 00 00 00 48 8b 50 18 48 81 c7 c0 00 00 00 48 89 f9 48 ...
>   RSP: 0018:ffffc90000df7bd8 EFLAGS: 00010082
>   RAX: 000000000000006a RBX: ffffffff81622390 RCX: 0000000000000027
>   RDX: 00000000fffeffff RSI: 000000000057ffa8 RDI: ffff88907f960c88
>   RBP: 0000000000000000 R08: ffffffff83068e50 R09: 000000000002fffd
>   R10: 0000000000000004 R11: 0000000000000000 R12: ffff8881001a4400
>   R13: 0000000000000000 R14: ffff88907f420fb8 R15: 0000000000000000
>   FS:  0000000000000000(0000) GS:ffff88907f940000(0000) knlGS:0000000000000000
>   CR2: 00007f60c3001000 CR3: 000000107d010005 CR4: 00000000007726f0
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    ? __warn+0xa4/0x140
>    ? check_flush_dependency+0x112/0x120
>    ? report_bug+0xe1/0x140
>    ? check_flush_dependency+0x112/0x120
>    ? handle_bug+0x5e/0x90
>    ? exc_invalid_op+0x16/0x40
>    ? asm_exc_invalid_op+0x16/0x20
>    ? timer_recalc_next_expiry+0x190/0x190
>    ? check_flush_dependency+0x112/0x120
>    ? check_flush_dependency+0x112/0x120
>    __flush_work.llvm.1643880146586177030+0x174/0x2c0
>    flush_rcu_work+0x28/0x30
>    kvfree_rcu_barrier+0x12f/0x160
>    kmem_cache_destroy+0x18/0x120
>    bioset_exit+0x10c/0x150
>    disk_release.llvm.6740012984264378178+0x61/0xd0
>    device_release+0x4f/0x90
>    kobject_put+0x95/0x180
>    nvme_put_ns+0x23/0xc0
>    nvme_remove_invalid_namespaces+0xb3/0xd0
>    nvme_scan_work+0x342/0x490
>    process_scheduled_works+0x1a2/0x370
>    worker_thread+0x2ff/0x390
>    ? pwq_release_workfn+0x1e0/0x1e0
>    kthread+0xb1/0xe0
>    ? __kthread_parkme+0x70/0x70
>    ret_from_fork+0x30/0x40
>    ? __kthread_parkme+0x70/0x70
>    ret_from_fork_asm+0x11/0x20
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
> <snip>
> 
> To address this switch to use of independent WQ_MEM_RECLAIM
> workqueue, so the rules are not violated from workqueue framework
> point of view.
> 
> Apart of that, since kvfree_rcu() does reclaim memory it is worth
> to go with WQ_MEM_RECLAIM type of wq because it is designed for
> this purpose.
> 
> Cc: <stable@vger.kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

stable is sufficient, no need for greg himself too

> Cc: Keith Busch <kbusch@kernel.org>
> Closes: https://www.spinics.net/lists/kernel/msg5563270.html

lore pls :)

> Fixes: 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> Reported-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

fixed locally and pushed to slab/for-next-fixes
thanks!


