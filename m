Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8E37ED340
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjKOUrD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjKOUrC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:47:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0184B8F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:46:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A729C433C9;
        Wed, 15 Nov 2023 20:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081218;
        bh=t0FeywH4oLMXI62DaImUFbQq8gxnBPS4UVmZmmc5xsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hvIu5BIf5hsJ8SgV7plOxeEJWPNAwbln/j4xSExTpT5ueFQCEdn1/D7K/4WO7ncVD
         D0fllyn7h6Kygs5rmEXpbtLEf5i0AZB/HKdO1VMOTwNZHBv1Q48h6rbnvwqUizhnc9
         B7NcZPmy7aEU3M+tG9Zadqbj+q0JXBv1ZijuoKpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jan Kara <jack@suse.cz>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 005/244] writeback, cgroup: switch inodes with dirty timestamps to release dying cgwbs
Date:   Wed, 15 Nov 2023 15:33:17 -0500
Message-ID: <20231115203548.700569923@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jingbo Xu <jefflexu@linux.alibaba.com>

[ Upstream commit 6654408a33e6297d8e1d2773409431d487399b95 ]

The cgwb cleanup routine will try to release the dying cgwb by switching
the attached inodes.  It fetches the attached inodes from wb->b_attached
list, omitting the fact that inodes only with dirty timestamps reside in
wb->b_dirty_time list, which is the case when lazytime is enabled.  This
causes enormous zombie memory cgroup when lazytime is enabled, as inodes
with dirty timestamps can not be switched to a live cgwb for a long time.

It is reasonable not to switch cgwb for inodes with dirty data, as
otherwise it may break the bandwidth restrictions.  However since the
writeback of inode metadata is not accounted for, let's also switch
inodes with dirty timestamps to avoid zombie memory and block cgroups
when laztytime is enabled.

Fixes: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching attached inodes")
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Link: https://lore.kernel.org/r/20231014125511.102978-1-jefflexu@linux.alibaba.com
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fs-writeback.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 5f0abea107e46..672d176524f5c 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -609,6 +609,24 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	kfree(isw);
 }
 
+static bool isw_prepare_wbs_switch(struct inode_switch_wbs_context *isw,
+				   struct list_head *list, int *nr)
+{
+	struct inode *inode;
+
+	list_for_each_entry(inode, list, i_io_list) {
+		if (!inode_prepare_wbs_switch(inode, isw->new_wb))
+			continue;
+
+		isw->inodes[*nr] = inode;
+		(*nr)++;
+
+		if (*nr >= WB_MAX_INODES_PER_ISW - 1)
+			return true;
+	}
+	return false;
+}
+
 /**
  * cleanup_offline_cgwb - detach associated inodes
  * @wb: target wb
@@ -621,7 +639,6 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 {
 	struct cgroup_subsys_state *memcg_css;
 	struct inode_switch_wbs_context *isw;
-	struct inode *inode;
 	int nr;
 	bool restart = false;
 
@@ -643,17 +660,17 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 
 	nr = 0;
 	spin_lock(&wb->list_lock);
-	list_for_each_entry(inode, &wb->b_attached, i_io_list) {
-		if (!inode_prepare_wbs_switch(inode, isw->new_wb))
-			continue;
-
-		isw->inodes[nr++] = inode;
-
-		if (nr >= WB_MAX_INODES_PER_ISW - 1) {
-			restart = true;
-			break;
-		}
-	}
+	/*
+	 * In addition to the inodes that have completed writeback, also switch
+	 * cgwbs for those inodes only with dirty timestamps. Otherwise, those
+	 * inodes won't be written back for a long time when lazytime is
+	 * enabled, and thus pinning the dying cgwbs. It won't break the
+	 * bandwidth restrictions, as writeback of inode metadata is not
+	 * accounted for.
+	 */
+	restart = isw_prepare_wbs_switch(isw, &wb->b_attached, &nr);
+	if (!restart)
+		restart = isw_prepare_wbs_switch(isw, &wb->b_dirty_time, &nr);
 	spin_unlock(&wb->list_lock);
 
 	/* no attached inodes? bail out */
-- 
2.42.0



