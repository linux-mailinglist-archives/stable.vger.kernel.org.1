Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DABE74C219
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjGILQu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGILQt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:16:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E6012A
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:16:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EA0860BC4
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7C8C433C8;
        Sun,  9 Jul 2023 11:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901407;
        bh=v9ItTI2Z0Kia6ORxclEXmdUn+0LHBmrRHO0uyh4ytnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wudHhJP0FKARA7qejpsA++7R1ckVM6qcS9o/fFnkkAqkaKH9HQ7mtbTlpXPbqtgw2
         x+Ox5zHSwpW5H7gj05J4MvydVcM5T3fHsPgV1DGof8PNjgkugQswPtOSm/2neS8Fm9
         Sld6rl5xQWkkjljiBXs4jMxMFek65YcG7plqyuHo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Waiman Long <longman@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 010/431] blk-cgroup: Reinit blkg_iostat_set after clearing in blkcg_reset_stats()
Date:   Sun,  9 Jul 2023 13:09:18 +0200
Message-ID: <20230709111451.350124111@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Waiman Long <longman@redhat.com>

[ Upstream commit 3d2af77e31ade05ff7ccc3658c3635ec1bea0979 ]

When blkg_alloc() is called to allocate a blkcg_gq structure
with the associated blkg_iostat_set's, there are 2 fields within
blkg_iostat_set that requires proper initialization - blkg & sync.
The former field was introduced by commit 3b8cc6298724 ("blk-cgroup:
Optimize blkcg_rstat_flush()") while the later one was introduced by
commit f73316482977 ("blk-cgroup: reimplement basic IO stats using
cgroup rstat").

Unfortunately those fields in the blkg_iostat_set's are not properly
re-initialized when they are cleared in v1's blkcg_reset_stats(). This
can lead to a kernel panic due to NULL pointer access of the blkg
pointer. The missing initialization of sync is less problematic and
can be a problem in a debug kernel due to missing lockdep initialization.

Fix these problems by re-initializing them after memory clearing.

Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
Fixes: f73316482977 ("blk-cgroup: reimplement basic IO stats using cgroup rstat")
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230606180724.2455066-1-longman@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-cgroup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index ad0cd992a6519..c50da8b3af029 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -585,8 +585,13 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 			struct blkg_iostat_set *bis =
 				per_cpu_ptr(blkg->iostat_cpu, cpu);
 			memset(bis, 0, sizeof(*bis));
+
+			/* Re-initialize the cleared blkg_iostat_set */
+			u64_stats_init(&bis->sync);
+			bis->blkg = blkg;
 		}
 		memset(&blkg->iostat, 0, sizeof(blkg->iostat));
+		u64_stats_init(&blkg->iostat.sync);
 
 		for (i = 0; i < BLKCG_MAX_POLS; i++) {
 			struct blkcg_policy *pol = blkcg_policy[i];
-- 
2.39.2



