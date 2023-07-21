Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E0B75D2AC
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjGUTCZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjGUTCY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:02:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0124B30D0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:02:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 932D461D84
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A465BC433C9;
        Fri, 21 Jul 2023 19:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966140;
        bh=hBxW4Aq5D2Vp7+U9Lxun/wkTGiytYGRzezopo3mc9JA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KvNhdpPMUUWLUjLxiiBgrctdvufngIbb5vO4cyXp8PpNr+G8BQ2nUGUA49dcFF9ul
         WEVxdeShupapcsZ29hksN/aQcktWwv9YY4l+TJL4gSJEm6+PgnofpodNXifIvu/Adr
         ryfFN86yT2wa95oR17JrSgKiML6vZH1pc04wd4C8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tom Talpey <tom@talpey.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 239/532] SMB3: Do not send lease break acknowledgment if all file handles have been closed
Date:   Fri, 21 Jul 2023 18:02:23 +0200
Message-ID: <20230721160627.325228599@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
 fs/cifs/file.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index bda1ffe6e41f8..4e4f73a90574b 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4923,20 +4923,19 @@ void cifs_oplock_break(struct work_struct *work)
 
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



