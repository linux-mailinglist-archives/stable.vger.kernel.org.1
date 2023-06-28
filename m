Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF4A74180C
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 20:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjF1SdO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 14:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjF1SdO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 14:33:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9D41726
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 11:33:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B573961416
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 18:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA67C433C8;
        Wed, 28 Jun 2023 18:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687977192;
        bh=OQGA1W/oI2UD9hbk/tMbFY3rOxOxKmHe2Rweoao7l0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P+sKZ7Kb8y6W7URKHds6Xo9TRcwRCV0wPyWgiqdWSIzfK4ut8YjsSxO25jVFuh+Pq
         7eC0XmX6jx0hhE9fQJsP4N2ejK/+8UKSG/Gx0yKmErS2uzNOWsZnQd7Qgr60JpcbzU
         3UQbnaDHuc1I6Bo745Eo8Yu8h9rUSAYAhezAmDX4=
Date:   Wed, 28 Jun 2023 20:33:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Luiz Capitulino <luizcap@amazon.com>, sashal@kernel.org,
        stable@vger.kernel.org
Subject: Re: Possible build time regression affecting stable kernels
Message-ID: <2023062846-outback-posting-dfbd@gregkh>
References: <8892cb92-0f30-db36-e9db-4bec5e7eb46e@amazon.com>
 <2023060156-precision-prorate-ce46@gregkh>
 <20259cf7-d50d-4eca-482b-3a89cc94df7b@amazon.com>
 <2023060148-levers-freight-5b11@gregkh>
 <CAHC9VhQ6W4hq3B122BxcrD6h6_-Q1AguFYYLjAbB6ALCbmzDoQ@mail.gmail.com>
 <2023060102-chatter-happening-f7a5@gregkh>
 <CAHC9VhRuc5jSK7xODqtBvhUmunov+PVVQyLb8oDP8k0pLq_P-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRuc5jSK7xODqtBvhUmunov+PVVQyLb8oDP8k0pLq_P-g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 01, 2023 at 02:39:00PM -0400, Paul Moore wrote:
> On Thu, Jun 1, 2023 at 11:51 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Thu, Jun 01, 2023 at 10:56:24AM -0400, Paul Moore wrote:
> > > On Thu, Jun 1, 2023 at 9:20 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > On Thu, Jun 01, 2023 at 09:13:21AM -0400, Luiz Capitulino wrote:
> > >
> > > ...
> > >
> > > > > Yes. I'm reporting this here because I'm more concerned with -stable kernels since
> > > > > they're more likely to be running on older user-space.
> > > >
> > > > Yeah, we are bug-compatible!  :)
> > >
> > > While I really don't want to go back into the old arguments about what
> > > does, and does not, get backported to -stable, I do want to ask if
> > > there is some way to signal to the -stable maintainers that a patch
> > > should not be backported?  Anything coming from the LSM, SELinux, or
> > > audit trees that I believe should be backported is explicitly marked
> > > with a stable@vger CC, as documented in stable-kernel-rules.rst,
> > > however it is generally my experience that patches with a 'Fixes:' tag
> > > are generally pulled into the -stable releases as well.
> >
> > Really?
> 
> Yes, really.
> 
> > Right now we HAVE to pick up the Fixes: tagged commits in those
> > subsystems as you are missing lots of real fixes.
> 
> This starts to bring us back to the old argument about what is
> appropriate for -stable, but I've been sticking as close as possible
> to what is documented in stable-kernel-rules.rst which (ignoring
> things like HW enablement) advises that only patches which fix build
> issues or "serious issues" should be considered for -stable.  I
> consider every bug fix that goes into the LSM, SELinux, and audit
> trees to see if it meets those criteria, if it does I mark it with a
> -stable tag, if not I leave the -stable tag and ensure it carries a
> 'Fixes:' tag if it makes sense and an appropriate root-cause commit is
> identified.
> 
> We definitely have different opinions on where the -stable bug fix
> threshold lies.  I am of the opinion that every -stable backport
> carries risk, and I consider that when deciding if a commit should be
> marked for -stable.  I do not believe that every bug fix, or every
> commit with a 'Fixes:' tag, should be backported to -stable.

Ok, I'll not argue here, but it feels like there is a lack of changes
for some of these portions of the kernel that end up in stable kernels.
I'll trust you on this.

So, can I get a directory list or file list of what we should be
ignoring for the AUTOSEL and "Fixes: only" tools to be ignoring?

thanks,

greg k-h
