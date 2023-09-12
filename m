Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C567579D2E5
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 15:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjILNx2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 09:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbjILNxT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 09:53:19 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A617A1992
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:53:13 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-500c37d479aso9195709e87.2
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1694526792; x=1695131592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sj3TDD9XY/2NurDLatMBw2VIZpwYLfq4TtQJpIkMx6E=;
        b=K0CNPnbeFR5wESgn+ABlF+oEogYRRYfate2plw1qsxzkp2b1kz253LGGmpPLWJnnOk
         08fZ1f3OHTho2Isgj1o2EBLz4GDV5dAVoNBN23Q2NxHbmAHBPjk3joCfvFXetBxdBnTi
         R1+Ojah0s3hOrtz0M5eTp392fN5qlYUfhSy0L5eK6sKxwHVV3VsjpiJwCS8/s6B3p1k9
         fuOmAheDKQJGTBZA60MGgm+4K0LumiVkc+iiOqmuEWrqnxputteJA9MVUELMkSeVpXkw
         OI9mM05GwkKpnRGffs/bt8GJnkgLio0pxlXMkC/cLmOaNeUvXjJIPeBmQyMLg1s9yeET
         amXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694526792; x=1695131592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sj3TDD9XY/2NurDLatMBw2VIZpwYLfq4TtQJpIkMx6E=;
        b=Pl9UsOWNagdb578wODIwz0zjfZr+DWZOreYnS/DM4UH+AHVi50R1DI2J7fSWXf9E71
         gfdTfDek6devQxpjrloDoTxH2XNk3oqXGPeDLQ0xLsH48HqQIq6dB8g3sUs4ov3ymcQt
         WA0TDvooLqvFUh8S9qFmxYiHSD+4CNuH9RYxNDEH94ACs+Qzb0MN94db20Io8gaMYg5B
         B4ksWbzfMSiDCIubT6oX1C3hSbI5dZCB2Y+rBNkbhVWXG321LmJV1ZJ+GvGLU6v954vK
         s3NDGnMPo3c+o12LGrrR5AmAkdiqebZuXYgHGJgNeJbzCVklPuoTb9hR5tvYJ3uaRDc8
         BXBQ==
X-Gm-Message-State: AOJu0YxdhCqVR2BsEg3Up/ETsTmhKRE4R7SJuL/6C47TyW01S1qWDF9y
        KGZzzfOdoBh7IBoVhIvKry6IOS4UQq8cyE+Hx/KLIQ==
X-Google-Smtp-Source: AGHT+IGGeEhCa84Ovvh4yQ9qAKoZAggX1AgyD4kvc5kwGZD3MWrBiul84PCjt9rrxjfmod32z2JZ27cggvsC8Kl6MOc=
X-Received: by 2002:ac2:5991:0:b0:500:8fcd:c3b8 with SMTP id
 w17-20020ac25991000000b005008fcdc3b8mr9492054lfn.8.1694526791495; Tue, 12 Sep
 2023 06:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAMGffEmtW+95Hsmf-6sZmS76Mpdt+R6uYQKtjbLup+iX96eVfg@mail.gmail.com>
 <2023091241-ecology-greyhound-4e24@gregkh>
In-Reply-To: <2023091241-ecology-greyhound-4e24@gregkh>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 12 Sep 2023 15:53:00 +0200
Message-ID: <CAMGffEkSQ-d4sHL3tvDvEsf7TE4Bn7yWUraTqw374Leor1CS2Q@mail.gmail.com>
Subject: Re: Regression with raid1 in stable 5.15.132-rc1 and 6.1.53-rc1
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 12, 2023 at 2:08=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 12, 2023 at 01:46:29PM +0200, Jinpu Wang wrote:
> > Hi Greg and Stable folks.
> >
> > We've noticed regression in raid1 due to following commits:
> > 79dabfd00a2b ("md/raid1: hold the barrier until handle_read_error() fin=
ishes")
> > caeed0b9f1ce ("md/raid1: free the r1bio before waiting for blocked rdev=
")
>
> I'll drop them from all queues, but can you test 6.6-rc1 to be sure that
> all is ok there?
Sure, I will test 6.6-rc1.
>
> thanks,
>
> greg k-h
Thx
