Return-Path: <stable+bounces-254096-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OmDIKvxE2puHwcAu9opvQ
	(envelope-from <stable+bounces-254096-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:52:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC1A5C6C49
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78F3C302AE39
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 06:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9895E3AA1B0;
	Mon, 25 May 2026 06:50:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1C63A963E;
	Mon, 25 May 2026 06:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691812; cv=none; b=MAS5O63JUpX9Aud/VgO+50/hQTRRURrZoYc2WM6SRMiL1DgMM1L6RcYhdj5lr77yTKDfdmcE9p05C+OTSIpxkE0YXIVIB2f8vdQHqCehtBWT0fe/WlzKL9mUlf1kvOlS9viSrm3CKkop88gSlRmE3dgKR/M8M/R0Yc7j8CF/fLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691812; c=relaxed/simple;
	bh=kD7LROtPXSQbpkVcfV9AN+LefkDHW+gCj1nO99huRr0=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=TH3rmodOLf1E9kibHOrzf5QXZ6Js76s+UjERvRWonJniPMo1EvNZm5wpElABavOkqf2Aey+27zJY2m2tM75hY7ceh3O1kTHyLyRPBHd9B8e8yGc1vF9LVqs9Z5g5jroAvD+e6qeyiry9lp1Y9TU80DjxFHPvHQ11LJ177aK4bHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gP62P4qT6z8Xrr9;
	Mon, 25 May 2026 14:50:05 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 64P6nws0036196;
	Mon, 25 May 2026 14:49:58 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 25 May 2026 14:50:00 +0800 (CST)
X-Zmail-TransId: 2af96a13f118096-76827
X-Mailer: Zmail v1.0
Message-ID: <20260525145000501-t0VQTKCI5BtrK9-y4tAI@zte.com.cn>
In-Reply-To: <20260525123938427-2LRlh6S2Ew79m61xNh6S@zte.com.cn>
References: 20260525123938427-2LRlh6S2Ew79m61xNh6S@zte.com.cn
Date: Mon, 25 May 2026 14:50:00 +0800 (CST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <wang.yaxin@zte.com.cn>, <chen.junlin@zte.com.cn>, <david@kernel.org>,
        <stable@vger.kernel.org>, <akpm@linux-foundation.org>
Cc: <akpm@linux-foundation.org>, <david@kernel.org>, <ziy@nvidia.com>,
        <matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>,
        <rakie.kim@sk.com>, <byungchul@sk.com>, <gourry@gourry.net>,
        <ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <wang.yaxin@zte.com.cn>, <jiang.kun2@zte.com.cn>,
        <tu.qiang35@zte.com.cn>, <ran.xiaokai@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBzdGFibGUgNS4xMF0gbW06IG51bWE6IHByZXNlcnZlIFBNRCB3cml0ZSBwZXJtaXNzaW9ucyBpbiBtaWdyYXRlX21pc3BsYWNlZF90cmFuc2h1Z2VfcGFnZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 64P6nws0036196
X-TLS: YES
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 25 May 2026 14:50:05 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A13F11D.001/4gP62P4qT6z8Xrr9
X-Spamd-Result: default: False [3.19 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_BASE64(1.50)[];
	R_BAD_CTE_7BIT(1.05)[unknown,utf8];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[zte.com.cn : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,kvack.org,vger.kernel.org,zte.com.cn];
	FROM_NEQ_ENVFROM(0.00)[xu.xin16@zte.com.cn,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254096-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.496];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zte.com.cn:mid,zte.com.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AAC1A5C6C49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> When a process allocates a transparent huge page in its address space, and
> then enters the kernel driver via an ioctl system call, a driver (eg.
> ib_uverbs) calls the pin_user_pages_fast function to pin the process’s
> virtual addresses to physical pages. Subsequently, when the process
> accesses this pinned memory across NUMA nodes, triggering the system’s
> NUMA balancing capability, a page fault occurs and the kernel enters
> do_huge_pmd_numa_page, then it calls migrate_misplaced_transhuge_page to
> migrate the transparent huge page. However, because the memory within the
> huge page has been pinned by pin_user_pages_fast, numamigrate_isolate_page
> returns 0. migrate_misplaced_transhuge_page proceeds to the out_fail path,
> where it changes the PMD page table entry to write-protected by pte_modify.
> If the process then performs a fork operation, copy_huge_pmd is invoked.
> Due to the pinned memory, __split_huge_pmd is called to split the PMD page
> table entry into PTE page table entries. These PTEs are also set to
> write-protected. Finally, when the process writes to this memory region, a
> copy-on-write (COW) operation takes place, allocating a new physical
> memory page. This breaks the binding between the process’s virtual
> address and the pinned physical memory.
> 
> commit b191f9b106ea ("mm: numa: preserve PTE write permissions across a
> NUMA hinting fault") added write permission recovery in
> do_huge_pmd_numa_page, but did not add the same recovery in
> migrate_misplaced_transhuge_page. Later, commit d042035eaf5f ("mm/thp:
> Split huge pmds/puds if they're pinned when fork()") enforced that
> transparent huge pages with pinned memory must have their PMD page
> tables split into PTE page tables in copy_huge_pmd. After that, this
> issue started to appear.
> 
> So, the simplest way to fix this issue is to also perform the
> corresponding write permission recovery in the out_fail code path of
> migrate_misplaced_transhuge_page.
> 
> Signed-off-by: Chen Junlin <chen.junlin@zte.com.cn>

It seems the latest kernel version is not affected by the issue you point out
because commit f66e2727ddfc ("mm: huge_memory: use folio_can_map_prot_numa() for pmd folio")
will make pined huge pages skip numa_balancing.

Could you please add two tags?  
1) Add a "fixes" tag (the commit that introduced this issue)
2) Cc: stable@vger.kernel.org

and Could you answer which other long-term stable branches are also affected?


The patch itself seems fine; if the above questions is resolved, feel free to add:
Reviewed-by: xu xin <xu.xin16@zte.com.cn>

