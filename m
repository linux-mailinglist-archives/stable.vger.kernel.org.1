Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19D3700C1B
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 17:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241913AbjELPmk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 11:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjELPmj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 11:42:39 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A128540E0;
        Fri, 12 May 2023 08:42:37 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 5673BCED62;
        Fri, 12 May 2023 15:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683906125; bh=x5wx3qPeUPAaZ+OCg9/XZryg09jLh6IL74dCZ6DqjZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UaTIoNNgOBwE/e4MgK8y3oP6Il2dc5hz9hdMc92y/vTrsbt3+Q/c/UGZG/zeTbzqC
         B8kOP0C7JCyxGgtbOkENDhAmf7oJSg3d77pANEhL+7rn9PSrOOtgCWRGedDFT4YVq8
         waO28/6K7Cndw2hzg/ABh/+KVAOYH3ZY3fFs89n8=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Francesco Dolcini <francesco@dolcini.it>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, stable@vger.kernel.org,
        francesco.dolcini@toradex.com, liu.ming50@gmail.com,
        Badhri Jagan Sridharan <badhri@google.com>
Subject: Re: USB gadget regression on v6.4-rc1 and v6.1.28
Date:   Fri, 12 May 2023 17:42:03 +0200
Message-ID: <13285014.O9o76ZdvQC@z3ntu.xyz>
In-Reply-To: <ZF4bMptC3Lf2Hnee@gerhold.net>
References: <ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com>
 <ZF4bMptC3Lf2Hnee@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Freitag, 12. Mai 2023 12:55:46 CEST Stephan Gerhold wrote:
> On Fri, May 12, 2023 at 11:07:10AM +0200, Francesco Dolcini wrote:
> > Hello all,
> > I recently did have a regression on v6.4rc1, and it seems that the same
> > exact issue is now happening also on v6.1.28.
> >=20
> > I was not able yet to bisect it (yet), but what is happening is that
> > libusbgx[1] that we use to configure a USB NCM gadget interface[2][3] j=
ust
> > hang completely at boot.
> >=20
> > This is happening with multiple ARM32 and ARM64 i.MX SOC (i.MX6, i.MX7,
> > i.MX8MM).
> >=20
> > The logs is something like that
> >=20
> > ```
> > [*     =EF=BF=BDF] A start job is running for Load def=E2=80=A6t schema=
 g1.schema (6s / no
> > limit) M[K[**    =EF=BF=BDF] A start job is running for Load def=E2=80=
=A6t schema
> > g1.schema (7s / no limit) M[K[***   =EF=BF=BDF] A start job is running =
for Load
> > def=E2=80=A6t schema g1.schema (8s / no limit) M[K[ ***  =EF=BF=BDF] A =
start job is
> > running for Load def=E2=80=A6t schema g1.schema (8s / no limit) ```
> >=20
> > I will try to bisect this and provide more useful feedback ASAP, I
> > decided to not wait for it and just send this email in case someone has
> > some insight on what is going on.
>=20
> I noticed a similar problem on the Qualcomm MSM8916 SoC (chipidea USB
> driver) and reverting commit 0db213ea8eed ("usb: gadget: udc: core:
> Invoke usb_gadget_connect only when started") fixes it for me. The
> follow-up commit a3afbf5cc887 ("usb: gadget: udc: core: Prevent
> redundant calls to pullup") must be reverted first to avoid conflicts.
> These two were also backported into 6.1.28.

Hi,

to confirm I'm seeing the same issue on Qualcomm MSM8974 and MSM8226 boards=
=2E=20
Reverting the patches Stephan mentioned makes it work again on v6.4-rc1.

Regards
Luca

>=20
> I didn't have time to investigate it further yet. With these patches it
> just hangs forever when setting up the USB gadget.
>=20
> Stephan




