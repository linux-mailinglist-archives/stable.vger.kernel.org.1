Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACC37B8768
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243773AbjJDSE6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243791AbjJDSE5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:04:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEE0E9
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:04:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8172C433C8;
        Wed,  4 Oct 2023 18:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442693;
        bh=XXNHbmjh2NXf+mNDpSYVuBCl85e+MLhdHlMh4eieQ5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gl4foDF8tvDks9z3PD9uhHPfEygBySMmLZ78q95pdKhbC+5Jhb/35wpgH6yCeutPa
         RiOZmh+1W+bvONhP6lPoZ4mLVjuxC0MC6CMhnnVDfARMkGtiMwQxPvqPzZUkZlhw+t
         r4dKgpxUIMQKc5tTxaxs7IpOkSAO8eFUgFdS+edg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 076/183] xfs: disable reaping in fscounters scrub
Date:   Wed,  4 Oct 2023 19:55:07 +0200
Message-ID: <20231004175207.054978919@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Darrick J. Wong <djwong@kernel.org>

[ Upstream commit 2d5f38a31980d7090f5bf91021488dc61a0ba8ee ]

The fscounters scrub code doesn't work properly because it cannot
quiesce updates to the percpu counters in the filesystem, hence it
returns false corruption reports.  This has been fixed properly in
one of the online repair patchsets that are under review by replacing
the xchk_disable_reaping calls with an exclusive filesystem freeze.
Disabling background gc isn't sufficient to fix the problem.

In other words, scrub doesn't need to call xfs_inodegc_stop, which is
just as well since it wasn't correct to allow scrub to call
xfs_inodegc_start when something else could be calling xfs_inodegc_stop
(e.g. trying to freeze the filesystem).

Neuter the scrubber for now, and remove the xchk_*_reaping functions.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/common.c     | 25 -------------------------
 fs/xfs/scrub/common.h     |  2 --
 fs/xfs/scrub/fscounters.c | 13 ++++++-------
 fs/xfs/scrub/scrub.c      |  2 --
 fs/xfs/scrub/scrub.h      |  1 -
 5 files changed, 6 insertions(+), 37 deletions(-)

diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index bf1f3607d0b60..08df23edea720 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -864,28 +864,3 @@ xchk_ilock_inverted(
 	return -EDEADLOCK;
 }
 
-/* Pause background reaping of resources. */
-void
-xchk_stop_reaping(
-	struct xfs_scrub	*sc)
-{
-	sc->flags |= XCHK_REAPING_DISABLED;
-	xfs_blockgc_stop(sc->mp);
-	xfs_inodegc_stop(sc->mp);
-}
-
-/* Restart background reaping of resources. */
-void
-xchk_start_reaping(
-	struct xfs_scrub	*sc)
-{
-	/*
-	 * Readonly filesystems do not perform inactivation or speculative
-	 * preallocation, so there's no need to restart the workers.
-	 */
-	if (!xfs_is_readonly(sc->mp)) {
-		xfs_inodegc_start(sc->mp);
-		xfs_blockgc_start(sc->mp);
-	}
-	sc->flags &= ~XCHK_REAPING_DISABLED;
-}
diff --git a/fs/xfs/scrub/common.h b/fs/xfs/scrub/common.h
index 454145db10e71..2ca80102e704a 100644
--- a/fs/xfs/scrub/common.h
+++ b/fs/xfs/scrub/common.h
@@ -148,7 +148,5 @@ static inline bool xchk_skip_xref(struct xfs_scrub_metadata *sm)
 
 int xchk_metadata_inode_forks(struct xfs_scrub *sc);
 int xchk_ilock_inverted(struct xfs_inode *ip, uint lock_mode);
-void xchk_stop_reaping(struct xfs_scrub *sc);
-void xchk_start_reaping(struct xfs_scrub *sc);
 
 #endif	/* __XFS_SCRUB_COMMON_H__ */
diff --git a/fs/xfs/scrub/fscounters.c b/fs/xfs/scrub/fscounters.c
index 48a6cbdf95d08..037541339d80a 100644
--- a/fs/xfs/scrub/fscounters.c
+++ b/fs/xfs/scrub/fscounters.c
@@ -128,13 +128,6 @@ xchk_setup_fscounters(
 	if (error)
 		return error;
 
-	/*
-	 * Pause background reclaim while we're scrubbing to reduce the
-	 * likelihood of background perturbations to the counters throwing off
-	 * our calculations.
-	 */
-	xchk_stop_reaping(sc);
-
 	return xchk_trans_alloc(sc, 0);
 }
 
@@ -353,6 +346,12 @@ xchk_fscounters(
 	if (fdblocks > mp->m_sb.sb_dblocks)
 		xchk_set_corrupt(sc);
 
+	/*
+	 * XXX: We can't quiesce percpu counter updates, so exit early.
+	 * This can be re-enabled when we gain exclusive freeze functionality.
+	 */
+	return 0;
+
 	/*
 	 * If ifree exceeds icount by more than the minimum variance then
 	 * something's probably wrong with the counters.
diff --git a/fs/xfs/scrub/scrub.c b/fs/xfs/scrub/scrub.c
index 51e4c61916d20..e4d2a41983f73 100644
--- a/fs/xfs/scrub/scrub.c
+++ b/fs/xfs/scrub/scrub.c
@@ -171,8 +171,6 @@ xchk_teardown(
 	}
 	if (sc->sm->sm_flags & XFS_SCRUB_IFLAG_REPAIR)
 		mnt_drop_write_file(sc->file);
-	if (sc->flags & XCHK_REAPING_DISABLED)
-		xchk_start_reaping(sc);
 	if (sc->flags & XCHK_HAS_QUOTAOFFLOCK) {
 		mutex_unlock(&sc->mp->m_quotainfo->qi_quotaofflock);
 		sc->flags &= ~XCHK_HAS_QUOTAOFFLOCK;
diff --git a/fs/xfs/scrub/scrub.h b/fs/xfs/scrub/scrub.h
index 80e5026bba44a..e8d9fe9de26ed 100644
--- a/fs/xfs/scrub/scrub.h
+++ b/fs/xfs/scrub/scrub.h
@@ -89,7 +89,6 @@ struct xfs_scrub {
 /* XCHK state flags grow up from zero, XREP state flags grown down from 2^31 */
 #define XCHK_TRY_HARDER		(1 << 0)  /* can't get resources, try again */
 #define XCHK_HAS_QUOTAOFFLOCK	(1 << 1)  /* we hold the quotaoff lock */
-#define XCHK_REAPING_DISABLED	(1 << 2)  /* background block reaping paused */
 #define XREP_ALREADY_FIXED	(1 << 31) /* checking our repair work */
 
 /* Metadata scrubbers */
-- 
2.40.1



