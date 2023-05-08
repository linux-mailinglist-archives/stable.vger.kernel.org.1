Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76726FAEB3
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbjEHLqy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbjEHLqi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:46:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FDB10E52
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:46:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 184A1638D0
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D77C433EF;
        Mon,  8 May 2023 11:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546396;
        bh=R+8Ex2/a2nFV5/EaeGJ54cokIe6OCmhDzBUCRXks/9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BLYXqmjCyqabHASNzNbXcBupctLd2OneG3QcVxFFpUZ5QrXoKLw0Y8nopl8cj9yAH
         ZZLeH8uV+jIZ9YLfuDI6L7t1bMAKFv+9kStQdHyPWyQtPPyuF7EeuRoC1qIulwv0Wh
         1jQslKUSJVjeqz9qvffkfj5xzz1tPm9150ljYpmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bharath SM <bharathsm@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 324/371] SMB3: Close deferred file handles in case of handle lease break
Date:   Mon,  8 May 2023 11:48:45 +0200
Message-Id: <20230508094824.937849093@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bharath SM <bharathsm@microsoft.com>

[ Upstream commit d906be3fa571f6fc9381911304a0eca99f1b6951 ]

We should not cache deferred file handles if we dont have
handle lease on a file. And we should immediately close all
deferred handles in case of handle lease break.

Fixes: 9e31678fb403 ("SMB3: fix lease break timeout when multiple deferred close handles for the same file.")
Signed-off-by: Bharath SM <bharathsm@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/file.c | 16 ++++++++++++++++
 fs/cifs/misc.c |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index b3cf9ab50139d..ebf2877dbe76c 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4870,6 +4870,8 @@ void cifs_oplock_break(struct work_struct *work)
 	struct TCP_Server_Info *server = tcon->ses->server;
 	int rc = 0;
 	bool purge_cache = false;
+	struct cifs_deferred_close *dclose;
+	bool is_deferred = false;
 
 	wait_on_bit(&cinode->flags, CIFS_INODE_PENDING_WRITERS,
 			TASK_UNINTERRUPTIBLE);
@@ -4905,6 +4907,20 @@ void cifs_oplock_break(struct work_struct *work)
 		cifs_dbg(VFS, "Push locks rc = %d\n", rc);
 
 oplock_break_ack:
+	/*
+	 * When oplock break is received and there are no active
+	 * file handles but cached, then schedule deferred close immediately.
+	 * So, new open will not use cached handle.
+	 */
+	spin_lock(&CIFS_I(inode)->deferred_lock);
+	is_deferred = cifs_is_deferred_close(cfile, &dclose);
+	spin_unlock(&CIFS_I(inode)->deferred_lock);
+
+	if (!CIFS_CACHE_HANDLE(cinode) && is_deferred &&
+			cfile->deferred_close_scheduled && delayed_work_pending(&cfile->deferred)) {
+		cifs_close_deferred_file(cinode);
+	}
+
 	/*
 	 * releasing stale oplock after recent reconnect of smb session using
 	 * a now incorrect file handle is not a data integrity issue but do
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 15e8ae31ffbc9..5e4dab5dfb7a3 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -748,7 +748,7 @@ cifs_close_deferred_file(struct cifsInodeInfo *cifs_inode)
 	spin_unlock(&cifs_inode->open_file_lock);
 
 	list_for_each_entry_safe(tmp_list, tmp_next_list, &file_head, list) {
-		_cifsFileInfo_put(tmp_list->cfile, true, false);
+		_cifsFileInfo_put(tmp_list->cfile, false, false);
 		list_del(&tmp_list->list);
 		kfree(tmp_list);
 	}
-- 
2.39.2



