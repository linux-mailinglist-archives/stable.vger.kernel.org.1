Return-Path: <stable+bounces-220037-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAEqE85comlw2QQAu9opvQ
	(envelope-from <stable+bounces-220037-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 04:11:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D591C016A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 04:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 650383027106
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 03:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6432BFC60;
	Sat, 28 Feb 2026 03:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i/IUwjHo"
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EAD2C11E3
	for <stable@vger.kernel.org>; Sat, 28 Feb 2026 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772248266; cv=none; b=f4Yap2Pko4YY+f1aJxrn3bIHm4yFGtGkGP6iZKY40EkPKIyNqQqssmJYaPrv+6RgM0IjYyMYBVl4sV6saZk1zwNCy7J+WLUvNPDwkHARBTz3ACtOV3HXx9b0RprowP33+XPyEr+BcVZzGAkYfvTa5GW/ExPrxVaogVx4OV2vaDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772248266; c=relaxed/simple;
	bh=mNl1LbMGjYUbCzU4vQByzQJiBmXZeLfvhuiL59GXBDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwVfTmHhJi3b99lDQjkwyKhLBSNdswTJXDXsAd7kjwIRF+vKDY+qlDd9Vi0zjvi4XimYHg0tj4kAreDf0lP6/asPsOoEgwZzuiQ3nY0owjbxeaOrUmmqTzEQotNy+ksLr0ar85Cz3tyFRF9MbL789M2n3s2fdW+eYS1TfiO8VBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i/IUwjHo; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d9e30bef-621f-444a-a1b0-510c50927d9b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772248253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PYQQLk8wpmk+sABOYPuHFRoK/LYQ6t6e9PEJlhNNQ1c=;
	b=i/IUwjHoBmbin/bk4vmzAyNuXXnNsDly9+ntzJ+UD3h3i+ybef+o76so/8CXJDE5DIeaBh
	KBLEDNWenb4Ov8Mc/yi3lIUejaCsiv3OD4dv8VHcyYBNonnljwaj+M/qAoUibHlR1xEpTo
	K/3dqOsB2xj9dcW8neHDZYTamke2rrM=
Date: Sat, 28 Feb 2026 11:10:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/huge_memory: fix a folio_split() race condition with
 folio_try_get()
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Hugh Dickins
 <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Bas van Dijk <bas@dfinity.org>, Eero Kelly <eero.kelly@dfinity.org>,
 Andrew Battat <andrew.battat@dfinity.org>,
 Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260228010614.2536430-1-ziy@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260228010614.2536430-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220037-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: A4D591C016A
X-Rspamd-Action: no action



On 2026/2/28 09:06, Zi Yan wrote:
> During a pagecache folio split, the values in the related xarray should not
> be changed from the original folio at xarray split time until all
> after-split folios are well formed and stored in the xarray. Current use
> of xas_try_split() in __split_unmapped_folio() lets some after-split folios
> show up at wrong indices in the xarray. When these misplaced after-split
> folios are unfrozen, before correct folios are stored via __xa_store(), and
> grabbed by folio_try_get(), they are returned to userspace at wrong file
> indices, causing data corruption.
> 
> Fix it by using the original folio in xas_try_split() calls, so that
> folio_try_get() can get the right after-split folios after the original
> folio is unfrozen.
> 
> Uniform split, split_huge_page*(), is not affected, since it uses
> xas_split_alloc() and xas_split() only once and stores the original folio
> in the xarray.
> 
> Fixes below points to the commit introduces the code, but folio_split() is
> used in a later commit 7460b470a131f ("mm/truncate: use folio_split() in
> truncate operation").
> 
> Fixes: 00527733d0dc8 ("mm/huge_memory: add two new (not yet used) functions for folio_split()")
> Reported-by: Bas van Dijk <bas@dfinity.org>
> Closes: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com/
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: <stable@vger.kernel.org>
> ---

Thanks for the fix!

I also made a C reproducer and tested this patch - the corruption
disappeared.

Without patch: corruption in < 10 iterations
With patch: 1000 iterations, all clean

Tested-by: Lance Yang <lance.yang@linux.dev>

