Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6707170322A
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242497AbjEOQGl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242484AbjEOQGk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:06:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E634830E3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:06:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CED4626D5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3B9C4339B;
        Mon, 15 May 2023 16:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684166768;
        bh=pzmeoheS/FFaE7ErQiSxJTxI+0lbm6CGIGbULZ1NUmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eZBFwzDLmt8VxVir+pMiyJyDOEDy5PkGb37x8Tda+3rZNqmGRkYLPgZy7JAzBGIVE
         t5C1h+nqVJ/7wGr66lwpc9IRRFIRLnvDn4S5FAo76Xui6rXHwG5WcW2dmTaQve9KOh
         MqpdRiQkeV/mWoAD9bDuPP2uZkWA6uF7/YLsCLS4=
Date:   Mon, 15 May 2023 18:06:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     stable@vger.kernel.org, John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 5.10.y] printk: declare printk_deferred_{enter,safe}() in
 include/linux/printk.h
Message-ID: <2023051501-mockup-override-c57e@gregkh>
References: <2023042446-gills-morality-d566@gregkh>
 <767ab028-d946-98d5-4a13-d6ed6df77763@I-love.SAKURA.ne.jp>
 <2023051537-embargo-scouting-a849@gregkh>
 <7f66845a-d27f-f1c8-fccf-91cd3be95024@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f66845a-d27f-f1c8-fccf-91cd3be95024@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 15, 2023 at 10:11:33PM +0900, Tetsuo Handa wrote:
> On 2023/05/15 21:56, Greg Kroah-Hartman wrote:
> > On Sun, May 14, 2023 at 01:41:27PM +0900, Tetsuo Handa wrote:
> >> commit 85e3e7fbbb720b9897fba9a99659e31cbd1c082e upstream.
> >>
> >> [This patch implements subset of original commit 85e3e7fbbb72 ("printk:
> >> remove NMI tracking") where commit 1007843a9190 ("mm/page_alloc: fix
> >> potential deadlock on zonelist_update_seq seqlock") depends on, for
> >> commit 3d36424b3b58 ("mm/page_alloc: fix race condition between
> >> build_all_zonelists and page allocation") was backported to stable.]
> > 
> > All now queued up, thanks.
> 
> Thank you. Then, please also queue original "[PATCH] mm/page_alloc: fix potential
> deadlock on zonelist_update_seq" (Message ID listed below) to stable kernels.
> 
>   <2023042446-gills-morality-d566@gregkh>
>   <2023042449-wobbling-putdown-13ea@gregkh>
>   <2023042452-stopper-engross-e9da@gregkh>
>   <2023042455-skinless-muzzle-1c50@gregkh>
> 

Now done, thanks.

greg k-h
