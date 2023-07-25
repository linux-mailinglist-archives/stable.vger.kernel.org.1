Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B7A761213
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjGYK7N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjGYK6Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:58:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7975199C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:55:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7488861648
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BC2C433C8;
        Tue, 25 Jul 2023 10:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282538;
        bh=gMuC0ZuHNDiWABZXb2y6akIvzBpqRjIdyg8yHybunpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mkc0IPU9+AzTbpBSypTmlSxpClWiQw2RAzF+5nTj6CBQAw23pHh/uKCq1juMNNT7d
         z7TfISKK4RQGFsR46d2QVtKoN0QvtsEQtYR1LQStOaXKtpD7N8D3nmohLx2HxCsAWt
         mNCyY921DPl/pJFsVhHVPsVoua0OjncdBZGWxNWs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 158/227] cifs: fix mid leak during reconnection after timeout threshold
Date:   Tue, 25 Jul 2023 12:45:25 +0200
Message-ID: <20230725104521.469955957@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
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

From: Shyam Prasad N <nspmangalore@gmail.com>

[ Upstream commit 69cba9d3c1284e0838ae408830a02c4a063104bc ]

When the number of responses with status of STATUS_IO_TIMEOUT
exceeds a specified threshold (NUM_STATUS_IO_TIMEOUT), we reconnect
the connection. But we do not return the mid, or the credits
returned for the mid, or reduce the number of in-flight requests.

This bug could result in the server->in_flight count to go bad,
and also cause a leak in the mids.

This change moves the check to a few lines below where the
response is decrypted, even of the response is read from the
transform header. This way, the code for returning the mids
can be reused.

Also, the cifs_reconnect was reconnecting just the transport
connection before. In case of multi-channel, this may not be
what we want to do after several timeouts. Changed that to
reconnect the session and the tree too.

Also renamed NUM_STATUS_IO_TIMEOUT to a more appropriate name
MAX_STATUS_IO_TIMEOUT.

Fixes: 8e670f77c4a5 ("Handle STATUS_IO_TIMEOUT gracefully")
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/connect.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index d9f0b3b94f007..853209268f507 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -60,7 +60,7 @@ extern bool disable_legacy_dialects;
 #define TLINK_IDLE_EXPIRE	(600 * HZ)
 
 /* Drop the connection to not overload the server */
-#define NUM_STATUS_IO_TIMEOUT   5
+#define MAX_STATUS_IO_TIMEOUT   5
 
 static int ip_connect(struct TCP_Server_Info *server);
 static int generic_ip_connect(struct TCP_Server_Info *server);
@@ -1117,6 +1117,7 @@ cifs_demultiplex_thread(void *p)
 	struct mid_q_entry *mids[MAX_COMPOUND];
 	char *bufs[MAX_COMPOUND];
 	unsigned int noreclaim_flag, num_io_timeout = 0;
+	bool pending_reconnect = false;
 
 	noreclaim_flag = memalloc_noreclaim_save();
 	cifs_dbg(FYI, "Demultiplex PID: %d\n", task_pid_nr(current));
@@ -1156,6 +1157,8 @@ cifs_demultiplex_thread(void *p)
 		cifs_dbg(FYI, "RFC1002 header 0x%x\n", pdu_length);
 		if (!is_smb_response(server, buf[0]))
 			continue;
+
+		pending_reconnect = false;
 next_pdu:
 		server->pdu_size = pdu_length;
 
@@ -1213,10 +1216,13 @@ cifs_demultiplex_thread(void *p)
 		if (server->ops->is_status_io_timeout &&
 		    server->ops->is_status_io_timeout(buf)) {
 			num_io_timeout++;
-			if (num_io_timeout > NUM_STATUS_IO_TIMEOUT) {
-				cifs_reconnect(server, false);
+			if (num_io_timeout > MAX_STATUS_IO_TIMEOUT) {
+				cifs_server_dbg(VFS,
+						"Number of request timeouts exceeded %d. Reconnecting",
+						MAX_STATUS_IO_TIMEOUT);
+
+				pending_reconnect = true;
 				num_io_timeout = 0;
-				continue;
 			}
 		}
 
@@ -1263,6 +1269,11 @@ cifs_demultiplex_thread(void *p)
 			buf = server->smallbuf;
 			goto next_pdu;
 		}
+
+		/* do this reconnect at the very end after processing all MIDs */
+		if (pending_reconnect)
+			cifs_reconnect(server, true);
+
 	} /* end while !EXITING */
 
 	/* buffer usually freed in free_mid - need to free it here on exit */
-- 
2.39.2



