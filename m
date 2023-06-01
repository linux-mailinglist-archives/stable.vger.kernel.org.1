Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA4071F239
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 20:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjFASlQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 14:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjFASlQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 14:41:16 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF42C0
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 11:41:13 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-565e8d575cbso11558697b3.3
        for <stable@vger.kernel.org>; Thu, 01 Jun 2023 11:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685644872; x=1688236872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5i/rugn+JHUgORqydvrNDiIVwaGMt1EtS6/u1rW4UPA=;
        b=c/MuLf0sLmCBBP+yaYo9+dtwBeInkrRGB/omLUGl2EMwH5sQ7UEto2uLC1r5/FTzYX
         iPq0Em2iLsipRDL+eePBG9Yz0xIFZ/iaTTkbgVEldT+Ps30PV+7Ws6xS/lR0BjkzhHy7
         n6g8OKpPUzpSaI5pAFb4KKtnmUOAaK+b2D+c12WplM7p43KLfY+3NzTmcCtihLclUoxE
         PNFBqFShNH1TmCbLjf9fM32IGb88GqVRG7CI9WG/g1CPPyE7UGmTDTA42IuFN8GfUNnj
         fOAzMfEJWwPzoCFGYmh1SvffX5fFqGDsq/XI1ZHhy2b7fT5Kg7du+G2wEtdB+4thruOd
         YAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685644872; x=1688236872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5i/rugn+JHUgORqydvrNDiIVwaGMt1EtS6/u1rW4UPA=;
        b=MynV3A1cnDZwWpiTUEQVJeCDgsq0umVikn1+SiySKHnqfPf2EgAN0Z5By3OWKTrBOD
         b3VMle6WysoXBXs1IiACi+01cqNzpI8L3EbLw8boKD2QXUXdxq31yvrXGctQ3YZGtQWo
         AZtzxS+Iwi1ybqnTu35Zr2jBVOtKgzFw1pgpVSVQKf5ij4JCU13eWwSpR6tZlfnzLVl5
         x0VNIhLpr10SFiH/in/n5D0zM78dTh8v7D2RUpD0KLdu3A+2dDSX6sowq8Ii4tV/F10B
         FbE+att8Y3PlTxnYRe2nTmKIQdSGqZtPqTlFmrnBbUtEM/WoBtKgzkdCbffVlh2D2BTj
         sKqA==
X-Gm-Message-State: AC+VfDyauTiYML6XSaLTF7rmefaw8f8TMxKw0C2x0+mIdvfb29kl65Co
        Icq8VybC4xPJ6W4URwbkSe9srWueut/jm2ZwdFQVbGVbUJIdEcs=
X-Google-Smtp-Source: ACHHUZ44a8Y+PnGW85VKG3dLAFnmUo27y/2/GyAkHMtdo65xdTf+Q77T1RoVsC1bhXMgAtL8kVzbh+pUFhIioO0fYlA=
X-Received: by 2002:a81:6b09:0:b0:545:637c:3ed7 with SMTP id
 g9-20020a816b09000000b00545637c3ed7mr10148481ywc.1.1685644872288; Thu, 01 Jun
 2023 11:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <8892cb92-0f30-db36-e9db-4bec5e7eb46e@amazon.com>
 <CAHC9VhTmKbQFx-7UtZgg8D+-vtFOar0dMqULYccWQ2x7zJqT-Q@mail.gmail.com>
 <bb1e18f8-9d31-1ec7-d69a-2d1f5af31310@amazon.com> <CAHC9VhTFzN_Y_7HBroJnbTHL2NZEYjFy9BB3JJJBKnwv_k25dw@mail.gmail.com>
 <d2b14172-7aeb-be98-ded2-b4ce255dccaf@amazon.com> <2023060120-monopoly-math-3bc5@gregkh>
 <CAHC9VhTdZ=-Tmi=nPzKFHRoiE+oWNFWrXr=oG70fti9HNCgrWQ@mail.gmail.com> <94516854-c5b6-e626-9f8e-d6600011dcf5@amazon.com>
In-Reply-To: <94516854-c5b6-e626-9f8e-d6600011dcf5@amazon.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Jun 2023 14:41:01 -0400
Message-ID: <CAHC9VhRd3QRb9YGMhdYrzRT1yoW7fErtyHS+qxoyc1uiL5hT3Q@mail.gmail.com>
Subject: Re: Possible build time regression affecting stable kernels
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, sashal@kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 1, 2023 at 2:15=E2=80=AFPM Luiz Capitulino <luizcap@amazon.com>=
 wrote:
> On 2023-06-01 14:10, Paul Moore wrote:
> > On Thu, Jun 1, 2023 at 1:05=E2=80=AFPM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> >> On Thu, Jun 01, 2023 at 11:50:16AM -0400, Luiz Capitulino wrote:
> >>> On 2023-06-01 11:45, Paul Moore wrote:
> >
> > ...
> >
> >>>> I don't want to block on fixing the kernel build while I keep chasin=
g
> >>>> some esoteric build behavior so I'm just going to revert the patch
> >>>> with a note to revisit this when we require make >=3D 4.3.
> >>>>
> >>>> Regardless, thanks for the report and the help testing, expect a
> >>>> patch/revert shortly ...
> >>>
> >>> Thank you Paul, I really appreciate your fast response. I'd also
> >>> appreciate if you CC me in the revert patch so that I don't loose
> >>> track of it.
> >>
> >> And please add a cc: stable@ to it too :)
> >
> > Done, and done.  I just sent the patch so give it a few minutes if you
> > haven't seen it yet.  I'll leave it for a few hours in case anyone can
> > give it a test build before I send it up to Linus.
>
> Thanks Paul, I can test it but it may take more than a few hours for me.

Okay, no worries, I'll hold off until I hear back from you.  I'd
rather it take a little longer in order to get the warm fuzzies you
get from a 'Tested-by:' by one of the 'Reported-by:' people :)

Thanks for all your help with this Luiz.

--=20
paul-moore.com
