Return-Path: <stable+bounces-211669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A1tDq+qd2kZkAEAu9opvQ
	(envelope-from <stable+bounces-211669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 18:55:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEA88BD02
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 18:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34318300102A
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 17:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F0D341AD6;
	Mon, 26 Jan 2026 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2nC4n7U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEB6233149
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769450155; cv=none; b=Q2qsH06yXWWuZdPfw1axGT/CGXkjps85O7mbExwHIkivCC6g6adXgr5BWu2/2OfVaVnrHlRaNAGx9bPR3/IzTNt4w5IVjAp4XuUFpgfrLoyaneX9u+q9mMOPRFHPpY4Avx1kpxfzQE/F2lEws5rFLsiLzJdsydDXmLtY2G+p+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769450155; c=relaxed/simple;
	bh=NNK6LcNOKWJNboay3ctTHuitTF3qpeUJ3zeE5ODtjkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+O0Xy3dbTIRI20eUo9w+ga/XvaEHKYg7aWm9OutjNE//47WAMnz0z6Jak/6uZMz8Raa8iu1Qr3fNUB3n3S1sO2nIKZjNftpfQpywzWQX2FKXpazcN7rCkzv00QB4pIY5xLQq5JF81y27xXquA6g1oS9jMIchIHymPtg9JoRp8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2nC4n7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D1AC116C6;
	Mon, 26 Jan 2026 17:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769450154;
	bh=NNK6LcNOKWJNboay3ctTHuitTF3qpeUJ3zeE5ODtjkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2nC4n7UAfI/cbiQn+k6Scx2geyUFYSHbaau8wzgAE6mN7zsf7KaPxEF0lqr3NWyv
	 JEgaBr4lZNJwc+IcpxNONGjHhaKx6hzRvhc4v72fGu7hYVm/E9etz3m0cRCQcvzmX8
	 dB2oB7EZRxn4OcXiSSx3g7/FPOFoCey3+yjinOupEsgExahNHTGqs01BxP9HOqvZGV
	 d66db/eR/gAA5qH10A7pF8/kCphrmoQzovuyaWVfVJrSfwZDfWxWq0pFNAWfvczYHG
	 +XrkP8dEYMtUo70g5IkGLlb8wVOgAFbbh8UCF3LFhNGRUxqJ8HLCxNxT4ydkFsv4Pl
	 dEmSDav7RLCPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Laurence Oberman <loberman@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Oscar Salvador <osalvador@suse.de>,
	Liu Shixin <liushixin2@huawei.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Lance Yang <lance.yang@linux.dev>,
	"Uschakow, Stanislav" <suschako@amazon.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/rmap: fix two comments related to huge_pmd_unshare()
Date: Mon, 26 Jan 2026 12:55:51 -0500
Message-ID: <20260126175552.3481327-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012636-hankie-scribing-0c00@gregkh>
References: <2026012636-hankie-scribing-0c00@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211669-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email,linux.dev:email,surriel.com:email,suse.de:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: CCEA88BD02
X-Rspamd-Action: no action

From: "David Hildenbrand (Red Hat)" <david@kernel.org>

[ Upstream commit a8682d500f691b6dfaa16ae1502d990aeb86e8be ]

PMD page table unsharing no longer touches the refcount of a PMD page
table.  Also, it is not about dropping the refcount of a "PMD page" but
the "PMD page table".

Let's just simplify by saying that the PMD page table was unmapped,
consequently also unmapping the folio that was mapped into this page.

This code should be deduplicated in the future.

Link: https://lkml.kernel.org/r/20251223214037.580860-4-david@kernel.org
Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Cc: Liu Shixin <liushixin2@huawei.com>
Cc: Harry Yoo <harry.yoo@oracle.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: "Uschakow, Stanislav" <suschako@amazon.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/rmap.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 968b85a67b1a1..b511dd811c30c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1579,14 +1579,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 					flush_tlb_range(vma,
 						range.start, range.end);
 					/*
-					 * The ref count of the PMD page was
-					 * dropped which is part of the way map
-					 * counting is done for shared PMDs.
-					 * Return 'true' here.  When there is
-					 * no other sharing, huge_pmd_unshare
-					 * returns false and we will unmap the
-					 * actual page and drop map count
-					 * to zero.
+					 * The PMD table was unmapped,
+					 * consequently unmapping the folio.
 					 */
 					page_vma_mapped_walk_done(&pvmw);
 					break;
@@ -1945,14 +1939,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 						range.start, range.end);
 
 					/*
-					 * The ref count of the PMD page was
-					 * dropped which is part of the way map
-					 * counting is done for shared PMDs.
-					 * Return 'true' here.  When there is
-					 * no other sharing, huge_pmd_unshare
-					 * returns false and we will unmap the
-					 * actual page and drop map count
-					 * to zero.
+					 * The PMD table was unmapped,
+					 * consequently unmapping the folio.
 					 */
 					page_vma_mapped_walk_done(&pvmw);
 					break;
-- 
2.51.0


