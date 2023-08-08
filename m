Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA96774578
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 20:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbjHHSml (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 14:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjHHSmT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 14:42:19 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4C832135
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 09:33:05 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-56c711a88e8so3950471eaf.2
        for <stable@vger.kernel.org>; Tue, 08 Aug 2023 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691512347; x=1692117147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s++4blSxMjulxr4WqQlajWQp+reqB47xPJw4qPYyIJs=;
        b=O8ECM+9UqIXUmMSXDK2fhOEVIDTBbwYbfwt0V/rIu3Npgn3KR7lmtvqD+mf5THe/SJ
         dlrd9IOJcCibjaixNZSgh/VQwnXw2Etv7X+WNRNKCipnZ+Ek6VrDhVDHvnzdTQPdGK7y
         SEWduC0zSmsVHmS5PYb1NH9hme5JfyPBIXFyGcdW7xqvARfXRQC/PZH08IOcMuwBN5Y6
         TfgRjnBUivX7jpI1uNbfT+K2h4SnuzoXXZKsfRrfxijT0/S50EUXvBWp+IULFs7M7loo
         QTUC6EDZcXlDSYKkoGBZjjedOG3ui+yecDT+SmmxcUfAph7OeVyMCzxLoUzYfkH0VUq1
         KVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512347; x=1692117147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s++4blSxMjulxr4WqQlajWQp+reqB47xPJw4qPYyIJs=;
        b=g94a1q1zy0QsH4bGXDY5LrD+LGcIBLz1zRwtFKv7mEm1uIM7n4X2/KLnZF1RohzMVb
         F3orq5+V4P7aompdWFJMVzt5xiIuFCHSum1djASw168xprtNChMhDBWlPmtLFxuwW+tn
         ZG6NjKGvZ29tfh5KuqpABcnnAHLhZApXs+hVc3+b7wWz9ydRbzDTjh0i1NhKVUUsuIjX
         F4OrvxFzYQW03BVhpJxCeOUNvc60JPSn3iX2Tk4uaKZZBw+n0mS5/Yoy/ISegnm6rB4A
         FPFUN4mHbbHymJHQBAJTBfQSE9CeQhlPbrq02bYTxqa/p3dX+rvLOL4G4ZdWZWJBF1Mf
         n4PA==
X-Gm-Message-State: AOJu0Yy8Jo8EJRerAfsOIp4wh6mxo2J0X5XkY1u+Zlx7u4mCtIDPiXmT
        7KaZScsjf4Q9YfqsnoLOecA2cBKfdFgH2gBZ387aM9MKj20ofISk
X-Google-Smtp-Source: AGHT+IGGcAj42nyoezAnxw/gRQ5a8aT9hrh74ET1epNHdpkHqryPud6eA2qTIgp9XEhLBjrOsYxl27ezpR/VAqMtR6k=
X-Received: by 2002:a25:6943:0:b0:ce8:42b6:46f9 with SMTP id
 e64-20020a256943000000b00ce842b646f9mr15212913ybc.45.1691491995143; Tue, 08
 Aug 2023 03:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230802023023.1318134-1-yunlong.xing@unisoc.com>
In-Reply-To: <20230802023023.1318134-1-yunlong.xing@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 12:52:39 +0200
Message-ID: <CAPDyKFr1ts4yE3it=+fFsvQaSPTa=R01yobaNVhHfRh4nRicow@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: block: Fix in_flight[issue_type] value error
To:     Yunlong Xing <yunlong.xing@unisoc.com>
Cc:     adrian.hunter@intel.com, CLoehle@hyperstone.com,
        brauner@kernel.org, hare@suse.de, asuk4.q@gmail.com,
        avri.altman@wdc.com, beanhuo@micron.com, linus.walleij@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, hongyu.jin@unisoc.com,
        zhiguo.niu@unisoc.com, yunlong.xing23@gmail.com,
        yibin.ding@unisoc.com, dongliang.cui@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 2 Aug 2023 at 04:33, Yunlong Xing <yunlong.xing@unisoc.com> wrote:
>
> From: Yibin Ding <yibin.ding@unisoc.com>
>
> For a completed request, after the mmc_blk_mq_complete_rq(mq, req)
> function is executed, the bitmap_tags corresponding to the
> request will be cleared, that is, the request will be regarded as
> idle. If the request is acquired by a different type of process at
> this time, the issue_type of the request may change. It further
> caused the value of mq->in_flight[issue_type] to be abnormal,
> and a large number of requests could not be sent.
>
> p1:                                           p2:
> mmc_blk_mq_complete_rq
>   blk_mq_free_request
>                                               blk_mq_get_request
>                                                 blk_mq_rq_ctx_init
> mmc_blk_mq_dec_in_flight
>   mmc_issue_type(mq, req)
>
> This strategy can ensure the consistency of issue_type
> before and after executing mmc_blk_mq_complete_rq.
>
> Fixes: 81196976ed94 ("mmc: block: Add blk-mq support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> changes of v2: Sort local declarations in descending order of
> line length
> ---
>  drivers/mmc/core/block.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index f701efb1fa78..b6f4be25b31b 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2097,14 +2097,14 @@ static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
>         mmc_blk_urgent_bkops(mq, mqrq);
>  }
>
> -static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
> +static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, enum mmc_issue_type issue_type)
>  {
>         unsigned long flags;
>         bool put_card;
>
>         spin_lock_irqsave(&mq->lock, flags);
>
> -       mq->in_flight[mmc_issue_type(mq, req)] -= 1;
> +       mq->in_flight[issue_type] -= 1;
>
>         put_card = (mmc_tot_in_flight(mq) == 0);
>
> @@ -2117,6 +2117,7 @@ static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
>  static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req,
>                                 bool can_sleep)
>  {
> +       enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
>         struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>         struct mmc_request *mrq = &mqrq->brq.mrq;
>         struct mmc_host *host = mq->card->host;
> @@ -2136,7 +2137,7 @@ static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req,
>                         blk_mq_complete_request(req);
>         }
>
> -       mmc_blk_mq_dec_in_flight(mq, req);
> +       mmc_blk_mq_dec_in_flight(mq, issue_type);
>  }
>
>  void mmc_blk_mq_recovery(struct mmc_queue *mq)
> --
> 2.25.1
>
