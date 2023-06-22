Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B2973A209
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 15:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjFVNki (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 09:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjFVNkd (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 09:40:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DC81997
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:40:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1CE06182F
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 13:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB57C433C9
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 13:40:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="O6QUREMu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1687441228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NMlPufS1+CTdDaO981ksP6l0rkZcElrayPR5JrP7aTU=;
        b=O6QUREMucD3BV93ZIR2NQdJcKhi9tlXAhNyO5CwzMJBqEbergT6rsnmQLRcUHC/cDLSFCM
        2bEW3xgFdj/DE6afrePfSsT9EnOSufVIlDOcgCex0KWVZmV31rcsI4O41mLRC0ZILVYlNq
        Dq9KA1p7SPK/rMX/ho97xCIvdpOn0ik=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 655b255a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <stable@vger.kernel.org>;
        Thu, 22 Jun 2023 13:40:28 +0000 (UTC)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-440a925df4aso1797873137.2
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:40:28 -0700 (PDT)
X-Gm-Message-State: AC+VfDzgvzRtzEbphZSewpdtHYZeoHjTCmiDsg9iliLfLV0GLi45icG0
        o88V60iCBf9iwp5AsQ9WInr3bRWCOwb086J8BHg=
X-Google-Smtp-Source: ACHHUZ6AedmTTMjJkhooZ6D7XkXYhYsP+uTelsVSFnTDMTpR+pjxhEZxY8PIvy32HERqZ48Gh3qsLyZrMsiakU7W+Q8=
X-Received: by 2002:a67:fbd8:0:b0:440:b25f:5cab with SMTP id
 o24-20020a67fbd8000000b00440b25f5cabmr6443596vsr.15.1687441226959; Thu, 22
 Jun 2023 06:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <GQUnKz2al3yke5mB2i1kp3SzNHjK8vi6KJEh7rnLrOQ24OrlljeCyeWveLW9pICEmB9Qc8PKdNt3w1t_g3-Uvxq1l8Wj67PpoMeWDoH8PKk=@proton.me>
 <ZHFaFosKY24-L7tQ@debian.me> <NVN-hJsvHwaHe6R-y6XIYJp0FV7sCavgMjobFnseULT1wjgkOFNXbGBGT5iVjCfbtU7dW5xy2hIDoq0ASeNaXhvSY-g2Df4aHWVIMQ2c3TQ=@proton.me>
 <ZIcmpcEsTLXFaO0f@debian.me> <oEbkgJ-ImLxBDZDUTnIAGFWrRVnwBss3FOlalTpwrz83xWgESC9pcvNKiAVp9BzFgqZ0V-NIwzBZ7icKD8ynuIi_ZMtGt7URu3ftcSt16u4=@proton.me>
 <e2ca75ef-d779-4bad-84a5-a9f262dbe213@lunn.ch> <FNzHwp9-AyweVwIMndmih6VuBD0nsyRp3OM72bmOxpeYszF680jFPJjENIknT32FeaqfVBtVSQFw-5mgE3ZXeksVD8VCFbxwojxP3mSZ9DQ=@proton.me>
 <9517bb70-426c-0296-b426-f5b4f075f7c8@leemhuis.info> <CAHmME9oh7kEUe-6NFk9=_8UxeD-SNbfMksYh3GaYdutXS01zOw@mail.gmail.com>
 <CAHk-=who5-p3QKFnio2nA9b4yf0qrV-KZ8bJa7m80ouJbvOfoA@mail.gmail.com>
In-Reply-To: <CAHk-=who5-p3QKFnio2nA9b4yf0qrV-KZ8bJa7m80ouJbvOfoA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 22 Jun 2023 15:40:15 +0200
X-Gmail-Original-Message-ID: <CAHmME9obXuj3qM8RkVqoKeU41--HqzMF-KEdNcepFWKCMAXCfQ@mail.gmail.com>
Message-ID: <CAHmME9obXuj3qM8RkVqoKeU41--HqzMF-KEdNcepFWKCMAXCfQ@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Boot stall from merge tag 'net-next-6.2'
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sami Korkalainen <sami.korkalainen@proton.me>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Brad Spengler <spender@grsecurity.net>,
        regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 21, 2023 at 9:51=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Now, with non-repeatable boot failures, anything is possible, and Sami
> does mention 6.1.30 as good (implying that 6.1.31 might not be - and
> that is when the backport happened).
>
> So it's certainly worth checking out, but on the face of it, that
> bisection result doesn't really support the bug being due to
> e9523a0d81899 (which came *after* e7b813b32a42).

Sami - awaiting your results.
