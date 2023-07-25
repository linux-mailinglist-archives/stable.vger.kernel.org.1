Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C877619E0
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 15:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjGYNZ4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 09:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjGYNZz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 09:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6866119B4
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 06:25:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04382616CC
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 13:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6852BC433C8
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 13:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690291549;
        bh=oyz4SyZSaUWRKzyik+FaSND/nLNTcCVmqrumJ4J86kU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dMOris+pxhXsYjIz8jOEdfPKCNyD4YgQYyjskupoqHEFdLBaWtJnLRvnLBQP1dV5o
         hcMYjzaHxU2pbC+xy9nDcb59Jt7mt1I2kjpPENWd2vUVDvqDyqw+VseAiRbJaqlKk2
         oqS90YTNwU6tSoqr3eZpzqlKqJMvC5IvesRAa2QkDJda2s+yH8FsyxZfFEqs4yf7VD
         bR6qEyJy8uDEqPJuNFrj26CLUSqhU20AzkPQIAKQAlKg8ewX/c07HSCqVJHUee5Lc+
         zEYqw2RRQpBdVWxiW1m0S9KlieXsn0L7iskvu6UYVeA4/IpswsfZN67fB7pl/OX3VO
         18Cj4OkZaJAgA==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b9a2033978so8773611fa.0
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 06:25:49 -0700 (PDT)
X-Gm-Message-State: ABy/qLYYO03BcjA+S7hMuuqu7Dy/VAluepzfcUHbR0SXqAvL1VxQGnlH
        eUGc8M/F8yCWs2oROpRBigwSD/+TPeEvXz38hFc=
X-Google-Smtp-Source: APBJJlFL63wUwiIjiTk06GaovW0aQWAZaO+jhtPY5/gXmyYHTXUdl6mOf2a8fL8a6N6nKOx/ChilfkZKSJ/hylWG14o=
X-Received: by 2002:a2e:8883:0:b0:2b9:40c7:f5ed with SMTP id
 k3-20020a2e8883000000b002b940c7f5edmr8019897lji.17.1690291547305; Tue, 25 Jul
 2023 06:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXHQkgRCt=W0FbZZ9qLVCaWisFhv9wJtYONjA3cEPdXMRQ@mail.gmail.com>
 <2023072521-refurnish-grooving-fd36@gregkh> <CAMj1kXF55o_YZ=kshh5ALszN3ZWiKk+5LSNVQvSkjPaJNgh56g@mail.gmail.com>
 <2023072527-dehydrate-frown-3312@gregkh>
In-Reply-To: <2023072527-dehydrate-frown-3312@gregkh>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 25 Jul 2023 15:25:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFzXs=cMz06J_z1vtbrQiF_yXsC0RLGun=ZgzrC0H+umA@mail.gmail.com>
Message-ID: <CAMj1kXFzXs=cMz06J_z1vtbrQiF_yXsC0RLGun=ZgzrC0H+umA@mail.gmail.com>
Subject: Re: backport request
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 25 Jul 2023 at 15:21, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 25, 2023 at 02:51:56PM +0200, Ard Biesheuvel wrote:
> > On Tue, 25 Jul 2023 at 14:29, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jul 25, 2023 at 01:13:34PM +0200, Ard Biesheuvel wrote:
> > > > Please backport commit
> > > >
> > > > commit 9cf42bca30e98a1c6c9e8abf876940a551eaa3d1
> > > > Author: Ard Biesheuvel <ardb@kernel.org>
> > > > Date:   Tue Aug 2 11:00:16 2022 +0200
> > > >
> > > >     efi: libstub: use EFI_LOADER_CODE region when moving the kernel in memory
> > > >
> > > > to all active stable trees all the way back to v5.15. I will provide a
> > > > separate backport for v5.10, and possibly a [much] larger set of
> > > > backports for v5.4 for EFI boot support.
> > >
> > > Sure, but why?  That sounds like a new feature, if you want EFI boot
> > > support, why not just move to a newer kernel tree?  What bug is this
> > > fixing?
> > >
> >
> > Perhaps it is something that the distros just needs to carry in their
> > forks, then.
> >
> > This is related to distro forks of grub and shim, and the royal mess
> > they created on x86. We are making progress on the GRUB side to move
> > to the much simpler and cleaner generic EFI stub support that works
> > for x86, ARM, arm64, RISC-V and LoongArch. The problem is that the
> > distros have a huge set of patches between them that turn shim, GRUB
> > and the way x86 boots in a huge tangled mess, and they cannot phase
> > those out as long as they need to support older kernels, and so they
> > are now in a situation where they need to support all of the above.
> >
> > v5.4 is the only release where it is somewhat feasible to backport the
> > changes [0] that would allow those GRUB out-of-tree hacks to be
> > dropped. I.e., the number of backported patches is quite substantial
> > but there are very few and minor conflicts, and the changes are
> > confined to EFI code. Backporting this stuff from ~v5.8 to v5.4 would
> > mean they can accelerate their phase out schedule by a year.
> > (Actually, they asked me about v4.4 but anything older than v5.4 is
> > really out of the question)
> >
> > In any case, I promised them to take a look and I did - I won't be the
> > one pushing for this to get merged.
>
> I think this is up to the distros if they want to deal with this mess on
> their older kernels.  They created it, and they want to maintain it as
> their "value add", so let's let them earn that value :)
>
> So I'll not add these to any older kernels, they can use 6.1.y instead
> if they want to.
>

Yes, but please backport commit
9cf42bca30e98a1c6c9e8abf876940a551eaa3d1  nonetheless - that one is an
obvious bug fix.
