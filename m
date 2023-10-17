Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFE07CBCA0
	for <lists+stable@lfdr.de>; Tue, 17 Oct 2023 09:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbjJQHox (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 03:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbjJQHox (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 03:44:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7ABAB
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 00:44:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDD4C433C8;
        Tue, 17 Oct 2023 07:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697528691;
        bh=IKkqAiLqo77VoP7MsS8FB81MMDg9+jCwbuhgq0PsJYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MDgAWEwTh82mLOhVATxJQxkS3qE3MfV/pzT6X6OhEloyh+/ggozg9c7XbrGmEJQoD
         VxIf6RVyC7H/emuFI7Z2NuUclUcMzoauODHwL+73TsZjMWGRtUdJmhURrSUNnuNxEP
         h1+HZubhNBnUcH9nUr6WrhbU8BG0DLbOv6M46wrc=
Date:   Tue, 17 Oct 2023 09:44:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shyam Prasad N <nspmangalore@gmail.com>
Cc:     Stable <stable@vger.kernel.org>, Steve French <smfrench@gmail.com>
Subject: Re: [request for patch inclusion to 5.15 stable] cifs: fix mid leak
 during reconnection after timeout threshold
Message-ID: <2023101757-dilation-femur-91b8@gregkh>
References: <CANT5p=rReboKPbEySnZsFAn8Zv2ZzgQQ8LhyTxkt538QgyxB7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANT5p=rReboKPbEySnZsFAn8Zv2ZzgQQ8LhyTxkt538QgyxB7A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 17, 2023 at 11:43:26AM +0530, Shyam Prasad N wrote:
> Hi Greg,
> 
> It recently came to my attention that this patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/?id=69cba9d3c1284e0838ae408830a02c4a063104bc
> [Upstream commit 69cba9d3c1284e0838ae408830a02c4a063104bc]
> ... which is marked with Fixes tag for a change that went into 5.9
> kernel, was taken into 6.4 and 6.1 stable trees.
> However, I do not see this in the 5.15 stable tree.
> 
> I got emails about this fix being taken to the 6.4 and 6.1 stable. But
> I do not see any communication about 5.15 kernel.
> 
> Was this missed? Or is there something in the process that I missed?
> Based on the kernel documentation about commit tags, I assumed that
> for commits that have the "Fixes: " tag, it was not necessary to add
> the "CC: stable" as well.
> Please let me know if that understanding is wrong.

That understanding is wrong, and has never been the case.  Please see:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

We just have been sweeping the tree at times to pick up the patches
where people only put Fixes: tags.  And then we do a "best effort" type
of backporting.

Odds are this commit does not apply to any older kernels, and yes, I
just tried and it did not apply to 5.15 at all.  Please provide a
working backport.

> Regarding this particular fix, I discussed this with Steve, and he
> agrees that this fix needs to go into all stable kernels as well.

Great, please provide working backports and we will be glad to queue
them up.

And in the future, please properly mark your patches with cc: stable if
you want to see them applied, AND for you to get FAILED notices if they
do not apply as far back as you are asking them to be sent to.

thanks,

greg k-h
