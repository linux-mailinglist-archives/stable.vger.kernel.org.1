Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B10B75CA23
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjGUOg0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjGUOgY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:36:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A8D30C4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:36:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D8CC61CD7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D204C433C8;
        Fri, 21 Jul 2023 14:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689950182;
        bh=/VBJm+HkxoXSWLCIhFBf45RvJXW/Hyp7ItXwkFUMHBc=;
        h=Subject:To:Cc:From:Date:From;
        b=1YxalETMPnVmrkehsrkvJm5KV8iAgt7CgysXJFT/8rL/x4Eh97UqlQr/pRJSOb8a+
         bUMhyoOfYB/Di2/G3LredqGp0EqSMMjBkl3O7dx1uPLGdZevy2UpfnyV8wVirY2/te
         Lbf+DNbzQU8AprbzVBEle0u/hvq6Q0PGXmhOSEOc=
Subject: FAILED: patch "[PATCH] mptcp: do not rely on implicit state check in mptcp_listen()" failed to apply to 6.1-stable tree
To:     pabeni@redhat.com, cpaasch@apple.com, davem@davemloft.net,
        matthieu.baerts@tessares.net
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:36:20 +0200
Message-ID: <2023072119-skipping-penalize-15f0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 0226436acf2495cde4b93e7400e5a87305c26054
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072119-skipping-penalize-15f0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

0226436acf24 ("mptcp: do not rely on implicit state check in mptcp_listen()")
cfdcfeed6449 ("mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0226436acf2495cde4b93e7400e5a87305c26054 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 4 Jul 2023 22:44:34 +0200
Subject: [PATCH] mptcp: do not rely on implicit state check in mptcp_listen()

Since the blamed commit, closing the first subflow resets the first
subflow socket state to SS_UNCONNECTED.

The current mptcp listen implementation relies only on such
state to prevent touching not-fully-disconnected sockets.

Incoming mptcp fastclose (or paired endpoint removal) unconditionally
closes the first subflow.

All the above allows an incoming fastclose followed by a listen() call
to successfully race with a blocking recvmsg(), potentially causing the
latter to hit a divide by zero bug in cleanup_rbuf/__tcp_select_window().

Address the issue explicitly checking the msk socket state in
mptcp_listen(). An alternative solution would be moving the first
subflow socket state update into mptcp_disconnect(), but in the long
term the first subflow socket should be removed: better avoid relaying
on it for internal consistency check.

Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/414
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 489a3defdde5..3613489eb6e3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3703,6 +3703,11 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	pr_debug("msk=%p", msk);
 
 	lock_sock(sk);
+
+	err = -EINVAL;
+	if (sock->state != SS_UNCONNECTED || sock->type != SOCK_STREAM)
+		goto unlock;
+
 	ssock = __mptcp_nmpc_socket(msk);
 	if (IS_ERR(ssock)) {
 		err = PTR_ERR(ssock);

