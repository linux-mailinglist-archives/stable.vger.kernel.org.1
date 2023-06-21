Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A717738F22
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 20:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjFUStf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 14:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFUSte (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 14:49:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFE49B
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 11:49:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF0E661689
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 18:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3896C433C0
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 18:49:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SAk+oiUr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1687373369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZR62tl0M6BOshKrD0nf8mF7iZ5cr1fmRG4jE24AQIZU=;
        b=SAk+oiUrQFWEDmXRaUg9nnUVTQmlRSAJgxlTz7LuSIMNC8MYdY0OJKhVuN5C5Mq1fBauuZ
        Qj6vjUx70Mdy4hpwZQHIl5GD+NR+m0KWUi5dj7vF0ktPM9bsyhTbHBifKbW+hTMmuZriWN
        Uh5nkJPDqWpCFNl8Ne3nMqOsPqOBmwE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9009531e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <stable@vger.kernel.org>;
        Wed, 21 Jun 2023 18:49:28 +0000 (UTC)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-440c14d6a5eso1105071137.0
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 11:49:28 -0700 (PDT)
X-Gm-Message-State: AC+VfDyjN0PDXGcgclqTMyau6j9y7nOQgqpsesShp1LjDuOpkAsB9EAa
        0aCCmbx8Lb/hiLDzX6H24qtWCbUkpGnvU6981fs=
X-Google-Smtp-Source: ACHHUZ4IQJSCPvWCxmMLQOe7nbT0LiDhZ8XnSQo8Wq/dexoR3YH1/8bbg9nnYkL7RUXRS29D5PNqruRa3+2Y/NxcdgI=
X-Received: by 2002:a67:edc9:0:b0:43b:2fa9:eb3a with SMTP id
 e9-20020a67edc9000000b0043b2fa9eb3amr6968951vsp.9.1687373367438; Wed, 21 Jun
 2023 11:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <GQUnKz2al3yke5mB2i1kp3SzNHjK8vi6KJEh7rnLrOQ24OrlljeCyeWveLW9pICEmB9Qc8PKdNt3w1t_g3-Uvxq1l8Wj67PpoMeWDoH8PKk=@proton.me>
 <ZHFaFosKY24-L7tQ@debian.me> <NVN-hJsvHwaHe6R-y6XIYJp0FV7sCavgMjobFnseULT1wjgkOFNXbGBGT5iVjCfbtU7dW5xy2hIDoq0ASeNaXhvSY-g2Df4aHWVIMQ2c3TQ=@proton.me>
 <ZIcmpcEsTLXFaO0f@debian.me> <oEbkgJ-ImLxBDZDUTnIAGFWrRVnwBss3FOlalTpwrz83xWgESC9pcvNKiAVp9BzFgqZ0V-NIwzBZ7icKD8ynuIi_ZMtGt7URu3ftcSt16u4=@proton.me>
 <e2ca75ef-d779-4bad-84a5-a9f262dbe213@lunn.ch> <FNzHwp9-AyweVwIMndmih6VuBD0nsyRp3OM72bmOxpeYszF680jFPJjENIknT32FeaqfVBtVSQFw-5mgE3ZXeksVD8VCFbxwojxP3mSZ9DQ=@proton.me>
 <9517bb70-426c-0296-b426-f5b4f075f7c8@leemhuis.info>
In-Reply-To: <9517bb70-426c-0296-b426-f5b4f075f7c8@leemhuis.info>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 21 Jun 2023 20:49:16 +0200
X-Gmail-Original-Message-ID: <CAHmME9oh7kEUe-6NFk9=_8UxeD-SNbfMksYh3GaYdutXS01zOw@mail.gmail.com>
Message-ID: <CAHmME9oh7kEUe-6NFk9=_8UxeD-SNbfMksYh3GaYdutXS01zOw@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Boot stall from merge tag 'net-next-6.2'
To:     Sami Korkalainen <sami.korkalainen@proton.me>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Brad Spengler <spender@grsecurity.net>,
        regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Sami,

Would you try applying
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=13bb06f8dd42071cb9a49f6e21099eea05d4b856
instead of the revert?

Spender (CC'd) suggested to me that possibly the reason for your first
mis-bisect and possibly for the result you wound with has more to do
with some non-determinism in the actual underlying bug that the above
commit fixes. If applying 13bb06f8dd4207 fixes the issue, then Linus
can then revert the revert he just committed.

Jason
