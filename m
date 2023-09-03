Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCB6790AF2
	for <lists+stable@lfdr.de>; Sun,  3 Sep 2023 07:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbjICFch (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 3 Sep 2023 01:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjICFcg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 3 Sep 2023 01:32:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7325B1A5;
        Sat,  2 Sep 2023 22:32:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04F696119B;
        Sun,  3 Sep 2023 05:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AACC433C8;
        Sun,  3 Sep 2023 05:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693719151;
        bh=/PcQUEmulcfpDGmnyzupuF3dQd5/Eek5MNQ10C379kw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pPOafECzZ9aJAjp9yNvyOB+sGbCkvXqgo1+f7ZUxpOvfKsSwCs+/QbTOdNqKroP3h
         ap1j5jtZ71HsOOM7w10zTJO+s+n0aYNr9TOfTT6Xch9RT7ETsft7uPWAK924Wr+6zW
         +6F8N6hB6amq+ot2M55MBQCCC8SybmFgXQlXyz0o=
Date:   Sun, 3 Sep 2023 07:32:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     John David Anglin <dave.anglin@bell.net>,
        Helge Deller <deller@gmx.de>, stable@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>, linux-parisc@vger.kernel.org,
        Vidra.Jonas@seznam.cz, Sam James <sam@gentoo.org>
Subject: Re: [STABLE] stable backport request for 6.1 for io_uring
Message-ID: <2023090358-anemia-trusting-fa33@gregkh>
References: <ZO0X64s72JpFJnRM@p100>
 <5aa6799a-d577-4485-88e0-545f6459c74e@kernel.dk>
 <8f6006a7-1819-a2fb-e928-7f26ba7df6ec@bell.net>
 <d9ed50b2-dfef-4825-be42-beac7277c447@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9ed50b2-dfef-4825-be42-beac7277c447@kernel.dk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Sep 02, 2023 at 06:45:56PM -0600, Jens Axboe wrote:
> On 9/2/23 5:04 PM, John David Anglin wrote:
> > On 2023-08-30 12:17 p.m., Jens Axboe wrote:
> >> On 8/28/23 3:55 PM, Helge Deller wrote:
> >>> Hello Greg, Hello Jens, Hello stable team,
> >>>
> >>> would you please accept some backports to v6.1-stable for io_uring()?
> >>> io_uring() fails on parisc because of some missing upstream patches.
> >>> Since 6.1 is currently used in debian and gentoo as main kernel we
> >>> face some build errors due to the missing patches.
> >> Fine with me.
> > This is probably not a problem with the backport but I see this fail in liburing tests:
> > 
> > Running test wq-aff.t open: No such file or directory
> > test sqpoll failed
> > Test wq-aff.t failed with ret 1
> > Running test xattr.t 0 sec [0]
> > Running test statx.t 0 sec [0]
> > Running test sq-full-cpp.t 0 sec [0]
> > Tests failed (1): <wq-aff.t>
> 
> That's because 6.1-stable is missing:
> 
> commit ebdfefc09c6de7897962769bd3e63a2ff443ebf5
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Sun Aug 13 11:05:36 2023 -0600
> 
>     io_uring/sqpoll: fix io-wq affinity when IORING_SETUP_SQPOLL is used
> 
> which went in recently and hasn't been backported to stable yet.

We can add that now to the stable queues if you want, otherwise we are
supposed to wait until -rc1.

thanks,

greg k-h
