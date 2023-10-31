Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EC47DCC28
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 12:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344060AbjJaLxB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 07:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344044AbjJaLxB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 07:53:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7913397
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 04:52:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED8EC433C8;
        Tue, 31 Oct 2023 11:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698753179;
        bh=W1/3ykyfJPdF32WO5xeLaT+d+Pt4ikd6smaQfM7je2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VZs/O64KjteS2hVm/9EanLCY4BhQbgML9T335wpcGUllZEcqyuXcTRinES1FFq16M
         W7Nh9tBobY7FVycN5OttQl+wZ44rOzYfemeFvTWSYWIFcRYhN9+M5gN6Y39c0bZD+y
         pkNdwPVgHB0AZTmPCVrtYyKgZmNN2TKuoFyackI8=
Date:   Tue, 31 Oct 2023 12:52:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] nfsd: lock_rename() needs both
 directories to live on the" failed to apply to 5.4-stable tree
Message-ID: <2023103148-taste-bazooka-5f6f@gregkh>
References: <2023102701-cadet-groovy-9672@gregkh>
 <20231028015032.GO800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028015032.GO800259@ZenIV>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Oct 28, 2023 at 02:50:32AM +0100, Al Viro wrote:
> On Fri, Oct 27, 2023 at 02:18:01PM +0200, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.4-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Trivial context change in that one, really.  The if (...) following the
> second chunk has changed; git cherry-pick is unhappy about it.  See below
> for rebased diff (identical to the original except for the post-chunk
> context):

Thanks, all now queued up.

greg k-h
