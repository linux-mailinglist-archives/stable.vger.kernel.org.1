Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B54A7618DD
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 14:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjGYMwN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 08:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjGYMwM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 08:52:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A256EC4
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 05:52:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FAF261700
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 12:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC08C433C8
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 12:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690289530;
        bh=TTjbltbFTPxIzqge8y31RgIrmx0F9/NGTFVmVWUAs64=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z3pDiOI3bE29xPk3lEDMXVdAZ0049dwY3N7oqrbLVPaB95hNCxAgbTOlK4fIHa425
         Ly2Xf2OcN3rlhdL368jBW8qq2hV8yOK63rFkrPDTEwRAFD6lULlkn+FnsZ0b7tQp3V
         +gRxseyNpDA1g5YS6HSxO0qTzxTXTIQfB479N5f20Ak4IbYXy8evXYTfGJ7eKHgwOe
         KlcizWQDI6bO1xaHNPxsCjcWadIs32DiS+L4YDxH7qWCxXjYVSQqKfAH/6HeKBkxvL
         uRQSD801resBgP7XQl0fgzg7IPQYv3tjFGp0PWawWRJx13abYgodBqN0q6mSLtc/B+
         BvU+Vvn3u2q/A==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so81873231fa.0
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 05:52:10 -0700 (PDT)
X-Gm-Message-State: ABy/qLY9OmlQH91Kb40Av41HYsTvojt6kqjTTD/BJcgV0YiJ8kaanyZ6
        HyV3ahW8HcFSX3WHv+3IG1hE8T48btDdQ0dcg1w=
X-Google-Smtp-Source: APBJJlF2hl4rILyWgCBlwhIJc2ynCJMSUyuferWCTCtZdc/YezQprT+BHOZGDNWtHaCwyjcmLWbfBU6uQENlxafOqQc=
X-Received: by 2002:a05:6512:3d1c:b0:4ef:edb4:2c77 with SMTP id
 d28-20020a0565123d1c00b004efedb42c77mr916102lfv.11.1690289528334; Tue, 25 Jul
 2023 05:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXHQkgRCt=W0FbZZ9qLVCaWisFhv9wJtYONjA3cEPdXMRQ@mail.gmail.com>
 <2023072521-refurnish-grooving-fd36@gregkh>
In-Reply-To: <2023072521-refurnish-grooving-fd36@gregkh>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 25 Jul 2023 14:51:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF55o_YZ=kshh5ALszN3ZWiKk+5LSNVQvSkjPaJNgh56g@mail.gmail.com>
Message-ID: <CAMj1kXF55o_YZ=kshh5ALszN3ZWiKk+5LSNVQvSkjPaJNgh56g@mail.gmail.com>
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

On Tue, 25 Jul 2023 at 14:29, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 25, 2023 at 01:13:34PM +0200, Ard Biesheuvel wrote:
> > Please backport commit
> >
> > commit 9cf42bca30e98a1c6c9e8abf876940a551eaa3d1
> > Author: Ard Biesheuvel <ardb@kernel.org>
> > Date:   Tue Aug 2 11:00:16 2022 +0200
> >
> >     efi: libstub: use EFI_LOADER_CODE region when moving the kernel in memory
> >
> > to all active stable trees all the way back to v5.15. I will provide a
> > separate backport for v5.10, and possibly a [much] larger set of
> > backports for v5.4 for EFI boot support.
>
> Sure, but why?  That sounds like a new feature, if you want EFI boot
> support, why not just move to a newer kernel tree?  What bug is this
> fixing?
>

Perhaps it is something that the distros just needs to carry in their
forks, then.

This is related to distro forks of grub and shim, and the royal mess
they created on x86. We are making progress on the GRUB side to move
to the much simpler and cleaner generic EFI stub support that works
for x86, ARM, arm64, RISC-V and LoongArch. The problem is that the
distros have a huge set of patches between them that turn shim, GRUB
and the way x86 boots in a huge tangled mess, and they cannot phase
those out as long as they need to support older kernels, and so they
are now in a situation where they need to support all of the above.

v5.4 is the only release where it is somewhat feasible to backport the
changes [0] that would allow those GRUB out-of-tree hacks to be
dropped. I.e., the number of backported patches is quite substantial
but there are very few and minor conflicts, and the changes are
confined to EFI code. Backporting this stuff from ~v5.8 to v5.4 would
mean they can accelerate their phase out schedule by a year.
(Actually, they asked me about v4.4 but anything older than v5.4 is
really out of the question)

In any case, I promised them to take a look and I did - I won't be the
one pushing for this to get merged.

Thanks,
Ard.




[0] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-lf2-backport-x86
