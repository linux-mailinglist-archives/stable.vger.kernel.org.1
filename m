Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111DE761A30
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 15:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGYNle (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 09:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjGYNld (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 09:41:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B16E7
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 06:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8680261701
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 13:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4A4C433C7;
        Tue, 25 Jul 2023 13:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690292491;
        bh=D0gQdm18nrnAJhjdDayqMmbba6T1TeeKmKIfBTCvgFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EsyOZqwo5gmXvL79eFNZbwlTUzelIaZn4/lSlXALVCqSQEN/yXkCamJLd/ZlscYGI
         9kMEPlb9GPQK9JpMGw2JUcTZtNDD9ZuUfoitC4OJIcUDd/CqqVHvk4zObwOOlTxPIm
         1RvYNtS/Grl+mTHzwoD/cOFVkg4Y9GkdWu9XXWLM=
Date:   Tue, 25 Jul 2023 15:41:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "# 3.4.x" <stable@vger.kernel.org>
Subject: Re: backport request
Message-ID: <2023072516-steerable-onlooker-0a82@gregkh>
References: <CAMj1kXHQkgRCt=W0FbZZ9qLVCaWisFhv9wJtYONjA3cEPdXMRQ@mail.gmail.com>
 <2023072521-refurnish-grooving-fd36@gregkh>
 <CAMj1kXF55o_YZ=kshh5ALszN3ZWiKk+5LSNVQvSkjPaJNgh56g@mail.gmail.com>
 <2023072527-dehydrate-frown-3312@gregkh>
 <CAMj1kXFzXs=cMz06J_z1vtbrQiF_yXsC0RLGun=ZgzrC0H+umA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFzXs=cMz06J_z1vtbrQiF_yXsC0RLGun=ZgzrC0H+umA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jul 25, 2023 at 03:25:35PM +0200, Ard Biesheuvel wrote:
> On Tue, 25 Jul 2023 at 15:21, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jul 25, 2023 at 02:51:56PM +0200, Ard Biesheuvel wrote:
> > > On Tue, 25 Jul 2023 at 14:29, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Jul 25, 2023 at 01:13:34PM +0200, Ard Biesheuvel wrote:
> > > > > Please backport commit
> > > > >
> > > > > commit 9cf42bca30e98a1c6c9e8abf876940a551eaa3d1
> > > > > Author: Ard Biesheuvel <ardb@kernel.org>
> > > > > Date:   Tue Aug 2 11:00:16 2022 +0200
> > > > >
> > > > >     efi: libstub: use EFI_LOADER_CODE region when moving the kernel in memory
> > > > >
> > > > > to all active stable trees all the way back to v5.15. I will provide a
> > > > > separate backport for v5.10, and possibly a [much] larger set of
> > > > > backports for v5.4 for EFI boot support.
> > > >
> > > > Sure, but why?  That sounds like a new feature, if you want EFI boot
> > > > support, why not just move to a newer kernel tree?  What bug is this
> > > > fixing?
> > > >
> > >
> > > Perhaps it is something that the distros just needs to carry in their
> > > forks, then.
> > >
> > > This is related to distro forks of grub and shim, and the royal mess
> > > they created on x86. We are making progress on the GRUB side to move
> > > to the much simpler and cleaner generic EFI stub support that works
> > > for x86, ARM, arm64, RISC-V and LoongArch. The problem is that the
> > > distros have a huge set of patches between them that turn shim, GRUB
> > > and the way x86 boots in a huge tangled mess, and they cannot phase
> > > those out as long as they need to support older kernels, and so they
> > > are now in a situation where they need to support all of the above.
> > >
> > > v5.4 is the only release where it is somewhat feasible to backport the
> > > changes [0] that would allow those GRUB out-of-tree hacks to be
> > > dropped. I.e., the number of backported patches is quite substantial
> > > but there are very few and minor conflicts, and the changes are
> > > confined to EFI code. Backporting this stuff from ~v5.8 to v5.4 would
> > > mean they can accelerate their phase out schedule by a year.
> > > (Actually, they asked me about v4.4 but anything older than v5.4 is
> > > really out of the question)
> > >
> > > In any case, I promised them to take a look and I did - I won't be the
> > > one pushing for this to get merged.
> >
> > I think this is up to the distros if they want to deal with this mess on
> > their older kernels.  They created it, and they want to maintain it as
> > their "value add", so let's let them earn that value :)
> >
> > So I'll not add these to any older kernels, they can use 6.1.y instead
> > if they want to.
> >
> 
> Yes, but please backport commit
> 9cf42bca30e98a1c6c9e8abf876940a551eaa3d1  nonetheless - that one is an
> obvious bug fix.

Ok, will do after this round of releases are done.

greg k-h
