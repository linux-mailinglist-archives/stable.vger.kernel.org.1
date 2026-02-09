Return-Path: <stable+bounces-215123-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OUUAhfxiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215123-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:37:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B936110881
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C65463030742
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949E537996F;
	Mon,  9 Feb 2026 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C6hNvEpX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565A9125B2;
	Mon,  9 Feb 2026 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647750; cv=none; b=fUgQSxWNVzL2GJsxq1CNYGTOzaHXZbZIHuRiAUUYDPgq8tLbmFKT+k+XCRjAKOU2zbb2/Hn9Br5JrY303XkCUHZ/tg6i0lcUuGDDbysLVuHI0mgHdKr1icHmNrxBkNMorxgEuZFBYiHM6X6QGQp9SP3QRSlTHf194Uijw2Q1jsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647750; c=relaxed/simple;
	bh=yULTwE7bi7PNQi7F9bNEQL1/yFi/qMJIGXVVnjpzXuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gS+/CWyHUGr3IOdBVSIJ125tX/9FrKrQQvaGOj6G35Cmi+VR+BkgZcup4LJJfKC2s54FbBrFYpO81SC9IcPLy9cHmLysK/i48EzbL9APl3waPIIl394KeRc3E9z+T8r7YZ99CxjUoiDLiakPf4ZlTONUfEa92/sfojeRsZJYglQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C6hNvEpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DD4C16AAE;
	Mon,  9 Feb 2026 14:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647750;
	bh=yULTwE7bi7PNQi7F9bNEQL1/yFi/qMJIGXVVnjpzXuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C6hNvEpXt67zM955xZj0D1/+jr8EWOPZQghQj1uVsDbcfPclXNY3FZ/Ypov1ZwLYF
	 oRj0V3WRfbUYDfuIMvUgHXyQsc74bADRXk4N7MShtu5kLCTleRLPXHYzeb+CAdBEx/
	 P7me4L8rn0UALtLbfUARYgoPROhRjmiKRV6DPd9o=
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
Subject: [PATCH 6.12 018/113] mm, shmem: prevent infinite loop on truncate race
Date: Mon,  9 Feb 2026 15:22:47 +0100
Message-ID: <20260209142310.865603787@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
References: <20260209142310.204833231@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-215123-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,tencent.com,meta.com,linux.alibaba.com,redhat.com,kernel.org,google.com,huaweicloud.com,gmail.com,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email,alibaba.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,huaweicloud.com:email,tencent.com:email]
X-Rspamd-Queue-Id: 8B936110881
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1109,17 +1109,22 @@ whole_folios:
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



