Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237CB72FA45
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 12:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbjFNKVR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 06:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjFNKVR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 06:21:17 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E737E5
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 03:21:16 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-78cca1f12e9so813888241.2
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 03:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686738075; x=1689330075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2qZrOytnly1ejGUFC/L6cAaUj5yBbCwAcovYjtM+cgk=;
        b=L4n9Cbk+mYKNRlNdY2e+AtH4a4DZ+guW+oM45WpBTc9pgxWpmWqTujky6/grqvoiBR
         01DLZRGm+W2vl4FYElMYcm1Val+eT3NkCDj+xf0lU67z4gjQHEkbgPKKpEfzSLeZxb9t
         wjvUDi5QQq4DR6xS4ATVX/+Q0CNDg5MZsuo1A/jIuQkoHh/yB8pbE1GUXUVU1oZz+zva
         s5OPKxw/h1+sZzWBWPs4oE6XDfnUw2HMXJ9dRns1DYwZ6p4dH/PQWnv/IOQlgibLwz8s
         /eGk2EJXXM5ej5A5wawKGD+gRvvp6eTLxgu74tN+2OnLY+cYXxZHh2L3y4sCp1VNCKaX
         MB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686738075; x=1689330075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qZrOytnly1ejGUFC/L6cAaUj5yBbCwAcovYjtM+cgk=;
        b=ZByWiUVQOx/NO06vnTBLuLR72jdGYjSAHBBbaOl6/Q5dst42Hy5osgydpOwRycI7dV
         BRyJGBK69tzUsLvhLPiWg6kiRh8nE2mjJk8oUDU9XCNzGFmSLUIQZ1Etu7fa3v04wlNL
         5lG/f6HNUqO4nKebJvFzA5Ggi7KD4iRwX58FFFO6CQfxS9rGn7MJWabfNElWaFxCRRGW
         OYC40at/y6g0aIX13x+zyc44v+mrZoPnMuUPLjM/u6kn5WuaKXjc2QAsiIhhcLHpRaWU
         4tFXAfIT0auJ+WsgYbigaDQnowckvmF0x5AB5KJxZ19VNBgFLn7h9p1s79n1U7/NEXyI
         7sqQ==
X-Gm-Message-State: AC+VfDyXrFhcB1mEXK/6Yh5i+KEzsJ8xsy6+7Vy6VHiRMkbyYTcr9n0E
        dbsslANY8FA3pjLcqTdRlRH2sFVGq6azxkDtqAFEY4uK1M1Q62A/IXw=
X-Google-Smtp-Source: ACHHUZ5xylBU/F/bfRp6ZckOxOos1x+400V4yD64m2X9z9fZpzU4BJiD97isXrHW/TwjQRC37tWgN9d216Pb9MhqO5o=
X-Received: by 2002:a67:f492:0:b0:43b:184d:e880 with SMTP id
 o18-20020a67f492000000b0043b184de880mr7768302vsn.18.1686738075093; Wed, 14
 Jun 2023 03:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <4f6724fd4c60476786a31bcbbf663ccb@hyperstone.com>
In-Reply-To: <4f6724fd4c60476786a31bcbbf663ccb@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 14 Jun 2023 12:20:39 +0200
Message-ID: <CAPDyKFq8Q4J3=udE2=VXAfWZhvJuOYJ=4N9B6NFWUys8oxvb3Q@mail.gmail.com>
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

On Tue, 13 Jun 2023 at 14:43, Christian Loehle <CLoehle@hyperstone.com> wrote:
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
> This is for the 5.15. stable tree
>  drivers/mmc/core/block.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ed034b93cb25..0b72096f10e6 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -265,6 +265,7 @@ static ssize_t power_ro_lock_store(struct device *dev,
>                 goto out_put;
>         }
>         req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_BOOT_WP;
> +       req_to_mmc_queue_req(req)->drv_op_result = -EIO;
>         blk_execute_rq(NULL, req, 0);
>         ret = req_to_mmc_queue_req(req)->drv_op_result;
>         blk_put_request(req);
> @@ -656,6 +657,7 @@ static int mmc_blk_ioctl_cmd(struct mmc_blk_data *md,
>         idatas[0] = idata;
>         req_to_mmc_queue_req(req)->drv_op =
>                 rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
> +       req_to_mmc_queue_req(req)->drv_op_result = -EIO;
>         req_to_mmc_queue_req(req)->drv_op_data = idatas;
>         req_to_mmc_queue_req(req)->ioc_count = 1;
>         blk_execute_rq(NULL, req, 0);
> @@ -725,6 +727,7 @@ static int mmc_blk_ioctl_multi_cmd(struct mmc_blk_data *md,
>         }
>         req_to_mmc_queue_req(req)->drv_op =
>                 rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
> +       req_to_mmc_queue_req(req)->drv_op_result = -EIO;
>         req_to_mmc_queue_req(req)->drv_op_data = idata;
>         req_to_mmc_queue_req(req)->ioc_count = num_of_cmds;
>         blk_execute_rq(NULL, req, 0);
> @@ -2784,6 +2787,7 @@ static int mmc_dbg_card_status_get(void *data, u64 *val)
>         if (IS_ERR(req))
>                 return PTR_ERR(req);
>         req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_CARD_STATUS;
> +       req_to_mmc_queue_req(req)->drv_op_result = -EIO;
>         blk_execute_rq(NULL, req, 0);
>         ret = req_to_mmc_queue_req(req)->drv_op_result;
>         if (ret >= 0) {
> @@ -2822,6 +2826,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
>                 goto out_free;
>         }
>         req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_EXT_CSD;
> +       req_to_mmc_queue_req(req)->drv_op_result = -EIO;
>         req_to_mmc_queue_req(req)->drv_op_data = &ext_csd;
>         blk_execute_rq(NULL, req, 0);
>         err = req_to_mmc_queue_req(req)->drv_op_result;
> --
> 2.37.3
