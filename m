Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371467CE6F5
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 20:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjJRSk4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 14:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjJRSk4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 14:40:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B14CF7
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 11:40:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5346BC433C9;
        Wed, 18 Oct 2023 18:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697654454;
        bh=WyKP8PedU2nY8vbXQRoM3WiPDLDUtfwm9DWzRfORrUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rIerSQLcj1eDe1mkPRSy4iOREOkm3M2Eb+EzEP0RsqbtAZ9liFl8nsw3MbXgQ8SVZ
         9hQk6rGmykL/ZqW6WgEWtZY/BMc8vRAxrPa/EM2W4qcCAwpx2Exton884/7tkaB3ki
         hGZIqK6nLJ3kCgrEH4M8lFMTXjKn+Z9qE2PgfgA0=
Date:   Wed, 18 Oct 2023 20:40:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jesse Hathaway <jesse@mbuki-mvuki.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Florian Weimer <fweimer@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
Subject: Re: [PATCH] attr: block mode changes of symlinks
Message-ID: <2023101819-satisfied-drool-49bb@gregkh>
References: <CANSNSoUYMdPPLuZhofOW6DaKzCF47WhZ+T9BnL8sA37M7b4F+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANSNSoUYMdPPLuZhofOW6DaKzCF47WhZ+T9BnL8sA37M7b4F+g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 18, 2023 at 01:34:13PM -0500, Jesse Hathaway wrote:
> > If this holds up without regressions than all LTSes. That's what Amir
> > and Leah did for some other work. I can add that to the comment for
> > clarity.
> 
> Unfortunately, this has not held up in LTSes without causing
> regressions, specifically in crun:
> 
> Crun issue and patch
>  1. https://github.com/containers/crun/issues/1308
>  2. https://github.com/containers/crun/pull/1309

So thre's a fix already for this, they agree that symlinks shouldn't
have modes, so what's the issue?

> Debian bug report
>  1. https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1053821

Same report.

> I think it should be reverted in LTSes and possibly in upstream.

It needs to reverted in Linus's tree first, otherwise you will hit the
same problem when moving to a new kernel.

> P.S. apologies for not having the correct threading headers. I am not on
> the list.

You can always grab the mail on lore.kernel.org and respond to it there,
you are trying to dig up a months old email and we don't really have any
context at all (I had to go to lore to figure it out...)

thanks,

greg k-h
