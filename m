Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE6375CA1C
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjGUOgI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjGUOgH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:36:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97FEE68
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E0CC61CD0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902DAC433C7;
        Fri, 21 Jul 2023 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689950165;
        bh=lWIumbhH/TpEI9RydyuAP7b9B4SYwKM9yyRTWux5BeE=;
        h=Subject:To:Cc:From:Date:From;
        b=MUtkAWrQW6/zPwPBl8D95Qb6w8ZhvTVhhP0Wykod6afTxvZOct5f2QsI8pdEpkqsS
         J2WSQVu1SGa420krIg1EOlF904MdIAIjauW2I6x0rh7UUzTQc7pks64c1eV5oXN00D
         VjB3mmNCrmsy3deTxmG+93sv/oxZRR1HAr2iGnZk=
Subject: FAILED: patch "[PATCH] mptcp: ensure subflow is unhashed before cleaning the backlog" failed to apply to 6.1-stable tree
To:     pabeni@redhat.com, davem@davemloft.net,
        matthieu.baerts@tessares.net
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:36:03 +0200
Message-ID: <2023072102-finicky-everyday-cce4@gregkh>
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
git cherry-pick -x 3fffa15bfef48b0ad6424779c03e68ae8ace5acb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072102-finicky-everyday-cce4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

3fffa15bfef4 ("mptcp: ensure subflow is unhashed before cleaning the backlog")
57fc0f1ceaa4 ("mptcp: ensure listener is unhashed before updating the sk status")
2a6a870e44dd ("mptcp: stops worker on unaccepted sockets at listener close")
0a3f4f1f9c27 ("mptcp: fix UaF in listener shutdown")
b6985b9b8295 ("mptcp: use the workqueue to destroy unaccepted sockets")
c558246ee73e ("mptcp: add statistics for mptcp socket in use")
cfdcfeed6449 ("mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()")
fec3adfd754c ("mptcp: fix lockdep false positive")
7d803344fdc3 ("mptcp: fix deadlock in fastopen error path")
f8c9dfbd875b ("mptcp: add pm listener events")
f2bb566f5c97 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3fffa15bfef48b0ad6424779c03e68ae8ace5acb Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 4 Jul 2023 22:44:33 +0200
Subject: [PATCH] mptcp: ensure subflow is unhashed before cleaning the backlog

While tacking care of the mptcp-level listener I unintentionally
moved the subflow level unhash after the subflow listener backlog
cleanup.

That could cause some nasty race and makes the code harder to read.

Address the issue restoring the proper order of operations.

Fixes: 57fc0f1ceaa4 ("mptcp: ensure listener is unhashed before updating the sk status")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e892673deb73..489a3defdde5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2909,10 +2909,10 @@ static void mptcp_check_listen_stop(struct sock *sk)
 		return;
 
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+	tcp_set_state(ssk, TCP_CLOSE);
 	mptcp_subflow_queue_clean(sk, ssk);
 	inet_csk_listen_stop(ssk);
 	mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
-	tcp_set_state(ssk, TCP_CLOSE);
 	release_sock(ssk);
 }
 

