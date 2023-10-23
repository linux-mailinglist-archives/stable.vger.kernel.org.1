Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ADC7D3369
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjJWLaE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbjJWLaD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:30:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2472DDB
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:30:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B300C433C7;
        Mon, 23 Oct 2023 11:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060599;
        bh=SA24MIPuwVcSz/U2Cf24E6+TvY/bdIJ3qMWJuMDud7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EoGo6y8Cr3l8D40ERlFee6XrKWWUyZrA2dKX3yC952eOwv4fdWPy7+itZDaYWv6Hj
         eUTpJSmzLvysk31059AncpFv1W6Waw9it3DEZquCuqwH573j/T/jmEYoZjmrWY3DLL
         dTWmjaFAM5gsN7Q2DwiLcI+QnnVEyTeVEx6YUWXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jordan Rife <jrife@google.com>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5.4 029/123] libceph: use kernel_connect()
Date:   Mon, 23 Oct 2023 12:56:27 +0200
Message-ID: <20231023104818.717888287@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -477,8 +477,8 @@ static int ceph_tcp_connect(struct ceph_
 	dout("connect %s\n", ceph_pr_addr(&con->peer_addr));
 
 	con_sock_state_connecting(con);
-	ret = sock->ops->connect(sock, (struct sockaddr *)&ss, sizeof(ss),
-				 O_NONBLOCK);
+	ret = kernel_connect(sock, (struct sockaddr *)&ss, sizeof(ss),
+			     O_NONBLOCK);
 	if (ret == -EINPROGRESS) {
 		dout("connect %s EINPROGRESS sk_state = %u\n",
 		     ceph_pr_addr(&con->peer_addr),


