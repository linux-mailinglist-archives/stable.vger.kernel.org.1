Return-Path: <stable+bounces-227930-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLD8FiQJwWmtPwQAu9opvQ
	(envelope-from <stable+bounces-227930-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:34:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B172EF248
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2712030074A6
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDF9386C37;
	Mon, 23 Mar 2026 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cxiue9GX"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ACF37BE66
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258465; cv=none; b=GXH0dXHA0yTqD5t4npmiC7Xdm6txMWWKhZygYl33xvjbEPtukNLk94ps7a6Huv+FxIavD1XNtudtKBDzZU4gL9jJHgZ8aXOGqmel+iCI5EN9e4nQe/TQX4QEU80rHnDhfUya+0ljN+4jSd+f0yJ2kYzpaRh523O4Yngxqdv5870=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258465; c=relaxed/simple;
	bh=mNk/nvM66J5qV88Dr8fMZvTO481kqDQPMWbiXqKdAYA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hKmFdvoL5NAs3pfy+j0XEOosejVISlMWxzR+f9sd4iXIU/z+mJ+MTS3rnxCUeIjNkZM5vFftbUNna+c8/DxgmwIgQYPmUDaodXKyqyVrkMijwJ0E+QEZEJoUg3wp2Ifc4N/PNrjPGb9hATtaiu4GKZLCW0jVFe9C53w99el3bik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cxiue9GX; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79a60975dc5so38459717b3.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 02:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774258463; x=1774863263; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0xrbBa9k+6NQgbzxqVXDiC8SMy7s/AaHJ4RIJGGI5is=;
        b=cxiue9GX6ZJiB2LcIho0VqtSQLL4qIutlND36fvE6GgAHhikJ2M+Uj6ecinLF9ULTk
         cwdJzoskHVFLE9h5mlxC5ZMJ/STiQM88N/RE/1SVj6ig29wkZLssP3m3uCcvQUdSDpMk
         nAYUPAqw6g8AZRzgoHD2qMWzDFQBugM0o35MpGqkkcYkTBa4bn4ZcxeMiuekEUYOx7ZJ
         N7mpdyomHxmiTxlo8f+XXN31vRv2JlejhxKZiixhzORYQaUuemIHSRR2TI7BwGON7IXz
         MPZYFYUyTwC0x+i4Rqo101WWyi73L7l5tWBtpH4hIfNtX4JU9dEuabYpKljSd3gHsuOi
         TlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774258463; x=1774863263;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xrbBa9k+6NQgbzxqVXDiC8SMy7s/AaHJ4RIJGGI5is=;
        b=T7Vnwh9I1Fm787q66chzzObcoOdA8SKGQ/3Itbn1DY0qEReUSC77iBBNT/1lsvIwLz
         lvSWNtAjpaTE5C++XkDrag+k3XJWEuNGzUWzB8ByDHe7H5i0nGcgR86IWiwOXnjLPVvU
         6LjsNoiT07IqvYicb/Koc2fsyNScnRkAuaFYYP4bysfz+DpZ0Ar701Sxr6ySAPNjintT
         1VVL0JGn1Mn6/vDVYGy0fw1npj/jVncs3yEWakBKIUULXuRLU7gO/+Dc8+V9ZWwQijRX
         llXIvGzFo5Qb2Ws9drBk4hodb6ODmUWWzL7nn+Sm3AYCFU9Hie8ecAzbuSdJl1X5Ca5T
         9TeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVzp7BCeUpGKp9esE95PCU3XQnhsmwfb9h6bVrgOOXTSxrx00uDxXNoHiIHOh971Vw4IDleSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0N9Mh+VX3bpTFYqhxbEUltzPe3tFZshcroP1BX39F89j+jXtM
	igL8JqnM2BULCjP6l8hLpBYw8Pb4Tu9D+/Zp2DNJ6M4teb1fhVkKh1BjZGxCOsugCQ==
X-Gm-Gg: ATEYQzyEqZ1RcGrM4gvBA8Y1XtePMAZJTV96obj2duP879gbB9zM+G6G2lunBSfT2bf
	OQU2RrCxibs+vxowa3q57BDtzHgpsFWS18EvJcP6+V/r1C3BaNawGW+WJld+twHmZIAdYNAhg/4
	P4Wfh+xG/3sfnH/TGHmneFNvmpLWVqVLR4+r92InSS3lkes+Z6Kg5xX8xLVby4t6d+vRyUFkc9o
	jYunnW5FSeDpRrwgNwk/03e0cRl4Xu46NurJ7YJLaKHIpg2CBcz04fkU9RmjxFn5K/b1ElG0WH+
	dJCtq+H3BLl55ROUg2PdcNSUEjEjujgrDCaH0p405V3O+KJq/xyF2iRVvXA2wraCshGj6cJsyTr
	wtMCqN95BR407/vT/i0TPwG81beu1nJuwceerYoQATVVV5/yaIJhhYkL3MICPdpijNrdPX1q7+v
	ed9I7TbJos/Yy5iVY+Xt7fUF0Uv7ELA91Eo36LBEzZRF9KR20asUaBHPTTgJTWDOut0U9hW8HWj
	4zcsGxdASc=
X-Received: by 2002:a05:690c:1e:b0:79a:b5fd:793f with SMTP id 00721157ae682-79ab5fd9654mr27807827b3.3.1774258462367;
        Mon, 23 Mar 2026 02:34:22 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a903e0b8csm54549467b3.12.2026.03.23.02.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 02:34:21 -0700 (PDT)
Date: Mon, 23 Mar 2026 02:34:19 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, Baoquan He <bhe@redhat.com>, 
    Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
    David Hildenbrand <david@kernel.org>, Dev Jain <dev.jain@arm.com>, 
    Greg Thelen <gthelen@google.com>, Guenter Roeck <groeck@google.com>, 
    Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
    Lance Yang <lance.yang@linux.dev>, Matthew Wilcox <willy@infradead.org>, 
    Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, stable@vger.kernel.org
Subject: [PATCH 6.12.y 1/4] mm: shmem: fix potential data corruption during
 shmem swapin
In-Reply-To: <a07eace6-82f2-32a8-0cbc-85972d4b1eee@google.com>
Message-ID: <0e918493-29b1-de47-9fca-b1fa93156d63@google.com>
References: <a07eace6-82f2-32a8-0cbc-85972d4b1eee@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,linux-foundation.org,linux.alibaba.com,redhat.com,kernel.org,arm.com,tencent.com,huaweicloud.com,linux.dev,infradead.org,gmail.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-227930-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hughd@google.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux-foundation.org:email,alibaba.com:email,infradead.org:email,tencent.com:email]
X-Rspamd-Queue-Id: D7B172EF248
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Baolin Wang <baolin.wang@linux.alibaba.com>

commit 058313515d5aab10d0a01dd634f92ed4a4e71d4c upstream.

Alex and Kairui reported some issues (system hang or data corruption) when
swapping out or swapping in large shmem folios.  This is especially easy
to reproduce when the tmpfs is mount with the 'huge=within_size'
parameter.  Thanks to Kairui's reproducer, the issue can be easily
replicated.

The root cause of the problem is that swap readahead may asynchronously
swap in order 0 folios into the swap cache, while the shmem mapping can
still store large swap entries.  Then an order 0 folio is inserted into
the shmem mapping without splitting the large swap entry, which overwrites
the original large swap entry, leading to data corruption.

When getting a folio from the swap cache, we should split the large swap
entry stored in the shmem mapping if the orders do not match, to fix this
issue.

Link: https://lkml.kernel.org/r/2fe47c557e74e9df5fe2437ccdc6c9115fa1bf70.1740476943.git.baolin.wang@linux.alibaba.com
Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reported-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
Reported-by: Kairui Song <ryncsn@gmail.com>
Closes: https://lore.kernel.org/all/1738717785.im3r5g2vxc.none@localhost/
Tested-by: Kairui Song <kasong@tencent.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Lance Yang <ioworker0@gmail.com>
Cc: Matthew Wilcow <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

[ hughd: removed skip_swapcache dependencies ]
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5e8184821fac..9105c732f341 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2132,7 +2132,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	struct swap_info_struct *si;
 	struct folio *folio = NULL;
 	swp_entry_t swap;
-	int error, nr_pages;
+	int error, nr_pages, order, split_order;
 
 	VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
 	swap = radix_to_swp_entry(*foliop);
@@ -2151,8 +2151,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 
 	/* Look it up and read it in.. */
 	folio = swap_cache_get_folio(swap, NULL, 0);
+	order = xa_get_order(&mapping->i_pages, index);
 	if (!folio) {
-		int split_order;
 
 		/* Or update major stats only when swapin succeeds?? */
 		if (fault_type) {
@@ -2189,13 +2189,37 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			error = -ENOMEM;
 			goto failed;
 		}
+	} else if (order != folio_order(folio)) {
+		/*
+		 * Swap readahead may swap in order 0 folios into swapcache
+		 * asynchronously, while the shmem mapping can still stores
+		 * large swap entries. In such cases, we should split the
+		 * large swap entry to prevent possible data corruption.
+		 */
+		split_order = shmem_split_large_entry(inode, index, swap, gfp);
+		if (split_order < 0) {
+			error = split_order;
+			goto failed;
+		}
+
+		/*
+		 * If the large swap entry has already been split, it is
+		 * necessary to recalculate the new swap entry based on
+		 * the old order alignment.
+		 */
+		if (split_order > 0) {
+			pgoff_t offset = index - round_down(index, 1 << split_order);
+
+			swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
+		}
 	}
 
 	/* We have to do this with folio locked to prevent races */
 	folio_lock(folio);
 	if (!folio_test_swapcache(folio) ||
 	    folio->swap.val != swap.val ||
-	    !shmem_confirm_swap(mapping, index, swap)) {
+	    !shmem_confirm_swap(mapping, index, swap) ||
+	    xa_get_order(&mapping->i_pages, index) != folio_order(folio)) {
 		error = -EEXIST;
 		goto unlock;
 	}

