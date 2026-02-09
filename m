Return-Path: <stable+bounces-214952-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKx5BUfviWn4EQAAu9opvQ
	(envelope-from <stable+bounces-214952-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:29:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 545D7110545
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D576303A930
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7888E37A4AE;
	Mon,  9 Feb 2026 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WHZ43Kcd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C99A37997D;
	Mon,  9 Feb 2026 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647182; cv=none; b=ZG3uIdSjShunkbBrELEYzSpwhDZ2sQl8KRxEMHcahX3obEPDYj/j1h32wTgwRpdDapIdM8nkc9GGPwgUn4Vo9T0XTewdeemFbkq1lx0DALRzFkmn+eOPQ5OmymWF3JbGJUzqFeNfg07JuSR+fMC6U/Te6wEGa8w9wJIuD1jKy9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647182; c=relaxed/simple;
	bh=L1ajPb3YaHTnOZtHHGum1ITzDaetJVTK1un6QqNFiVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+AGu40O12bg/RsakQxV1LBfZ9FsL0g+AhM7GBn9ee9DAZwn/7fRH9Jppv43nY3pTbuf1aLCVEcU13mrBcDr5LLPhcL0fLHyR5VcT16LUm/bUrQSOvOlYTcT7aMpcWLX8YFTh/g5zpJt2bAUNRtW7oiiMHjHTMPLlOyDgKhaWY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WHZ43Kcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B8CC116C6;
	Mon,  9 Feb 2026 14:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647182;
	bh=L1ajPb3YaHTnOZtHHGum1ITzDaetJVTK1un6QqNFiVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WHZ43KcdCDA8rODwz2QF/zlgQiAaZ0QSkN0fWkHo4u3RPa1mrnPwyVij9oZYLmOrN
	 jkDjARAZ6dQcXrkgyGEGT6p8wWje0X9lcjHl1O9InUBhVX3WdP4VdFY8avwXds+cWe
	 J273cEoSgdnwaMORWW++Ug7La5RWmaekAS3Tv7L4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kairui Song <kasong@tencent.com>,
	Chris Mason <clm@meta.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18 024/175] mm, shmem: prevent infinite loop on truncate race
Date: Mon,  9 Feb 2026 15:21:37 +0100
Message-ID: <20260209142321.349534204@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-214952-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,tencent.com,meta.com,linux.alibaba.com,redhat.com,kernel.org,google.com,huaweicloud.com,gmail.com,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email,meta.com:email]
X-Rspamd-Queue-Id: 545D7110545
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kairui Song <kasong@tencent.com>

commit 2030dddf95451b4e7a389f052091e7c4b7b274c6 upstream.

When truncating a large swap entry, shmem_free_swap() returns 0 when the
entry's index doesn't match the given index due to lookup alignment.  The
failure fallback path checks if the entry crosses the end border and
aborts when it happens, so truncate won't erase an unexpected entry or
range.  But one scenario was ignored.

When `index` points to the middle of a large swap entry, and the large
swap entry doesn't go across the end border, find_get_entries() will
return that large swap entry as the first item in the batch with
`indices[0]` equal to `index`.  The entry's base index will be smaller
than `indices[0]`, so shmem_free_swap() will fail and return 0 due to the
"base < index" check.  The code will then call shmem_confirm_swap(), get
the order, check if it crosses the END boundary (which it doesn't), and
retry with the same index.

The next iteration will find the same entry again at the same index with
same indices, leading to an infinite loop.

Fix this by retrying with a round-down index, and abort if the index is
smaller than the truncate range.

Link: https://lkml.kernel.org/r/aXo6ltB5iqAKJzY8@KASONG-MC4
Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
Fixes: 8a1968bd997f ("mm/shmem, swap: fix race of truncate and swap entry split")
Signed-off-by: Kairui Song <kasong@tencent.com>
Reported-by: Chris Mason <clm@meta.com>
Closes: https://lore.kernel.org/linux-mm/20260128130336.727049-1-clm@meta.com/
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Chris Li <chrisl@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/shmem.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1193,17 +1193,22 @@ whole_folios:
 				swaps_freed = shmem_free_swap(mapping, indices[i],
 							      end - 1, folio);
 				if (!swaps_freed) {
-					/*
-					 * If found a large swap entry cross the end border,
-					 * skip it as the truncate_inode_partial_folio above
-					 * should have at least zerod its content once.
-					 */
+					pgoff_t base = indices[i];
+
 					order = shmem_confirm_swap(mapping, indices[i],
 								   radix_to_swp_entry(folio));
-					if (order > 0 && indices[i] + (1 << order) > end)
-						continue;
-					/* Swap was replaced by page: retry */
-					index = indices[i];
+					/*
+					 * If found a large swap entry cross the end or start
+					 * border, skip it as the truncate_inode_partial_folio
+					 * above should have at least zerod its content once.
+					 */
+					if (order > 0) {
+						base = round_down(base, 1 << order);
+						if (base < start || base + (1 << order) > end)
+							continue;
+					}
+					/* Swap was replaced by page or extended, retry */
+					index = base;
 					break;
 				}
 				nr_swaps_freed += swaps_freed;



