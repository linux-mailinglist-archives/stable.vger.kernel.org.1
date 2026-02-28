Return-Path: <stable+bounces-220872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCADBXlFo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:43:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 055511C74CC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E37A6345E732
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4867941F55B;
	Sat, 28 Feb 2026 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwjdYgg2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8692141F54E;
	Sat, 28 Feb 2026 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300758; cv=none; b=SJ9qXwoFDZO7OWpvRIGRI5TiqJDxQzOHGYl3/MotSfSI2/16oKxM3vyblemXAf/obvoyYRWWCGwAlt4g9MSdTdGT7K5E6O6W9qsJPBnR3jsOi+Oa8t83Nov3dTd/DgI823eTG0OiuXtiE9oTzRyQa8qsJriSpQr3KMgQjqdZkms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300758; c=relaxed/simple;
	bh=SvhekaeBihNp9RCE30D+VMaOdhKwa+8CeDfTQXBXoo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s3Wzm3xOlLE9tUP17oSejU5fOHVPe12iJc61yYhM+Zaz4qDTVJz6/1DCl9PiLgAQ/zE8XF0ZsJUSLJMrqsFfYbt/ofSoPo8pN++N2VhpwprNGIpEe4Cgj0BgE9gUm3SqKDSjz60GBLMWyR/+RGtyBsc2u4WYrB21oKAxZzRi66o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwjdYgg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57413C116D0;
	Sat, 28 Feb 2026 17:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300758;
	bh=SvhekaeBihNp9RCE30D+VMaOdhKwa+8CeDfTQXBXoo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwjdYgg2+6Mk/XDH+wrD/P+cQGoKOWjE2GN5RwjU+6RBDlx8SPCPxgJ98TBesEVVB
	 Bu5V4zdxk6FJt714iWgEFV5Fft3Oo7FBAJ66s2IVJND8giJQbQNpuLSR7HUFcClbiX
	 KPzA2VQiG0dnoaGoaiVZQyLjHPvnV73Locickq4ZcO/dfEQNTGuMBC+cyNdZLSblRv
	 wbqwZgJ8z7zY15JdEredev8FrX5620ro1WnGO3rhnw9SclJzLVtt4RG2VRQqFCBfWC
	 YZ6ABCrXkxurpKzu1qPTfvQZ09ybTRKlz374Mij5nuy2l1m9y4729T+IL5vZHIDfi7
	 wPFvaR4IyfV/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>,
	Usama Arif <usama.arif@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ma Wupeng <mawupeng1@huawei.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 793/844] mm/hugetlb: restore failed global reservations to subpool
Date: Sat, 28 Feb 2026 12:31:46 -0500
Message-ID: <20260228173244.1509663-794-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,oracle.com,huawei.com,suse.com,suse.de,google.com,suse.cz,redhat.com,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-220872-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 055511C74CC
X-Rspamd-Action: no action

From: Joshua Hahn <joshua.hahnjy@gmail.com>

[ Upstream commit 1d3f9bb4c8af70304d19c22e30f5d16a2d589bb5 ]

Commit a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
fixed an underflow error for hstate->resv_huge_pages caused by incorrectly
attributing globally requested pages to the subpool's reservation.

Unfortunately, this fix also introduced the opposite problem, which would
leave spool->used_hpages elevated if the globally requested pages could
not be acquired.  This is because while a subpool's reserve pages only
accounts for what is requested and allocated from the subpool, its "used"
counter keeps track of what is consumed in total, both from the subpool
and globally.  Thus, we need to adjust spool->used_hpages in the other
direction, and make sure that globally requested pages are uncharged from
the subpool's used counter.

Each failed allocation attempt increments the used_hpages counter by how
many pages were requested from the global pool.  Ultimately, this renders
the subpool unusable, as used_hpages approaches the max limit.

The issue can be reproduced as follows:
1. Allocate 4 hugetlb pages
2. Create a hugetlb mount with max=4, min=2
3. Consume 2 pages globally
4. Request 3 pages from the subpool (2 from subpool + 1 from global)
	4.1 hugepage_subpool_get_pages(spool, 3) succeeds.
		used_hpages += 3
	4.2 hugetlb_acct_memory(h, 1) fails: no global pages left
		used_hpages -= 2
5. Subpool now has used_hpages = 1, despite not being able to
   successfully allocate any hugepages. It believes it can now only
   allocate 3 more hugepages, not 4.

With each failed allocation attempt incrementing the used counter, the
subpool eventually reaches a point where its used counter equals its
max counter.  At that point, any future allocations that try to
allocate hugeTLB pages from the subpool will fail, despite the subpool
not having any of its hugeTLB pages consumed by any user.

Once this happens, there is no way to make the subpool usable again,
since there is no way to decrement the used counter as no process is
really consuming the hugeTLB pages.

The underflow issue that the original commit fixes still remains fixed
as well.

Without this fix, used_hpages would keep on leaking if
hugetlb_acct_memory() fails.

Link: https://lkml.kernel.org/r/20260116204037.2270096-1-joshua.hahnjy@gmail.com
Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Acked-by: Usama Arif <usama.arif@linux.dev>
Cc: David Hildenbrand <david@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Ma Wupeng <mawupeng1@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Waiman Long <longman@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a1832da0f6236..77e45dd50ba21 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6717,6 +6717,15 @@ long hugetlb_reserve_pages(struct inode *inode,
 		 */
 		hugetlb_acct_memory(h, -gbl_resv);
 	}
+	/* Restore used_hpages for pages that failed global reservation */
+	if (gbl_reserve && spool) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&spool->lock, flags);
+		if (spool->max_hpages != -1)
+			spool->used_hpages -= gbl_reserve;
+		unlock_or_release_subpool(spool, flags);
+	}
 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);
-- 
2.51.0


