Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6A5793EED
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 16:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbjIFOdZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 10:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjIFOdX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 10:33:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5625E173A
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694010756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XR2SmgDqVCsMYOHQFTOFp+NHQ5byWemKZvcRwOWVI20=;
        b=DOP5lsXV9J+dNqAJUzYmni77T01wcBgVU3f7sSly1sXBl38bQo6lKjR14vCef0OLBmO9dz
        Rx5hKuwHFjW7VvkyUTyJvwWdpkwkLlIjyUExfoIt1ph8pkStyxjqoctTiHlWU4sAUji/pN
        l/JpV0D+oKzFX+WHvTT9N7dlbwSrYAU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-HY_6CHSKPmWeUktyIRtC2g-1; Wed, 06 Sep 2023 10:32:33 -0400
X-MC-Unique: HY_6CHSKPmWeUktyIRtC2g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1BE8877281;
        Wed,  6 Sep 2023 14:32:32 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 814AC140E950;
        Wed,  6 Sep 2023 14:32:32 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, gfs2@lists.linux.dev,
        aahringo@redhat.com, stable@vger.kernel.org
Subject: [PATCH dlm/next 1/6] dlm: fix creating multiple node structures
Date:   Wed,  6 Sep 2023 10:31:48 -0400
Message-Id: <20230906143153.1353077-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This patch will lookup existing nodes instead of always creating them
when dlm_midcomms_addr() is called. The idea is here to create midcomms
nodes when user space getting informed that nodes joins the cluster. This
is the case when dlm_midcomms_addr() is called, however it can be called
multiple times by user space to add several address configurations to one
node e.g. when using SCTP. Those multiple times need to be filtered out
and we doing that by looking up if the node exists before. Due configfs
entry it is safe that this function gets only called once at a time.

Cc: stable@vger.kernel.org
Fixes: 63e711b08160 ("fs: dlm: create midcomms nodes when configure")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/midcomms.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index f641b36a36db..455265c6ba53 100644
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
2.31.1

