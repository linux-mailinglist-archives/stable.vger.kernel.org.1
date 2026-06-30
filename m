Return-Path: <stable+bounces-269864-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pWm+BYItQ2owTgoAu9opvQ
	(envelope-from <stable+bounces-269864-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 04:44:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EF86DFD74
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 04:44:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=bHTv8m80;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269864-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269864-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37A05300916C
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 02:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DF336F419;
	Tue, 30 Jun 2026 02:44:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B136C5AC
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 02:44:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782787450; cv=none; b=G7Z7C78i6xbsJEAuo+Poru/N/oPzOhtMJ0pwMN09Pml57oC+HDpyVrc4s1iPBITD9hwDAy3EM1BH9MICXjeZG9rI22pJV/25nUv50w4fKhDRU3Hg6J4b+WFdBSot0d1X8tky8ueWcBZEULobnYuixZtiDBMXtEN0CV+fvk3FXXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782787450; c=relaxed/simple;
	bh=c99kRCJCWQwJR86icw09W9+ztSOgXeq805r87yWqcUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1PB5PLvqkgyaKkdviQNmVkKn7Ys3LD1SmUNhfWFQlQQ1uef6Hf8ozKao+VXvq8g6cTgo/flNhe/33BFQcUY4fPRL8z2YDMRzh3VTxyApG8ASlhxJNsYRkzwIf39AGiehaAwTO7frKJqUNWplJq3RsYusSWsDSVO0kbfUNbZcJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bHTv8m80; arc=none smtp.client-ip=91.218.175.182
Message-ID: <57a65820-d0b6-48f5-8de6-5d362d0e4ca3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782787446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OisJI56156U7nSgtBYB0oE48vrZLbekiX9UlbgQeffk=;
	b=bHTv8m80NqwdlrtRO9yUqtJ+KyEoRzt1XgxKw5T+gWwbI6l5s4dSAAlhq5sTu1aN0CWEB6
	Slnd8GFyn1MY5MgL/PIG0AtF5+LzPVNuq5sS4D5jFsaWka8szV7X9ZY/x7xjAWmtr6Z8JX
	IucB/ZEdEHbdXLy+CuIYEGYP+QwpaBk=
Date: Tue, 30 Jun 2026 10:43:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Patch mm-hotfixes v5] mm/page_vma_mapped: fix device-private PMD
 handling
To: Wei Yang <richard.weiyang@gmail.com>
Cc: liam@infradead.org, linux-mm@kvack.org, ljs@kernel.org, david@kernel.org,
 akpm@linux-foundation.org, sj@kernel.org, balbirs@nvidia.com,
 harry@kernel.org, jannh@google.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, vbabka@kernel.org, ziy@nvidia.com, riel@surriel.com
References: <20260630021540.17297-1-richard.weiyang@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260630021540.17297-1-richard.weiyang@gmail.com>
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
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-269864-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:richard.weiyang@gmail.com,m:liam@infradead.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:david@kernel.org,m:akpm@linux-foundation.org,m:sj@kernel.org,m:balbirs@nvidia.com,m:harry@kernel.org,m:jannh@google.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:vbabka@kernel.org,m:ziy@nvidia.com,m:riel@surriel.com,m:richardweiyang@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61EF86DFD74



On 2026/6/30 10:15, Wei Yang wrote:
> Commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration support
> device-private entries") introduced the concept of device-private
> PMD entries, but did not correctly update the rmap walk code to
> account for them.
> 
> As a result, when page_vma_mapped_walk() encounters device-private
> PMD entries, it takes no action other than to acquire the PMD lock
> and exit.
> 
> However this is highly problematic for two reasons - firstly,
> device private entries possess a PFN so check_pmd() needs to be
> called to ensure an overlapping PFN range.
> 
> Secondly, and more importantly, if PVMW_MIGRATION is set the
> caller assumes the returned entry is a migration entry, resulting
> in memory corruption when the caller tries to interpret the device
> private entry as such.
> 
> In addition, commit 146287290023 ("mm/huge_memory: implement
> device-private THP splitting") allowed device private PMDs to be
> split like THP mappings, but again did not update this code path.
> 
> As a result, we might race a PMD split prior to acquiring the PMD
> lock.
> 
> This patch addresses all of these issues by invoking check_pmd(),
> ensuring PMVW_MIGRATION is not set and checks whether a split raced
> us we do for PMD THP and migration entries.
> 
> Instead of checking for a subset of the cases after taking the
> pmd_lock(), put device-private along with pmd_trans_huge() and
> pmd_is_migration_entry(). Also remove thp_migration_supported() as
> it is already guarded by pmd_is_migration_entry().
> 
> Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Suggested-by: David Hildenbrand <david@kernel.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Balbir Singh <balbirs@nvidia.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Lance Yang <lance.yang@linux.dev>
> 
> ---

LGTM, thanks!

Reviewed-by: Lance Yang <lance.yang@linux.dev>

