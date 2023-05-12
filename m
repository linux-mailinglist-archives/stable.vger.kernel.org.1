Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC3C70096C
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 15:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241203AbjELNsy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 09:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240963AbjELNsw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 09:48:52 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4CB12EA9;
        Fri, 12 May 2023 06:48:51 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ab13da70a3so96134975ad.1;
        Fri, 12 May 2023 06:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683899330; x=1686491330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6xvzEXyDsENHQd2trIjdOsTv/FkyNGg39h9NWdAg4uY=;
        b=Kfm6Tk9N8hvSffS15wK5IU29YeLWGRDi9/30X6JkYBMlg51B8oEepxwMh+xWLajxHk
         bEZal+CVzLzW5KoWuzrUUL5JmjKS1uFKe7DgX8pEfX+IlHoLl34eJOCIt54gsZ9zp2ko
         vCJ8RMomxyhty3eEEx1I15SaaTLk2atrgblLcrv77bDys+07oMJ3VizxJuEm1e+DduIZ
         7lT75pUhY9C1oAyUHrwqTO6e5gNKwlqjIMO2iSndOQgqHUpXcXlOyrm6Mt1GsA57hK3O
         KS+VkKUjeJzolBdXHiNsoBXukRusiHhoTNFb3KHt6oy0WERpZ1tfHqYft/oWVS+wcrJL
         pLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683899330; x=1686491330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xvzEXyDsENHQd2trIjdOsTv/FkyNGg39h9NWdAg4uY=;
        b=PXoh9e01picuhbyzqdXNdc2ppl95gYX/bFPavHYblpUnPxhH4VlQcX8cWPLsZ2RLIb
         kGBlQmStBDQakLfnLZfnuSPvZqAiU2+d6TH8PEz8ziHLQGO8FC73GPbcM+NM3tkO/K3L
         zNFgPJ/IQ8EmbURj9sXgYePcCCWvG25bXJwZCD44dFhRss7Z9/9qCGrMJ5jM9D1iutVX
         vJdblSNere2tvOCBP03wViPlmWv2JYOTMXwKw3gmZThA7b91BUCCh736x7DcZU2vM+es
         tTBVevt09zkBHYrwa+P1VP6eOhbL9xKQIF3Vcp20VIIL+juZ4xZQYKC5OPtSYXs7kpOn
         Ao+Q==
X-Gm-Message-State: AC+VfDwQlhYuWjh/luY5mQ0UQlmgIAyaC0J+0PuagESuPpE/KxzrnwSc
        ThzmiX2o2+9wMDvVIVtHCvuDhvWrjAe2ig==
X-Google-Smtp-Source: ACHHUZ6k7WV7m+3s6Rs/xuXz+1ut7fJPmcn5PAjaJSL8tlNyfz1QckxCuV5mdf8gkDC6pX1lDCkkKw==
X-Received: by 2002:a17:903:185:b0:1a1:e237:5f0 with SMTP id z5-20020a170903018500b001a1e23705f0mr33021596plg.58.1683899330548;
        Fri, 12 May 2023 06:48:50 -0700 (PDT)
Received: from debian.me (subs09b-223-255-225-227.three.co.id. [223.255.225.227])
        by smtp.gmail.com with ESMTPSA id g22-20020a1709029f9600b001a1c721f7f8sm7901772plq.267.2023.05.12.06.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 06:48:50 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 84551106A0F; Fri, 12 May 2023 20:48:46 +0700 (WIB)
Date:   Fri, 12 May 2023 20:48:46 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Francesco Dolcini <francesco@dolcini.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, stable@vger.kernel.org
Cc:     francesco.dolcini@toradex.com, liu.ming50@gmail.com,
        Badhri Jagan Sridharan <badhri@google.com>
Subject: Re: USB gadget regression on v6.4-rc1 and v6.1.28
Message-ID: <ZF5DvpOGGMTIIptx@debian.me>
References: <ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ymYbBZk3RZHol3+p"
Content-Disposition: inline
In-Reply-To: <ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--ymYbBZk3RZHol3+p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2023 at 11:07:10AM +0200, Francesco Dolcini wrote:
> Hello all,
> I recently did have a regression on v6.4rc1, and it seems that the same
> exact issue is now happening also on v6.1.28.
>=20
> I was not able yet to bisect it (yet), but what is happening is that
> libusbgx[1] that we use to configure a USB NCM gadget interface[2][3] just
> hang completely at boot.
>=20
> This is happening with multiple ARM32 and ARM64 i.MX SOC (i.MX6, i.MX7,
> i.MX8MM).
>=20
> The logs is something like that
>=20
> ```
> [*     =EF=BF=BDF] A start job is running for Load def=E2=80=A6t schema g=
1.schema (6s / no limit)
> M[K[**    =EF=BF=BDF] A start job is running for Load def=E2=80=A6t schem=
a g1.schema (7s / no limit)
> M[K[***   =EF=BF=BDF] A start job is running for Load def=E2=80=A6t schem=
a g1.schema (8s / no limit)
> M[K[ ***  =EF=BF=BDF] A start job is running for Load def=E2=80=A6t schem=
a g1.schema (8s / no limit)
> ```
>=20
> I will try to bisect this and provide more useful feedback ASAP, I
> decided to not wait for it and just send this email in case someone has
> some insight on what is going on.
>=20

Thanks for the report. I'm adding it to regzbot:

#regzbot ^introduced: 0db213ea8eed55
#regzbot titile: libusbgx hang completely at boot (stuck at loading g1.sche=
ma)

--=20
An old man doll... just what I always wanted! - Clara

--ymYbBZk3RZHol3+p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZF5DtwAKCRD2uYlJVVFO
o4qOAQDO9PNiRuKEsUvIqOWbxp2Lo3cwMGFNMFvVp1Be++PB6QEAuaOlI3oULkid
PDbhZCvc6xTB1Q1XA5UW4kqSK6hsIws=
=xkQO
-----END PGP SIGNATURE-----

--ymYbBZk3RZHol3+p--
