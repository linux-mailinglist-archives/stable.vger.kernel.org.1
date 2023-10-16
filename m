Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048077CA339
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjJPJCg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjJPJCc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 05:02:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F33E1
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 02:02:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172A3C433C7;
        Mon, 16 Oct 2023 09:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446950;
        bh=vm099ejbfuBUF7TSGNvggBdxEO+er0/N1dqFzJgCBbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NIB9X9J17FG8O1dgPBmLqhyYE1LXhgh5BSq31Fu4WmKvod/7zK2A2wBUpBsdU9L6y
         vPeWQS/g8rq2RdhgCPtPQVo0nhvMuMcOsQSziV+cBEer1IBFHOCaM4SCkUoMI4DiR2
         KkUC4fyFyAtoRd0/aun22JGTKe+mmdGhpbAS7Cyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jordan Rife <jrife@google.com>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6.1 103/131] libceph: use kernel_connect()
Date:   Mon, 16 Oct 2023 10:41:26 +0200
Message-ID: <20231016084002.623693930@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jordan Rife <jrife@google.com>

commit 7563cf17dce0a875ba3d872acdc63a78ea344019 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ceph/messenger.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -454,8 +454,8 @@ int ceph_tcp_connect(struct ceph_connect
 	set_sock_callbacks(sock, con);
 
 	con_sock_state_connecting(con);
-	ret = sock->ops->connect(sock, (struct sockaddr *)&ss, sizeof(ss),
-				 O_NONBLOCK);
+	ret = kernel_connect(sock, (struct sockaddr *)&ss, sizeof(ss),
+			     O_NONBLOCK);
 	if (ret == -EINPROGRESS) {
 		dout("connect %s EINPROGRESS sk_state = %u\n",
 		     ceph_pr_addr(&con->peer_addr),


