Return-Path: <stable+bounces-266640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Fy8qIzMmMmrWvgUAu9opvQ
	(envelope-from <stable+bounces-266640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 06:44:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F251696797
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 06:44:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=jSX+kpzd;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266640-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266640-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7030F30F1642
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 04:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFEF318EE4;
	Wed, 17 Jun 2026 04:38:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37AD31619C;
	Wed, 17 Jun 2026 04:38:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781671097; cv=none; b=jUZWC8berESMIR7E9TaY0qmbDcRJ2XQnDMfHHUBEIbSB0NcBFyfC3XbKlmxqIsvM/LSwBCLfgj45xiQ1nUPcEEswOXgU/j6gcjOvnc2PtIovOGZDQ/XgaqgGNxlUg3UbnIYMRQvgmpZXw0ZO/2hzk1sR4utHhP1UbFmyLm6nYC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781671097; c=relaxed/simple;
	bh=l+sF4otBiaDNbyxmHxkYKK75JQmzb87WkRxRuGRMIP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fly/WEmJgTaAHGnwaT0HbC2m+JT2aGVyUbDJ5entw59Dkow3rV/rWD7ktsOJ8FOvxdwTDAj7S7oHJWfeGt0d2MQy6VGL6QzaaPhPV7/bvb45dYyoltlS10tbu+Y8ZZB/EDI5FsHqFsNUTAYjoPGiwi4Nrkjzl1ufA8Z+04a2FHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jSX+kpzd; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=wZk7D+ivMxt9ZF3nKyDzrGddw1Qvn0Tco2RSdjIvfNY=; b=jSX+kpzdrZtnNDIskjSTsizwTZ
	Cj6hwX6PJcXqKeNMpOTd67r9mv5UQdqNjn32xGHBaGgcj3CEUe7kcmYretduKkNmxX3tyXezHvlsF
	yvbPyPBGQ9TGo+efO3ax70Kibg2nQyy+wZoC8COw968zlSx5OAB2/5uLKBRTVSEf0XSAjnMvL7+Jh
	c8av7dNx9rAwsXeHGzpiGqWgB5qY48c/vPjR42BOzbRv/Pfa0lTa4aujxn1/UsxnwbHBElM3tzlhD
	Syvbr2p7ko1BvzF6oqNM6bkn6IxSxZU+ZWvxn/Q1n8Im3ZnFaytqL31U1QM0pF+1y3GSt5E0DkqBB
	w39hQvag==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZi2W-0000000Gc3w-1uAw;
	Wed, 17 Jun 2026 04:38:12 +0000
Message-ID: <79c90e12-c157-4d91-a7a4-54225d876d56@infradead.org>
Date: Tue, 16 Jun 2026 21:38:11 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab: recognize @GFP parameter as optional in kernel-doc
To: Harry Yoo <harry@kernel.org>, linux-kernel@vger.kernel.org
Cc: Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 stable@vger.kernel.org, "kees@kernel.org" <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
References: <20260616193929.2394119-1-rdunlap@infradead.org>
 <48840fb6-8c33-4e4a-9951-aa603576357e@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <48840fb6-8c33-4e4a-9951-aa603576357e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-266640-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:linux-kernel@vger.kernel.org,m:vbabka@kernel.org,m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:stable@vger.kernel.org,m:kees@kernel.org,m:corbet@lwn.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rdunlap@infradead.org,stable@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[infradead.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,infradead.org:dkim,infradead.org:email,infradead.org:mid,infradead.org:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F251696797



On 6/16/26 8:25 PM, Harry Yoo wrote:
> [+Cc Kees and Jonathan]
> 
> On 6/17/26 4:39 AM, Randy Dunlap wrote:
>> Since the @GFP parameter in kmalloc_obj() etc. is now optional, change
>> the kernel-doc to indicate that it is optional. This avoids kernel-doc
>> warnings:
>>
>> WARNING: include/linux/slab.h:1101 Excess function parameter 'GFP' description in 'kmalloc_obj'
>> WARNING: include/linux/slab.h:1113 Excess function parameter 'GFP' description in 'kmalloc_objs'
>> WARNING: include/linux/slab.h:1128 Excess function parameter 'GFP' description in 'kmalloc_flex'
>>
>> Fixes: e19e1b480ac7 ("add default_gfp() helper macro and use it in the new *alloc_obj() helpers")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
> 
> I think there is no better way to specify an optional parameter, so:
> Acked-by: Harry Yoo (Oracle) <harry@kernel.org>
> 
> By the way, the doc should probably say that it is GFP_KERNEL when it is
> not specified?

How about (in general):

 * @...: optional GFP flags for the allocation (GFP_KERNEL when not specified)

?
>> Cc: Vlastimil Babka <vbabka@kernel.org>
>> Cc: Harry Yoo <harry@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: stable@vger.kernel.org
>>
>>  include/linux/slab.h |    6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> --- linux-next-20260615.orig/include/linux/slab.h
>> +++ linux-next-20260615/include/linux/slab.h
>> @@ -1094,7 +1094,7 @@ void *kmalloc_nolock(size_t size, gfp_t
>>  /**
>>   * kmalloc_obj - Allocate a single instance of the given type
>>   * @VAR_OR_TYPE: Variable or type to allocate.
>> - * @GFP: GFP flags for the allocation.
>> + * @...: GFP flags for the allocation.
>>   *
>>   * Returns: newly allocated pointer to a @VAR_OR_TYPE on success, or NULL
>>   * on failure.
>> @@ -1106,7 +1106,7 @@ void *kmalloc_nolock(size_t size, gfp_t
>>   * kmalloc_objs - Allocate an array of the given type
>>   * @VAR_OR_TYPE: Variable or type to allocate an array of.
>>   * @COUNT: How many elements in the array.
>> - * @GFP: GFP flags for the allocation.
>> + * @...: GFP flags for the allocation.
>>   *
>>   * Returns: newly allocated pointer to array of @VAR_OR_TYPE on success,
>>   * or NULL on failure.
>> @@ -1119,7 +1119,7 @@ void *kmalloc_nolock(size_t size, gfp_t
>>   * @VAR_OR_TYPE: Variable or type to allocate (with its flex array).
>>   * @FAM: The name of the flexible array member of the structure.
>>   * @COUNT: How many flexible array member elements are desired.
>> - * @GFP: GFP flags for the allocation.
>> + * @...: GFP flags for the allocation.
>>   *
>>   * Returns: newly allocated pointer to @VAR_OR_TYPE on success, NULL on
>>   * failure. If @FAM has been annotated with __counted_by(), the allocation
> 

-- 
~Randy


