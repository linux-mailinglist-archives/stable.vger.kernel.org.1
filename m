Return-Path: <stable+bounces-89996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2862A9BDC63
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59DB91C21189
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915081DF257;
	Wed,  6 Nov 2024 02:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Re+NKPPn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFA119049B;
	Wed,  6 Nov 2024 02:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859123; cv=none; b=VbTJON+0lvgy7UlWpc4JvhnkZFGeFTFFlxD/BcNqYdW9z4aaUW+2V/qhaD73S3gSBGxYoGo/y9es3SK1Xp7qGGtS8rB2CzTDpNmL1V/cvEaTjDyrZjbMlur4SXx5OLx9diqwjqNfno5gxj59B1BYtCN8fCfMdbahdHoMKwFEsK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859123; c=relaxed/simple;
	bh=s5pww47MAPQozDd3hmUkgIR6Hr/gQ7mIcYl+0/uI4GI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iNlut+iKy8rZ4q7vTYSafAbCTKhuG2s5SvCaDEoQVJo6AlUf7R+GfhLDVK9kXHkkMEoW6ov+MgOigqFl8uGwsCESFWrJXo/8FLkOka4hw54U6LpRGsrlnGG7HRpS7jOUgIPQHODmWOlKZi4XiD3c2enJ/dewd06Sxg3CLenb0o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Re+NKPPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76676C4CECF;
	Wed,  6 Nov 2024 02:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859123;
	bh=s5pww47MAPQozDd3hmUkgIR6Hr/gQ7mIcYl+0/uI4GI=;
	h=From:To:Cc:Subject:Date:From;
	b=Re+NKPPnxVkQ8Sg8s8amQSLcBf+uJuStJvg83w5z26BoYEEzFF2y2W/ejIbXikUlq
	 iXyLw7PgKI/8kfHa26udxWaWd4htAh6LeXPsGQNBsC+y/zR47i9Cra/JFcmZ1tJkCw
	 7daCJEyHN0Xn0878mDqdHgKqVGk6Sk19xTZFDmA4NmDO9CWsVmMjo2R8/8Hvfn7Ple
	 ad53oQEYdsOuM0ci6a5pFWjOrIYGB0gMZbARMnC6MPZKLkOE+hPrAyyz9vrduC+udi
	 EyQSfhBGl4nQ+18EdwXPaVDXKRmRpv46DVAaRQnwdarkWcu8CK10GRUDAxElvmBE3q
	 D6p4HlZdzJb7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gourry@gourry.net
Cc: Yang Shi <shy828301@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Huang, Ying" <ying.huang@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Wei Xu <weixugc@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "vmscan,migrate: fix page count imbalance on node stats when demoting pages" failed to apply to v5.15-stable tree
Date: Tue,  5 Nov 2024 21:11:59 -0500
Message-ID: <20241106021159.182619-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 35e41024c4c2b02ef8207f61b9004f6956cf037b Mon Sep 17 00:00:00 2001
From: Gregory Price <gourry@gourry.net>
Date: Fri, 25 Oct 2024 10:17:24 -0400
Subject: [PATCH] vmscan,migrate: fix page count imbalance on node stats when
 demoting pages

When numa balancing is enabled with demotion, vmscan will call
migrate_pages when shrinking LRUs.  migrate_pages will decrement the
the node's isolated page count, leading to an imbalanced count when
invoked from (MG)LRU code.

The result is dmesg output like such:

$ cat /proc/sys/vm/stat_refresh

[77383.088417] vmstat_refresh: nr_isolated_anon -103212
[77383.088417] vmstat_refresh: nr_isolated_file -899642

This negative value may impact compaction and reclaim throttling.

The following path produces the decrement:

shrink_folio_list
  demote_folio_list
    migrate_pages
      migrate_pages_batch
        migrate_folio_move
          migrate_folio_done
            mod_node_page_state(-ve) <- decrement

This path happens for SUCCESSFUL migrations, not failures.  Typically
callers to migrate_pages are required to handle putback/accounting for
failures, but this is already handled in the shrink code.

When accounting for migrations, instead do not decrement the count when
the migration reason is MR_DEMOTION.  As of v6.11, this demotion logic
is the only source of MR_DEMOTION.

Link: https://lkml.kernel.org/r/20241025141724.17927-1-gourry@gourry.net
Fixes: 26aa2d199d6f ("mm/migrate: demote pages during reclaim")
Signed-off-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Wei Xu <weixugc@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 7e520562d421a..fab84a7760889 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1178,7 +1178,7 @@ static void migrate_folio_done(struct folio *src,
 	 * not accounted to NR_ISOLATED_*. They can be recognized
 	 * as __folio_test_movable
 	 */
-	if (likely(!__folio_test_movable(src)))
+	if (likely(!__folio_test_movable(src)) && reason != MR_DEMOTION)
 		mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
 				    folio_is_file_lru(src), -folio_nr_pages(src));
 
-- 
2.43.0





