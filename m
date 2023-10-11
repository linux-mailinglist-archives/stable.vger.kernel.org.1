Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009057C5A39
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 19:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjJKR1t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 13:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjJKR1s (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 13:27:48 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09E298
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 10:27:45 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9a58f5f33dso58622276.1
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 10:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697045265; x=1697650065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ux9l0w8MwnLT0igWhr7JaIiHQtbfOgsc08xSinU3ZPo=;
        b=zwv78Tgh1+jyOCA7IjpgSzWo28Vb32DC5uCOb3xX42u7MAahzPSBvKIeGUHT94i6WO
         xyFHgmDYHf9WsJCx7vArqxNR5PIUDbCTtLack+xiEEJ+I3oNv+HhpzpZ42o1ucMJuT4O
         d6En98q9xkI5PcJSW+slO8vWniyWKaD51TPn5lXldfUuPSH6Bs2jQfteVbgznqJn3JDF
         EmVoXRNDC2gWOMBDSiTKjd0EhTrPxqnR9wiV7auvuKfVtJs1Sv0wgxTa1DGYpjW6bOgT
         KUveSZBQxVXfBe0OfxEMx4LWoiYL4l/JO+izqmPTgLsoJyCWIn/BLe9MSJMEoMiZ9fFd
         YQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697045265; x=1697650065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ux9l0w8MwnLT0igWhr7JaIiHQtbfOgsc08xSinU3ZPo=;
        b=n5KzX/F35KSpnGQcY4O9YC+wP4dxon1FqhRpP/cHnJCPEjmg0e5083BZi4aaUdiesN
         rfYfQjeE9GBRp1Na4HsttyufcM/5pmMZSUKw7Lp6776lEnCXOc1WdLwhOsdgZV2k2y6f
         o4SwiMqkMnJlSwRmI/QG74YlZIiaVeYGHYnvrSHX9gPiUNjukrC2OwyiyZto4QKASqp5
         dsAJ/6XAvVTDkv1qL5SV12Fs7E6p5NLSxtM0C1qstJphUcswlqW4Vz4ExMKKPEqoL7EZ
         J9xHdvdBLFx7ZXGa8OazXIAFSzSPIgJaNSd02rftAwMbWg8WGTeMcSdZOUQdcs8gkP+n
         7Akw==
X-Gm-Message-State: AOJu0YwbnWZiEEBXHbvEdH8gZ+UCB3snuZ3D7Z6af4HTv0rebt1PMMjd
        ldI662Fc3CLVhMblBl7i6o7M9e2JM/0hCcq4HtaWHA==
X-Google-Smtp-Source: AGHT+IEQBUxAGueSbmH/ftTAGlXE9A+ltpTRdTrDbTEhQBxV4DZ94J8BvpuSx30G8cixjCAWrpDqrGG06hOXwp1ztB0=
X-Received: by 2002:a25:938b:0:b0:d15:e204:a7be with SMTP id
 a11-20020a25938b000000b00d15e204a7bemr21213352ybm.8.1697045265167; Wed, 11
 Oct 2023 10:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
 <065a0dac-499f-7375-ddb4-1800e8ef61d1@mojatatu.com> <0BC2C22C-F9AA-4B13-905D-FE32F41BDA8A@flyingcircus.io>
 <20231009080646.60ce9920@kernel.org> <da08ba06-e24c-d2c3-b9a0-8415a83ae791@mojatatu.com>
 <20231009172849.00f4a6c5@kernel.org> <CAM0EoM=mnOdEgHPzbPxCAotoy4C54XyGiisrjwnO_raqVWPryw@mail.gmail.com>
 <20231010112647.2cd6590c@kernel.org>
In-Reply-To: <20231010112647.2cd6590c@kernel.org>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Wed, 11 Oct 2023 13:27:34 -0400
Message-ID: <CAM0EoMkKm4VcQB7p1abg9d-Pozz7fV-isexDtA1rGX+NuJEykA@mail.gmail.com>
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC requirement
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Pedro Tammela <pctammela@mojatatu.com>, markovicbudimir@gmail.com,
        Christian Theune <ct@flyingcircus.io>, stable@vger.kernel.org,
        netdev@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 10, 2023 at 2:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 10 Oct 2023 11:02:25 -0400 Jamal Hadi Salim wrote:
> > > > We had a UAF with a very straight forward way to trigger it.
> > >
> > > Any details?
> >
> > As in you want the sequence of commands that caused the fault posted?
> > Budimir, lets wait for Jakub's response before you do that. I have
> > those details as well of course.
>
> More - the sequence of events which leads to the UAF, and on what
> object it occurs. If there's an embargo or some such we can wait
> a little longer before discussing?
>
> I haven't looked at the code for more than a minute. If this is super
> trivial to spot let me know, I'll stare harder. Didn't seem like the
> qdisc as a whole is all that trivial.

The qdisc is non-trivial. The good news is we now know there's at
least one user for this qdisc ;->

cheers,
jamal
