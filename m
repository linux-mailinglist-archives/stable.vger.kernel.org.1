Return-Path: <stable+bounces-269328-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tYSPNOA6P2ppQAkAu9opvQ
	(envelope-from <stable+bounces-269328-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 04:52:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 208FC6D0CDF
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 04:52:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=HzaW6oQX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269328-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269328-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70135302EEA6
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 02:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA24C32E141;
	Sat, 27 Jun 2026 02:51:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457BE30E0FB
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 02:51:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782528716; cv=none; b=RaXe7fV/xqKcmdseed2iurtiVYVOyzln0XS6t4wYkAYib6SZmUYLWkILCD8cLghP5HEt3acH2jSn/GrtIm8OR3PpDVXoGROVv2kQTT9KfZAdhS5m5fLhJAsdqMSalW9WpiFYgabuE00uvlnj5wy8QF37qOPJ+2fUxsX3/54fR5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782528716; c=relaxed/simple;
	bh=Pc6g61P+PpxGknRJgmmqIo167RjsspVtlCGIy7/VoFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5JelqUrhjowssIhhTr5wjvsCSZ57fqY65AcpWK6FKSw8KV6w7IYcqUkee0KHPz+H5BFOH3TLOzk6/+qKV/hFtm4lUjbVhUYC9aOuiyI/SJsAneA9l/nmPKj3eYZMPQPX213VWLN5ODCd7PzID37d8V40JmFW9+c8fSBsw2ABLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HzaW6oQX; arc=none smtp.client-ip=95.215.58.188
Message-ID: <99fa03d6-9869-476b-a605-1ab27f13c369@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782528703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BDYcE5MsrZIKnRWtwXNcAj7rSHtaafqGAtwFoyTEBR0=;
	b=HzaW6oQXohR6/maYtwI7n7BvwwmvGnJO/N1eUnnHpEXBW5Qyuo2NPtrEUtsoS3CdlTRLdA
	W2uQQ113xI/zkQsAapMbuuBudKju88XP5F5ATruxgFSHRV7RlHKH5eXdgp6KH18X2+iC2/
	sy6HTHxPVGhRdLHcutYJKoJJp9tpMuQ=
Date: Sat, 27 Jun 2026 10:51:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Patch mm-hotfixes v4] mm/page_vma_mapped: fix device-private PMD
 handling
Content-Language: en-US
To: Wei Yang <richard.weiyang@gmail.com>
Cc: david@kernel.org, akpm@linux-foundation.org, ljs@kernel.org,
 riel@surriel.com, liam@infradead.org, vbabka@kernel.org, harry@kernel.org,
 jannh@google.com, ziy@nvidia.com, sj@kernel.org, balbirs@nvidia.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <d060cadd-34f8-42da-b7f7-c8d295050436@kernel.org>
 <20260626132728.77436-1-lance.yang@linux.dev>
 <20260627003813.ktpya35fx5doaz36@master>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260627003813.ktpya35fx5doaz36@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:richard.weiyang@gmail.com,m:david@kernel.org,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:riel@surriel.com,m:liam@infradead.org,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:ziy@nvidia.com,m:sj@kernel.org,m:balbirs@nvidia.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:richardweiyang@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-269328-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 208FC6D0CDF



On 2026/6/27 08:38, Wei Yang wrote:
[...]
>>
>> Might be good with this on top:
>>
>> ---8<---
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index cfa1230c87bb..8b7c062bd81d 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -281,7 +281,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>> 					return not_found(pvmw);
>> 				return true;
>> 			}
>> -			/* THP pmd was split under us: handle on pte level */
>> +			/* THP/device-private pmd was split under us: handle on pte level */
> 
> As the comment in commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration
> support device-private entries") says:
> 
>    Add device-private THP support...
> 
> Per my understanding, we first already setup mapping and "migrate" to device
> memory. This looks a kind of place holder.
> 
> Not familiar with this. Just want to clarify, we want to treat device-private
> pmd as some sort of THP or not?

Not a regular THP, obviously. Just the PMD-sized device-private entry case.

It can be split under us too; see commit 146287290023 ("mm/huge_memory:
implement device-private THP splitting").

Nothing deeper meant here. After taking PTL, if that PMD-sized entry
is gone, just drop to the PTE walk.

> 
>> 			spin_unlock(pvmw->ptl);
>> 			pvmw->ptl = NULL;
>> 		} else if (!pmd_present(pmde)) {
>> --


