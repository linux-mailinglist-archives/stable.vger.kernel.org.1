Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6397556B6
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjGPUxS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjGPUxR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:53:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEF2109
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:53:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0A1860EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5BFC433C7;
        Sun, 16 Jul 2023 20:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540796;
        bh=thcaNabwn2qKu0ks9ymYLEOkstvw9jFVYeEqR+TIaB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bshiw9NwP1YBMzdxWi7c9wWuc3nxqsuEJf0rgyNTd51HXCrlZ2obRWmk12kOcqUuG
         9Lv9O4TcihnlIGa5MmOsTg2usmLYCSz8gCTmA11cMQY6gEhEWZxmTjPwJT1rLAx3C4
         J10R1occZ48dxB2mnf0wH6CypFB543VcQ8BxV8nc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bart van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 463/591] blk-cgroup: dont update io stat for root cgroup
Date:   Sun, 16 Jul 2023 21:50:02 +0200
Message-ID: <20230716194935.881304644@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 0416f3be58c6b1ea066cd52e354b857693feb01e ]

We source root cgroup stats from the system-wide stats, see blkcg_print_stat
and blkcg_rstat_flush, so don't update io state for root cgroup.

Fixes blkg leak issue introduced in commit 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
which starts to grab blkg's reference when adding iostat_cpu into percpu
blkcg list, but this state won't be consumed by blkcg_rstat_flush() where
the blkg reference is dropped.

Tested-by: Bart van Assche <bvanassche@acm.org>
Reported-by: Bart van Assche <bvanassche@acm.org>
Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
Cc: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20230202021804.278582-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: ad7c3b41e86b ("blk-throttle: Fix io statistics for cgroup v1")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-cgroup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 2c7be256ff879..5ee0ae8ddbf6f 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2008,6 +2008,10 @@ void blk_cgroup_bio_start(struct bio *bio)
 	struct blkg_iostat_set *bis;
 	unsigned long flags;
 
+	/* Root-level stats are sourced from system-wide IO stats */
+	if (!cgroup_parent(blkcg->css.cgroup))
+		return;
+
 	cpu = get_cpu();
 	bis = per_cpu_ptr(bio->bi_blkg->iostat_cpu, cpu);
 	flags = u64_stats_update_begin_irqsave(&bis->sync);
-- 
2.39.2



