Return-Path: <stable+bounces-217249-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LgVGb6DlWlrSAIAu9opvQ
	(envelope-from <stable+bounces-217249-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 10:17:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB96F154A83
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 10:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 695EF3005792
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 09:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0AB33B6C7;
	Wed, 18 Feb 2026 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnD4a6jJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37B133B6DC
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771406188; cv=none; b=dwLTECgWASSXsiKsFQaI/Kwvf0VtmpX/5uAw7uLKfFA8eXtIdvUxWW5BAkv6z52fFJjrhtR2ay589BkjmB51/H8jHSSvBYH5viV6CfFZ1/azYwZkp6hYG7fYgvQRlxH2gu3NGxsBoFDcbrsdkkZYCz6exoPNwbjIzqA0HjgfIWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771406188; c=relaxed/simple;
	bh=39DroJTogKBY87voxk5lhToETPVp1UL6sXM7Ll8wgOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7S+AVmJn1C2Z4K6yfhB6VWrPd9jF1cbpGYRt3y+uLZe1oIN0+Jj1fVWLY8CaeGnJxnLbKXEraenr8o9xKffRNomsEaa7D3uomD2bXUANCjqk/xUVtEtftAZe9mReV+9HEHUrVkQm1sEw6Cdtcd+Tuj904skIK3PEvz5xOdd1p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnD4a6jJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C929C19421;
	Wed, 18 Feb 2026 09:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771406188;
	bh=39DroJTogKBY87voxk5lhToETPVp1UL6sXM7Ll8wgOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FnD4a6jJiHJ/GFgP+OakmEhSUPXYwdRgVi0fVi/819FwyCRH5zTgohtIrEzhDDWPf
	 TrDFMaDtvgCCalnTjml4kJuLPxLer/bn9RCgReeHe3PgaqFGXIoZoweut9EjOEsnsu
	 l+7jgwuA+BffW235pm1t1pinms6MNJoP3dZbjVIcyh0oCEhqIPyst7LlDeuMTYxk5X
	 AAHeN9VzjGtgorWIN2zqwTleuaL0oCOsam0tta/lDjsKEoBLb9Crsz2ta+yri+X3Mt
	 zB8rk7/pqSZTBq1uYIoe5FwjW5AhOYCCHwjCGh/Vhmweb5q55jBbKIkU14yLGuqgjV
	 onn2H/qNuq/1w==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jane Chu <jane.chu@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Jann Horn <jannh@google.com>,
	Liu Shixin <liushixin2@huawei.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rik van Riel <riel@surriel.com>,
	Laurence Oberman <loberman@redhat.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH 6.1.y 0/4] mm/hugetlb: fixes for PMD table sharing (incl. using mmu_gather)
Date: Wed, 18 Feb 2026 10:16:03 +0100
Message-ID: <20260218091608.25726-1-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026012605-uncorrupt-yanking-4155@gregkh>
References: <2026012605-uncorrupt-yanking-4155@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217249-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,oracle.com:email,linux.dev:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: AB96F154A83
X-Rspamd-Action: no action

Backport of [1] for 6.1. Backport notes are in the individual patches.

The patch "mm/rmap: fix two comments related to huge_pmd_unshare()"
was already backported.

While backporting I realized that Jane's fix was not backported yet.

Tested on x86-64 with the original reproducer.

[1] https://lore.kernel.org/linux-mm/20251223214037.580860-1-david@kernel.org/

Cc: Jane Chu <jane.chu@oracle.com>,
Cc: Harry Yoo <harry.yoo@oracle.com>,
Cc: Oscar Salvador <osalvador@suse.de>,
Cc: David Hildenbrand <david@redhat.com>,
Cc: Jann Horn <jannh@google.com>,
Cc: Liu Shixin <liushixin2@huawei.com>,
Cc: Muchun Song <muchun.song@linux.dev>,
Cc: Andrew Morton <akpm@linux-foundation.org>,
Cc: Rik van Riel <riel@surriel.com>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liu Shixin <liushixin2@huawei.com>

David Hildenbrand (Red Hat) (3):
  mm/hugetlb: fix hugetlb_pmd_shared()
  mm/hugetlb: fix two comments related to huge_pmd_unshare()
  mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables
    using mmu_gather

Jane Chu (1):
  mm/hugetlb: fix copy_hugetlb_page_range() to use ->pt_share_count

 include/asm-generic/tlb.h |  77 +++++++++++++++++++-
 include/linux/hugetlb.h   |  17 +++--
 include/linux/mm_types.h  |   1 +
 mm/hugetlb.c              | 143 ++++++++++++++++++++------------------
 mm/mmu_gather.c           |  33 +++++++++
 mm/rmap.c                 |  25 ++++---
 6 files changed, 212 insertions(+), 84 deletions(-)

-- 
2.43.0


