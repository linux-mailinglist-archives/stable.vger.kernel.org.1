Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73DE736E8D
	for <lists+stable@lfdr.de>; Tue, 20 Jun 2023 16:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjFTOWF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 20 Jun 2023 10:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjFTOVp (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Jun 2023 10:21:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B7391
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 07:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687270849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0ernhwPaP6FSJ+kstqzHO13IrHrywXGZE43s/6KXwas=;
        b=Jrp8q6QAB/jPyPXr0mkFgaig0pl6pzUJfbc+4FstrMJrnh5h+bOwWuzzsAHnHLw9GUwP7s
        qPvKxlUdvqE/PbUfjmYHQ2O3zpkeqN5Fno6oLTWq30R020kykCAFz9nZz1IrTWpx8SgCWM
        bLhzDxd5JYOG8Kn9N0n0iMzI76z/9Yc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-cfyC2KMPPAmDet1BUk1gtw-1; Tue, 20 Jun 2023 10:20:37 -0400
X-MC-Unique: cfyC2KMPPAmDet1BUk1gtw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2C971C128DB
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 14:15:59 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77883492C13;
        Tue, 20 Jun 2023 14:15:59 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, aahringo@redhat.com,
        stable@vger.kernel.org
Subject: [PATCHv2 dlm/next] fs: dlm: remove filter local comms on close
Date:   Tue, 20 Jun 2023 10:15:57 -0400
Message-Id: <20230620141557.2952429-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The current way how lowcomms is configured is due configfs entries. Each
comms configfs entry will create a lowcomms connection. Even the local
connection itself will be stored as a lowcomms connection, although most
functionality for a local lowcomms connection struct is not necessary.

Now in some scenarios we will see that dlm_controld reports a -EEXIST
when configure a node via configfs:

... /sys/kernel/config/dlm/cluster/comms/1/addr: write failed: 17 -1

Doing a:

cat /sys/kernel/config/dlm/cluster/comms/1/addr_list

reported nothing. This was being seen on cluster with nodeid 1 and it's
local configuration. To be sure the configfs entries are in sync with
lowcomms connection structures we always call dlm_midcomms_close() to be
sure the lowcomms connection gets removed when the configfs entry gets
dropped.

Before commit 07ee38674a0b ("fs: dlm: filter ourself midcomms calls") it
was just doing this by accident and the filter by doing:

if (nodeid == dlm_our_nodeid())
	return 0;

inside dlm_midcomms_close() was never been hit because drop_comm() sets
local_comm to NULL and cause that dlm_our_nodeid() returns always the
invalid nodeid 0.

Fixes: 07ee38674a0b ("fs: dlm: filter ourself midcomms calls")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
changes since v2:
 - add fixes tag
 - cc stable

 fs/dlm/config.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index 4246cd425671..2beceff024e3 100644
--- a/fs/dlm/config.c
+++ b/fs/dlm/config.c
@@ -532,8 +532,7 @@ static void drop_comm(struct config_group *g, struct config_item *i)
 	struct dlm_comm *cm = config_item_to_comm(i);
 	if (local_comm == cm)
 		local_comm = NULL;
-	if (!cm->local)
-		dlm_midcomms_close(cm->nodeid);
+	dlm_midcomms_close(cm->nodeid);
 	while (cm->addr_count--)
 		kfree(cm->addr[cm->addr_count]);
 	config_item_put(i);
-- 
2.31.1

