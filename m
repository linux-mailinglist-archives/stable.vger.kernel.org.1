Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0FC79B03C
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348517AbjIKV1I (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238382AbjIKNzH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:55:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFFECD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:55:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349C9C433C9;
        Mon, 11 Sep 2023 13:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440501;
        bh=ljzwRkyqmbgqNAW1gkceF3WRm9XEP5FoHRGIULX2ezE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+GuM2Vyw53dIVIT55eyxzynuDZ6C0vB7LuCabna4GQc1iJHqKsAnimI+GSY0q6FJ
         so7BHe6S6+pFoom0HwzGZxfSStJLfByqFbgLUhTh3q2u7ksSlIa7Ohp9v3bvJgWqpz
         WUqUTeQhyf36A+/ynoHhf8or9vDuX4ws/OoUJu/M=
Date:   Mon, 11 Sep 2023 15:54:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Donald Buczek <buczek@molgen.mpg.de>
Cc:     stable@vger.kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        David Ahern <dsahern@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH 5.15 052/107] Remove DECnet support from kernel
Message-ID: <2023091117-unripe-ceremony-c29a@gregkh>
References: <20230619102141.541044823@linuxfoundation.org>
 <20230619102143.987013167@linuxfoundation.org>
 <6084b5fc-577c-468a-a28e-e0ccc530ed9e@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6084b5fc-577c-468a-a28e-e0ccc530ed9e@molgen.mpg.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Sep 11, 2023 at 03:47:01PM +0200, Donald Buczek wrote:
> On 6/19/23 12:30 PM, Greg Kroah-Hartman wrote:
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > 
> > commit 1202cdd665315c525b5237e96e0bedc76d7e754f upstream.
> > 
> > DECnet is an obsolete network protocol that receives more attention
> > from kernel janitors than users. It belongs in computer protocol
> > history museum not in Linux kernel.
> [...]
> 
> May I ask, how and why this patch made it into the stable kernels?
> 
> Did this patch "fix a real bug that bothers people?"

Yes.

> No, we don't use DECNET since 25 years or so. But still any change of kconfig patterns bothers us. 

We have never guaranteed that Kconfig options will never change in
stable kernel releases, sorry.  This happens all the time with things
being removed, and fixes happening to add new ones for various reasons
as you have seen.

> We automatically build each released kernel and our config evolves automatically following a `cp config-mpi .config && make olddefconfig && make savedefconfig && cp defconfig config-mpi && git commit -m"Update for new kernel version" config-mpi` pattern.

You might want to manually check this as well, because as you have seen,
sometimes things are added that you need to keep things working properly
(like the spectre/meltdown-like fixes.)

thanks,

greg k-h
