Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BA67616F3
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjGYLnx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbjGYLnY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:43:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224C019AD
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:43:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 777BC616A8
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851DBC433C7;
        Tue, 25 Jul 2023 11:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285319;
        bh=wHcwFXoZIfsjldlBg353FN+1Xjd22G9gWveTdorJWIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0JYkqFOPl7rEKBkPn5zera2eVO6aCglAyCtHQlIcrW+lrlWmk4gJ504ta96E1o6NS
         5zutU5qg8TiIa8cnYY1hc4Rd3W3dQshVY2qySO7jGarasJ1QLWvJJ41oCeR5D4gH1U
         MViw6or5YJS3n+rcgyoyPEpijjEbEJoEEhLFWbCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ilya Maximets <i.maximets@ovn.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 155/313] xsk: Honor SO_BINDTODEVICE on bind
Date:   Tue, 25 Jul 2023 12:45:08 +0200
Message-ID: <20230725104527.684051510@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
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

From: Ilya Maximets <i.maximets@ovn.org>

[ Upstream commit f7306acec9aae9893d15e745c8791124d42ab10a ]

Initial creation of an AF_XDP socket requires CAP_NET_RAW capability. A
privileged process might create the socket and pass it to a non-privileged
process for later use. However, that process will be able to bind the socket
to any network interface. Even though it will not be able to receive any
traffic without modification of the BPF map, the situation is not ideal.

Sockets already have a mechanism that can be used to restrict what interface
they can be attached to. That is SO_BINDTODEVICE.

To change the SO_BINDTODEVICE binding the process will need CAP_NET_RAW.

Make xsk_bind() honor the SO_BINDTODEVICE in order to allow safer workflow
when non-privileged process is using AF_XDP.

The intended workflow is following:

  1. First process creates a bare socket with socket(AF_XDP, ...).
  2. First process loads the XSK program to the interface.
  3. First process adds the socket fd to a BPF map.
  4. First process ties socket fd to a particular interface using
     SO_BINDTODEVICE.
  5. First process sends socket fd to a second process.
  6. Second process allocates UMEM.
  7. Second process binds socket to the interface with bind(...).
  8. Second process sends/receives the traffic.

All the steps above are possible today if the first process is privileged
and the second one has sufficient RLIMIT_MEMLOCK and no capabilities.
However, the second process will be able to bind the socket to any interface
it wants on step 7 and send traffic from it. With the proposed change, the
second process will be able to bind the socket only to a specific interface
chosen by the first process at step 4.

Fixes: 965a99098443 ("xsk: add support for bind for Rx")
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Link: https://lore.kernel.org/bpf/20230703175329.3259672-1-i.maximets@ovn.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/networking/af_xdp.rst | 9 +++++++++
 net/xdp/xsk.c                       | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index 7a4caaaf3a179..09b3943b3b719 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -378,6 +378,15 @@ start N bytes into the buffer leaving the first N bytes for the
 application to use. The final option is the flags field, but it will
 be dealt with in separate sections for each UMEM flag.
 
+SO_BINDTODEVICE setsockopt
+--------------------------
+
+This is a generic SOL_SOCKET option that can be used to tie AF_XDP
+socket to a particular network interface.  It is useful when a socket
+is created by a privileged process and passed to a non-privileged one.
+Once the option is set, kernel will refuse attempts to bind that socket
+to a different interface.  Updating the value requires CAP_NET_RAW.
+
 XDP_STATISTICS getsockopt
 -------------------------
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 2bc0d6e3e124c..d04a2345bc3f5 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -613,6 +613,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	struct sock *sk = sock->sk;
 	struct xdp_sock *xs = xdp_sk(sk);
 	struct net_device *dev;
+	int bound_dev_if;
 	u32 flags, qid;
 	int err = 0;
 
@@ -626,6 +627,10 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 		      XDP_USE_NEED_WAKEUP))
 		return -EINVAL;
 
+	bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
+	if (bound_dev_if && bound_dev_if != sxdp->sxdp_ifindex)
+		return -EINVAL;
+
 	rtnl_lock();
 	mutex_lock(&xs->mutex);
 	if (xs->state != XSK_READY) {
-- 
2.39.2



