Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D525978332F
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjHUUD6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjHUUD6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:03:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43651DF
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:03:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7EB564894
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DEAC433C7;
        Mon, 21 Aug 2023 20:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648236;
        bh=RrXHtGy317FVEhZMESI/Ncw9A1/YQro2RoPblKc8aUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CQK0GotNXT6oG6j0FECfzYFDbnyPe5DO3K3VXsSnLQxaCgdsbQchCt92MRMCE2lfm
         ZNGlLqPqqv5lLoK1ZBxd+AfopgPQS2Y0TnnDURW6yR7shObukYXYN6uSnTFYeHsPHP
         5elEbrVCgTmggN8VZ+TQZw4xZi651xyzY6wnFZFg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Paulo Alcantara (SUSE)" <pc@manguebit.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.4 104/234] smb3: display network namespace in debug information
Date:   Mon, 21 Aug 2023 21:41:07 +0200
Message-ID: <20230821194133.416635430@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

commit 7b38f6ddc97bf572c3422d3175e8678dd95502fa upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifs_debug.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -153,6 +153,11 @@ cifs_dump_channel(struct seq_file *m, in
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
@@ -429,10 +434,15 @@ skip_rdma:
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


