Return-Path: <stable+bounces-215597-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEH0Oq2kimmhMgAAu9opvQ
	(envelope-from <stable+bounces-215597-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 04:23:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F01BF116B8D
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 04:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEC8830086E7
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 03:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50658285073;
	Tue, 10 Feb 2026 03:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8uwrp4S"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737E33A1C9
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 03:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770693791; cv=none; b=Ao31i2xOHb0mA9nd2ok3H3IfJF/cm8pb4FsLV8Coab7J6KG3fbusObBGVbSvylfbL51h+F65J9occooboIRk/Yr0s6stl/pJnCBa8e35mFWg3NNuzSFoIhEaxQbGmMDNDF/D4izeG593Mk6gJtAeFsALObirFwKhd3j60E2umkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770693791; c=relaxed/simple;
	bh=gVrMey1DIUk/OJv7ojBAa1Os8S/2D8csj2CRybOyjq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VI5hV3ReTR8/Q0yM8HJSrBNeYNAHEQkwU/nhPjBDHR5bP4ANPMZdIf23J20DxIwg2X900ujutmvjM9TfLD/j5+5UmVCOrTpU914LfdfEQCetRjb2llhdOVaZsDUhBBgcPcCn7u37bdGC5owS9UZhukGZAdhTAK0fAAd7KnUpn5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8uwrp4S; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6582e8831aeso554170a12.1
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 19:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770693788; x=1771298588; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hc6QPKraklZc802qcURShhVzZIMv2vVuwuGAuOaJIEo=;
        b=L8uwrp4St/tH9W1OHtBii4vmtwa7AHToeXJEW/ejzId8ahJym9jWc/z+Umx3AIdh1E
         3x1vGDuojGrnYSEMXRz19HSDpYQ/CuqCH8NBeKnDuXexOi5LexgGq82FCU3Erdz5JYIH
         VuB9iXAG3MIumelwvjcE+s1u3s2po6S9CAWoZONtRZN1+nczYI6Ui6nnm0rl3Lo2w+5g
         zIFo/2o1mSSIf2bNNm2IrHI2PkeVPnoXzyGLbueX/+2ZPzteeA/dMbT/Uz+tP18vBGmq
         kToMC33vow33tSnbbi+8/zTGe/KkmK4GJG3CURKKNBW2zrUTxheAavS8jTN7TOTZxDN1
         2ZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770693788; x=1771298588;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hc6QPKraklZc802qcURShhVzZIMv2vVuwuGAuOaJIEo=;
        b=ic2bLMM0SPcNYCEaLQzG+kT3k+Jnf9lt9eI9iMmiNOVmTOdDAqdBLdGesLsaZA6BuN
         pOv9S4s2pWVIsL6QmIIiH5aQRPNpW+aGFHn2GkssoMtnM2Q+Ehv7BRklKwNsYSICjHkR
         DObUl11RWCZoCvo+FW154bWFbAqM3kal2g3MFMH8IMIBZKlvSi3p0syCXwIcQe6KAdWY
         4XyX/goJx2SwvtUJh3o/lr4M1/pxmfDf7o+gC4r4xLqHzH3xMTw7iIx9MaDZLlNbxMmc
         QKZdrLnpSlxfmguwXsIcs/yNnmBoKhshexQ8XnTdLaZ1Nxg2TlyV3Mj/hLC3j00UhgjH
         cWWw==
X-Forwarded-Encrypted: i=1; AJvYcCWD+7hNmQr3+nxf677o9CG6Umr/YD6es7nvglbnHH8ncbdVEL/nhlYNKmcmtYqEHLbwcfWUioI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO4yR6+CS9R5f1R/WV/SUh/MYCsEaw7E2jZyZ5UHm8ej+5Ws2b
	vbz+fRl5qTn+Ip10P912iG0+b6JWOpTNF86YCDil+xyNMGvEL3Jv7avE
X-Gm-Gg: AZuq6aJ/jQx3vlLILGN64Kk6FkbXx077F8lNR8ERGZIp2kleRH/YN6XDmobh1v1Y5Gl
	//sp46vg2/Cl0dhG2898zbXvUm1CjcGXDFcaHNsc3OOpSQdf1TKn5bqtGAMCfcCGkoK6LBFu+67
	+aH30jyeHSNVxNeZkEYZd/VT4OhkQAK8I1iHJId/E4MT//LzSM/l5q/Qd8S/cCffMvhdjUkp5SL
	e+p7BrE6BijdEJu9cR8TxyyyTuLvARYdJrmPyc356K1j2EwHpL+adC0XBU8f302Mo4KnYE65Lm6
	T9qZFFuuz3MtgoQR9o9+NWw0y88lv05P8zpWmRDTmP1Fy6FapFHjHyCDlJ4PvOS8oWq3OiajvUC
	jaqhaWi8/daKrBKyXvVaBv26OLae+Siht0FgwvOcNK9YEO5qqhY+j8qU/Gl8+VLqjrZZ+Rydyus
	oSUqoz1QhUfhJAEB9Skit1Pg==
X-Received: by 2002:a17:907:a03:b0:b87:5464:8b5c with SMTP id a640c23a62f3a-b8edf48fac1mr816411666b.63.1770693787443;
        Mon, 09 Feb 2026 19:23:07 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8edacb1d3fsm444339366b.34.2026.02.09.19.23.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Feb 2026 19:23:06 -0800 (PST)
Date: Tue, 10 Feb 2026 03:23:04 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	david@kernel.org, riel@surriel.com, Liam.Howlett@oracle.com,
	vbabka@suse.cz, harry.yoo@oracle.com, jannh@google.com,
	gavinguo@igalia.com, baolin.wang@linux.alibaba.com, ziy@nvidia.com,
	linux-mm@kvack.org, Lance Yang <lance.yang@linux.dev>,
	stable@vger.kernel.org
Subject: Re: [Patch v3] mm/huge_memory: fix early failure try_to_migrate()
 when split huge pmd for shared thp
Message-ID: <20260210032304.j4k5izweewouabqb@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260205033113.30724-1-richard.weiyang@gmail.com>
 <fbd6c31f-7f35-4986-86e3-76bf8963433d@lucifer.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbd6c31f-7f35-4986-86e3-76bf8963433d@lucifer.local>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-215597-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,surriel.com,oracle.com,suse.cz,google.com,igalia.com,linux.alibaba.com,nvidia.com,kvack.org,linux.dev,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: F01BF116B8D
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 05:08:16PM +0000, Lorenzo Stoakes wrote:
>On Thu, Feb 05, 2026 at 03:31:13AM +0000, Wei Yang wrote:
>> Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and
>> split_huge_pmd_locked()") return false unconditionally after
>> split_huge_pmd_locked() which may fail early during try_to_migrate() for
>> shared thp. This will lead to unexpected folio split failure.
>
>I think this could be put more clearly. 'When splitting a PMD THP migration
>entry in try_to_migrate_one() in a rmap walk invoked by try_to_migrate() when

split_huge_pmd_locked() could split a PMD THP migration entry, but here we
expect a PMD THP normal entry.

>TTU_SPLIT_HUGE_PMD is specified.' or something like that.
>
>>
>> One way to reproduce:
>>
>>     Create an anonymous thp range and fork 512 children, so we have a
>>     thp shared mapped in 513 processes. Then trigger folio split with
>>     /sys/kernel/debug/split_huge_pages debugfs to split the thp folio to
>>     order 0.
>
>I think you should explain the issue before the repro. This is just confusing
>things. Mention the repro _afterwards_.
>

OK, will move afterwards.

>>
>> Without the above commit, we can successfully split to order 0.
>> With the above commit, the folio is still a large folio.
>>
>> The reason is the above commit return false after split pmd
>
>This sentence doesn't really make sense. Returns false where? And under what
>circumstances?
>
>I'm having to look through 60fbb14396d5 to understand this which isn't a good
>sign.
>
>'This patch adjusted try_to_migrate_one() to, when a PMD-mapped THP migration

I am afraid the original intention of commit 60fbb14396d5 is not just for
migration entry.

>entry is found, and TTU_SPLIT_HUGE_PMD is specified (for example, via
>unmap_folio()), exit the walk and return false unconditionally'.
>
>> unconditionally in the first process and break try_to_migrate().
>>
>> On memory pressure or failure, we would try to reclaim unused memory or
>> limit bad memory after folio split. If failed to split it, we will leave
>
>Limit bad memory? What does that mean? Also should be If '_we_' or '_it_' or
>something like that.
>

What I want to mean is in memory_failure() we use try_to_split_thp_page() and
the PG_has_hwpoisoned bit is only set in the after-split folio contains
@split_at.

>> some more memory unusable than expected.
>
>'We will leave some more memory unusable than expected' is super unclear.
>
>You mean we will fail to migrate THP entries at the PTE level?
>

No. 

Hmm... I would like to clarify before continue.

This fix is not to fix migration case. This is to fix folio split for a shared
mapped PMD THP. Current folio split leverage migration entry during split
anonymous folio. So the action here is not to migrate it.

I am a little lost here.

>Can we say this instead please?
>
>>
>> The tricky thing in above reproduce method is current debugfs interface
>> leverage function split_huge_pages_pid(), which will iterate the whole
>> pmd range and do folio split on each base page address. This means it
>> will try 512 times, and each time split one pmd from pmd mapped to pte
>> mapped thp. If there are less than 512 shared mapped process,
>> the folio is still split successfully at last. But in real world, we
>> usually try it for once.
>
>This whole sentence could be dropped I think I don't think it adds anything.
>
>And you're really confusing the issue by dwelling on this I think.
>
>You need to restart the walk in this case in order for the PTEs to be correctly
>handled right?
>
>Can you explain why we can't just essentially revert 60fbb14396d5? Or at least
>the bit that did this change?
>
>Also is unmap_folio() the only caller with TTU_SPLIT_HUGE_PMD as the comment
>that was deleted by 60fbb14396d5 implied? Or are there others? If it is, please
>mention the commit msg.
>
>
>>
>> This patch fixes this by restart page_vma_mapped_walk() after
>> split_huge_pmd_locked(). We cannot simply return "true" to fix the
>> problem, as that would affect another case:
>
>I mean how would it fix the problem to incorrectly have it return true when the
>walk had not in fact completed?
>
>I'm not sure why you're dwelling on this idea in the commit msg?
>
>> split_huge_pmd_locked()->folio_try_share_anon_rmap_pmd() can failed and
>> leave the folio mapped through PTEs; we would return "true" from
>> try_to_migrate_one() in that case as well. While that is mostly
>> harmless, we could end up walking the rmap, wasting some cycles.
>
>I mean I think we can just drop this whole paragraph no?
>
>You might think I'm being picky about the commit msg here, but as is I find it
>pretty much incomprehensible and that's not helpful if we have to go back and
>read this in future.
>

Never mind.

A clearer and comprehensive change log is helpful for all. And my English is
not native language, so your suggestion helps a lot.

>>
>> Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and split_huge_pmd_locked()")
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Tested-by: Lance Yang <lance.yang@linux.dev>
>> Reviewed-by: Lance Yang <lance.yang@linux.dev>
>> Reviewed-by: Gavin Guo <gavinguo@igalia.com>
>> Acked-by: David Hildenbrand (arm) <david@kernel.org>
>> Cc: Gavin Guo <gavinguo@igalia.com>
>> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Lance Yang <lance.yang@linux.dev>
>> Cc: <stable@vger.kernel.org>
>>
>> ---
>> v3:
>>   * gather RB
>>   * adjust the commit log and comment per David
>
>Clearly not enough :)
>
>>   * add userspace-visible runtime effect in change log
>
>Which one was that?
>
>> v2:
>>   * restart page_vma_mapped_walk() after split_huge_pmd_locked()
>> ---
>>  mm/rmap.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 618df3385c8b..1041a64b8e6b 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -2446,11 +2446,17 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>  			__maybe_unused pmd_t pmdval;
>>
>>  			if (flags & TTU_SPLIT_HUGE_PMD) {
>> +				/*
>> +				 * split_huge_pmd_locked() might leave the
>> +				 * folio mapped through PTEs. Retry the walk
>> +				 * so we can detect this scenario and properly
>> +				 * abort the walk.
>> +				 */
>
>This comment is a lot clearer than the commit msg :)
>
>>  				split_huge_pmd_locked(vma, pvmw.address,
>>  						      pvmw.pmd, true);
>> -				ret = false;
>> -				page_vma_mapped_walk_done(&pvmw);
>> -				break;
>> +				flags &= ~TTU_SPLIT_HUGE_PMD;
>> +				page_vma_mapped_walk_restart(&pvmw);
>> +				continue;
>
>This logic does lok reasonable.
>
>>  			}
>>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>>  			pmdval = pmdp_get(pvmw.pmd);
>> --
>> 2.34.1
>>
>
>Cheers, Lorenzo

-- 
Wei Yang
Help you, Help me

