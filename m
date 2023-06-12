Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C6372BCC8
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 11:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjFLJeB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 05:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjFLJdK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 05:33:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCD75248
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 02:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1940B62230
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 09:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF908C433AE;
        Mon, 12 Jun 2023 09:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686561946;
        bh=B+Q1pJZ83mqVXYXDx2fyRggrICY7qEupSuKiF+VcpM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bYKr3gjBsf3RW04q2VMEM1eMcrihByeoKJYbIgAVKIuJgi1ePhYOCnWEUahF8vDBK
         TPTO70h5VA0kZGl5L7/a6qrhWXdiKOAN3HmcP+1BvyiuRXR2xRl+qGH359Z4aQaFfV
         fXVwh/u4pZCtnCyS9kjlW7ADFwm3RTDWvi9MWp7s=
Date:   Mon, 12 Jun 2023 11:25:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     stable@vger.kernel.org,
        Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: Re: [PATCH for 5.4] rbd: get snapshot context after exclusive lock
 is ensured to be held
Message-ID: <2023061228-dab-doorbell-c1ed@gregkh>
References: <20230611184127.29830-1-idryomov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230611184127.29830-1-idryomov@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jun 11, 2023 at 08:41:27PM +0200, Ilya Dryomov wrote:
> Move capturing the snapshot context into the image request state
> machine, after exclusive lock is ensured to be held for the duration of
> dealing with the image request.  This is needed to ensure correctness
> of fast-diff states (OBJECT_EXISTS vs OBJECT_EXISTS_CLEAN) and object
> deltas computed based off of them.  Otherwise the object map that is
> forked for the snapshot isn't guaranteed to accurately reflect the
> contents of the snapshot when the snapshot is taken under I/O.  This
> breaks differential backup and snapshot-based mirroring use cases with
> fast-diff enabled: since some object deltas may be incomplete, the
> destination image may get corrupted.
> 
> Cc: stable@vger.kernel.org
> Link: https://tracker.ceph.com/issues/61472
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> Reviewed-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
> [idryomov@gmail.com: backport to 5.4: no rbd_img_capture_header(),
>  img_request not embedded in blk-mq pdu]
> ---
>  drivers/block/rbd.c | 41 ++++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 17 deletions(-)

What is the commit id in Linus's tree of this change?

thanks,

greg k-h
