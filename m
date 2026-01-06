Return-Path: <stable+bounces-206046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E151CFB529
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 00:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39583304E5E4
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 23:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79642E542C;
	Tue,  6 Jan 2026 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSYzroI2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E752550BA
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767740874; cv=none; b=RCdV0UCSo12Itacq8kcN44DuOA1WJAET2w9+YdlryuLwYq7NtZHfzVXic+8UdSAwkWfxeuxVjgjDg3GFoHuef7agXA8JfqTcl5OxNAC0RmX93IsbsbyexX0Y7NPa7NdNDQE06+xqWPKwRwkcoIFRhCJHMKzWrf+6dQMY+d6ZIF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767740874; c=relaxed/simple;
	bh=dY5jh0fDrczOegcNmRnB1RIq2GS0wAVKbPrg0jfyAuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnLEgM9dZEnYMHc9m0rXMP7/4Qw93q+FyYX5tfXkEyWMPcNdTh1plEln1/xEXSphAH/fHddYLmg0WEKBuX9fs1M6AkQfcuL5cVMVIZwzwt/s8iXG0D5PB6lMJNWGm1Xi1cOsFHtQ7IzJswK1V5gtb/J/+Au2EqVa+eJfHgpzelA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSYzroI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275D9C116C6;
	Tue,  6 Jan 2026 23:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767740873;
	bh=dY5jh0fDrczOegcNmRnB1RIq2GS0wAVKbPrg0jfyAuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qSYzroI2nTCvIlKEYnq617VXkisFLgroUJ+jNaCgTKucVwuNB3Buf6j+JNyCmGgQA
	 EQY9Axo7kFBmdTosxgD+9zcHh3u/PEHFN1xffS1ZT/WCjMyN5pwQhbNNTc55TRwaBg
	 g/jxQdL5WzW2jX/mTFR3dnH799RiikHCVZC13Dn9hw3fL5g/eV5MIgbfBJ8VCLVG5X
	 aNA7nACdtmnBj2PudmgRI3gfvz+AMGKl8jmJN8aSD9ij5mqvRZwa6quGJWyA9bQEVA
	 nqQh8Zrv3GCbg9G6/GEFosAo+R4B86IgeGMmoEgTUi1Xq6rSBveAO96cmDutKJl1pS
	 REct3cCTsJsjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Alistair Popple <apopple@nvidia.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Brendan Jackman <jackmanb@google.com>,
	Byungchul Park <byungchul@sk.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	=?UTF-8?q?Eugenio=20P=C3=A9=20rez?= <eperezma@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gregory Price <gourry@gourry.net>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Jan Kara <jack@suse.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jason Wang <jasowang@redhat.com>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mathew Brost <matthew.brost@intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Rik van Riel <riel@surriel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	xu xin <xu.xin16@zte.com.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] mm: simplify folio_expected_ref_count()
Date: Tue,  6 Jan 2026 18:07:46 -0500
Message-ID: <20260106230747.3447947-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010544-pavestone-gloating-a829@gregkh>
References: <2026010544-pavestone-gloating-a829@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 78cb1a13c42a6d843e21389f74d1edb90ed07288 ]

Now that PAGE_MAPPING_MOVABLE is gone, we can simplify and rely on the
folio_test_anon() test only.

... but staring at the users, this function should never even have been
called on movable_ops pages. E.g.,
* __buffer_migrate_folio() does not make sense for them
* folio_migrate_mapping() does not make sense for them
* migrate_huge_page_move_mapping() does not make sense for them
* __migrate_folio() does not make sense for them
* ... and khugepaged should never stumble over them

Let's simply refuse typed pages (which includes slab) except hugetlb, and
WARN.

Link: https://lkml.kernel.org/r/20250704102524.326966-26-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Eugenio Pé rez <eperezma@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gregory Price <gourry@gourry.net>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mathew Brost <matthew.brost@intel.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: f183663901f2 ("mm: consider non-anon swap cache folios in folio_expected_ref_count()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 13b4bd7355c1..bbea39a8d441 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2238,13 +2238,13 @@ static inline int folio_expected_ref_count(const struct folio *folio)
 	const int order = folio_order(folio);
 	int ref_count = 0;
 
-	if (WARN_ON_ONCE(folio_test_slab(folio)))
+	if (WARN_ON_ONCE(page_has_type(&folio->page) && !folio_test_hugetlb(folio)))
 		return 0;
 
 	if (folio_test_anon(folio)) {
 		/* One reference per page from the swapcache. */
 		ref_count += folio_test_swapcache(folio) << order;
-	} else if (!((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS)) {
+	} else {
 		/* One reference per page from the pagecache. */
 		ref_count += !!folio->mapping << order;
 		/* One reference from PG_private. */
-- 
2.51.0


