Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0C271510E
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 23:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjE2Vpb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 17:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjE2Vp3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 17:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569A6CF
        for <stable@vger.kernel.org>; Mon, 29 May 2023 14:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685396683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qwAUpK4a0J9dnz49/qMvbT7hbZUh6ED2xd6uRMiNwmk=;
        b=AiWiuRuURMmGUnlxpo8xVeFp46U4l+4s8bpZ5kQ2g+SBCGePUO2AvA3PYJYBdZTiwWYHuQ
        IcX43iHRT/nEVPQSEPR+aQaTGFXhJ2WT8kSQiDeURoFVbGJa0MK2vESedPSkuh7majr4GO
        8nt7/d1ZJjN0Cj+qSDry2QFruOIppxs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-58DdBS1yOJKp1pyqV1r2RA-1; Mon, 29 May 2023 17:44:42 -0400
X-MC-Unique: 58DdBS1yOJKp1pyqV1r2RA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6A6B3802134
        for <stable@vger.kernel.org>; Mon, 29 May 2023 21:44:41 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B51002166B2B;
        Mon, 29 May 2023 21:44:41 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, aahringo@redhat.com,
        stable@vger.kernel.org
Subject: [PATCH dlm/next 01/12] fs: dlm: revert check required context while close
Date:   Mon, 29 May 2023 17:44:29 -0400
Message-Id: <20230529214440.2542721-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This patch reverts commit 2c3fa6ae4d52 ("dlm: check required context
while close"). The function dlm_midcomms_close(), which will call later
dlm_lowcomms_close(), is called when the cluster manager tells the node
got fenced which means on midcomms/lowcomms layer to disconnect the node
from the cluster communication. The node can rejoin the cluster later.
This patch was ensuring no new message were able to be triggered when we
are in the close() function context. This was done by checking if the
lockspace has been stopped. However there is a missing check that we
only need to check specific lockspaces where the fenced node is member
of. This is currently complicated because there is no way to easily
check if a node is part of a specific lockspace without stopping the
recovery. For now we just revert this commit as it is just a check to
finding possible leaks of stopping lockspaces before close() is called.

Cc: stable@vger.kernel.org
Fixes: 2c3fa6ae4d52 ("dlm: check required context while close")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lockspace.c | 12 ------------
 fs/dlm/lockspace.h |  1 -
 fs/dlm/midcomms.c  |  3 ---
 3 files changed, 16 deletions(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 67261b7b1f0e..0455dddb0797 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -935,15 +935,3 @@ void dlm_stop_lockspaces(void)
 		log_print("dlm user daemon left %d lockspaces", count);
 }
 
-void dlm_stop_lockspaces_check(void)
-{
-	struct dlm_ls *ls;
-
-	spin_lock(&lslist_lock);
-	list_for_each_entry(ls, &lslist, ls_list) {
-		if (WARN_ON(!rwsem_is_locked(&ls->ls_in_recovery) ||
-			    !dlm_locking_stopped(ls)))
-			break;
-	}
-	spin_unlock(&lslist_lock);
-}
diff --git a/fs/dlm/lockspace.h b/fs/dlm/lockspace.h
index 03f4a4a3a871..47ebd4411926 100644
--- a/fs/dlm/lockspace.h
+++ b/fs/dlm/lockspace.h
@@ -27,7 +27,6 @@ struct dlm_ls *dlm_find_lockspace_local(void *id);
 struct dlm_ls *dlm_find_lockspace_device(int minor);
 void dlm_put_lockspace(struct dlm_ls *ls);
 void dlm_stop_lockspaces(void);
-void dlm_stop_lockspaces_check(void);
 int dlm_new_user_lockspace(const char *name, const char *cluster,
 			   uint32_t flags, int lvblen,
 			   const struct dlm_lockspace_ops *ops,
diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index c02c43e4980a..3df916a568ba 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -136,7 +136,6 @@
 #include <net/tcp.h>
 
 #include "dlm_internal.h"
-#include "lockspace.h"
 #include "lowcomms.h"
 #include "config.h"
 #include "memory.h"
@@ -1491,8 +1490,6 @@ int dlm_midcomms_close(int nodeid)
 	if (nodeid == dlm_our_nodeid())
 		return 0;
 
-	dlm_stop_lockspaces_check();
-
 	idx = srcu_read_lock(&nodes_srcu);
 	/* Abort pending close/remove operation */
 	node = nodeid2node(nodeid, 0);
-- 
2.31.1

