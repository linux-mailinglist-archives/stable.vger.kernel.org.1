Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2D07B82C4
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 16:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243004AbjJDOxh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 10:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242977AbjJDOxg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 10:53:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F42C4
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 07:53:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F813C433C8;
        Wed,  4 Oct 2023 14:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696431212;
        bh=2oz2WsYL1fZc6GQWEeo3kNxf6EkqtCDNQ3jJhhrUXfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1QGSvBd9Glvj4kOFcTpRbig1Eypbp+Fdn9uL2Ohh4vwAatxEYItEQwSho6nmfkciZ
         8mE1mN/orjQzkdIRPBomg15Xs3o3rihgDEhR8t6eUVDA4y+0jJmDi36Wk0ULEf3H3w
         lUX6iLMzJueQIkHEPo1YrQamPuzEcEq+S3geMSX0=
Date:   Wed, 4 Oct 2023 16:53:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     talex5@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/fs: remove sqe->rw_flags
 checking from LINKAT" failed to apply to 5.15-stable tree
Message-ID: <2023100421-overripe-agony-3977@gregkh>
References: <2023100446-broiler-liquid-20a4@gregkh>
 <2c6fec36-ec1c-418b-a40a-262ed3ce980d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c6fec36-ec1c-418b-a40a-262ed3ce980d@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 04, 2023 at 08:44:23AM -0600, Jens Axboe wrote:
> On 10/4/23 8:33 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x a52d4f657568d6458e873f74a9602e022afe666f
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100446-broiler-liquid-20a4@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Here's one that applies (and works) against 5.15-stable, thanks.

Thanks, now qeued up.

greg k-h
