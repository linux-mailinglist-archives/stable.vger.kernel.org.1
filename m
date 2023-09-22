Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9A87AB6D9
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 19:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjIVRI6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 13:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjIVRI6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 13:08:58 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Sep 2023 10:08:52 PDT
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED27192;
        Fri, 22 Sep 2023 10:08:52 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id D12FE20718;
        Fri, 22 Sep 2023 19:01:16 +0200 (CEST)
Date:   Fri, 22 Sep 2023 19:01:12 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        beanhuo@micron.com, jakub.kwapisz@toradex.com,
        rafael.beims@toradex.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for
 Micron eMMC Q2J54A
Message-ID: <ZQ3IWOpcSfjVqNYC@francesco-nb.int.toradex.com>
References: <20230921203426.638262-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921203426.638262-1-beanhuo@iokpp.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 21, 2023 at 10:34:26PM +0200, Bean Huo wrote:
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
>  				ret = mmc_blk_cqe_issue_rw_rq(mq, req);
>  			else
>  				ret = mmc_blk_mq_issue_rw_rq(mq, req);
> +
> +			if (host->card->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH &&
> +			    !host->card->written_flag && !ret)
> +				host->card->written_flag = true;

From what I can see this branch is followed for both REQ_OP_READ and
REQ_OP_WRITE, and I would say we want to set this flag only for
REQ_OP_WRITE.

Am I wrong?

Francesco

