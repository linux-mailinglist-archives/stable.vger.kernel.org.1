Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23B77D1531
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 19:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377973AbjJTRxS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 13:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377932AbjJTRxR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 13:53:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31B2D55
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 10:53:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E094C433CB;
        Fri, 20 Oct 2023 17:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697824395;
        bh=VFk4jwMoExzsw5xbuyHSs8DCiG8Yo8q+ITBsQMdlYK8=;
        h=Subject:To:Cc:From:Date:From;
        b=Qq7f0ss9AcBXXhpggwF9PqoKYBUyYj8iZ8eOQbgKMOPNS7V6ydwHhqqVsrILDkDOm
         e1xvvJrO1mdwTAHH/r/FL8A8OANLylBUOGQ2R4SPIkqx2BwxVMvkDVLZFzO/Xdq6P4
         vu86vJdydOVR1G2CJ5lTwSWdwn3o1VazYThwBWoY=
Subject: FAILED: patch "[PATCH] nvmet-tcp: Fix a possible UAF in queue intialization setup" failed to apply to 5.4-stable tree
To:     sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, kch@nvidia.com,
        zahavi.alon@gmail.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 19:53:12 +0200
Message-ID: <2023102012-pleat-snippet-29cf@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x d920abd1e7c4884f9ecd0749d1921b7ab19ddfbd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102012-pleat-snippet-29cf@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d920abd1e7c4884f9ecd0749d1921b7ab19ddfbd Mon Sep 17 00:00:00 2001
From: Sagi Grimberg <sagi@grimberg.me>
Date: Mon, 2 Oct 2023 13:54:28 +0300
Subject: [PATCH] nvmet-tcp: Fix a possible UAF in queue intialization setup

From Alon:
"Due to a logical bug in the NVMe-oF/TCP subsystem in the Linux kernel,
a malicious user can cause a UAF and a double free, which may lead to
RCE (may also lead to an LPE in case the attacker already has local
privileges)."

Hence, when a queue initialization fails after the ahash requests are
allocated, it is guaranteed that the queue removal async work will be
called, hence leave the deallocation to the queue removal.

Also, be extra careful not to continue processing the socket, so set
queue rcv_state to NVMET_TCP_RECV_ERR upon a socket error.

Cc: stable@vger.kernel.org
Reported-by: Alon Zahavi <zahavi.alon@gmail.com>
Tested-by: Alon Zahavi <zahavi.alon@gmail.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index cd92d7ddf5ed..197fc2ecb164 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -372,6 +372,7 @@ static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
 
 static void nvmet_tcp_socket_error(struct nvmet_tcp_queue *queue, int status)
 {
+	queue->rcv_state = NVMET_TCP_RECV_ERR;
 	if (status == -EPIPE || status == -ECONNRESET)
 		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	else
@@ -910,15 +911,11 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 	iov.iov_len = sizeof(*icresp);
 	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
 	if (ret < 0)
-		goto free_crypto;
+		return ret; /* queue removal will cleanup */
 
 	queue->state = NVMET_TCP_Q_LIVE;
 	nvmet_prepare_receive_pdu(queue);
 	return 0;
-free_crypto:
-	if (queue->hdr_digest || queue->data_digest)
-		nvmet_tcp_free_crypto(queue);
-	return ret;
 }
 
 static void nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,

