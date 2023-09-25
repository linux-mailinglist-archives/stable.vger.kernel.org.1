Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AE47AD9B3
	for <lists+stable@lfdr.de>; Mon, 25 Sep 2023 16:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjIYOHS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 25 Sep 2023 10:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjIYOHR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 25 Sep 2023 10:07:17 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2B0CE
        for <stable@vger.kernel.org>; Mon, 25 Sep 2023 07:07:11 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d862533ea85so5613271276.0
        for <stable@vger.kernel.org>; Mon, 25 Sep 2023 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695650830; x=1696255630; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pbeInWKlUN3Z2QQBrR4UtpzNoToZLCsYpJRewAj23h8=;
        b=u6KT1EOy4DnS7okQTzXwROIFx2P8jddoRYL+AKF9JeJKCFdlFeZ1mz8ZmqzNoLjtKA
         1ux1WoOTPuvTMB1EZXr982mOOOxj89bC+SNRrFWtB6IMGJwqLENeWovlgeyBmFmLK5Kl
         GzP9/9gPBmw3qe50jgBsnCdJg93PAeo1LkNWWoCoZwsfW/YBQKL6nG8xgTgC9N0Yvgrf
         Mcb/Xn4/3CZlxmfxiFXkTA5rCT4l6YY5lLu92g5buyRh0nSGfFdFdKu7aeR65y04P0YM
         aS7BAVKv+jRpsxdkT9SRanDPGkqXjNIYAVkKMWI72p9C2PCNq1cUtjir5+H0mLLdK53n
         q/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695650830; x=1696255630;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbeInWKlUN3Z2QQBrR4UtpzNoToZLCsYpJRewAj23h8=;
        b=TZvTDw1emUHlj75yAIu0E79KJ6p9BmW0Ex2HtRjS55EvkXvZWVyiRdqC0bddWOUssC
         /U57zbkGdh0xWF20biL10rUmM8n+OIMLXeERCI4Jl2wYCmU01sFHxw3RdcU2+5/6uPdR
         Nrsok8uyGDrl6x2K7zPEdcq4T5rXVSbbopwnwC/KYVpXURTOH38Mr7QuKQTG1lyt3P8p
         eCC5b+s67Dppre2XShtam0WDmRiiO7eH9z7kNmczP20Kp61LyjaJahE+ajYcLGEbChF7
         H2hkHPhDbG37SiCXO5CXw2fo5UsfWTfrJ+XPWS1RozStLcJWLhTtS4wh/XCjIu2RnwZ+
         XSUQ==
X-Gm-Message-State: AOJu0YzG+VqUDetbcOYFPqwH7kOctB3p3JHkvZYmwu3q6PX/N33oXM9B
        +g89SGmQpvHT3pLKdjay8l1hzT8XDNaW6dR9lmFNtw==
X-Google-Smtp-Source: AGHT+IGybh6b+QMCWVSNtS3PoG9odUy0INJ8lN7t0nCkj2GqRCzX4hr4FBHQ6scP86ZT8zt2NFX8jVlVz6abd2tcvGs=
X-Received: by 2002:a25:ce4c:0:b0:d80:9ef:928e with SMTP id
 x73-20020a25ce4c000000b00d8009ef928emr5922448ybe.33.1695650830416; Mon, 25
 Sep 2023 07:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230921203426.638262-1-beanhuo@iokpp.de>
In-Reply-To: <20230921203426.638262-1-beanhuo@iokpp.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 Sep 2023 16:06:34 +0200
Message-ID: <CAPDyKFqN9xASjqJWmjtkTGdYEG0AauMzCVkR7VJ10Va0oF-B4w@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron
 eMMC Q2J54A
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     adrian.hunter@intel.com, beanhuo@micron.com,
        jakub.kwapisz@toradex.com, rafael.beims@toradex.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 21 Sept 2023 at 22:35, Bean Huo <beanhuo@iokpp.de> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> Micron MTFC4GACAJCN eMMC supports cache but requires that flush cache
> operation be allowed only after a write has occurred. Otherwise, the
> cache flush command or subsequent commands will time out.
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> Co-developed-by: Rafael Beims <rafael.beims@toradex.com>
> Cc: stable@vger.kernel.org
> ---
> Changelog:
>
> v2--v3:
>     1. Set card->written_flag in mmc_blk_mq_issue_rq().
> v1--v2:
>     1. Add Rafael's test-tag, and Co-developed-by.
>     2. Check host->card whether NULL or not in __mmc_start_request() before asserting host->card->->quirks
> ---
>  drivers/mmc/core/block.c  | 4 ++++
>  drivers/mmc/core/mmc.c    | 5 +++++
>  drivers/mmc/core/quirks.h | 7 ++++---
>  include/linux/mmc/card.h  | 2 ++
>  4 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 3a8f27c3e310..14d0dc7942de 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2387,6 +2387,10 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
>                                 ret = mmc_blk_cqe_issue_rw_rq(mq, req);
>                         else
>                                 ret = mmc_blk_mq_issue_rw_rq(mq, req);
> +
> +                       if (host->card->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH &&

Please add an inline helper function for this in
drivers/mmc/core/card.h, along with the others.

[...]

Kind regards
Uffe
