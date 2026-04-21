Return-Path: <stable+bounces-240093-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IV/A2U952kK5wEAu9opvQ
	(envelope-from <stable+bounces-240093-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 11:03:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B29043890B
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 11:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D25C3012217
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2C33A5453;
	Tue, 21 Apr 2026 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YxtO80Py"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CEE3A451F
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762172; cv=none; b=qnhY1zzC8BtUsh/0vWBfmj7Da9pFa+urwpTZozJrhOK4GmYEKshl7teGSHpHj9NSFYmDt9bAf9iUDhKIjKeSJJ/eSySAQwV2yl+l6+1pVTuE78yf8x2SshS6T2lDcY1wPVcaXtHuEn4CO+UV4aRJ9omowKN+yjFxQhVXXlUcJnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762172; c=relaxed/simple;
	bh=PtUQkhF8ODo+uUc8J4/pGSkHu0QMqX1x2kVB2oV6dAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hK3tVPW4EL571E/YAyRfUQLeJQ/n7gXfF76241gRx5jVEz4R1WbWorjqTYVBXMB1wMO+sGvDGjpRekkHE+KPUmHGxBDECAuwrnFeMa3BsrojA4xHBoduZbwf0GAp6fq/1dsZ1GZAjiTIgG4JX/6HTKmDWnEJyrct8kHyeDZ72P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YxtO80Py; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4411e2dfe9fso81527f8f.0
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 02:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776762168; x=1777366968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D1tUMNKsUka20XG67YhLFUj+hBxuaCOCgy+TNZlHY/s=;
        b=YxtO80Py/n3gxmHgHjs6Eh2Bk/cI921/+YOfcAx40aw+LmhohQLDFN1GIT4Wp077ua
         Y4jmQInmJHK8GCoDFgXDFcH+vwSsEUjI5gHcJU0ZgC2MfQSZkQGp1rWISfvGxl7W3yny
         fVXbiZNfhKawTeLkjmeRLfPw5dOJ2lmBbtU4hPu8MtuY984kNYJBjzvHXOK5mFej75ue
         w1lnfg0a+JuRFDsl/Vo3f5dJcvMOc4S9hTN+B1+ODqq4paqSR39Q9BNAYnvXuWxE3blK
         0kGKgYXhct+6Td08nRtNpfWJ8E0Tdu8IV2PPtP+hqfaComPktR3Qfw008gI8uOJWS8kq
         PUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776762168; x=1777366968;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1tUMNKsUka20XG67YhLFUj+hBxuaCOCgy+TNZlHY/s=;
        b=HP+lI1d0bsTmsBQQtkMb85gDTAFw1IcyUSewab+MLIiTsKU6UtspH1ZQ9RmEp8c6Hs
         gFnNtIMXECCE1TGFEFlUJoGFzlr30m0d0YzPaBkLqiKo8IP50zY03WWkzaRgr2RZAIps
         OORxn9shYUE5BIWMi1haIFgBXqGIYf7fBU4fm4NHSU/Lg9JmUJjuyKUE7Bq3uFOmrDHD
         h24u6l1/hhGz20yIIc+OGbtsNC/vqcJ6ItSIFsdw8ZaX7ZojZRZK40RptkrfpZX4QO85
         1kycMvw3kMZl3O9Fwo4PIPEhdKQsdN7+8JCoNy0L68xm/yLObZlZ9oU2g5ZEW+8rxF+A
         c7ZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9/dK+0s6Kql2+9Y7TocwNu8YqcXMm6EL+0z2viUsdW990T/WSyUKhrYaGBXsQ4HnFZacGa/58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJsGOhPURfjjtIITXDWObt6gXbG9pj4t1euYeyCnYx7EC4658Y
	scgDwXWda5fhuG6+FUG9M8Ydv5epcw/gyH/pW9LT9XWS01ngSjUgO79YANUEAjXpabw=
X-Gm-Gg: AeBDiesfmqZjlWPDQCsB2aG1NJSsj52pxchCe0K9EN+3mdQFMay3+hgkooxotOVssM+
	x5d0SML9XH0+pLe0L1MLpupFmAHZX9ZbA3xi5cswfH3fx7fdYmGinzZDnChYyaOVz5Mi6lGEjbI
	aJphTo3ye5ysjxgHtfXgasjB2RJDH5sI78o1Z+e9xXI1DpXm/uPdPOc/CcUnDApZ90bGY2/jGyx
	YUQVpfbmzT6oC3Pb7IcBqllml7boyROHY6xFlTK+nfk85wNpTE0hQXDMS2ZT8PDIP0/dPwPe1Tv
	toltGRxGgYmoo1B71o5+XxUrTCCcs7Eth9iM2437X0BNQ7eHN0wNpL2xeb9vws3jTGFq9VIQqpv
	0KTKQ0T2xZ5BkDXhdKMmrhzz4myKqWSjuv81rnWu/VzHg57F2weYdjSFkuoIn6lI+otGfKBnse2
	9I9t8BO6Kf3d+LAZlC4cpiVRquYiLDaC9Jo4oyyG2+8SOMf8WrRyuvFePUtVdjUaK10iRi
X-Received: by 2002:a05:600c:4746:b0:488:ac4b:59d1 with SMTP id 5b1f17b1804b1-488fb7ab49cmr115940905e9.8.1776762168051;
        Tue, 21 Apr 2026 02:02:48 -0700 (PDT)
Received: from ?IPV6:2001:1a48:8:903:1ed6:4f73:ce38:f9d4? ([2001:1a48:8:903:1ed6:4f73:ce38:f9d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c08faffsm269654935e9.1.2026.04.21.02.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 02:02:47 -0700 (PDT)
Message-ID: <1f50ce04-20e6-46a0-9d8a-00a5f7a74967@suse.com>
Date: Tue, 21 Apr 2026 11:02:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order
 allocation
Content-Language: en-US
To: Dave Chinner <dgc@kernel.org>, Salvatore Dipietro <dipiets@amazon.it>
Cc: linux-kernel@vger.kernel.org, alisaidi@amazon.com, blakgeof@amazon.com,
 abuehaze@amazon.de, dipietro.salvatore@gmail.com, willy@infradead.org,
 stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20260403193535.9970-1-dipiets@amazon.it>
 <20260403193535.9970-2-dipiets@amazon.it> <adLlrSZ5oRAa_Hfd@dread>
From: Vlastimil Babka <vbabka@suse.com>
In-Reply-To: <adLlrSZ5oRAa_Hfd@dread>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[vger.kernel.org,amazon.com,amazon.de,gmail.com,infradead.org,kernel.org,kvack.org,suse.com,cmpxchg.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240093-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.it:email,suse.com:dkim,suse.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B29043890B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/26 00:43, Dave Chinner wrote:
> On Fri, Apr 03, 2026 at 07:35:34PM +0000, Salvatore Dipietro wrote:
>> Commit 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
>> introduced high-order folio allocations in the buffered write
>> path. When memory is fragmented, each failed allocation triggers
>> compaction and drain_all_pages() via __alloc_pages_slowpath(),
>> causing a 0.75x throughput drop on pgbench (simple-update) with 
>> 1024 clients on a 96-vCPU arm64 system.
>> 
>> Strip __GFP_DIRECT_RECLAIM from folio allocations in
>> iomap_get_folio() when the order exceeds PAGE_ALLOC_COSTLY_ORDER,
>> making them purely opportunistic.
>> 
>> Fixes: 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Salvatore Dipietro <dipiets@amazon.it>

BTW, backporting perf regressions fixes to 6.6, when they are only reported
at the time 7.0 is released, might be too risky. There will likely be a
different workload that will regress as a result, no matter what we do.

>> ---
>>  fs/iomap/buffered-io.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>> 
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index 92a831cf4bf1..cb843d54b4d9 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -715,6 +715,7 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
>>  struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
>>  {
>>  	fgf_t fgp = FGP_WRITEBEGIN | FGP_NOFS;
>> +	gfp_t gfp;
>>  
>>  	if (iter->flags & IOMAP_NOWAIT)
>>  		fgp |= FGP_NOWAIT;
>> @@ -722,8 +723,20 @@ struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
>>  		fgp |= FGP_DONTCACHE;
>>  	fgp |= fgf_set_order(len);
>>  
>> +	gfp = mapping_gfp_mask(iter->inode->i_mapping);
>> +
>> +	/*
>> +	 * If the folio order hint exceeds PAGE_ALLOC_COSTLY_ORDER,
>> +	 * strip __GFP_DIRECT_RECLAIM to make the allocation purely
>> +	 * opportunistic.  This avoids compaction + drain_all_pages()
>> +	 * in __alloc_pages_slowpath() that devastate throughput
>> +	 * on large systems during buffered writes.
>> +	 */
>> +	if (FGF_GET_ORDER(fgp) > PAGE_ALLOC_COSTLY_ORDER)
>> +		gfp &= ~__GFP_DIRECT_RECLAIM;
> 
> Adding these "gfp &= ~__GFP_DIRECT_RECLAIM" hacks everywhere
> we need to do high order folio allocation is getting out of hand.
> 
> Compaction improves long term system performance, so we don't really
> just want to turn it off whenever we have demand for high order
> folios.
> 
> We should be doing is getting rid of compaction out of the direct
> reclaim path - it is -clearly- way too costly for hot paths that use
> large allocations, especially those with fallbacks to smaller
> allocations or vmalloc.
> 
> Instead, memory reclaim should kick background compaction and let it
> do the work. If the allocation path really, really needs high order
> allocation to succeed, then it can direct the allocation to retry
> until it succeeds and the allocator itself can wait for background
> compaction to make progress.
> 
> For code that has fallbacks to smaller allocations, then there is no
> need to wait for compaction - we can attempt fast smaller allocations
> and continue that way until an allocation succeeds....

So, should we do a LSF/MM session?

But I think in any case, the page allocator needs to know which allocations
do have the fallback. __GFP_NORETRY exists for this. Here it wasn't tried at
all, in v2 [1] it was, but not alone. I'd start from __GFP_NORETRY alone,
and then we can look at tweaking what it does if it's currently insufficient.

We could have a helper to encapsulate this "turn this allocation to a
lightweight fallbackable one", which would add __GFP_NORETRY. It probably
already exists somewhere but not gfp.h. But I'm not sure we can simply
change GFP_KERNEL to start failing more for non-costly orders. We've
discussed that a lot in the past :)

[1] https://lore.kernel.org/all/20260420161404.642-1-dipiets@amazon.it/

> -Dave.


