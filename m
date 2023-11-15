Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92237ECF1E
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbjKOTq3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbjKOTq3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:46:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE21B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:46:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54841C433C7;
        Wed, 15 Nov 2023 19:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077585;
        bh=j+iPLhG9zlGjGxAM4McI+S2VzGYVr2xPPBcAK71oSmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v+sq4DdQJWs/zFYmZ9/xbQVQd4/9y3tw4qbZcLAApkb+6ORl1Z20psLxtFaTNhPRv
         BT0296JWNV0enrJygB8wgjPINyiDd6FsCPiTsbigCcIALjRELmmgXTP+9z1TYAZ17+
         eFH4VJ5xjJ01/i48riMAQy2Kd4swMzIocy7T2FFc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 372/603] dlm: fix creating multiple node structures
Date:   Wed, 15 Nov 2023 14:15:17 -0500
Message-ID: <20231115191639.240793641@linuxfoundation.org>
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

[ Upstream commit fe9b619e6e94acf0b068fb1a8f658f5a96b8fad7 ]

This patch will lookup existing nodes instead of always creating them
when dlm_midcomms_addr() is called. The idea is here to create midcomms
nodes when user space getting informed that nodes joins the cluster. This
is the case when dlm_midcomms_addr() is called, however it can be called
multiple times by user space to add several address configurations to one
node e.g. when using SCTP. Those multiple times need to be filtered out
and we doing that by looking up if the node exists before. Due configfs
entry it is safe that this function gets only called once at a time.

Fixes: 63e711b08160 ("fs: dlm: create midcomms nodes when configure")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/midcomms.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index f641b36a36db0..455265c6ba53d 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -337,13 +337,21 @@ static struct midcomms_node *nodeid2node(int nodeid)
 
 int dlm_midcomms_addr(int nodeid, struct sockaddr_storage *addr, int len)
 {
-	int ret, r = nodeid_hash(nodeid);
+	int ret, idx, r = nodeid_hash(nodeid);
 	struct midcomms_node *node;
 
 	ret = dlm_lowcomms_addr(nodeid, addr, len);
 	if (ret)
 		return ret;
 
+	idx = srcu_read_lock(&nodes_srcu);
+	node = __find_node(nodeid, r);
+	if (node) {
+		srcu_read_unlock(&nodes_srcu, idx);
+		return 0;
+	}
+	srcu_read_unlock(&nodes_srcu, idx);
+
 	node = kmalloc(sizeof(*node), GFP_NOFS);
 	if (!node)
 		return -ENOMEM;
-- 
2.42.0



