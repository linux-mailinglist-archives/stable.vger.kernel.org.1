Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EF07BFEFF
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 16:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjJJOU6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 10:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjJJOU5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 10:20:57 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3435100
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 07:20:52 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a4c073cc06so56704747b3.1
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 07:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696947652; x=1697552452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L5saximkGAFfDMGoSqxxv3pak34i8pSAVoPDQ6N1HI8=;
        b=DZSeq2C/GS/hYX/fXRUM93mRHcMjbWK1oisT1ra/o56C+YgfYHti9gb19fbesXQsEQ
         cpuTfL/7G8gfq1rLBrQW1r0w3nOtu/vs3Rn30k3ObhAucw5p9tlEZLt698chaVZkAGZq
         jYZJeCWmcxYEqrr952wnQEv+sbWD91FBmihWfNSAP7ZQ5Dw7f8iVGsq+XNt/9MJpCbT/
         aB88I9dR5Q7xp0PM1DO6uWw5VwH6lHrpeNN4OE21GYTBNxYxM57cDgw1GG5nx4+cpVD1
         RO4u9sEANbJlBRWcW+SnTzNta3JwnR4XBmfFbpvkFuKlxp0d8mCnVhfU8zeW/NGrtUNr
         uoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696947652; x=1697552452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5saximkGAFfDMGoSqxxv3pak34i8pSAVoPDQ6N1HI8=;
        b=F3wC/WdUOAkV2tmOTHzCiV+RfCisEOs/72F45ZBfqSzdhEq3KXgq7fylMXCGKAV+n9
         sfA2r9ETSyot9+k8wyrCX2vajF8d7tu0X/7uRHgy+ciS6kWpjqzd0FitLi5ac7Cv/rbh
         tjG1I53qWnGcnDdxovOSE7nJ6IGptFPcTmOAC+k116Rzq980hGOBmz544f/cM7hKSqMU
         tCdYuN1zU+AhbxU+7YT4DovSoLx/FimT4RnaiYof3QBRx2cL+iMPerpG0rbHB7pGTNR5
         HmiA5pblOZRN4oII1cAyB+Q/70AWViksGe9sMoGNhK1lHUfyZuLfnoNXLAD47HfHcZ+y
         tnUQ==
X-Gm-Message-State: AOJu0YxnzXzX+FBOUM8sNEWT8soAuFBMRkcWHqxn07uqjtTBAF3n+Eyx
        6MRKjO1SRpakWuMgoO3E1e9gwmPczcbPT4Gz/lWBeg==
X-Google-Smtp-Source: AGHT+IGqsbf9Cft3GMS6ZzUHyLPHpOdO9coUmpkw9k/ubwVwdymppEUwRE4Aoy8YAOTMVFnJ/zBmoslNaE0gzCGb0uc=
X-Received: by 2002:a25:b30e:0:b0:d89:c969:beee with SMTP id
 l14-20020a25b30e000000b00d89c969beeemr9738349ybj.1.1696947651870; Tue, 10 Oct
 2023 07:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231001194943.658299-1-beanhuo@iokpp.de>
In-Reply-To: <20231001194943.658299-1-beanhuo@iokpp.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Oct 2023 16:20:15 +0200
Message-ID: <CAPDyKFpgPEhVuTbxe5YhYQ0W6907SwJRxSQLB1F2FbVW3zKHxg@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron
 eMMC Q2J54A
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     adrian.hunter@intel.com, beanhuo@micron.com,
        jakub.kwapisz@toradex.com, rafael.beims@toradex.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, 1 Oct 2023 at 21:50, Bean Huo <beanhuo@iokpp.de> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> Micron MTFC4GACAJCN eMMC supports cache but requires that flush cache
> operation be allowed only after a write has occurred. Otherwise, the
> cache flush command or subsequent commands will time out.
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
> Cc: stable@vger.kernel.org
>
> ---
> Changelog:
>
> v3--v4:
>     1. Add helper function for this quirk in drivers/mmc/core/card.h.
>     2. Set card->written_flag only for REQ_OP_WRITE.
> v2--v3:
>     1. Set card->written_flag in mmc_blk_mq_issue_rq().
> v1--v2:
>     1. Add Rafael's test-tag, and Co-developed-by.
>     2. Check host->card whether NULL or not in __mmc_start_request() before asserting host->card->->quirks
> ---
>  drivers/mmc/core/block.c  | 5 ++++-
>  drivers/mmc/core/card.h   | 4 ++++
>  drivers/mmc/core/mmc.c    | 5 +++++
>  drivers/mmc/core/quirks.h | 7 ++++---
>  include/linux/mmc/card.h  | 2 ++
>  5 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 3a8f27c3e310..dfa67d9c80bb 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2381,8 +2381,11 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
>                         }
>                         ret = mmc_blk_cqe_issue_flush(mq, req);
>                         break;
> -               case REQ_OP_READ:
>                 case REQ_OP_WRITE:
> +                       if (mmc_card_broken_cache_flush(card) && !card->written_flag)

It looks superfluous to me to check mmc_card_broken_cache_flush() and
!card->written_flag. Just set the card->written_flag unconditionally.

> +                               card->written_flag = true;
> +                       fallthrough;
> +               case REQ_OP_READ:
>                         if (host->cqe_enabled)
>                                 ret = mmc_blk_cqe_issue_rw_rq(mq, req);
>                         else
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 4edf9057fa79..b7754a1b8d97 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -280,4 +280,8 @@ static inline int mmc_card_broken_sd_cache(const struct mmc_card *c)
>         return c->quirks & MMC_QUIRK_BROKEN_SD_CACHE;
>  }
>
> +static inline int mmc_card_broken_cache_flush(const struct mmc_card *c)
> +{
> +       return c->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH;
> +}
>  #endif
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 89cd48fcec79..47896c32086e 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1929,6 +1929,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>         if (!oldcard)
>                 host->card = card;
>
> +       card->written_flag = false;
> +

How about doing this after a successful flush operation instead? In
other words in _mmc_flush_cache().

>         return 0;
>
>  free_card:
> @@ -2081,6 +2083,9 @@ static int _mmc_flush_cache(struct mmc_host *host)
>  {
>         int err = 0;
>
> +       if (mmc_card_broken_cache_flush(host->card) && !host->card->written_flag)
> +               return err;

return 0;

> +
>         if (_mmc_cache_enabled(host)) {
>                 err = mmc_switch(host->card, EXT_CSD_CMD_SET_NORMAL,
>                                  EXT_CSD_FLUSH_CACHE, 1,
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 32b64b564fb1..5e68c8b4cdca 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -110,11 +110,12 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>                   MMC_QUIRK_TRIM_BROKEN),
>
>         /*
> -        * Micron MTFC4GACAJCN-1M advertises TRIM but it does not seems to
> -        * support being used to offload WRITE_ZEROES.
> +        * Micron MTFC4GACAJCN-1M supports TRIM but does not appear to suppor
> +        * WRITE_ZEROES offloading. It also supports caching, but the cache can
> +        * only be flushed after a write has occurred.
>          */
>         MMC_FIXUP("Q2J54A", CID_MANFID_MICRON, 0x014e, add_quirk_mmc,
> -                 MMC_QUIRK_TRIM_BROKEN),
> +                 MMC_QUIRK_TRIM_BROKEN | MMC_QUIRK_BROKEN_CACHE_FLUSH),
>
>         /*
>          * Kingston EMMC04G-M627 advertises TRIM but it does not seems to
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index daa2f40d9ce6..7b12eebc5586 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -295,7 +295,9 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_HPI   (1<<13)         /* Disable broken HPI support */
>  #define MMC_QUIRK_BROKEN_SD_DISCARD    (1<<14) /* Disable broken SD discard support */
>  #define MMC_QUIRK_BROKEN_SD_CACHE      (1<<15) /* Disable broken SD cache support */
> +#define MMC_QUIRK_BROKEN_CACHE_FLUSH   (1<<16) /* Don't flush cache until the write has occurred */
>
> +       bool                    written_flag;   /* Indicates eMMC has been written since power on */
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
>
>         unsigned int            erase_size;     /* erase size in sectors */
> --
> 2.34.1
>

Kind regards
Uffe
