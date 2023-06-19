Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40548734CA3
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 09:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjFSHqo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 03:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSHqo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 03:46:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADF71B4
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 00:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAEFE60E93
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 07:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F7CC433CA;
        Mon, 19 Jun 2023 07:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687160802;
        bh=Kfuh1AL0YNzxZl8XN6Rmak939iAX5fuq/O1ymHjSIsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LDT7MhBUqvK94b1nSgONlojg10FJiGnOw2KWpoXJoVCuJOC/fjtAGhOAJSZVIwhZF
         3z+75mlFJYCidAh5ciyculSbPzFVe7NJg1sse2TCGE6dpTNxexwKnSypVvVwM1r//9
         lZUqFMvb25PqQK185WDNfx4gHLFKUYqkxi6qAjD0=
Date:   Mon, 19 Jun 2023 09:46:38 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christian Loehle <CLoehle@hyperstone.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] mmc: block: ensure error propagation for non-blk
Message-ID: <2023061927-shrubbery-presuming-5480@gregkh>
References: <4f6724fd4c60476786a31bcbbf663ccb@hyperstone.com>
 <CAPDyKFq8Q4J3=udE2=VXAfWZhvJuOYJ=4N9B6NFWUys8oxvb3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq8Q4J3=udE2=VXAfWZhvJuOYJ=4N9B6NFWUys8oxvb3Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 14, 2023 at 12:20:39PM +0200, Ulf Hansson wrote:
> On Tue, 13 Jun 2023 at 14:43, Christian Loehle <CLoehle@hyperstone.com> wrote:
> >
> > commit 003fb0a51162d940f25fc35e70b0996a12c9e08a upstream.
> >
> > Requests to the mmc layer usually come through a block device IO.
> > The exceptions are the ioctl interface, RPMB chardev ioctl
> > and debugfs, which issue their own blk_mq requests through
> > blk_execute_rq and do not query the BLK_STS error but the
> > mmcblk-internal drv_op_result. This patch ensures that drv_op_result
> > defaults to an error and has to be overwritten by the operation
> > to be considered successful.
> >
> > The behavior leads to a bug where the request never propagates
> > the error, e.g. by directly erroring out at mmc_blk_mq_issue_rq if
> > mmc_blk_part_switch fails. The ioctl caller of the rpmb chardev then
> > can never see an error (BLK_STS_IOERR, but drv_op_result is unchanged)
> > and thus may assume that their call executed successfully when it did not.
> >
> > While always checking the blk_execute_rq return value would be
> > advised, let's eliminate the error by always setting
> > drv_op_result as -EIO to be overwritten on success (or other error)
> >
> > Fixes: 614f0388f580 ("mmc: block: move single ioctl() commands to block requests")
> > Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> 
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> 

All now queued up, thanks.

greg k-h
