Return-Path: <stable+bounces-166795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC12FB1DB94
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 18:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036811893A7A
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 16:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5551E26E6E4;
	Thu,  7 Aug 2025 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="j2OXaEVr"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678CC1A0BFD
	for <stable@vger.kernel.org>; Thu,  7 Aug 2025 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754583893; cv=none; b=ueqQOvcjVQnIFHunXC2E/p3q8RW4st0lXT75Apf5hA63aDzivQ6eCB3WAB51UhdhzKjR1Ge04uwcNQQDDVtewwKR65Ks3ddQxwmPayL9SBpl4bS6ZDcrRNrZhG5ZWuKAPCkldS9MkEbKF8kc62m3uxv2lWdsVivn499vLINHcFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754583893; c=relaxed/simple;
	bh=e8UA82WWbvs95x7GEu0Qs+WzQPVdOwUM2dOWu71eJi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQ1AX5+q8M4KA16YByqa7ltlVaSa/WPhVz6f8Y8IgLycVuB3m1Gx1r/8kvwEEQd6BnoWxaHVFBAD5dqPv5Jyy3sm5quL/lMiQ/Myi6JUhF0+c65pU6jVCZmIJ2AfhYi+LSYpnBN63m2E2RSpkMi4T0yhVNNz0YGLvAgj6GS4YBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=j2OXaEVr; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-147.bstnma.fios.verizon.net [173.48.82.147])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 577GMUpJ029077
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Aug 2025 12:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1754583752; bh=aQv5OK9d3Sw0ikDpxCLt3KXG1Y9/Rmfc7AB3nXBBEoQ=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=j2OXaEVrv0Vnm87PrzSJZE6nASde/K60wL/+0MYM03qwFKRiwU3nzIjv+fRWnmvdE
	 OU0uv2YkP2XEkQPH1Llbi+2FubVLPrlOnFsFPEDqpf1NU6WbDalUBA+dwilCi+RRke
	 cI3O7O8+84kc/2Lt/y3TbCnYjdG+zkloC9b/earikXWckqmxvPrFFnSWBC4nthtd1b
	 CL5Q0MmvK7/DgFn/YxM7pyB1xbnH+RwF8Cbw2y4nj9feEKnyzYEcJffBTZvBlOyGeq
	 z4xtPVB6vSHHZS6i0b4FHHhfz3VnTHU5LFgmjo70F4PVcg8iifSNK3ziV6m0fVukG6
	 i32XSRuctXj9Q==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 4F05F2E00D6; Thu, 07 Aug 2025 12:22:30 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, stable@vger.kernel.org
Subject: [PATCH] ext4: don't try to clear the orphan_present feature block device is r/o
Date: Thu,  7 Aug 2025 12:22:20 -0400
Message-ID: <20250807162220.882655-1-tytso@mit.edu>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the file system is frozen in preparation for taking an LVM
snapshot, the journal is checkpointed and if the orphan_file feature
is enabled, and the orphan file is empty, we clear the orphan_present
feature flag.  But if there are pending inodes that need to be removed
the orphan_present feature flag can't be cleared.

The problem comes if the block device is read-only.  In that case, we
can't process the orphan inode list, so it is skipped in
ext4_orphan_cleanup().  But then in ext4_mark_recovery_complete(),
this results in the ext4 error "Orphan file not empty on read-only fs"
firing and the file system mount is aborted.

Fix this by clearing the needs_recovery flag in the block device is
read-only.  We do this after the call to ext4_load_and_init-journal()
since there are some error checks need to be done in case the journal
needs to be replayed and the block device is read-only, or if the
block device containing the externa journal is read-only, etc.

Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1108271
Cc: stable@vger.kernel.org
Fixes: 02f310fcf47f ("ext4: Speedup ext4 orphan inode handling")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c7d39da7e733..52a5f2b391fb 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5414,6 +5414,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		err = ext4_load_and_init_journal(sb, es, ctx);
 		if (err)
 			goto failed_mount3a;
+		if (bdev_read_only(sb->s_bdev))
+		    needs_recovery = 0;
 	} else if (test_opt(sb, NOLOAD) && !sb_rdonly(sb) &&
 		   ext4_has_feature_journal_needs_recovery(sb)) {
 		ext4_msg(sb, KERN_ERR, "required journal recovery "
-- 
2.47.2


