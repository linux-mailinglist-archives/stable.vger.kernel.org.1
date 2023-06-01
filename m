Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D01719F58
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 16:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjFAONZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 10:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjFAONX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 10:13:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169AFE62
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 07:13:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FC4163530
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 14:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75352C433EF;
        Thu,  1 Jun 2023 14:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685628789;
        bh=DCqu4J3OkUUe7pvGh/Y3i7i5bY7uq29tH22M361sXD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yU+DuNEqB+pxjqwG6VeMm5uINqICZ8ZqNbfxmcNeqnNJ0SIz4pETPw7gR6Gd1xkTF
         sptnSjjt4iXzMYR5XnL1OA/0/RtkGJIS4WvL7eV9x6dVcHH0pT/bc4AYca1lufXMAZ
         8TccIvPbfiR6fcx3nuED8LBAUyEmXFzPwy+5r9co=
Date:   Thu, 1 Jun 2023 15:13:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     paul@paul-moore.com, sashal@kernel.org, stable@vger.kernel.org
Subject: Re: Possible build time regression affecting stable kernels
Message-ID: <2023060106-malformed-unwoven-3106@gregkh>
References: <8892cb92-0f30-db36-e9db-4bec5e7eb46e@amazon.com>
 <2023060156-precision-prorate-ce46@gregkh>
 <20259cf7-d50d-4eca-482b-3a89cc94df7b@amazon.com>
 <2023060148-levers-freight-5b11@gregkh>
 <71ab9b4b-ef82-10d0-e97b-b870c3bd85f1@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71ab9b4b-ef82-10d0-e97b-b870c3bd85f1@amazon.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 01, 2023 at 09:26:30AM -0400, Luiz Capitulino wrote:
> 
> 
> On 2023-06-01 09:20, Greg KH wrote:
> 
> > 
> > 
> > 
> > On Thu, Jun 01, 2023 at 09:13:21AM -0400, Luiz Capitulino wrote:
> > > 
> > > 
> > > On 2023-06-01 02:06, Greg KH wrote:
> > > 
> > > > 
> > > > 
> > > > 
> > > > On Wed, May 31, 2023 at 10:12:40PM -0400, Luiz Capitulino wrote:
> > > > > Hi Paul,
> > > > > 
> > > > > A number of stable kernels recently backported this upstream commit:
> > > > > 
> > > > > """
> > > > > commit 4ce1f694eb5d8ca607fed8542d32a33b4f1217a5
> > > > > Author: Paul Moore <paul@paul-moore.com>
> > > > > Date:   Wed Apr 12 13:29:11 2023 -0400
> > > > > 
> > > > >       selinux: ensure av_permissions.h is built when needed
> > > > > """
> > > > > 
> > > > > We're seeing a build issue with this commit where the "crash" tool will fail
> > > > > to start, it complains that the vmlinux image and /proc/version don't match.
> > > > > 
> > > > > A minimum reproducer would be having "make" version before 4.3 and building
> > > > > the kernel with:
> > > > > 
> > > > > $ make bzImages
> > > > > $ make modules
> > > > > 
> > > > > Then compare the version strings in the bzImage and vmlinux images,
> > > > > we can use "strings" for this. For example, in the 5.10.181 kernel I get:
> > > > > 
> > > > > $ strings vmlinux | egrep '^Linux version'
> > > > > Linux version 5.10.181 (ec2-user@ip-172-31-79-134.ec2.internal) (gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-15), GNU ld version 2.29.1-31.amzn2) #2 SMP Thu Jun 1 01:26:38 UTC 2023
> > > > > 
> > > > > $ strings ./arch/x86_64/boot/bzImage | egrep 'ld version'
> > > > > 5.10.181 (ec2-user@ip-172-31-79-134.ec2.internal) (gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-15), GNU ld version 2.29.1-31.amzn2) #1 SMP Thu Jun 1 01:23:59 UTC 2023
> > > > > 
> > > > > The version string in the bzImage doesn't have the "Linux version" part, but
> > > > > I think this is added by the kernel when printing. If you compare the strings,
> > > > > you'll see that they have a different build date and the "#1" and "#2" are
> > > > > different.
> > > > > 
> > > > > This only happens with commit 4ce1f694eb5 applied and older "make", in my case I
> > > > > have "make" version 3.82.
> > > > > 
> > > > > If I revert 4ce1f694eb5 or use "make" version 4.3 I get identical strings (except
> > > > > for the "Linux version" part):
> > > > > 
> > > > > $ strings vmlinux | egrep '^Linux version'
> > > > > Linux version 5.10.181+ (ec2-user@ip-172-31-79-134.ec2.internal) (gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-15), GNU ld version 2.29.1-31.amzn2) #1 SMP Thu Jun 1 01:29:11 UTC 2023
> > > > > 
> > > > > $ strings ./arch/x86_64/boot/bzImage | egrep 'ld version'
> > > > > 5.10.181+ (ec2-user@ip-172-31-79-134.ec2.internal) (gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-15), GNU ld version 2.29.1-31.amzn2) #1 SMP Thu Jun 1 01:29:11 UTC 2023
> > > > > 
> > > > > Maybe the grouped target usage in 4ce1f694eb5 with older "make" is causing a
> > > > > rebuild of the vmlinux image in "make modules"? If yes, is this expected?
> > > > > 
> > > > > I'm afraid this issue could be high impact for distros with older user-space.
> > > > 
> > > > Is this issue also in 6.4-rc1 where this change came from?
> > > 
> > > Yes. I'm reporting this here because I'm more concerned with -stable kernels since
> > > they're more likely to be running on older user-space.
> > 
> > Yeah, we are bug-compatible!  :)
> > 
> > When this gets fixed in Linus's tree, I'll be glad to backport the
> > changes to the other kernels.  Please work with the developers to get
> > that fixed there.
> 
> OK, I'll report it there, but shouldn't we avoid regressing -stable kernels?

We should avoid regressing Linus's kernel tree just as much.  It's
always been this way, I don't want to revert patches unless they are
really bad if the fix is not in Linus's tree already.  Gives people
"encouragement" to resolve the issue quicker.

thanks,

greg k-h
