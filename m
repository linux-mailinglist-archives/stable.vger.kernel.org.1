Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C539F6FACE3
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbjEHL27 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbjEHL2b (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:28:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669E83D559
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:28:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3A7A62EB2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06487C433EF;
        Mon,  8 May 2023 11:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545294;
        bh=Yzi87WhceUp6FZn+ykAI3vICoqFhonqzZeEy0CkgwnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DNfmYxqay9eRmu0h6jFBMXIOo9Bxtg8xyeVhbsuBfH5KS/vlNwHnGuNTz3S+kDCl2
         5B/xzCQRtQwom+ldqJwDmnJe8K9TvwDWn2N9BZRC9KclcGI9MHeFH85G07JYbEUYjr
         rznKAdPtbsfuytUiwGnT8ioWO7jcPQsCreUeQLkc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Paulo Alcantara (SUSE)" <pc@manguebit.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.3 688/694] cifs: fix potential use-after-free bugs in TCP_Server_Info::hostname
Date:   Mon,  8 May 2023 11:48:43 +0200
Message-Id: <20230508094458.721938671@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paulo Alcantara <pc@manguebit.com>

commit 90c49fce1c43e1cc152695e20363ff5087897c09 upstream.

TCP_Server_Info::hostname may be updated once or many times during
reconnect, so protect its access outside reconnect path as well and
then prevent any potential use-after-free bugs.

Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/cifs_debug.c |    7 ++++++-
 fs/cifs/cifs_debug.h |   12 ++++++------
 fs/cifs/connect.c    |   10 +++++++---
 fs/cifs/sess.c       |    7 ++++---
 4 files changed, 23 insertions(+), 13 deletions(-)

--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -280,8 +280,10 @@ static int cifs_debug_data_proc_show(str
 		seq_printf(m, "\n%d) ConnectionId: 0x%llx ",
 			c, server->conn_id);
 
+		spin_lock(&server->srv_lock);
 		if (server->hostname)
 			seq_printf(m, "Hostname: %s ", server->hostname);
+		spin_unlock(&server->srv_lock);
 #ifdef CONFIG_CIFS_SMB_DIRECT
 		if (!server->rdma)
 			goto skip_rdma;
@@ -623,10 +625,13 @@ static int cifs_stats_proc_show(struct s
 				server->fastest_cmd[j],
 				server->slowest_cmd[j]);
 		for (j = 0; j < NUMBER_OF_SMB2_COMMANDS; j++)
-			if (atomic_read(&server->smb2slowcmd[j]))
+			if (atomic_read(&server->smb2slowcmd[j])) {
+				spin_lock(&server->srv_lock);
 				seq_printf(m, "  %d slow responses from %s for command %d\n",
 					atomic_read(&server->smb2slowcmd[j]),
 					server->hostname, j);
+				spin_unlock(&server->srv_lock);
+			}
 #endif /* STATS2 */
 		list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
 			list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
--- a/fs/cifs/cifs_debug.h
+++ b/fs/cifs/cifs_debug.h
@@ -81,19 +81,19 @@ do {									\
 
 #define cifs_server_dbg_func(ratefunc, type, fmt, ...)			\
 do {									\
-	const char *sn = "";						\
-	if (server && server->hostname)					\
-		sn = server->hostname;					\
+	spin_lock(&server->srv_lock);					\
 	if ((type) & FYI && cifsFYI & CIFS_INFO) {			\
 		pr_debug_ ## ratefunc("%s: \\\\%s " fmt,		\
-				      __FILE__, sn, ##__VA_ARGS__);	\
+				      __FILE__, server->hostname,	\
+				      ##__VA_ARGS__);			\
 	} else if ((type) & VFS) {					\
 		pr_err_ ## ratefunc("VFS: \\\\%s " fmt,			\
-				    sn, ##__VA_ARGS__);			\
+				    server->hostname, ##__VA_ARGS__);	\
 	} else if ((type) & NOISY && (NOISY != 0)) {			\
 		pr_debug_ ## ratefunc("\\\\%s " fmt,			\
-				      sn, ##__VA_ARGS__);		\
+				      server->hostname, ##__VA_ARGS__);	\
 	}								\
+	spin_unlock(&server->srv_lock);					\
 } while (0)
 
 #define cifs_server_dbg(type, fmt, ...)					\
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -403,8 +403,10 @@ static int __reconnect_target_unlocked(s
 		if (server->hostname != target) {
 			hostname = extract_hostname(target);
 			if (!IS_ERR(hostname)) {
+				spin_lock(&server->srv_lock);
 				kfree(server->hostname);
 				server->hostname = hostname;
+				spin_unlock(&server->srv_lock);
 			} else {
 				cifs_dbg(FYI, "%s: couldn't extract hostname or address from dfs target: %ld\n",
 					 __func__, PTR_ERR(hostname));
@@ -561,9 +563,7 @@ cifs_echo_request(struct work_struct *wo
 		goto requeue_echo;
 
 	rc = server->ops->echo ? server->ops->echo(server) : -ENOSYS;
-	if (rc)
-		cifs_dbg(FYI, "Unable to send echo request to server: %s\n",
-			 server->hostname);
+	cifs_server_dbg(FYI, "send echo request: rc = %d\n", rc);
 
 	/* Check witness registrations */
 	cifs_swn_check();
@@ -1404,6 +1404,8 @@ static int match_server(struct TCP_Serve
 {
 	struct sockaddr *addr = (struct sockaddr *)&ctx->dstaddr;
 
+	lockdep_assert_held(&server->srv_lock);
+
 	if (ctx->nosharesock)
 		return 0;
 
@@ -1810,7 +1812,9 @@ cifs_setup_ipc(struct cifs_ses *ses, str
 	if (tcon == NULL)
 		return -ENOMEM;
 
+	spin_lock(&server->srv_lock);
 	scnprintf(unc, sizeof(unc), "\\\\%s\\IPC$", server->hostname);
+	spin_unlock(&server->srv_lock);
 
 	xid = get_xid();
 	tcon->ses = ses;
--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -159,6 +159,7 @@ cifs_chan_is_iface_active(struct cifs_se
 /* returns number of channels added */
 int cifs_try_adding_channels(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses)
 {
+	struct TCP_Server_Info *server = ses->server;
 	int old_chan_count, new_chan_count;
 	int left;
 	int rc = 0;
@@ -178,16 +179,16 @@ int cifs_try_adding_channels(struct cifs
 		return 0;
 	}
 
-	if (ses->server->dialect < SMB30_PROT_ID) {
+	if (server->dialect < SMB30_PROT_ID) {
 		spin_unlock(&ses->chan_lock);
 		cifs_dbg(VFS, "multichannel is not supported on this protocol version, use 3.0 or above\n");
 		return 0;
 	}
 
-	if (!(ses->server->capabilities & SMB2_GLOBAL_CAP_MULTI_CHANNEL)) {
+	if (!(server->capabilities & SMB2_GLOBAL_CAP_MULTI_CHANNEL)) {
 		ses->chan_max = 1;
 		spin_unlock(&ses->chan_lock);
-		cifs_dbg(VFS, "server %s does not support multichannel\n", ses->server->hostname);
+		cifs_server_dbg(VFS, "no multichannel support\n");
 		return 0;
 	}
 	spin_unlock(&ses->chan_lock);


