Return-Path: <stable+bounces-225313-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDAaCIMWtGlkgwAAu9opvQ
	(envelope-from <stable+bounces-225313-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 14:52:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7682B28443A
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 14:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E035431CA480
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4EF37F8C8;
	Fri, 13 Mar 2026 13:49:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64B7385539;
	Fri, 13 Mar 2026 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773409789; cv=none; b=NjDGi3KPCcimA6L4XOor0UVH+aRMe3hEH6EdN4Lu8JClYwQe6ypyU6y6xNybi/ocV4IKjHUqqCJKvtBIpS7iGEF8WBriKkYT7Rc3hWsYjbP4GJZFBxMJoHPQHLgm5/bohBt4+e12hr0aCQzVxQO2BZq/xRbw1zVpEs3Dk0xXW+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773409789; c=relaxed/simple;
	bh=R/RzDa8ggoa84nzwGaugZlESyMtuWsihWmZpw7DVq54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7iqsCZr222N/t8HhBagddkQLNuSPCiaVryqV/XFEgkbtuPTN9ndOUTe/aQg7sxrQfZa/lcIcEYYMME7jVhsO9/qU8GY3SMNCPcbp6i62KUONwB+kvObJnm8zhO/kMSE44yJNfbVUqUaQnzT2WhXPQ6HNWtVaEELVOx1YmUlUDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 906A93E97C;
	Fri, 13 Mar 2026 13:49:40 +0000 (UTC)
Message-ID: <3020ec8a-5ff9-4816-ad3c-f81dd4513e1a@ghiti.fr>
Date: Fri, 13 Mar 2026 14:49:39 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm: Fix demotion gfp by clearing GFP_RECLAIM after
 setting GFP_TRANSHUGE
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, alexghiti@kernel.org, kernel-team@meta.com,
 akinobu.mita@gmail.com, david@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, zhengqi.arch@bytedance.com,
 shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, gourry@gourry.net, apopple@nvidia.com, byungchul@sk.com,
 joshua.hahnjy@gmail.com, matthew.brost@intel.com, rakie.kim@sk.com,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Bing Jiao <bingjiao@google.com>,
 stable@vger.kernel.org
References: <20260311110314.237315-1-alex@ghiti.fr>
 <20260311110314.237315-4-alex@ghiti.fr> <abGsagHIieEobFbB@cmpxchg.org>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <abGsagHIieEobFbB@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeelkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpefhhfdutdevgeelgeegfeeltdduhfduledvteduhfegffffiefggfektefhjedujeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedufeekrdduleelrdeirddvfeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudefkedrudelledriedrvdefkedphhgvlhhopegluddtrddugedurdeitddrkedtngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhqihgupeeltdeiteelfefgleejvedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedvledprhgtphhtthhopehhrghnnhgvshestghmphigtghhghdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghlvgigghhhihhtiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhmpdhrtghpt
 hhtoheprghkihhnohgsuhhmihhtrgesghhmrghilhdrtghomhdprhgtphhtthhopegurghvihgusehkvghrnhgvlhdrohhrgh
X-GND-State: clean
X-GND-Score: -100
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225313-lists,stable=lfdr.de];
	DMARC_NA(0.00)[ghiti.fr];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,meta.com,gmail.com,oracle.com,google.com,suse.com,bytedance.com,linux.dev,gourry.net,nvidia.com,sk.com,intel.com,linux.alibaba.com,kvack.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@ghiti.fr,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ghiti.fr:email,ghiti.fr:mid]
X-Rspamd-Queue-Id: 7682B28443A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Johannes,

On 3/11/26 18:54, Johannes Weiner wrote:
> On Wed, Mar 11, 2026 at 12:02:42PM +0100, Alexandre Ghiti wrote:
>> GFP_TRANSHUGE sets __GFP_DIRECT_RECLAIM so we must clear GFP_RECLAIM
>> after, not before.
>>
>> Reported-by: Bing Jiao <bingjiao@google.com>
>> Closes: https://lore.kernel.org/linux-mm/aXlKOxGGI9zne8sl@google.com/
>> Fixes: 9933a0c8a539 ("mm/migrate: clear __GFP_RECLAIM to make the migration callback consistent with regular THP allocations")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>   mm/migrate.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 2c3d489ecf51..ee533a4d38db 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -2190,12 +2190,12 @@ struct folio *alloc_migration_target(struct folio *src, unsigned long private)
>>   	}
>>   
>>   	if (folio_test_large(src)) {
>> +		gfp_mask |= GFP_TRANSHUGE;
>>   		/*
>>   		 * clear __GFP_RECLAIM to make the migration callback
>>   		 * consistent with regular THP allocations.
>>   		 */
>>   		gfp_mask &= ~__GFP_RECLAIM;
>> -		gfp_mask |= GFP_TRANSHUGE;
> I don't think this is right.
>
> The Fixes: did it this way to disable kswapd for THP allocations,
> while still allowing the customary direct reclaim. Maybe a better
> comment would have been: /* GFP_TRANSHUGE has its own reclaim policy */
>
> After your fix, direct reclaim isn't allowed either, which makes the
> request unnecessarily wimpy.
>
> The Closes: refers to reclaim that should be avoided during demotion.
> But if this path is taken during demotion it will already not recurse
> into direct reclaim due to PF_MEMALLOC.
>
> So I don't see a bug in the existing code. But maybe the comment could
> be clearer.


Makes sense, I had not understood the comment indeed. I'll drop this fix 
in the next version then.

Thanks,

Alex


