Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48397B8765
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243789AbjJDSEx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243786AbjJDSEw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:04:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177EFA7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:04:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E37CC433C7;
        Wed,  4 Oct 2023 18:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442687;
        bh=IVMad4PuskXtZ8AVKsLOb9p3M0hCpKsqTtJ6SJf6GAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EBD7dz9AWfcVPbnBxSC9RaOh2ZBKP9qAsPy+5IavO7L+SuIIKNKC9PjvgZ6EH5pln
         8XpNKSJLXmgVBDm1Uti0N7wbKl/++Rh5fqrwkE71tgBOgcAbaS3e3hBShAiJRCPCAa
         UwlycDeT81QkTytlfzCieyUbG5pFoiduqzV0rhlw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 074/183] xfs: explicitly specify cpu when forcing inodegc delayed work to run immediately
Date:   Wed,  4 Oct 2023 19:55:05 +0200
Message-ID: <20231004175206.966385592@linuxfoundation.org>
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

[ Upstream commit 03e0add80f4cf3f7393edb574eeb3a89a1db7758 ]

I've been noticing odd racing behavior in the inodegc code that could
only be explained by one cpu adding an inode to its inactivation llist
at the same time that another cpu is processing that cpu's llist.
Preemption is disabled between get/put_cpu_ptr, so the only explanation
is scheduler mayhem.  I inserted the following debug code into
xfs_inodegc_worker (see the next patch):

	ASSERT(gc->cpu == smp_processor_id());

This assertion tripped during overnight tests on the arm64 machines, but
curiously not on x86_64.  I think we haven't observed any resource leaks
here because the lockfree list code can handle simultaneous llist_add
and llist_del_all functions operating on the same list.  However, the
whole point of having percpu inodegc lists is to take advantage of warm
memory caches by inactivating inodes on the last processor to touch the
inode.

The incorrect scheduling seems to occur after an inodegc worker is
subjected to mod_delayed_work().  This wraps mod_delayed_work_on with
WORK_CPU_UNBOUND specified as the cpu number.  Unbound allows for
scheduling on any cpu, not necessarily the same one that scheduled the
work.

Because preemption is disabled for as long as we have the gc pointer, I
think it's safe to use current_cpu() (aka smp_processor_id) to queue the
delayed work item on the correct cpu.

Fixes: 7cf2b0f9611b ("xfs: bound maximum wait time for inodegc work")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_icache.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index e9ebfe6f80150..ab8181f8d08a9 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -2057,7 +2057,8 @@ xfs_inodegc_queue(
 		queue_delay = 0;
 
 	trace_xfs_inodegc_queue(mp, __return_address);
-	mod_delayed_work(mp->m_inodegc_wq, &gc->work, queue_delay);
+	mod_delayed_work_on(current_cpu(), mp->m_inodegc_wq, &gc->work,
+			queue_delay);
 	put_cpu_ptr(gc);
 
 	if (xfs_inodegc_want_flush_work(ip, items, shrinker_hits)) {
@@ -2101,7 +2102,8 @@ xfs_inodegc_cpu_dead(
 
 	if (xfs_is_inodegc_enabled(mp)) {
 		trace_xfs_inodegc_queue(mp, __return_address);
-		mod_delayed_work(mp->m_inodegc_wq, &gc->work, 0);
+		mod_delayed_work_on(current_cpu(), mp->m_inodegc_wq, &gc->work,
+				0);
 	}
 	put_cpu_ptr(gc);
 }
-- 
2.40.1



