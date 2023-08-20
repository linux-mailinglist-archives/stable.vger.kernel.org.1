Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A536B781F27
	for <lists+stable@lfdr.de>; Sun, 20 Aug 2023 20:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjHTSLh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 20 Aug 2023 14:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjHTSLf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 20 Aug 2023 14:11:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105DE1B3
        for <stable@vger.kernel.org>; Sun, 20 Aug 2023 11:10:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99ACF60C4B
        for <stable@vger.kernel.org>; Sun, 20 Aug 2023 18:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E93C433C8;
        Sun, 20 Aug 2023 18:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692555052;
        bh=li2XU9EnRTt/JFS0w3thcW8KWy5vtVR9yjfumvrKKBY=;
        h=Subject:To:Cc:From:Date:From;
        b=cwggKuBqgxT/p6h993DjhESsAQN0MbMOExti8Fwg70uKINxgbZGvLGbsDH5Pl69Md
         /IK9lwvoeTPqIlqHP3r6ceksKn4sdgHBkgV0CakP5LN3lEt9aWtB5tAmFJikoORxI6
         0RFm8xeV3m+8QGi6mBxUG7wqxE60ZC0WG9IfuzOM=
Subject: FAILED: patch "[PATCH] smb3: display network namespace in debug information" failed to apply to 6.1-stable tree
To:     stfrench@microsoft.com, pc@manguebit.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 20 Aug 2023 20:10:48 +0200
Message-ID: <2023082048-jeep-prancing-da9a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7b38f6ddc97bf572c3422d3175e8678dd95502fa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082048-jeep-prancing-da9a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

7b38f6ddc97b ("smb3: display network namespace in debug information")
3ae872de4107 ("smb: client: fix shared DFS root mounts with different prefixes")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
72a7804a667e ("cifs: fix smb1 mount regression")
8e3554150d6c ("cifs: fix sharing of DFS connections")
3dc9c433c9dd ("cifs: protect access of TCP_Server_Info::{origin,leaf}_fullpath")
ee20d7c61007 ("cifs: fix potential race when tree connecting ipc")
d5a863a153e9 ("cifs: avoid dup prefix path in dfs_get_automount_devname()")
2f4e429c8469 ("cifs: lock chan_lock outside match_session")
396935de1455 ("cifs: fix use-after-free bug in refresh_cache_worker()")
b56bce502f55 ("cifs: set DFS root session in cifs_get_smb_ses()")
b9ee2e307c6b ("cifs: improve checking of DFS links over STATUS_OBJECT_NAME_INVALID")
9e6002c8738a ("cifs: ignore ipc reconnect failures during dfs failover")
7ad54b98fc1f ("cifs: use origin fullpath for automounts")
466611e4af82 ("cifs: fix source pathname comparison of dfs supers")
1d04a6fe75ee ("cifs: don't block in dfs_cache_noreq_update_tgthint()")
6916881f443f ("cifs: fix refresh of cached referrals")
cb3f6d876452 ("cifs: don't refresh cached referrals from unactive mounts")
a1c0d00572fc ("cifs: share dfs connections and supers")
a73a26d97eca ("cifs: split out ses and tcon retrieval from mount_get_conns()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7b38f6ddc97bf572c3422d3175e8678dd95502fa Mon Sep 17 00:00:00 2001
From: Steve French <stfrench@microsoft.com>
Date: Thu, 10 Aug 2023 21:41:03 -0500
Subject: [PATCH] smb3: display network namespace in debug information

We recently had problems where a network namespace was deleted
causing hard to debug reconnect problems.  To help deal with
configuration issues like this it is useful to dump the network
namespace to better debug what happened.

So add this to information displayed in /proc/fs/cifs/DebugData for
the server (and channels if mounted with multichannel). For example:

   Local Users To Server: 1 SecMode: 0x1 Req On Wire: 0 Net namespace: 4026531840

This can be easily compared with what is displayed for the
processes on the system. For example /proc/1/ns/net in this case
showed the same thing (see below), and we can see that the namespace
is still valid in this example.

   'net:[4026531840]'

Cc: stable@vger.kernel.org
Acked-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index fb4162a52844..aec6e9137474 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -153,6 +153,11 @@ cifs_dump_channel(struct seq_file *m, int i, struct cifs_chan *chan)
 		   in_flight(server),
 		   atomic_read(&server->in_send),
 		   atomic_read(&server->num_waiters));
+#ifdef CONFIG_NET_NS
+	if (server->net)
+		seq_printf(m, " Net namespace: %u ", server->net->ns.inum);
+#endif /* NET_NS */
+
 }
 
 static inline const char *smb_speed_to_str(size_t bps)
@@ -430,10 +435,15 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 				server->reconnect_instance,
 				server->srv_count,
 				server->sec_mode, in_flight(server));
+#ifdef CONFIG_NET_NS
+		if (server->net)
+			seq_printf(m, " Net namespace: %u ", server->net->ns.inum);
+#endif /* NET_NS */
 
 		seq_printf(m, "\nIn Send: %d In MaxReq Wait: %d",
 				atomic_read(&server->in_send),
 				atomic_read(&server->num_waiters));
+
 		if (server->leaf_fullpath) {
 			seq_printf(m, "\nDFS leaf full path: %s",
 				   server->leaf_fullpath);

