Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02BB7ECF1F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbjKOTqd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbjKOTqa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:46:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B3E189
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:46:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223E8C433C7;
        Wed, 15 Nov 2023 19:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077587;
        bh=wf8G/1Urj8zwDf8IclRrKdfc6INEEgKR9kH3x5sSiJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ubxB/gK/hzLxXsNDLhkS2i5aI6swJpJzbmFsuCfQ7I52sNj85PQ7a8P+srWh2/GX9
         v2LrGFuCI0ptg2kOuYr7LbfSy6exvKcTGWyKQO2hisvAuImoQeSA2EdZLRGmwyjY0g
         fvTQEdSgHUbGhcmfq7jNIA1w1sroUacvF7Mk4Wt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 373/603] dlm: fix remove member after close call
Date:   Wed, 15 Nov 2023 14:15:18 -0500
Message-ID: <20231115191639.285854266@linuxfoundation.org>
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

From: Alexander Aring <aahringo@redhat.com>

[ Upstream commit 2776635edc7fcd62e03cb2efb93c31f685887460 ]

The idea of commit 63e711b08160 ("fs: dlm: create midcomms nodes when
configure") is to set the midcomms node lifetime when a node joins or
leaves the cluster. Currently we can hit the following warning:

[10844.611495] ------------[ cut here ]------------
[10844.615913] WARNING: CPU: 4 PID: 84304 at fs/dlm/midcomms.c:1263
dlm_midcomms_remove_member+0x13f/0x180 [dlm]

or running in a state where we hit a midcomms node usage count in a
negative value:

[  260.830782] node 2 users dec count -1

The first warning happens when the a specific node does not exists and
it was probably removed but dlm_midcomms_close() which is called when a
node leaves the cluster. The second kernel log message is probably in a
case when dlm_midcomms_addr() is called when a joined the cluster but
due fencing a node leaved the cluster without getting removed from the
lockspace. If the node joins the cluster and it was removed from the
cluster due fencing the first call is to remove the node from lockspaces
triggered by the user space. In both cases if the node wasn't found or
the user count is zero, we should ignore any additional midcomms handling
of dlm_midcomms_remove_member().

Fixes: 63e711b08160 ("fs: dlm: create midcomms nodes when configure")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/midcomms.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index 455265c6ba53d..4ad71e97cec2a 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -1268,12 +1268,23 @@ void dlm_midcomms_remove_member(int nodeid)
 
 	idx = srcu_read_lock(&nodes_srcu);
 	node = nodeid2node(nodeid);
-	if (WARN_ON_ONCE(!node)) {
+	/* in case of dlm_midcomms_close() removes node */
+	if (!node) {
 		srcu_read_unlock(&nodes_srcu, idx);
 		return;
 	}
 
 	spin_lock(&node->state_lock);
+	/* case of dlm_midcomms_addr() created node but
+	 * was not added before because dlm_midcomms_close()
+	 * removed the node
+	 */
+	if (!node->users) {
+		spin_unlock(&node->state_lock);
+		srcu_read_unlock(&nodes_srcu, idx);
+		return;
+	}
+
 	node->users--;
 	pr_debug("node %d users dec count %d\n", nodeid, node->users);
 
-- 
2.42.0



