Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA63E7BADAD
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 23:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjJEViS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 17:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJEViS (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 17:38:18 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E5395
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 14:38:17 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-419b53acc11so116061cf.0
        for <stable@vger.kernel.org>; Thu, 05 Oct 2023 14:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696541896; x=1697146696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nRT9P7Z9k4O2b9FyVLYjnAd64IIajcQIX0NQ/hAgqw=;
        b=CZLckd0PcaNMq8Q1r0JM0fRzunLiP9UF8/emzVubGZuuFPQ4LkSl6hJhUhlBYMpsVu
         Lejp3D0Xtmh5mIJjS/QiUOTIKaKNNcD6Schri/gn6wAFCVaX9uelL6PfxVmbi2OA3fOi
         pHoSAMoEc6xbX/4wLu5XvKQ1V4D/VNhuncrYPJtn6MpsZk2EDRDhWEMk6YqltPaOaOdU
         ojN0hYECHsFZpkkYlzi/udXy+1TuRS9LTibkGq50SdboY4NV7HqgI5MvWOb5Yy8rM4gb
         i6+sEX/DubLWf8Q8Sc9qqOM0fudgkw2Jh+y0lycOSU83RZ1yQLo4xvRFLM/UhPj12Y7r
         MzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696541896; x=1697146696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nRT9P7Z9k4O2b9FyVLYjnAd64IIajcQIX0NQ/hAgqw=;
        b=auI6lfYvrm1WoZYAm/szqUrrg2tIDAh0OsoXB6uclY0/sKbIReqtZ8EGpSEXtm4rfp
         B4gPFrxUOiMq1Y940YlOpQ7H453ZQU4bSfYTQduLfHrROhS81aKalp1SEmFXFkxucn9K
         hz4bObskrQTA9tip8nhY6yMcmvjVrUlfX9YGdM8Jeme4pQDCAO+sCvEn9weVfmt+wPLe
         0BW40eUd+HFG0ChwcSpvcjAooi5rcvV6xuovK6erW0P72TTpmdOy+s9pf5ZVmd34T96J
         Hr0PLEV4lJP/Gc+litRc1rmDGhqnzbRGKrFIaK1/0AZJUZRZfyMixE5w8n6J6TOj4Cyd
         9EfA==
X-Gm-Message-State: AOJu0YyzBNtk4WUhSDMVXMZdsZSsU91IkyGipGrG9Z5kIlCZklCdlCIr
        XNeyOkq52wpIaep4oSR/q5EjVKsgYdOvA/AL4oUsXgB5xvwt+sSAumA=
X-Google-Smtp-Source: AGHT+IGxFZ38GZhIeOF0sXOPlhB7u9LJdAaa6tYBh+kL8FiBE80vPFiVNDxaQyiqnTaD4uvxnKECth9yJOmQmFVLUN8=
X-Received: by 2002:a05:622a:646:b0:417:cd34:2a7b with SMTP id
 a6-20020a05622a064600b00417cd342a7bmr256967qtb.3.1696541896094; Thu, 05 Oct
 2023 14:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230925211034.905320-1-prohr@google.com>
In-Reply-To: <20230925211034.905320-1-prohr@google.com>
From:   Patrick Rohr <prohr@google.com>
Date:   Thu, 5 Oct 2023 14:37:59 -0700
Message-ID: <CANLD9C1gOnYNPtSn=dMv9YjBz3H0qW6xRZdM-PYkG+Gnz7q-bg@mail.gmail.com>
Subject: Re: [PATCH 6.1 0/3] net: add sysctl accept_ra_min_lft
To:     stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Sep 25, 2023 at 2:10=E2=80=AFPM Patrick Rohr <prohr@google.com> wro=
te:
>
> This series adds a new sysctl accept_ra_min_lft which enforces a minimum
> lifetime value for individual RA sections; in particular, router
> lifetime, PIO preferred lifetime, and RIO lifetime. If any of those
> lifetimes are lower than the configured value, the specific RA section
> is ignored.
>
> This fixes a potential denial of service attack vector where rogue WiFi
> routers (or devices) can send RAs with low lifetimes to actively drain a
> mobile device's battery (by preventing sleep).
>
> In addition to this change, Android uses hardware offloads to drop RAs
> for a fraction of the minimum of all lifetimes present in the RA (some
> networks have very frequent RAs (5s) with high lifetimes (2h)). Despite
> this, we have encountered networks that set the router lifetime to 30s
> which results in very frequent CPU wakeups. Instead of disabling IPv6
> (and dropping IPv6 ethertype in the WiFi firmware) entirely on such
> networks, misconfigured routers must be ignored while still processing
> RAs from other IPv6 routers on the same network (i.e. to support IoT
> applications).
>
> Patches:
> - 1671bcfd76fd ("net: add sysctl accept_ra_min_rtr_lft")
> - 5027d54a9c30 ("net: change accept_ra_min_rtr_lft to affect all RA lifet=
imes")
> - 5cb249686e67 ("net: release reference to inet6_dev pointer")
>
> Patrick Rohr (3):
>   net: add sysctl accept_ra_min_rtr_lft
>   net: change accept_ra_min_rtr_lft to affect all RA lifetimes
>   net: release reference to inet6_dev pointer
>
>  Documentation/networking/ip-sysctl.rst |  8 ++++++++
>  include/linux/ipv6.h                   |  1 +
>  include/uapi/linux/ipv6.h              |  1 +
>  net/ipv6/addrconf.c                    | 13 +++++++++++++
>  net/ipv6/ndisc.c                       | 13 +++++++++++--
>  5 files changed, 34 insertions(+), 2 deletions(-)
>
> --
> 2.42.0.515.g380fc7ccd1-goog
>

Was this rejected?
Any resolution on this (ACK or NAK) would be useful. Thanks!
