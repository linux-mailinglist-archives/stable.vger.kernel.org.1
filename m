Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD737C9AB8
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 20:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjJOSUS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 14:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOSUR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 14:20:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A458B7
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 11:20:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AB9C433C7;
        Sun, 15 Oct 2023 18:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697394015;
        bh=8GsNL8JD6lPEV9cRHANhcmdgykcopQF5BZXigpZL6FI=;
        h=Subject:To:Cc:From:Date:From;
        b=H7g08nA46FkgQlqDZJZBTXY8Ptj5beOmjkd/YUb3Q9xDZQWAyV+vAuFn/inH8Cqzv
         3LL0SKQtyT1A6yPwXzdn0+qMjdBH1bFXsS+UX8AQSop6y7l/MR3mPpnJOwsEDheIVH
         Mh13ve8PTyqWT5abjLZP5R5tLydjw3+9o8zY87MI=
Subject: FAILED: patch "[PATCH] libceph: use kernel_connect()" failed to apply to 4.19-stable tree
To:     jrife@google.com, idryomov@gmail.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 15 Oct 2023 20:20:11 +0200
Message-ID: <2023101511-mulberry-although-ef0c@gregkh>
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


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 7563cf17dce0a875ba3d872acdc63a78ea344019
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023101511-mulberry-although-ef0c@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

7563cf17dce0 ("libceph: use kernel_connect()")
cede185b1ba3 ("libceph: fix unaligned accesses in ceph_entity_addr handling")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7563cf17dce0a875ba3d872acdc63a78ea344019 Mon Sep 17 00:00:00 2001
From: Jordan Rife <jrife@google.com>
Date: Wed, 4 Oct 2023 18:38:27 -0500
Subject: [PATCH] libceph: use kernel_connect()

Direct calls to ops->connect() can overwrite the address parameter when
used in conjunction with BPF SOCK_ADDR hooks. Recent changes to
kernel_connect() ensure that callers are insulated from such side
effects. This patch wraps the direct call to ops->connect() with
kernel_connect() to prevent unexpected changes to the address passed to
ceph_tcp_connect().

This change was originally part of a larger patch targeting the net tree
addressing all instances of unprotected calls to ops->connect()
throughout the kernel, but this change was split up into several patches
targeting various trees.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netdev/20230821100007.559638-1-jrife@google.com/
Link: https://lore.kernel.org/netdev/9944248dba1bce861375fcce9de663934d933ba9.camel@redhat.com/
Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
Signed-off-by: Jordan Rife <jrife@google.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 10a41cd9c523..3c8b78d9c4d1 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -459,8 +459,8 @@ int ceph_tcp_connect(struct ceph_connection *con)
 	set_sock_callbacks(sock, con);
 
 	con_sock_state_connecting(con);
-	ret = sock->ops->connect(sock, (struct sockaddr *)&ss, sizeof(ss),
-				 O_NONBLOCK);
+	ret = kernel_connect(sock, (struct sockaddr *)&ss, sizeof(ss),
+			     O_NONBLOCK);
 	if (ret == -EINPROGRESS) {
 		dout("connect %s EINPROGRESS sk_state = %u\n",
 		     ceph_pr_addr(&con->peer_addr),

