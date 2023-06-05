Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C87772306F
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 21:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbjFETvs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 15:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbjFETvV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 15:51:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93E7E5C
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 12:50:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05D9C62A13
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 19:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176D5C4331D;
        Mon,  5 Jun 2023 19:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685994603;
        bh=zDdAsvvsg1qUtwnccHAkNGoM8TJHqL8zGc+p2rxxG0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hP0BdsApE6bOSx9/xD4rb6NSfIwd/Q/n67ibC1b7FCo0Na2U4CYsQzLBEFIYnm+Li
         UiZcjszZ8aGcL5OMcaNsvZCoQf1QBVnNwxePdHHGI6qPTGTCchIZALcdFp70qZqcpf
         r50NorGc3iE/7OSBoGnw7YaYwxbKMkIPUSmQCfNE=
Date:   Mon, 5 Jun 2023 21:50:01 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Christian Loehle <CLoehle@hyperstone.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] mmc: block: ensure error propagation for non-blk
Message-ID: <2023060547-wildfowl-courier-9373@gregkh>
References: <a70f433fd7754c83a7f5eda86d1cc31d@hyperstone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a70f433fd7754c83a7f5eda86d1cc31d@hyperstone.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 05, 2023 at 01:46:16PM +0000, Christian Loehle wrote:
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
> ---
>  drivers/mmc/core/block.c | 5 +++++
>  1 file changed, 5 insertions(+)

What stable tree(s) do you want this applied to?

thanks,

greg k-h
