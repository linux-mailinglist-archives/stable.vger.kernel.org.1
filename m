Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5EA7C436D
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 00:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjJJWFr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 18:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjJJWFq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 18:05:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A676894
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 15:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696975499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PNDcpeq2zwb1Ai5E4yBf1qdfkoauBsYMo15/py24iVw=;
        b=YagAh28QuczMOCHl52GS7oXfE9wn4ANSoSG2lNw+TXUI+UtoFP50LyckzQTwiDl4M5rhYy
        FvPoGQYQ2pqkwBNV30e9UutU+3eDjz3bPHlbHkorPTqLivR79DrzdwW62MCiJt29fZ7nNz
        qkSefoiaMhY62/PK2adIYc4o0Sm3w7A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-riUvex5VMfCHRwtL8sFLzA-1; Tue, 10 Oct 2023 18:04:58 -0400
X-MC-Unique: riUvex5VMfCHRwtL8sFLzA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFD291C060C3;
        Tue, 10 Oct 2023 22:04:57 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEEEE63F45;
        Tue, 10 Oct 2023 22:04:57 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, gfs2@lists.linux.dev,
        christophe.jaillet@wanadoo.fr, stable@vger.kernel.org,
        aahringo@redhat.com
Subject: [PATCH RESEND 4/8] dlm: fix creating multiple node structures
Date:   Tue, 10 Oct 2023 18:04:44 -0400
Message-Id: <20231010220448.2978176-4-aahringo@redhat.com>
In-Reply-To: <20231010220448.2978176-1-aahringo@redhat.com>
References: <20231010220448.2978176-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
2.39.3

