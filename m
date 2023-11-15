Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9187ECCF2
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbjKOTd0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbjKOTdZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:33:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A099F9E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:33:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EAFC433CA;
        Wed, 15 Nov 2023 19:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076801;
        bh=N/dEb5iPt959rsWuCOmG3n3FYzNjvj+bUWHbBqeojhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pEuQ6mKdvUJ6+itAvClm8xTfHIWh7TCFfb4KSH9h6PQLJ0gT6r+C6YJdOnQNLKHco
         8Pswt6+r2bYHKxLbD7yb+uQLOkhXwKVs0OaivIXKIpHNYdZ2ny9TA8+8UqflDxG5bN
         CNS1Z+9KhaUR2/89aOI5f4rPi6OoFoqGCUD4e5L8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jan Kara <jack@suse.cz>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 013/603] writeback, cgroup: switch inodes with dirty timestamps to release dying cgwbs
Date:   Wed, 15 Nov 2023 14:09:18 -0500
Message-ID: <20231115191614.073048584@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index c1af01b2c42d7..1767493dffda7 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -613,6 +613,24 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
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
@@ -625,7 +643,6 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 {
 	struct cgroup_subsys_state *memcg_css;
 	struct inode_switch_wbs_context *isw;
-	struct inode *inode;
 	int nr;
 	bool restart = false;
 
@@ -647,17 +664,17 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 
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



