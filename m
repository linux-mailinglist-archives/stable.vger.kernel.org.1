Return-Path: <stable+bounces-270301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ICutEpHDRWpcEwsAu9opvQ
	(envelope-from <stable+bounces-270301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 03:49:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A37856F2DEA
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 03:49:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=ZFj8EC9C;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270301-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270301-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 927EE3056FD7
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 01:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523902D2394;
	Thu,  2 Jul 2026 01:48:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2CF2D7814
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 01:47:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956882; cv=none; b=tccjQmaqaG4fRVkmBOblrej8uod4DOAUvOof/WWRdiKeMW/onzJV3oihAWspk91PO4xvF7XQ9Di2e/5otCsXhyhwEJKyW2viLur0VGr0sVVApzSUzHuXBTmd8zncjgZV0dsXko80C25htcrEmqmOvS8LwM2I/8k72dCyJyIwOSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956882; c=relaxed/simple;
	bh=vL19Y66aq34h6lqefzTPMlw6YHkIm12+EbTAWK8cCro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlPXOeNRb/s3ENNrCX4at2dQIEBzaYu2cIYkImVqCmissXaiA6HfZ2TjnyP5kbZK7takkCTRVIPaemd+iFlee0IDP38nij6Xlui1zoThj4yEmxc9gHaK5dKuxNcL5Dj0lWK5kiTBQ4LQMtsB5DT/jNgmP3HDDftYLSDYlRXoKOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZFj8EC9C; arc=none smtp.client-ip=95.215.58.174
Message-ID: <5af860ed-e468-495b-905e-5571bf7344af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782956867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JADcuSn/VPIsOHwuCi62daxla5bBVdR5HLrgcBe0R44=;
	b=ZFj8EC9C00SOAkiPd9aM7NmWzeXHYvQayP7DAeln2p7O6oY0pn46TFCduoAzBHEbZwdunE
	d6YaQcpaVWFusEmmmz55uoGwcr0BNfZFcL6jWmXkx3vyMsFm+hgvh6kWEBL83KUzjyTeKF
	j3I0zb2aV3VH+Bg+ZkWgp5I75KWH2es=
Date: Thu, 2 Jul 2026 09:47:25 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Patch mm-hotfixes v5] mm/page_vma_mapped: fix device-private PMD
 handling
To: Klara Modin <klarasmodin@gmail.com>
Cc: david@kernel.org, richard.weiyang@gmail.com, akpm@linux-foundation.org,
 ljs@kernel.org, riel@surriel.com, liam@infradead.org, vbabka@kernel.org,
 harry@kernel.org, jannh@google.com, balbirs@nvidia.com, sj@kernel.org,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <d4e4180e-dcdf-40e6-b5a2-2ac55f4aecc4@kernel.org>
 <20260701163356.22936-1-lance.yang@linux.dev>
 <akVDNLGaCfr-PF8K@soda.int.kasm.eu>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <akVDNLGaCfr-PF8K@soda.int.kasm.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:klarasmodin@gmail.com,m:david@kernel.org,m:richard.weiyang@gmail.com,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:riel@surriel.com,m:liam@infradead.org,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:balbirs@nvidia.com,m:sj@kernel.org,m:ziy@nvidia.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:richardweiyang@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-270301-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux-foundation.org,surriel.com,infradead.org,google.com,nvidia.com,kvack.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A37856F2DEA



On 2026/7/2 00:46, Klara Modin wrote:
[...]
>>>>
>>>> My only guess here would be that the compiler evaluates
>>>> !softleaf_is_migration(entry) to always be true and optimises away the
>>>> !check_pmd(softleaf_to_pfn(entry), pvmw) which is why this worked
>>>> before?
>>>
>>> Weird, we enter this path only with
>>>
>>> pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
>>> pmd_is_device_private_entry(pmde)
>>>
>>> If any one of these would compile for !CONFIG_TRANSPARENT_HUGEPAGE that would be
>>> odd.
>>>
>>> pmd_is_device_private_entry() is hard-coded to false unless
>>> CONFIG_ARCH_ENABLE_THP_MIGRATION. Which is only selected with
>>> ARCH_ENABLE_THP_MIGRATION.
>>>
>>> pmd_trans_huge() as well.
>>>
>>> Maybe it's struggling with pmd_is_migration_entry() on some (older) compilers?
>>> (not innlining stuff and not properly optimizing it out).
> 
> It's a GCC 16 cross-compiler for armv6 so I wouldn't call it old :)
> 
>>>
>>> The whole conditional must be optimized out.
>>
>> Right. Kinda weird if compiler didn't fold
>>
>> pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
>> pmd_is_device_private_entry(pmde)
>>
>> away here ...
>>
>>> We could check for IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) right at the start
>>> to make it easier for the compiler:
>>
>> +1, explicit THP guard should do the trick :)
>>
>>> if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) &&
>>>     (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
>>>      pmd_is_device_private_entry(pmde))) {
>>>
>>>
>>
>> Klara, could you try with this change and see if it fixes the build?
>>
>> Thanks, Lance
> 
> This does indeed make it build.

Good to know, thanks for testing!

