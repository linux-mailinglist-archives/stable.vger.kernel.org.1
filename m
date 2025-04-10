Return-Path: <stable+bounces-132069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F1CA83C2A
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 10:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C803D7A7124
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 08:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEBC1DF987;
	Thu, 10 Apr 2025 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dk8qpuyw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="svQQQJ+M";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dk8qpuyw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="svQQQJ+M"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AC5202C53
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744272774; cv=none; b=jfNuXhnh2UaCLA1zctGs0tynpM5P1j+eUYpSI1LZ+QOL6ZbIq5gVp/O5otiEQJMsgltT/YE3Obt3LuASf36pr3HJRq3otg8+hIiNQL/mEIkF1LNmA0oCTfNZodWdMFYppJTCfvgMf77hANxoMxTDOhPd1wA6KCLXxldYGiRwYkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744272774; c=relaxed/simple;
	bh=JSRO87HqVO4bGSGMxleIYOVX6hrO09crH0pzJpUCGlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ld192w8XqqEgLmw1LM8xD9+xIYY9aU574nsFXq+TWtHzBhwpwiPHLr+kcjQ1SyxeDDeZQCAVBU98tYugM/buho9TMf8L/HsLHvQsxrwABZHsY7iL3Al2QQZo+Qz7UxZJ7SKUd+MW77wBwab2Byb/sD/gm7M2MJK0U6zefuCeV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dk8qpuyw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=svQQQJ+M; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dk8qpuyw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=svQQQJ+M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0382F2118B;
	Thu, 10 Apr 2025 08:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744272765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhnrev0ra4PwSkpyWtVkGoW6BWZCtaecoXBOEh9FMgo=;
	b=dk8qpuyw27rmjYdfkloqA4RH91rSbf/EEfazfHTiFw88VwkZMhSg79oDsu/saFEmM67X34
	KYn1kL/M/tTkrqiYU0ZCFYVHpZBLjrAu6sfSCKhUS3/UzIdBaurF2flLvOIHRVMmC+B9DD
	fuQaEHLVgsjUT+tLHUmFpJvKrNSjV7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744272765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhnrev0ra4PwSkpyWtVkGoW6BWZCtaecoXBOEh9FMgo=;
	b=svQQQJ+Mv3at12FsHgpdGsUm369PuMtGX7NoIuoTIFdCJDO2+QC9mVj9WfoRSifQGOsg00
	W1y0yfavdFIPtQCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dk8qpuyw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=svQQQJ+M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744272765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhnrev0ra4PwSkpyWtVkGoW6BWZCtaecoXBOEh9FMgo=;
	b=dk8qpuyw27rmjYdfkloqA4RH91rSbf/EEfazfHTiFw88VwkZMhSg79oDsu/saFEmM67X34
	KYn1kL/M/tTkrqiYU0ZCFYVHpZBLjrAu6sfSCKhUS3/UzIdBaurF2flLvOIHRVMmC+B9DD
	fuQaEHLVgsjUT+tLHUmFpJvKrNSjV7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744272765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhnrev0ra4PwSkpyWtVkGoW6BWZCtaecoXBOEh9FMgo=;
	b=svQQQJ+Mv3at12FsHgpdGsUm369PuMtGX7NoIuoTIFdCJDO2+QC9mVj9WfoRSifQGOsg00
	W1y0yfavdFIPtQCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD0E6132D8;
	Thu, 10 Apr 2025 08:12:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VhiYNXx992d0BQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 10 Apr 2025 08:12:44 +0000
Message-ID: <18217ade-4ac4-4654-9c25-d6b65e6c23e5@suse.cz>
Date: Thu, 10 Apr 2025 10:12:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: page_alloc: speed up fallbacks in rmqueue_bulk()
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Jackman <jackmanb@google.com>,
 Mel Gorman <mgorman@techsingularity.net>, Carlos Song <carlos.song@nxp.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org
References: <20250407180154.63348-1-hannes@cmpxchg.org>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250407180154.63348-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0382F2118B
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,intel.com:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/7/25 20:01, Johannes Weiner wrote:
> The test robot identified c2f6ea38fc1b ("mm: page_alloc: don't steal
> single pages from biggest buddy") as the root cause of a 56.4%
> regression in vm-scalability::lru-file-mmap-read.
> 
> Carlos reports an earlier patch, c0cd6f557b90 ("mm: page_alloc: fix
> freelist movement during block conversion"), as the root cause for a
> regression in worst-case zone->lock+irqoff hold times.
> 
> Both of these patches modify the page allocator's fallback path to be
> less greedy in an effort to stave off fragmentation. The flip side of
> this is that fallbacks are also less productive each time around,
> which means the fallback search can run much more frequently.
> 
> Carlos' traces point to rmqueue_bulk() specifically, which tries to
> refill the percpu cache by allocating a large batch of pages in a
> loop. It highlights how once the native freelists are exhausted, the
> fallback code first scans orders top-down for whole blocks to claim,
> then falls back to a bottom-up search for the smallest buddy to steal.
> For the next batch page, it goes through the same thing again.
> 
> This can be made more efficient. Since rmqueue_bulk() holds the
> zone->lock over the entire batch, the freelists are not subject to
> outside changes; when the search for a block to claim has already
> failed, there is no point in trying again for the next page.
> 
> Modify __rmqueue() to remember the last successful fallback mode, and
> restart directly from there on the next rmqueue_bulk() iteration.
> 
> Oliver confirms that this improves beyond the regression that the test
> robot reported against c2f6ea38fc1b:
> 
> commit:
>   f3b92176f4 ("tools/selftests: add guard region test for /proc/$pid/pagemap")
>   c2f6ea38fc ("mm: page_alloc: don't steal single pages from biggest buddy")
>   acc4d5ff0b ("Merge tag 'net-6.15-rc0' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
>   2c847f27c3 ("mm: page_alloc: speed up fallbacks in rmqueue_bulk()")   <--- your patch
> 
> f3b92176f4f7100f c2f6ea38fc1b640aa7a2e155cc1 acc4d5ff0b61eb1715c498b6536 2c847f27c37da65a93d23c237c5
> ---------------- --------------------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \
>   25525364 ±  3%     -56.4%   11135467           -57.8%   10779336           +31.6%   33581409        vm-scalability.throughput
> 
> Carlos confirms that worst-case times are almost fully recovered
> compared to before the earlier culprit patch:
> 
>   2dd482ba627d (before freelist hygiene):    1ms
>   c0cd6f557b90  (after freelist hygiene):   90ms
>  next-20250319    (steal smallest buddy):  280ms
>     this patch                          :    8ms
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Reported-by: Carlos Song <carlos.song@nxp.com>
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Fixes: c0cd6f557b90 ("mm: page_alloc: fix freelist movement during block conversion")
> Fixes: c2f6ea38fc1b ("mm: page_alloc: don't steal single pages from biggest buddy")
> Closes: https://lore.kernel.org/oe-lkp/202503271547.fc08b188-lkp@intel.com
> Cc: stable@vger.kernel.org	# 6.10+

Might be going to be fun with dependency commits.

> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Cool stuff.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


