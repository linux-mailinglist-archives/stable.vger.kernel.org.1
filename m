Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1931761A77
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 15:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjGYNs4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 09:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjGYNsx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 09:48:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D4F1FF7
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 06:48:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B1F36171E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 13:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C4FC433C8
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 13:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690292927;
        bh=LVsuvniU41OAjpmlr1YuKkw2BJTWr3abFPETIUBEzKU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tj4qp5QdD/NKiiNrCgaIkPCA0j1aYSug/ixLGjyIqxAisSiaUuX+BOqGUrHUcoqTX
         YOITCCYeDo3cbrImfdl3UxL2VGvp69Wedc0ye+vaH09GU77pi8fih8b+8I/IHvr20C
         qDPCrnzCI/LFgBKX8B32cE1R6jI5DXFTjxbruWL8Lt0IZQdXSIQn1tRicTFkuOemxR
         +vZAkKFigJCEFZoYg8JZRHreAcRFWKr1GbG6WegdUo6968qoSQqqvAPu54NBMwqHLy
         JmJm+gHSh3CmKunQxz/KnXXYHKNCxGkq0+xhYadxEkF3DBKL+LcBzuPwZWXyJqy1i6
         k8KI2lWWoE7dQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4fdd14c1fbfso8536981e87.1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 06:48:46 -0700 (PDT)
X-Gm-Message-State: ABy/qLbp7gOqYoJAYd2no/BC3nV2uXyW0cjdI4gS80/pk9HKO1SkD7lQ
        hqChzVoq2yqAVTqFunchU1Q967Xd95bRWN58tes=
X-Google-Smtp-Source: APBJJlGcWdPSElzZZj0dWZfvE9WkxvtmIFPCohS2A1LGgf0FBZQR3Tsdb3mcPYGrVsaIZLcITSuZy8nJaMHLtnCMohE=
X-Received: by 2002:a19:914d:0:b0:4f8:4512:c844 with SMTP id
 y13-20020a19914d000000b004f84512c844mr6648747lfj.48.1690292924893; Tue, 25
 Jul 2023 06:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXHQkgRCt=W0FbZZ9qLVCaWisFhv9wJtYONjA3cEPdXMRQ@mail.gmail.com>
 <2023072521-refurnish-grooving-fd36@gregkh> <CAMj1kXF55o_YZ=kshh5ALszN3ZWiKk+5LSNVQvSkjPaJNgh56g@mail.gmail.com>
 <2023072527-dehydrate-frown-3312@gregkh> <CAMj1kXFzXs=cMz06J_z1vtbrQiF_yXsC0RLGun=ZgzrC0H+umA@mail.gmail.com>
 <2023072516-steerable-onlooker-0a82@gregkh>
In-Reply-To: <2023072516-steerable-onlooker-0a82@gregkh>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 25 Jul 2023 15:48:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEswMxpxj3yVar08mVQBAtSxMKH5-oYZqsjThsYd1Xx0A@mail.gmail.com>
Message-ID: <CAMj1kXEswMxpxj3yVar08mVQBAtSxMKH5-oYZqsjThsYd1Xx0A@mail.gmail.com>
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

On Tue, 25 Jul 2023 at 15:41, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 25, 2023 at 03:25:35PM +0200, Ard Biesheuvel wrote:
> > On Tue, 25 Jul 2023 at 15:21, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jul 25, 2023 at 02:51:56PM +0200, Ard Biesheuvel wrote:
> > > > On Tue, 25 Jul 2023 at 14:29, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Tue, Jul 25, 2023 at 01:13:34PM +0200, Ard Biesheuvel wrote:
> > > > > > Please backport commit
> > > > > >
> > > > > > commit 9cf42bca30e98a1c6c9e8abf876940a551eaa3d1
> > > > > > Author: Ard Biesheuvel <ardb@kernel.org>
> > > > > > Date:   Tue Aug 2 11:00:16 2022 +0200
> > > > > >
> > > > > >     efi: libstub: use EFI_LOADER_CODE region when moving the kernel in memory
> > > > > >
> > > > > > to all active stable trees all the way back to v5.15. I will provide a
> > > > > > separate backport for v5.10, and possibly a [much] larger set of
> > > > > > backports for v5.4 for EFI boot support.
> > > > >
> > > > > Sure, but why?  That sounds like a new feature, if you want EFI boot
> > > > > support, why not just move to a newer kernel tree?  What bug is this
> > > > > fixing?
> > > > >
> > > >
> > > > Perhaps it is something that the distros just needs to carry in their
> > > > forks, then.
> > > >
> > > > This is related to distro forks of grub and shim, and the royal mess
> > > > they created on x86. We are making progress on the GRUB side to move
> > > > to the much simpler and cleaner generic EFI stub support that works
> > > > for x86, ARM, arm64, RISC-V and LoongArch. The problem is that the
> > > > distros have a huge set of patches between them that turn shim, GRUB
> > > > and the way x86 boots in a huge tangled mess, and they cannot phase
> > > > those out as long as they need to support older kernels, and so they
> > > > are now in a situation where they need to support all of the above.
> > > >
> > > > v5.4 is the only release where it is somewhat feasible to backport the
> > > > changes [0] that would allow those GRUB out-of-tree hacks to be
> > > > dropped. I.e., the number of backported patches is quite substantial
> > > > but there are very few and minor conflicts, and the changes are
> > > > confined to EFI code. Backporting this stuff from ~v5.8 to v5.4 would
> > > > mean they can accelerate their phase out schedule by a year.
> > > > (Actually, they asked me about v4.4 but anything older than v5.4 is
> > > > really out of the question)
> > > >
> > > > In any case, I promised them to take a look and I did - I won't be the
> > > > one pushing for this to get merged.
> > >
> > > I think this is up to the distros if they want to deal with this mess on
> > > their older kernels.  They created it, and they want to maintain it as
> > > their "value add", so let's let them earn that value :)
> > >
> > > So I'll not add these to any older kernels, they can use 6.1.y instead
> > > if they want to.
> > >
> >
> > Yes, but please backport commit
> > 9cf42bca30e98a1c6c9e8abf876940a551eaa3d1  nonetheless - that one is an
> > obvious bug fix.
>
> Ok, will do after this round of releases are done.
>

Actually, no - please disregard.

I confused myself here - the fix is fine, just not needed for v5.10 - v6.4.

Sorry for the noise.
