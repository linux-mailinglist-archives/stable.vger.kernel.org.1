Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A30472FA44
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 12:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjFNKVH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 06:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjFNKVH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 06:21:07 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F35E5
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 03:21:02 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bd6446528dcso437650276.2
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 03:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686738061; x=1689330061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3y/Xj2Ca3VwE6RMwHpFnSTSpwSflxnG6R/Pmef/Vv28=;
        b=Uh0Qlp9zwUUyfNi4tq5WrraiQJXITDRf+RnOZYJi8Ut/tvFHsBJE8mrCQ4JS7//roP
         p2yvg077MMiDeJmbbH5RuoofLcg4IA675cjdg6/6kPv4mte9fsWtk++pX1KIjj0g7Nvy
         9x55h1uURGXRKpbllCshH8DYbJRMuxwC46XSTn164ScmEb7lPN43kLDlEi5tL5+mV80P
         7ddFMBmBjWAc82fkzAzISpdmHXjOoIAGei+yVkZH68wNWDNaBzj/1Al9A1Ahky88x/jT
         NdQsZlQLzeLUS5N+NKwqJCiFTGyeYx596/K76a+sd3+Lyhr3D0NU/gv9Udl0qwc6zzQD
         AIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686738061; x=1689330061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3y/Xj2Ca3VwE6RMwHpFnSTSpwSflxnG6R/Pmef/Vv28=;
        b=hr+gmnrZlyTO8+iy/X8V75Wu8tHNJWyAex3T3A3tHa6XMmZ/2LWo4aFF6BWxpdVfWT
         F7gDYwxs+hx9VfSycKM5BvhM9IG08exTh6/t6l3CsAH8Ba8mgrAfReyFc9KH1N5c/79l
         EPjfFUi8PIzBfRMid8JJnW2LpdbonH/h2Mml7uJvF5KOruS2uT6Jxz/fQb9y0RCpycjz
         ytQNNhTt7Tck3RU/+unMaFSSURdA7d4JB3DA8oWcEoiM7u2ibrmGny3/cewAmOR3qcdr
         54O7no0WpryXDerRXteREhxbCbGrlfNJA03tzOh/0CrP60XfjHe7AxX7j8/ar0gImHQI
         HbGA==
X-Gm-Message-State: AC+VfDxM3/dAPAUMvHFR/IcxqDHW9YRKplPsZ/WG3IBydfPir29ISF0E
        +SCYc/dPX7jfPdmaqfzy07OlDjBiZHcL0qF9S0nm4g==
X-Google-Smtp-Source: ACHHUZ48zQmeLtiS8DkMgEyS9pPtR595ZKK5F58gaDFKl7zWM36L79iOsMypmnFYBPW712u6vXweBmZ8cO133MAq27k=
X-Received: by 2002:a25:2c2:0:b0:bc3:ac37:99f4 with SMTP id
 185-20020a2502c2000000b00bc3ac3799f4mr1448761ybc.62.1686738061245; Wed, 14
 Jun 2023 03:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <d83cedabb09c42209f86618917bef7e3@hyperstone.com>
In-Reply-To: <d83cedabb09c42209f86618917bef7e3@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 14 Jun 2023 12:20:25 +0200
Message-ID: <CAPDyKFoi+rfkS9qKqP3J+r5L0Dic-=dwEr5H1xZHQo7ctscSnA@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: ensure error propagation for non-blk
To:     Christian Loehle <CLoehle@hyperstone.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 13 Jun 2023 at 14:37, Christian Loehle <CLoehle@hyperstone.com> wrote:
>
> commit 003fb0a51162d940f25fc35e70b0996a12c9e08a upstream.
>
> Requests to the mmc layer usually come through a block device IO.
> The exceptions are the ioctl interface, RPMB chardev ioctl
> and debugfs, which issue their own blk_mq requests through
> blk_execute_rq and do not query the BLK_STS error but the
> mmcblk-internal drv_op_result. This patch ensures that drv_op_result
> defaults to an error and has to be overwritten by the operation
> to be considered successful.
>
> The behavior leads to a bug where the request never propagates
> the error, e.g. by directly erroring out at mmc_blk_mq_issue_rq if
> mmc_blk_part_switch fails. The ioctl caller of the rpmb chardev then
> can never see an error (BLK_STS_IOERR, but drv_op_result is unchanged)
> and thus may assume that their call executed successfully when it did not.
>
> While always checking the blk_execute_rq return value would be
> advised, let's eliminate the error by always setting
> drv_op_result as -EIO to be overwritten on success (or other error)
>
> Fixes: 614f0388f580 ("mmc: block: move single ioctl() commands to block requests")
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> This is for the following stable trees:
> 4.14
> 4.19
> 5.4
> 5.10
>  drivers/mmc/core/block.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 79e5acc6e964..a6228bfdf3ea 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -243,6 +243,7 @@ static ssize_t power_ro_lock_store(struct device *dev,
>                 goto out_put;
>         }
>         req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_BOOT_WP;
> +       req_to_mmc_queue_req(req)->drv_op_result = -EIO;
>         blk_execute_rq(mq->queue, NULL, req, 0);
>         ret = req_to_mmc_queue_req(req)->drv_op_result;
>         blk_put_request(req);
> @@ -671,6 +672,7 @@ static int mmc_blk_ioctl_cmd(struct mmc_blk_data *md,
>         idatas[0] = idata;
>         req_to_mmc_queue_req(req)->drv_op =
>                 rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
> +       req_to_mmc_queue_req(req)->drv_op_result = -EIO;
>         req_to_mmc_queue_req(req)->drv_op_data = idatas;
>         req_to_mmc_queue_req(req)->ioc_count = 1;
>         blk_execute_rq(mq->queue, NULL, req, 0);
> @@ -741,6 +743,7 @@ static int mmc_blk_ioctl_multi_cmd(struct mmc_blk_data *md,
>         }
>         req_to_mmc_queue_req(req)->drv_op =
>                 rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
> +       req_to_mmc_queue_req(req)->drv_op_result = -EIO;
>         req_to_mmc_queue_req(req)->drv_op_data = idata;
>         req_to_mmc_queue_req(req)->ioc_count = num_of_cmds;
>         blk_execute_rq(mq->queue, NULL, req, 0);
> @@ -2590,6 +2593,7 @@ static int mmc_dbg_card_status_get(void *data, u64 *val)
>         if (IS_ERR(req))
>                 return PTR_ERR(req);
>         req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_CARD_STATUS;
> +       req_to_mmc_queue_req(req)->drv_op_result = -EIO;
>         blk_execute_rq(mq->queue, NULL, req, 0);
>         ret = req_to_mmc_queue_req(req)->drv_op_result;
>         if (ret >= 0) {
> @@ -2628,6 +2632,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
>                 goto out_free;
>         }
>         req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_EXT_CSD;
> +       req_to_mmc_queue_req(req)->drv_op_result = -EIO;
>         req_to_mmc_queue_req(req)->drv_op_data = &ext_csd;
>         blk_execute_rq(mq->queue, NULL, req, 0);
>         err = req_to_mmc_queue_req(req)->drv_op_result;
> --
> 2.37.3
