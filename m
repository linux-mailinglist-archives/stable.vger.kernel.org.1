Return-Path: <stable+bounces-165884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66472B195D8
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 23:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D608188644B
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 21:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA7921ADB7;
	Sun,  3 Aug 2025 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmfBfw1q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C5B1D5CC6;
	Sun,  3 Aug 2025 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256012; cv=none; b=Np0kT6cuqU5Iitl1DHXiKIEXzVDJML1nS/K4ikSZz4qYptW7EsMxK0l41X/K/fCsJIGWm4Yg1D2L57mLP0thZ2a1o8MhB1xPBtOTTPrXjQFVATJsTXV/Vhg7JnMyVSyvEA80vJx0wQHhNgT26hqZhQSSN7A9C2Gqmiy5DITRYBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256012; c=relaxed/simple;
	bh=JZsFyGYZ8Vevilu4nisLCtIzBBy74dSzOuFlO41YO00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CWe7Gz+eJkJkkFZZ/T5Z6N/FpkiF3umfZVsFxrd4UpGqt9oNBGlRi2KXWHqMeRQPSRvbGXyBGKJZpmZH1ZNWyue0KGB8F90hU5M9cbrFnvBWwFc/9dfia2+r6GNRMYyHLUFbxuGsWewY9VTVmQ3Iy9tZiF67kgQCh06HkanUnEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmfBfw1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7128C4CEEB;
	Sun,  3 Aug 2025 21:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754256012;
	bh=JZsFyGYZ8Vevilu4nisLCtIzBBy74dSzOuFlO41YO00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GmfBfw1q5d8Qa7CeNBdo+RNPFRmhbYthUhIYB+I6u2/px2TzbKK3KIk9X4j059BQt
	 K1EdxR0OMgo8B8iSClqL0LTdBz386sPoAEdj4aW2jQyJclALp5vEJX0ztap3Mot0Ih
	 OP0C52hMUmsR9FpXeio245zbb5CWOo1Z/Cz5BWf7b5cYTPFRUU2vC53zWzvaSgnkOT
	 Dp/xcHDYg/N+WjWYPagavzpjrkp/cqXsVH84P6ZDwhNMX9GKNBhlBf6grde8oqdoH0
	 AU58zCPzuw8eoh5vfvwafqDeVP0/VOGYhFwfqVwGCJzEzfhlSAcv81xPO5KM3iSfbT
	 baDTU0uxRfYFQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Andrew Price <anprice@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 14/31] gfs2: Set .migrate_folio in gfs2_{rgrp,meta}_aops
Date: Sun,  3 Aug 2025 17:19:17 -0400
Message-Id: <20250803211935.3547048-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803211935.3547048-1-sashal@kernel.org>
References: <20250803211935.3547048-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.41
Content-Transfer-Encoding: 8bit

From: Andrew Price <anprice@redhat.com>

[ Upstream commit 5c8f12cf1e64e0e8e6cb80b0c935389973e8be8d ]

Clears up the warning added in 7ee3647243e5 ("migrate: Remove call to
->writepage") that occurs in various xfstests, causing "something found
in dmesg" failures.

[  341.136573] gfs2_meta_aops does not implement migrate_folio
[  341.136953] WARNING: CPU: 1 PID: 36 at mm/migrate.c:944 move_to_new_folio+0x2f8/0x300

Signed-off-by: Andrew Price <anprice@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my analysis, I can now provide my assessment:

**YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Fixes a real bug**: The commit fixes a warning that appears in
   xfstests runs where GFS2 filesystems trigger a WARN_ONCE in
   mm/migrate.c:944 because the gfs2_meta_aops and gfs2_rgrp_aops
   address space operations don't implement the migrate_folio callback.

2. **Small and contained fix**: The change is minimal - it only adds two
   lines setting `.migrate_folio = buffer_migrate_folio_norefs,` to two
   address_space_operations structures in fs/gfs2/meta_io.c. This is a
   very low-risk change.

3. **Prevents test failures**: Without this fix, xfstests fail with
   "something found in dmesg" errors due to the warning, which affects
   testing infrastructure and CI systems.

4. **Follows established pattern**: The fix uses
   `buffer_migrate_folio_norefs`, which is the standard migration
   function for filesystems that use buffer heads without additional
   reference counting requirements. This same function is already used
   by ext4, nilfs2, and block device operations.

5. **Regression from upstream change**: The warning was introduced by
   commit 7ee3647243e5 ("migrate: Remove call to ->writepage"), which
   enforces that filesystems must implement migrate_folio. This makes
   the fix necessary for proper operation with newer kernels.


The fix is a classic stable tree candidate: it addresses a specific bug,
has minimal code changes, doesn't introduce new features or
architectural changes, and fixes a regression that affects users running
tests on GFS2 filesystems.

 fs/gfs2/meta_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 960d6afcdfad..b795ca7765cd 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -103,6 +103,7 @@ const struct address_space_operations gfs2_meta_aops = {
 	.invalidate_folio = block_invalidate_folio,
 	.writepages = gfs2_aspace_writepages,
 	.release_folio = gfs2_release_folio,
+	.migrate_folio = buffer_migrate_folio_norefs,
 };
 
 const struct address_space_operations gfs2_rgrp_aops = {
@@ -110,6 +111,7 @@ const struct address_space_operations gfs2_rgrp_aops = {
 	.invalidate_folio = block_invalidate_folio,
 	.writepages = gfs2_aspace_writepages,
 	.release_folio = gfs2_release_folio,
+	.migrate_folio = buffer_migrate_folio_norefs,
 };
 
 /**
-- 
2.39.5


