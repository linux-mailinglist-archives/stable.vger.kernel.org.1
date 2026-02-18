Return-Path: <stable+bounces-217286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COLaKzy5lWm7UQIAu9opvQ
	(envelope-from <stable+bounces-217286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 14:06:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 174C1156809
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 14:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E54E53013EFD
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96595309DB1;
	Wed, 18 Feb 2026 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRQj+0Z+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3112FDC3C
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771419961; cv=none; b=h30wbCCfu7B3JT/0Osh2uOhDc4xqC2VEUuBh574reGX53b98+ldc3Za8mV7JxBJvlsiFj05WQGOU9MsQ/uCv3NSjMIjA6jaGN71ZACDZ30qbgmqQE2BoC77umVO8ZYQZr98YGR2iPRVupz6GKA9y5Owo4Kzs+feQfLefKUWb8dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771419961; c=relaxed/simple;
	bh=wdJZZIzpHkDq9CqfLAQjA1xz1Y1X7C30wWjsc3kJBLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0pToru42N5dnnPrkLQYdtQhSi5VIZ5rgRvEq6m7+1jBoxav3kAAjSIg0SNuWWxpnV1ldNk+2RcPvT9TLvBmChou8v4s4SFq3pIWOSZG8T1wqBNZ5MIPmjFQptsQtOZaM11j3Yvlyhf2V+O5lkX7xkNWkDbs+hvbCNGbmXioU+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRQj+0Z+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F54C19421;
	Wed, 18 Feb 2026 13:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771419960;
	bh=wdJZZIzpHkDq9CqfLAQjA1xz1Y1X7C30wWjsc3kJBLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZRQj+0Z+xmjQDy7Gh1FpYKpwRI5gTMmaLTgEUNpjiE4drKJA1sUVKEgZiIheDcNfY
	 rlZ8Rjn32bl+hR2oRNX2+FdmMJKBDFVjTBBzYnX5wO91q3cHZPvWvEAweJ8SWQtJlr
	 Bs3krNJd/1KYRXoyDY5/bBCmBdOwBYLk7B310IBpcK06yAnFAHI8mTsjCYCZ3x/+eD
	 HR0JgBwOpINJkPwRHftweSKDvpiqEPntdZEyGL5cQceQMCIGs3MYbqdRBL/AbK62bM
	 s2MTUySTsZbAKNuTJh7GQ9OrtWkjaQnsEkkQH+sMO5PrKr3dWoE2HcyoE4Zv5BSlYr
	 5IORZp81aGVCA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jane Chu <jane.chu@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Oscar Salvador <osalvador@suse.de>,
	Jann Horn <jannh@google.com>,
	Liu Shixin <liushixin2@huawei.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rik van Riel <riel@surriel.com>,
	Laurence Oberman <loberman@redhat.com>,
	Lance Yang <lance.yang@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	James Houghton <jthoughton@google.com>
Subject: [PATCH 5.10.y 0/7] mm/hugetlb: fixes for PMD table sharing (incl. using mmu_gather)
Date: Wed, 18 Feb 2026 14:05:45 +0100
Message-ID: <20260218130552.55727-1-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026012610-absolve-ducktail-3c64@gregkh>
References: <2026012610-absolve-ducktail-3c64@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217286-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linux-foundation.org:email,suse.de:email]
X-Rspamd-Queue-Id: 174C1156809
X-Rspamd-Action: no action

Backport of [1] for 5.10. Backport notes are in the individual patches.

I found one bug in a previous backport, fix in patch #1.

I'm also including a cleanup/fix from Miaohe that makes backporting at
least a bit easier, followed by the fix from Jane.

Tested on x86-64 with the original reproducer.

[1] https://lore.kernel.org/linux-mm/20251223214037.580860-1-david@kernel.org/

Cc: Jane Chu <jane.chu@oracle.com>
Cc: Harry Yoo <harry.yoo@oracle.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Jann Horn <jannh@google.com>
Cc: Liu Shixin <liushixin2@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liu Shixin <liushixin2@huawei.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: James Houghton <jthoughton@google.com>

David Hildenbrand (Arm) (1):
  mm/hugetlb: fix skipping of unsharing of pmd page tables

David Hildenbrand (Red Hat) (4):
  mm/hugetlb: fix hugetlb_pmd_shared()
  mm/hugetlb: fix two comments related to huge_pmd_unshare()
  mm/rmap: fix two comments related to huge_pmd_unshare()
  mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables
    using mmu_gather

Jane Chu (1):
  mm/hugetlb: fix copy_hugetlb_page_range() to use ->pt_share_count

Miaohe Lin (1):
  mm/hugetlb: make detecting shared pte more reliable

 include/asm-generic/tlb.h |  77 +++++++++++++++++++-
 include/linux/hugetlb.h   |  17 +++--
 include/linux/mm_types.h  |   2 +
 mm/hugetlb.c              | 143 ++++++++++++++++++++------------------
 mm/mmu_gather.c           |  36 ++++++++++
 mm/rmap.c                 |  20 +++---
 6 files changed, 208 insertions(+), 87 deletions(-)

-- 
2.43.0


