Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F233577A6FD
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 16:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjHMOhM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 10:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjHMOhM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 10:37:12 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C93910FD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 07:37:12 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2b9b458b441so7203391fa.1
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 07:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691937429; x=1692542229;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hypwtTapfC1qAMNrEPsN+b2bz7xO+GFxnp+ydEGm8Ho=;
        b=i0b6f3szn5DXSagCEC+bOrHr+rd2VMEa8oRRhDUrN9mrBIT5WuuDtORcnRrRYn7PIn
         TmqV1HeD3GoWKWQh+oZ5d7Pchr7M7TJUit+QObGILidFTQGFYGBr4XcxlnZcdJM0qnX5
         1Eq5YBSzkDsSAk0VrGODL7V1xDWWz2G5M+hYAigQsaYtCYlpsRbjNSMaWwwqZ8mU6hmm
         k/5+MKHWcz5s48qWccQHCdM3H4pUVGYmXE2Rug7HCTgyu1NA9bGXBdo9EVKvgfvI1YkZ
         RhwGzbYnB5EGNo5XUohgoDNgeVLFsETg8jBH/cY3xh/WkCmbSQ6E8i/vExRxi5W/RrcY
         mBAQ==
X-Gm-Message-State: AOJu0Yx5wrhWZglQLMB0jNjBbpx45NFhdNuxCSZB9suMzy5yPGRBvh1D
        06vJOihh/yLlKAIZaWIpOQ3YhMrxuMM=
X-Google-Smtp-Source: AGHT+IHraw8TrMSVQAIM+IZT7TAlCgjQ+MeHnpIkFSwqUE5zdfKJ+IDIQwXDTU6Szf4xzPYukLgnqg==
X-Received: by 2002:a05:651c:1c6:b0:2bb:7710:1cea with SMTP id d6-20020a05651c01c600b002bb77101ceamr154981ljn.0.1691937429393;
        Sun, 13 Aug 2023 07:37:09 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id w4-20020a1709064a0400b0099cce6f7d50sm4655835eju.64.2023.08.13.07.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 07:37:08 -0700 (PDT)
Message-ID: <28894fc3-2d62-4a48-c538-ee83ec768309@grimberg.me>
Date:   Sun, 13 Aug 2023 17:37:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15.y] nvme-tcp: fix potential unbalanced freeze &
 unfreeze
Content-Language: en-US
From:   Sagi Grimberg <sagi@grimberg.me>
To:     stable@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org
References: <2023081226-oak-cartoon-6115@gregkh>
 <20230813143106.12390-1-sagi@grimberg.me>
In-Reply-To: <20230813143106.12390-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Sorry Greg...

disregard these patches...
Thought that if they apply 6.1.y it would go further...

I'll just send a fresh series for each stable kernel.

On 8/13/23 17:31, Sagi Grimberg wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> Move start_freeze into nvme_tcp_configure_io_queues(), and there is
> at least two benefits:
> 
> 1) fix unbalanced freeze and unfreeze, since re-connection work may
> fail or be broken by removal
> 
> 2) IO during error recovery can be failfast quickly because nvme fabrics
> unquiesces queues after teardown.
> 
> One side-effect is that !mpath request may timeout during connecting
> because of queue topo change, but that looks not one big deal:
> 
> 1) same problem exists with current code base
> 
> 2) compared with !mpath, mpath use case is dominant
> 
> Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/tcp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 1dc7c733c7e3..8d67cdd844f5 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1884,6 +1884,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   		goto out_cleanup_connect_q;
>   
>   	if (!new) {
> +		nvme_start_freeze(ctrl);
>   		nvme_start_queues(ctrl);
>   		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
>   			/*
> @@ -1892,6 +1893,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   			 * to be safe.
>   			 */
>   			ret = -ENODEV;
> +			nvme_unfreeze(ctrl);
>   			goto out_wait_freeze_timed_out;
>   		}
>   		blk_mq_update_nr_hw_queues(ctrl->tagset,
> @@ -1996,7 +1998,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
>   	if (ctrl->queue_count <= 1)
>   		return;
>   	nvme_stop_admin_queue(ctrl);
> -	nvme_start_freeze(ctrl);
>   	nvme_stop_queues(ctrl);
>   	nvme_sync_io_queues(ctrl);
>   	nvme_tcp_stop_io_queues(ctrl);
