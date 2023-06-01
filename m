Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862DD71A341
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 17:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjFAPvx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 11:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbjFAPvu (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 11:51:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A0519F
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 08:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19AD961D7C
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 15:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09112C433D2;
        Thu,  1 Jun 2023 15:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685634703;
        bh=m+FWme3UjVBxLiDYdjrBDDB0C/dE7nxFE0pe4teS3Hk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4XS+klwcv4st1BK+sZ+j5b+qzcjIag6d+zSgcTRT5/HHBjzoLsk/EXCRIb14OKGG
         CrY6wIwkZ5OJ4ni9cwnX6ImMy4ofjvsFChx29SUUay3Fw4arGFhMXBR4ZNfNZR9V5Y
         H5Sq7WFKkeBG1Ejwo7Zw6hZ8S+7ShW3oUCpdY8EY=
Date:   Thu, 1 Jun 2023 16:51:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Luiz Capitulino <luizcap@amazon.com>, sashal@kernel.org,
        stable@vger.kernel.org
Subject: Re: Possible build time regression affecting stable kernels
Message-ID: <2023060102-chatter-happening-f7a5@gregkh>
References: <8892cb92-0f30-db36-e9db-4bec5e7eb46e@amazon.com>
 <2023060156-precision-prorate-ce46@gregkh>
 <20259cf7-d50d-4eca-482b-3a89cc94df7b@amazon.com>
 <2023060148-levers-freight-5b11@gregkh>
 <CAHC9VhQ6W4hq3B122BxcrD6h6_-Q1AguFYYLjAbB6ALCbmzDoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQ6W4hq3B122BxcrD6h6_-Q1AguFYYLjAbB6ALCbmzDoQ@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 01, 2023 at 10:56:24AM -0400, Paul Moore wrote:
> On Thu, Jun 1, 2023 at 9:20 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Thu, Jun 01, 2023 at 09:13:21AM -0400, Luiz Capitulino wrote:
> 
> ...
> 
> > > Yes. I'm reporting this here because I'm more concerned with -stable kernels since
> > > they're more likely to be running on older user-space.
> >
> > Yeah, we are bug-compatible!  :)
> 
> While I really don't want to go back into the old arguments about what
> does, and does not, get backported to -stable, I do want to ask if
> there is some way to signal to the -stable maintainers that a patch
> should not be backported?  Anything coming from the LSM, SELinux, or
> audit trees that I believe should be backported is explicitly marked
> with a stable@vger CC, as documented in stable-kernel-rules.rst,
> however it is generally my experience that patches with a 'Fixes:' tag
> are generally pulled into the -stable releases as well.

Really?  Right now we HAVE to pick up the Fixes: tagged commits in those
subsystems as you are missing lots of real fixes.  I just quick looked
and noticed 8cf0a1bc1287 ("capabilities: fix potential memleak on error
path from vfs_getxattr_alloc()") which you should have tagged, right?

In fact, I've considered most of the LSM code as a "we never tag
anything for stable so we rely on the Fixes: pickup to clean up after
us" subsystem.  We have many of those in the kernel, so you are in good
company :)

> I could start dropping the 'Fixes:' tag from non-stable tagged
> commits, but that's a step backwards in my opinion.

If a commit has fixes: why wouldn't it be ok for stable trees?  That
feels very odd to me.

Anyway, if you really want, yes, we can add you to the "list of
subsystems we do not pick anything for except by explicit cc: stable
marking" that we have, but note, that feels wrong to me based on the
very low number of patches being tagged for these directories over time.

> I could start replying to every -stable backport email notice, but
> that seems like a lot of unnecessary work for something that was never
> marked for -stable in the first place.  I'm guessing it would also add
> some additional management/testing burden to the -stable folks as
> well.

We have a list, so if you really want it, we can add you to it.  But can
you point out any Fixes: commits that we backported that we shouldn't
have?  If so, why was a Fixes: tag on it?

thanks,

greg k-h
