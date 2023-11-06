Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B419D7E2486
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjKFNWr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjKFNWr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:22:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C78FA9
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:22:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14C0C433C7;
        Mon,  6 Nov 2023 13:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276964;
        bh=o8n1i2Sn6oL+fcbaIOeJlxb7/B9GJquWlWHZULJt+is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jAZpPumvo1TCLcwxqcdFH8LgwNyn6GPy7q+m/msnijiTXmOyhEMWsm/Y4Bgpi2ek1
         dKiRzQVndpKmjTyR+jb7F/F/Bqg2rYemo/CsZ9RCsmZaeLVJgcA+NC2uk+h+wGj4eB
         Y2S34LzF0fys4x7KHVjfP0vQSESKqFd4JtAqwvwU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alon Zahavi <zahavi.alon@gmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch <kbusch@kernel.org>,
        Dragos-Marian Panait <dragos.panait@windriver.com>
Subject: [PATCH 5.4 67/74] nvmet-tcp: Fix a possible UAF in queue intialization setup
Date:   Mon,  6 Nov 2023 14:04:27 +0100
Message-ID: <20231106130303.993818732@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.687882731@linuxfoundation.org>
References: <20231106130301.687882731@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sagi Grimberg <sagi@grimberg.me>

commit d920abd1e7c4884f9ecd0749d1921b7ab19ddfbd upstream.

>From Alon:
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
Signed-off-by: Dragos-Marian Panait <dragos.panait@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/target/tcp.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -323,6 +323,7 @@ static void nvmet_tcp_fatal_error(struct
 
 static void nvmet_tcp_socket_error(struct nvmet_tcp_queue *queue, int status)
 {
+	queue->rcv_state = NVMET_TCP_RECV_ERR;
 	if (status == -EPIPE || status == -ECONNRESET)
 		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	else
@@ -828,15 +829,11 @@ static int nvmet_tcp_handle_icreq(struct
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


