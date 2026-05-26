Return-Path: <stable+bounces-254342-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOR+DuOZFWqNWgcAu9opvQ
	(envelope-from <stable+bounces-254342-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:02:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F195D5F94
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02FCE3040CAA
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D774A23E320;
	Tue, 26 May 2026 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U7FFtse2"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1F2571B8
	for <stable@vger.kernel.org>; Tue, 26 May 2026 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800399; cv=none; b=SyXCoFmwSpSxTX4aFpmqRyo2FTBDcNsDeFvK7MiN4i7r2v9V+p118Dq7ap08xLa5NR7i5FgYjKeRqFRjESyMH5YIg21ET35xtpJbvDBRubrcF3MT6DZoc6jlBu5uiDYYImlW9wP/AQ50kw4dtkKxzjhofSsePy4/066SOEx3fuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800399; c=relaxed/simple;
	bh=JRwfVSK7Bo+hVVeIuCi/spRY9GEU8tG4fcsk+VY8nBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcafnY2FGgdEnKu8MJxvrYhza4EneqXU1Et2YxJdxiRExAw6/b31g8a8PnN3h69L7UqQ0drWpdMS0MvAW399GUy8gi87pfk3Ifg2K2NQacMXvs2FscJBQd5Emh/nVNpcf/UTIQDX3yQRPCJGXwS88yk5J01ihFGotU/nyX4+pX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U7FFtse2; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <206dc5f5-0278-4100-a595-4923da30b900@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779800384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHTwPvQeI3NSDvgqwGcFB5R2OzdXWrLDStlSCxXrhzw=;
	b=U7FFtse2S1tSBDZwOBMwS45HA/T/U66Sxth5rABgqKjubFtl2vU6dpsX0Qmlc/bJREFOAz
	gC1FAbtntfPKPXwn64hsVo/1QECyy5ExehlKkQCbkKC1jrGg9ycUOLOxrbNuvQ1zMGs0uZ
	uCjD7KoU1MaCgiSAp57zhZZFcHAOB9E=
Date: Tue, 26 May 2026 13:59:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/cma: fix reserved page leak on activation failure
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@kernel.org>
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Frank van der Linden <fvdl@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <ahWJMwG8xoQli_Q0@localhost.localdomain>
 <9A340644-CD8D-44B0-BBC5-43D29E9D046E@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <9A340644-CD8D-44B0-BBC5-43D29E9D046E@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254342-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim,bytedance.com:email]
X-Rspamd-Queue-Id: 34F195D5F94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 26/05/2026 13:44, Muchun Song wrote:
> 
> 
>> On May 26, 2026, at 19:51, Oscar Salvador (SUSE) <osalvador@kernel.org> wrote:
>>
>> ﻿On Tue, May 26, 2026 at 04:30:03AM -0700, Usama Arif wrote:
>>> On Fri, 22 May 2026 14:26:58 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
>> ...
>>>> diff --git a/mm/cma.c b/mm/cma.c
>>>> index c7ca567f4c5c..a30075507d41 100644
>>>> --- a/mm/cma.c
>>>> +++ b/mm/cma.c
>>>> @@ -188,10 +188,13 @@ static void __init cma_activate_area(struct cma *cma)
>>>>
>>>>    /* Expose all pages to the buddy, they are useless for CMA. */
>>>>    if (!test_bit(CMA_RESERVE_PAGES_ON_ERROR, &cma->flags)) {
>>>> -        for (r = 0; r < allocrange; r++) {
>>>> +        for (r = 0; r < cma->nranges; r++) {
>>>> +            unsigned long start_pfn;
>>>> +
>>>>            cmr = &cma->ranges[r];
>>>> +            start_pfn = r < allocrange ? early_pfn[r] : cmr->early_pfn;
>>>
>>> Should this be r <= allocrange?
> 
> Yes. So I sent a v2 to fix it last Saturday.
> 
> https://lore.kernel.org/linux-mm/20260523060123.2207992-1-songmuchun@bytedance.com/
> 
> Thanks.

Ah still catching up on the mailing list. Thanks!

> 
>>
>> Yes, I think you are right. I missed that.
>>
>> early_pfn[alloc_range] holds the last assignment, so we should start
>> from the next one reading cmr->early_pfn.
>>
>>
>>
>> --
>> Oscar Salvador
>> SUSE Labs


