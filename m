Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAAF75533F
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjGPURB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjGPUQ5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:16:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D194D1B9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:16:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 612AB60E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D21C433C9;
        Sun, 16 Jul 2023 20:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538615;
        bh=RyYOc5qoiF0giIKqtOfW/Znsgpew67bMTXDhBOdVDFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dTLsPQzW4bJUwbjiA0cTzyh5GayBGQl3wXCcq46EdTULybPA7HLbWM4BGNrGG0hpe
         U4ejcGDSTqyImNd9Y2xuKDZ+tRtCt7+qVBv+5BCwx3BGHXdipwmYd5m0BlKCMCNAcG
         ET+qOnRzWAXxFQWnMDtkwTgbGY6iIk9cRMUVIc/Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tom Talpey <tom@talpey.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 514/800] SMB3: Do not send lease break acknowledgment if all file handles have been closed
Date:   Sun, 16 Jul 2023 21:46:07 +0200
Message-ID: <20230716195001.029784860@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Bharath SM <bharathsm@microsoft.com>

[ Upstream commit da787d5b74983f7525d1eb4b9c0b4aff2821511a ]

In case if all existing file handles are deferred handles and if all of
them gets closed due to handle lease break then we dont need to send
lease break acknowledgment to server, because last handle close will be
considered as lease break ack.
After closing deferred handels, we check for openfile list of inode,
if its empty then we skip sending lease break ack.

Fixes: 59a556aebc43 ("SMB3: drop reference to cfile before sending oplock break")
Reviewed-by: Tom Talpey <tom@talpey.com>
Signed-off-by: Bharath SM <bharathsm@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/file.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 051283386e229..1a854dc204823 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -4936,20 +4936,19 @@ void cifs_oplock_break(struct work_struct *work)
 
 	_cifsFileInfo_put(cfile, false /* do not wait for ourself */, false);
 	/*
-	 * releasing stale oplock after recent reconnect of smb session using
-	 * a now incorrect file handle is not a data integrity issue but do
-	 * not bother sending an oplock release if session to server still is
-	 * disconnected since oplock already released by the server
+	 * MS-SMB2 3.2.5.19.1 and 3.2.5.19.2 (and MS-CIFS 3.2.5.42) do not require
+	 * an acknowledgment to be sent when the file has already been closed.
+	 * check for server null, since can race with kill_sb calling tree disconnect.
 	 */
-	if (!oplock_break_cancelled) {
-		/* check for server null since can race with kill_sb calling tree disconnect */
-		if (tcon->ses && tcon->ses->server) {
-			rc = tcon->ses->server->ops->oplock_response(tcon, persistent_fid,
-				volatile_fid, net_fid, cinode);
-			cifs_dbg(FYI, "Oplock release rc = %d\n", rc);
-		} else
-			pr_warn_once("lease break not sent for unmounted share\n");
-	}
+	spin_lock(&cinode->open_file_lock);
+	if (tcon->ses && tcon->ses->server && !oplock_break_cancelled &&
+					!list_empty(&cinode->openFileList)) {
+		spin_unlock(&cinode->open_file_lock);
+		rc = tcon->ses->server->ops->oplock_response(tcon, persistent_fid,
+						volatile_fid, net_fid, cinode);
+		cifs_dbg(FYI, "Oplock release rc = %d\n", rc);
+	} else
+		spin_unlock(&cinode->open_file_lock);
 
 	cifs_done_oplock_break(cinode);
 }
-- 
2.39.2



