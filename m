Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E745373BE54
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 20:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjFWSUf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 14:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjFWSUe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 14:20:34 -0400
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A652705
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 11:20:30 -0700 (PDT)
Date:   Fri, 23 Jun 2023 18:20:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1687544427; x=1687803627;
        bh=sqyZYV43F6W278PBn+QNb6bfWovuTOxia6lpaVS6ZSE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=F5WtJ0W6lyJQfjHub1jYVSMvVAO2KBh08wk48X7UEDK9qPvh+/yccIGrFy9k+0vE7
         Baw0Qfhds9o/I3WR/nRfYYAZID229+5vwc9myZHTwjA8dl11Vyd7tnumeUyXSkZMVY
         zL1V5tPmLJpRkMi+IecJtIROemHEQYGx09al+kvzFwZcvyGNS/tAOmUuOCVlV/8Cyi
         HiCMQiD36c4X2iTNaXBp2kLlcS/8d4fSwYTl/rJv4JrXmD2wEG0siG4HvZ1Oj9wZdW
         +jXzL1ZVnbOoogAha1u807/eQBNzL0x5DbN2ZLNj9Xi2QPuafMl+2MOxlGhm+Sa+b4
         bdu8bAQXsUMSQ==
To:     Ard Biesheuvel <ardb@kernel.org>
From:   Sami Korkalainen <sami.korkalainen@proton.me>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, regressions@leemhuis.info,
        Andrew Lunn <andrew@lunn.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [REGRESSION][BISECTED] Boot stall from merge tag 'net-next-6.2'
Message-ID: <CzNbNfn7R2cqLMD6_jp11Dku0OoXYJhx2AMfk8JXeQVP2EGdt7tqeYD4HH0COhp2o_yj5kN6Ao7oObSelRi8yiz-5ltbQ2xtjBvplvgcZjo=@proton.me>
In-Reply-To: <CAMj1kXHGkJsgArabs_mbzR3Y83s48qmf_aqb50k1LV1Hi5iNgA@mail.gmail.com>
References: <GQUnKz2al3yke5mB2i1kp3SzNHjK8vi6KJEh7rnLrOQ24OrlljeCyeWveLW9pICEmB9Qc8PKdNt3w1t_g3-Uvxq1l8Wj67PpoMeWDoH8PKk=@proton.me> <ZHFaFosKY24-L7tQ@debian.me> <NVN-hJsvHwaHe6R-y6XIYJp0FV7sCavgMjobFnseULT1wjgkOFNXbGBGT5iVjCfbtU7dW5xy2hIDoq0ASeNaXhvSY-g2Df4aHWVIMQ2c3TQ=@proton.me> <ZIcmpcEsTLXFaO0f@debian.me> <oEbkgJ-ImLxBDZDUTnIAGFWrRVnwBss3FOlalTpwrz83xWgESC9pcvNKiAVp9BzFgqZ0V-NIwzBZ7icKD8ynuIi_ZMtGt7URu3ftcSt16u4=@proton.me> <e2ca75ef-d779-4bad-84a5-a9f262dbe213@lunn.ch> <FNzHwp9-AyweVwIMndmih6VuBD0nsyRp3OM72bmOxpeYszF680jFPJjENIknT32FeaqfVBtVSQFw-5mgE3ZXeksVD8VCFbxwojxP3mSZ9DQ=@proton.me> <9517bb70-426c-0296-b426-f5b4f075f7c8@leemhuis.info> <CAHmME9p2ZLJUMq96vhkiSgvJkxP5BxE778MhY5Ou2WdxLVEJyg@mail.gmail.com> <CAMj1kXHGkJsgArabs_mbzR3Y83s48qmf_aqb50k1LV1Hi5iNgA@mail.gmail.com>
Feedback-ID: 45678890:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> However, the failure mode still strikes me as odd, and I'd be
> interested in finding out whether booting with efi=3Dnoruntime makes a
> difference at all, as that would prevent the SetVariable() all from
> taking place, without affecting anything else.

No boot stall with efi=3Dnoruntime. Tested on 6.3.9 and 6.4-rc7.
