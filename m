Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB687B6EE0
	for <lists+stable@lfdr.de>; Tue,  3 Oct 2023 18:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbjJCQqp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 3 Oct 2023 12:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjJCQqo (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Oct 2023 12:46:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E749E
        for <stable@vger.kernel.org>; Tue,  3 Oct 2023 09:46:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE218C433C7;
        Tue,  3 Oct 2023 16:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696351600;
        bh=b9xYQ/SIeRx1steUhZNvfdYjdKSQQNxP5+nQLygoX8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eis379LSrq4moB6PeZW1RvAM4nhf0sZKfGfS3cT0rK95JV6R/CGaRr8qFu1aVUFAv
         2j34VOtmyC12+JgmRgtoZAB7ILlBAt9i66WpxuDKol2q+ozw+BwLnonx0y2OeyM1ss
         Ow+qqzB+OHQfuoXujya8AA8Ui3j5w2iIY251ByO2wkC5JxjTLfgbL3B2gt0Z2uWxUq
         G88Q8VARki+3hHa8tl3rWmSYAymOI0RN8mQw6nrpXE2G3GwfiDJJvqKgQZIRJStemV
         AXmIjwo9mABdKrd3v8UZXnPpONgWF57z1h+YIkVo1yLky67eiBc19PqntINn8fkYE9
         KK0mNobKeWoaQ==
From:   sj@kernel.org
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        zahavi.alon@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: Fix a possible UAF in queue intialization setup
Date:   Tue,  3 Oct 2023 16:46:37 +0000
Message-Id: <20231003164638.2526-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002105428.226515-1-sagi@grimberg.me>
References: 
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

Hello,

On Mon, 2 Oct 2023 13:54:28 +0300 Sagi Grimberg <sagi@grimberg.me> wrote:

> From Alon:
> "Due to a logical bug in the NVMe-oF/TCP subsystem in the Linux kernel,
> a malicious user can cause a UAF and a double free, which may lead to
> RCE (may also lead to an LPE in case the attacker already has local
> privileges)."
> 
> Hence, when a queue initialization fails after the ahash requests are
> allocated, it is guaranteed that the queue removal async work will be
> called, hence leave the deallocation to the queue removal.
> 
> Also, be extra careful not to continue processing the socket, so set
> queue rcv_state to NVMET_TCP_RECV_ERR upon a socket error.
> 
> Reported-by: Alon Zahavi <zahavi.alon@gmail.com>
> Tested-by: Alon Zahavi <zahavi.alon@gmail.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Would it be better to add Fixes: and Cc: stable lines?


Thanks,
SJ

> ---
>  drivers/nvme/target/tcp.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 97d07488072d..d840f996eb82 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -372,6 +372,7 @@ static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
>  
>  static void nvmet_tcp_socket_error(struct nvmet_tcp_queue *queue, int status)
>  {
> +	queue->rcv_state = NVMET_TCP_RECV_ERR;
>  	if (status == -EPIPE || status == -ECONNRESET)
>  		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
>  	else
> @@ -910,15 +911,11 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
>  	iov.iov_len = sizeof(*icresp);
>  	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
>  	if (ret < 0)
> -		goto free_crypto;
> +		return ret; /* queue removal will cleanup */
>  
>  	queue->state = NVMET_TCP_Q_LIVE;
>  	nvmet_prepare_receive_pdu(queue);
>  	return 0;
> -free_crypto:
> -	if (queue->hdr_digest || queue->data_digest)
> -		nvmet_tcp_free_crypto(queue);
> -	return ret;
>  }
>  
>  static void nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
> -- 
> 2.41.0
> 
> 
