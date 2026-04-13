Return-Path: <stable+bounces-236214-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDk2ItAW3WmXZwkAu9opvQ
	(envelope-from <stable+bounces-236214-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:16:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C9D3EE86C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 484A130886B9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83E32F547F;
	Mon, 13 Apr 2026 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1hdAFz60"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E42741A0;
	Mon, 13 Apr 2026 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096336; cv=none; b=Zl80gfMaNCFIfFtyGfl4JJbMvkjIe0qpIZ9OKUB4teJDqFs74Q1uef/3JwAr8rRzVRTQVQR8EPI7/ItBfrVfPJD4h8ogUsthsUe5oTMt19di+1oQQndXee7CaGEu4HPBNfS7PpmZA+HbQxT1lNLRMvXupz1WUX9Qz71ya87TwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096336; c=relaxed/simple;
	bh=pGlWZDBwxMnBKNHQBG99Y7DTMUlcdkbYLrIUyWZIqRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJrCJTyvS5bgNjdqK10wDv1u2OvUTwIJ2UMyb6c7D7Y8u2iT/Bz2MNCAmeyuy5RTFnnmmW85ZFAjL3E/vatm2aPaEvcg3FIjtVa5zQI55hE4p99u6XtfWsJbrLmNh7p7ft3KYsXppkOSOFYYREEzpahUbLvGZA6HKQOT1Ha9Gvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1hdAFz60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C911BC2BCAF;
	Mon, 13 Apr 2026 16:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096336;
	bh=pGlWZDBwxMnBKNHQBG99Y7DTMUlcdkbYLrIUyWZIqRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1hdAFz60ZYpjABwHArzUoZOb1pLoztlw7Xm+GkGuiDabJGOdw8JjmgBzXS866qtzx
	 q7H4z/S71UAEUHSw2e6wwjyLXgcVmd/pRXlieBeunLdF+q2+h4McybaGPh/M5GsJ4a
	 7VD7k7wXp2s+lAeifTISEDp9VSJzzU6oslQiTd6c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Yuanhe Shu <xiangzao@linux.alibaba.com>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Gomez <da.gomez@samsung.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Luis Chamberalin <mcgrof@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.19 58/86] mm: filemap: fix nr_pages calculation overflow in filemap_map_pages()
Date: Mon, 13 Apr 2026 18:00:05 +0200
Message-ID: <20260413155733.729172071@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.568515178@linuxfoundation.org>
References: <20260413155731.568515178@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236214-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15C9D3EE86C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baolin Wang <baolin.wang@linux.alibaba.com>

commit f58df566524ebcdfa394329c64f47e3c9257516e upstream.

When running stress-ng on my Arm64 machine with v7.0-rc3 kernel, I
encountered some very strange crash issues showing up as "Bad page state":

"
[  734.496287] BUG: Bad page state in process stress-ng-env  pfn:415735fb
[  734.496427] page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x4cf316 pfn:0x415735fb
[  734.496434] flags: 0x57fffe000000800(owner_2|node=1|zone=2|lastcpupid=0x3ffff)
[  734.496439] raw: 057fffe000000800 0000000000000000 dead000000000122 0000000000000000
[  734.496440] raw: 00000000004cf316 0000000000000000 0000000000000000 0000000000000000
[  734.496442] page dumped because: nonzero mapcount
"

After analyzing this page’s state, it is hard to understand why the
mapcount is not 0 while the refcount is 0, since this page is not where
the issue first occurred.  By enabling the CONFIG_DEBUG_VM config, I can
reproduce the crash as well and captured the first warning where the issue
appears:

"
[  734.469226] page: refcount:33 mapcount:0 mapping:00000000bef2d187 index:0x81a0 pfn:0x415735c0
[  734.469304] head: order:5 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  734.469315] memcg:ffff000807a8ec00
[  734.469320] aops:ext4_da_aops ino:100b6f dentry name(?):"stress-ng-mmaptorture-9397-0-2736200540"
[  734.469335] flags: 0x57fffe400000069(locked|uptodate|lru|head|node=1|zone=2|lastcpupid=0x3ffff)
......
[  734.469364] page dumped because: VM_WARN_ON_FOLIO((_Generic((page + nr_pages - 1),
const struct page *: (const struct folio *)_compound_head(page + nr_pages - 1), struct page *:
(struct folio *)_compound_head(page + nr_pages - 1))) != folio)
[  734.469390] ------------[ cut here ]------------
[  734.469393] WARNING: ./include/linux/rmap.h:351 at folio_add_file_rmap_ptes+0x3b8/0x468,
CPU#90: stress-ng-mlock/9430
[  734.469551]  folio_add_file_rmap_ptes+0x3b8/0x468 (P)
[  734.469555]  set_pte_range+0xd8/0x2f8
[  734.469566]  filemap_map_folio_range+0x190/0x400
[  734.469579]  filemap_map_pages+0x348/0x638
[  734.469583]  do_fault_around+0x140/0x198
......
[  734.469640]  el0t_64_sync+0x184/0x188
"

The code that triggers the warning is: "VM_WARN_ON_FOLIO(page_folio(page +
nr_pages - 1) != folio, folio)", which indicates that set_pte_range()
tried to map beyond the large folio’s size.

By adding more debug information, I found that 'nr_pages' had overflowed
in filemap_map_pages(), causing set_pte_range() to establish mappings for
a range exceeding the folio size, potentially corrupting fields of pages
that do not belong to this folio (e.g., page->_mapcount).

After above analysis, I think the possible race is as follows:

CPU 0                                                  CPU 1
filemap_map_pages()                                   ext4_setattr()
   //get and lock folio with old inode->i_size
   next_uptodate_folio()

                                                          .......
                                                          //shrink the inode->i_size
                                                          i_size_write(inode, attr->ia_size);

   //calculate the end_pgoff with the new inode->i_size
   file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
   end_pgoff = min(end_pgoff, file_end);

   ......
   //nr_pages can be overflowed, cause xas.xa_index > end_pgoff
   end = folio_next_index(folio) - 1;
   nr_pages = min(end, end_pgoff) - xas.xa_index + 1;

   ......
   //map large folio
   filemap_map_folio_range()
                                                          ......
                                                          //truncate folios
                                                          truncate_pagecache(inode, inode->i_size);

To fix this issue, move the 'end_pgoff' calculation before
next_uptodate_folio(), so the retrieved folio stays consistent with the
file end to avoid 'nr_pages' calculation overflow.  After this patch, the
crash issue is gone.

Link: https://lkml.kernel.org/r/1cf1ac59018fc647a87b0dad605d4056a71c14e4.1773739704.git.baolin.wang@linux.alibaba.com
Fixes: 743a2753a02e ("filemap: cap PTE range to be created to allowed zero fill in folio_map_range()")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reported-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
Tested-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Daniel Gomez <da.gomez@samsung.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Cc: Luis Chamberalin <mcgrof@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/filemap.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3883,14 +3883,19 @@ vm_fault_t filemap_map_pages(struct vm_f
 	unsigned int nr_pages = 0, folio_type;
 	unsigned short mmap_miss = 0, mmap_miss_saved;
 
+	/*
+	 * Recalculate end_pgoff based on file_end before calling
+	 * next_uptodate_folio() to avoid races with concurrent
+	 * truncation.
+	 */
+	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
+	end_pgoff = min(end_pgoff, file_end);
+
 	rcu_read_lock();
 	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
 	if (!folio)
 		goto out;
 
-	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
-	end_pgoff = min(end_pgoff, file_end);
-
 	/*
 	 * Do not allow to map with PMD across i_size to preserve
 	 * SIGBUS semantics.



