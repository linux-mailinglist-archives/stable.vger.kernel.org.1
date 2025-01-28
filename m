Return-Path: <stable+bounces-110943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60D9A2078E
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 10:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2739216833D
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 09:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781D4199252;
	Tue, 28 Jan 2025 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YV0mgcu5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mElZqkOe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E5Wy373x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lU0UZKiN"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763F4C2ED
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738057332; cv=none; b=isU7Srq25I0r1HVlkFla6Akc9Y/vtCXVpWfCL8xsyp/Etk5Cm+mYcsA1W60w7y3vLi1p8V1e5LR3FuigixoOuomyAHS1XANkJhZSCgWK5i3TKkgjNPpu1DfZm41ZOQ5oRsFR5nuZKzCTV3kafTFSachsXtl5A4fHilByxRk+06o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738057332; c=relaxed/simple;
	bh=rtPuxrZRBcS9qa7jfKb3Ywkr93qlmYLaR6WN3b4qFHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwEj5DNeLw/kKrCc0PyLSJaEqFZKH7LZKZ7yRi4s+1kpY4ICTd9dhXVrCmWY9LT08QCr53xj7ZYJI7jT/TAID5wR/rsTzGa00aFiNYxvaFxIIW2DAiPh5pY2ORY84c/FFmO0T56zq14CwOG5FwQkaF0hxvcM3olQhFqbMvlMHWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YV0mgcu5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mElZqkOe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E5Wy373x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lU0UZKiN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 765951F381;
	Tue, 28 Jan 2025 09:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738057326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73qoOr68BeVckfLf3UU58FBRy6jOf3OFC4ec2nszGCg=;
	b=YV0mgcu5OqRj1pmcb2Fy28BCCHc87Q972G6D9RcjaFhm7OCAc6XRSjQdw0dVGkMlWWreZN
	Gw79L9vAzxsihMC1EJb7cjXWsLVMtnfQv4o+Qeme++FDuL70mDWQxXfFH/Am/gsklvPHdh
	Qa26Mma0ndd5Fdz79pkiS8XX/YFuC78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738057326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73qoOr68BeVckfLf3UU58FBRy6jOf3OFC4ec2nszGCg=;
	b=mElZqkOeEWYcAe1INocToC+wy+28oXItRPUAHK2NiYazofX4dSOO3vIYyinWAMRdD4hysE
	6YpqOFPFMDr+4CBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=E5Wy373x;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lU0UZKiN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738057325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73qoOr68BeVckfLf3UU58FBRy6jOf3OFC4ec2nszGCg=;
	b=E5Wy373xJzTdKlZnSBGWVVPoco8D4dY3cL3C5WEAg8QLc9meMCEGTR6z92gRANjQhHQbaP
	7y9MUD8b13SOHmIprg2jCmPWcgzoFsZM4Uk8xpIBp+9eSAH5NL925mYSvjlQ/1xAJ3Uauc
	YULcb01UocbfdsTRu9/KwfNPJUtxYlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738057325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73qoOr68BeVckfLf3UU58FBRy6jOf3OFC4ec2nszGCg=;
	b=lU0UZKiNHC51HTff+IK7tVPkhrMzizlNmo57+0BMSOYWv9pFzYCebeEc7bw4pAYGADAiq7
	HUOvbpEkGWnYqnDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BDBC13625;
	Tue, 28 Jan 2025 09:42:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lX/wFW2mmGcRDgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 28 Jan 2025 09:42:05 +0000
Message-ID: <ecbc496b-aee5-402c-add1-0ab9d8eef8a9@suse.cz>
Date: Tue, 28 Jan 2025 10:42:04 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.12 hotfix] mm/zswap: fix inconsistent charging when
 zswap_store_page() fails
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 stable@vger.kernel.org
References: <20250128174938.2638-1-42.hyeyoo@gmail.com>
 <2025012842-rebuilt-snugly-518f@gregkh>
 <CAB=+i9Q56PxJ_YpzdcJWWGfxMKKEhkSu0xszv4ne4Ep+KFs-Aw@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAB=+i9Q56PxJ_YpzdcJWWGfxMKKEhkSu0xszv4ne4Ep+KFs-Aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 765951F381
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,cmpxchg.org,google.com,gmail.com,linux.dev,linux-foundation.org,kvack.org,vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 1/28/25 19:18, Hyeonggon Yoo wrote:
> On Tue, Jan 28, 2025 at 6:14 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Wed, Jan 29, 2025 at 02:49:38AM +0900, Hyeonggon Yoo wrote:
>> > Commit b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
>> > mistakenly skipped charging any zswapped pages when a single call to
>> > zswap_store_page() failed, even if some pages in the folio are
>> > successfully stored in zswap.
>> >
>> > Making things worse, these not-charged pages are uncharged in
>> > zswap_entry_free(), making zswap charging inconsistent.
>> >
>> > This inconsistency triggers two warnings when following these steps:
>> >   # On a machine with 64GiB of RAM and 36GiB of zswap
>> >   $ stress-ng --bigheap 2 # wait until the OOM-killer kills stress-ng
>> >   $ sudo reboot
>> >
>> >   Two warnings are:
>> >     in mm/memcontrol.c:163, function obj_cgroup_release():
>> >       WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
>> >
>> >     in mm/page_counter.c:60, function page_counter_cancel():
>> >       if (WARN_ONCE(new < 0, "page_counter underflow: %ld nr_pages=%lu\n",
>> >         new, nr_pages))
>> >
>> > Charge zswapped pages even if some pages of the folio are not zswapped.
>> > After resolving the inconsistency, these warnings disappear.
>> >
>> > Fixes: b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
>>
>> This commit is in 6.13, not 6.12, so your subject line is a bit
>> confusing :(
> 
> Oh, thanks for catching. Will fix it.
> Also, I noticed I incorrectly described the problem.
> 
> Will send v2 (for v6.13!) after adjusting them.

I think we use e.g. "v6.13 hotfix" only while the stabilization of 6.13 is
ongoing, to indicate the urgency. Now it's too late so it would only confuse
stable maintainers, while the patch is not directly aimed at stable, but
through mm to mainline and then stable backport as usual. So I think you can
just use [PATCH mm-hotfixes] at this point.

> Best,
> Hyeonggon
> 


