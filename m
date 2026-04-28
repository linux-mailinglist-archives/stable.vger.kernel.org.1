Return-Path: <stable+bounces-241668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHoRGkO98Gl0YAEAu9opvQ
	(envelope-from <stable+bounces-241668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:59:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2B748672C
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B29D312D607
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 13:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BAF47A0C0;
	Tue, 28 Apr 2026 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SuCOgAS4"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9A444BC91
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382450; cv=none; b=aP1TjTW0HygM95Ajk0X+NIQi9ozyd8uamyN5yO3Xv1zRag3jKGqA0kyW3AGrz8iPlYiaHnVginhnDUeCkt4FwSBSu4P9NdhZapOpazP+O35y3ju+tOW8EVe1U/fQgIfG0AG9Jpw2g38hjiwtuN1siT8pTvl5QOnJPI/pwbxqawE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382450; c=relaxed/simple;
	bh=cjinaMZvasHvUbUuPqZKOoDMWlhhsn0nuiixHAz9ST8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFOmGZ30VdqkLk5Q6BRs++zqDQNFxKZBssmYBWlqQzDotd/7oZwXv5gBX10C/JJ/QqEB4PRpc6mSGLRFgfyv1ceYlRV9cqJo/7aOPQ+6YZMTUadshcC/aGX/K9FH0dWhzmOfSiIrJi1bTtobD6mqtIFfjj7F1AxbfFeffcj6Spo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SuCOgAS4; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777382445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQK83wzMxgtDx5zJs+rX80tqrYmQXtE7Gqa/54foH+M=;
	b=SuCOgAS4NzrmxBcKqLQ638tD3V02Ag8mN8/0M7capcdVTyJsCDDgenQZtxQTB4AUTX4YIF
	Zks1Lkqhz4DcxlukdWzarX/zlV6DV5yKyhodqiUSxXCOc2Noc/Xq71hZLkhOWE/kdIFcj4
	vmBJt3djqbaM9XoBwIeaPLeZ8lXKk/w=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	rppt@kernel.org,
	jgg@ziepe.ca,
	baolu.lu@linux.intel.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH] x86/mm: fix freeing of PMD-sized vmemmap pages
Date: Tue, 28 Apr 2026 21:20:25 +0800
Message-Id: <20260428132025.86657-1-lance.yang@linux.dev>
In-Reply-To: <20260428-vmemmap-v1-1-b2aa1e6db2c0@kernel.org>
References: <20260428-vmemmap-v1-1-b2aa1e6db2c0@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: BC2B748672C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241668-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


On Tue, Apr 28, 2026 at 12:29:36PM +0200, David Hildenbrand (Arm) wrote:
>In commit bf9e4e30f353 ("x86/mm: use pagetable_free()"), we switched
>from freeing non-boot page tables through __free_pages() to
>pagetable_free().
>
>However, the function is also called to free vmemmap pages.
>
>Given that vmemmap pages are not page tables, already the page_ptdesc(page)
>is wrong. But worse, pagetable_free() calls
>
>	__free_pages(page, compound_order(page));
>
>As vmemmap pages are not compound pages (see vmemmap_alloc_block()) --
>except for HVO, which doesn't apply here -- we will only free the first
>page when freeing a PMD-sized vmemmap page, leaking the other ones.
>
>Fix it by properly decoupling pagetable and vmemmap freeing.
>free_pagetable() no longer has to mess with SECTION_INFO, as only the
>vmemmap is marked like that in register_page_bootmem_memmap().
>
>While at it, just wire up the altmap parameter for remove_pte_table().
>Also, the indentation in remove_pmd_table() is messed up, let's fix that
>while touching it.
>
>Note that we'll try to get rid of that bootmem info handling soon. For
>now, we'll handle it similar to free_pagetable(), just avoiding the
>ifdef.
>
>Fixes: bf9e4e30f353 ("x86/mm: use pagetable_free()")
>Cc: stable@vger.kernel.org
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
>Reproduced and tested with a simple VM with a virtio-mem device,
>repeatedly adding and removing memory.
>
>Found by code inspection while working on bootmem_info removal.
>---

Cool! I just reproduced the leak with QEMU pc-dimm memory hotplug as
well.

Without the fix, nr_free_pages kept dropping after the hotplugged memory
was removed again. With the fix applied, it stays stable over repeated
add/remove cycles :)

Tested-by: Lance Yang <lance.yang@linux.dev>

