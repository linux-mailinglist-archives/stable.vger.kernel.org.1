Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D7073D186
	for <lists+stable@lfdr.de>; Sun, 25 Jun 2023 16:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjFYOkh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 25 Jun 2023 10:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFYOkg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 25 Jun 2023 10:40:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871D213E
        for <stable@vger.kernel.org>; Sun, 25 Jun 2023 07:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 178AC60B94
        for <stable@vger.kernel.org>; Sun, 25 Jun 2023 14:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27665C433C0;
        Sun, 25 Jun 2023 14:40:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JZi3W7u0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1687704030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W9bwUh3XZI0MEK9b1+FH1A6Siutg0zhBNWcDa+CeRtE=;
        b=JZi3W7u0qo7z03jALCC+GJ5v1KJePmwLLMpenda/7UBFHp+upwiG+3CkGbhPytkh3pRQRI
        l75ubZZWHVON7KrYWEYDLNzhrhr6ZLcg/LuQ7ku3/tOeHfV7kYJEn8KTeWMceGV2+yEvjk
        P576kJnixk9yuR/PlzfRQjXWHvPRXlc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 788447a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 25 Jun 2023 14:40:28 +0000 (UTC)
Date:   Sun, 25 Jun 2023 16:40:26 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, regressions@leemhuis.info,
        Andrew Lunn <andrew@lunn.ch>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Sami Korkalainen <sami.korkalainen@proton.me>
Subject: Re: [REGRESSION][BISECTED] Boot stall from merge tag 'net-next-6.2'
Message-ID: <ZJhR2sIaMdT1qf8v@zx2c4.com>
References: <ZIcmpcEsTLXFaO0f@debian.me>
 <oEbkgJ-ImLxBDZDUTnIAGFWrRVnwBss3FOlalTpwrz83xWgESC9pcvNKiAVp9BzFgqZ0V-NIwzBZ7icKD8ynuIi_ZMtGt7URu3ftcSt16u4=@proton.me>
 <e2ca75ef-d779-4bad-84a5-a9f262dbe213@lunn.ch>
 <FNzHwp9-AyweVwIMndmih6VuBD0nsyRp3OM72bmOxpeYszF680jFPJjENIknT32FeaqfVBtVSQFw-5mgE3ZXeksVD8VCFbxwojxP3mSZ9DQ=@proton.me>
 <9517bb70-426c-0296-b426-f5b4f075f7c8@leemhuis.info>
 <CAHmME9p2ZLJUMq96vhkiSgvJkxP5BxE778MhY5Ou2WdxLVEJyg@mail.gmail.com>
 <CAMj1kXHGkJsgArabs_mbzR3Y83s48qmf_aqb50k1LV1Hi5iNgA@mail.gmail.com>
 <CAHk-=wiiFHLSDe3JSSMm5EezpXXMFxYH=RwFLEbgsCKLjg4qqQ@mail.gmail.com>
 <CAHmME9oC6Kq5qeoSmY5CdDrbGnkcp9sy-9ESXdpRtM8x1_6Hwg@mail.gmail.com>
 <CAHk-=wjKtHwJBeUiJL_1HFJKWja120w-6qaLx1FS5p9QE0PfSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjKtHwJBeUiJL_1HFJKWja120w-6qaLx1FS5p9QE0PfSw@mail.gmail.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jun 23, 2023 at 02:52:25PM -0700, Linus Torvalds wrote:
> On Fri, 23 Jun 2023 at 13:31, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > We always have to write when using so that we don't credit the same
> > seed twice, so it's gotta be used at a stage when SetVariable is
> > somewhat working.
> 
> This code isn't even the code that "uses" the alleged entropy from
> that EFI variable in the first place. That's the code in
> efi_random_get_seed() in the EFI boot sequence, and appends it to the
> bootup randomness buffers.
> 
> And that code already seems to clear the EFI variable (or seems to
> append to it).

Oh, doh, yea, you're right. Sorry. My mistake.

So indeed, we can probably get away with just delaying this until much
later in boot, and doing this inside of a workqueue or similar, instead
of in some special early boot context. Or maybe shutdown? Shutdown seems
like it'd better handle potential firmware issues since hanging on
shutdown is a lot better than hanging on boot. But it would be nice to
keep this working during unclean shutdown, which maybe means doing it
sometime after bootup is still better.

> So this argument seems to be complete garbage - we absolutely do not
> have to write it, and your patch already just wrote it in the wrong
> place anyway.
> 
> Don't make excuses. That code caused boot failures, it was all done in
> the wrong place, and at entirely the wrong time.

Yes, my point was entirely wrong. I was mistaken. But it wasn't an
*excuse*. I was just momentarily confused. No malice here, I promise.

Jason
