Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960FC7082B7
	for <lists+stable@lfdr.de>; Thu, 18 May 2023 15:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjERNb2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 18 May 2023 09:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjERNb1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 18 May 2023 09:31:27 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E13EC
        for <stable@vger.kernel.org>; Thu, 18 May 2023 06:31:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-25344113e9bso1491151a91.3
        for <stable@vger.kernel.org>; Thu, 18 May 2023 06:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684416686; x=1687008686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=07jbkWZvVWjpNcKjxaXoMx/wlMgnDj/DjSx7DmqYFT8=;
        b=lzpDaJAXMALSOUcCHSZtsWI12iYitCMms76PC56TCFywRRfHP1N5L6XZE6NeF4PaMu
         nBUihCwtYHfjTDrzNznS/atSsJYSiHiGx4wL+yNWWsLr8P6BcW1vljTvxt8FuE4VMRw5
         eX18NtgpssDdkdsR5UPI9Fnv9Qcnp8ixsuU41+AzfWVt+GgDW8p4owawNuHv4GmVyZbG
         zlud1ijZwULP4ZxeFyRLk+gIKlTvqIkkFSDKDuVRVvfnDKL3nlTTTVoG3DFCDhTdTwFI
         LKDYWpOVsUQMrpM6rnwdBvK7JQdsUNQnJwZN2m/f50nj7xB0WZZyUTlaG1LLIA1ozF2H
         nRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684416686; x=1687008686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07jbkWZvVWjpNcKjxaXoMx/wlMgnDj/DjSx7DmqYFT8=;
        b=KDMM19twdkSR2dP1rb+KhMQ61zP3ND6QXDcMnCFkkSs0zseC+wJHxei9xVveiBi6DP
         25UCvTpQOWYKihtHj23450+I2kxuwCfdfkPWkMv86MaAeJqBAW53OdoHYRiPpj5p0mTt
         Y7nFK5sDJcZu/gs+XxqPWqMHLj5MvowufhSp0dPFHdKwffTgBzC+97h1ZGh0x8S2Wy0Z
         FJyepDfbdbvF6DjHFVq838YyWpfUvG44GWWfbQ2LHsLRCut5+X6KRFeNiT14AtoJCBck
         PgyHCFgIoxDuLc1BwecNtnO0dE6Vxrt+1vDqe3pcQcTfoE70DAc3j2qIoUrDC6kVHPFO
         tbIw==
X-Gm-Message-State: AC+VfDxB+/VglhtGFRltbdu2ZHxEXF4TGMk9t0zTC1L0HByUrKGtkO40
        GKWuIQDC7UuiXmvSkX+Xuc8=
X-Google-Smtp-Source: ACHHUZ6Rg39C5s3A5szjjXrbwt9+lrhInJP56naXUPdn570zbNmxeD3burzDiugaUyMp+7pNS5at4Q==
X-Received: by 2002:a17:90a:ba8a:b0:252:b14a:55c2 with SMTP id t10-20020a17090aba8a00b00252b14a55c2mr2560424pjr.9.1684416686127;
        Thu, 18 May 2023 06:31:26 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-78.three.co.id. [180.214.233.78])
        by smtp.gmail.com with ESMTPSA id u11-20020a63f64b000000b00513cc8c9597sm1213765pgj.10.2023.05.18.06.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 06:31:25 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0AED1105431; Thu, 18 May 2023 20:31:21 +0700 (WIB)
Date:   Thu, 18 May 2023 20:31:21 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     =?utf-8?B?w4lyaWM=?= Brunet <eric.brunet@ens.fr>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     stable@vger.kernel.org, regressions@lists.linux.dev,
        jouni.hogander@intel.com, jani.nikula@intel.com,
        gregkh@linuxfoundation.org
Subject: Re: Regression on drm/i915, with bisected commit
Message-ID: <ZGYoqbhkxkCg9m7d@debian.me>
References: <3236901.44csPzL39Z@skaro>
 <ZGU56n66OAe0DqN3@intel.com>
 <5681706.DvuYhMxLoT@skaro>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EoPTFpm/moMAQdNP"
Content-Disposition: inline
In-Reply-To: <5681706.DvuYhMxLoT@skaro>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--EoPTFpm/moMAQdNP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 10:14:30AM +0200, =C3=89ric Brunet wrote:
> Le mercredi 17 mai 2023, 22:32:42 CEST Ville Syrj=C3=A4l=C3=A4 a =C3=A9cr=
it :
> > On Tue, May 16, 2023 at 03:04:53PM +0200, =C3=89ric Brunet wrote:
> > > Hello all,
> > >=20
> > > I have a HP Elite x360 1049 G9 2-in-1 notebook running fedora 38 with=
 an
> > > Adler Lake intel video card.
> > >=20
> > > After upgrading to kernel 6.2.13 (as packaged by fedora), I started s=
eeing
> > > severe video glitches made of random pixels in a vertical band occupy=
ing
> > > about 20% of my screen, on the right. The glitches would happen both =
with
> > > X.org and wayland.
> >=20
> > Please file a bug at https://gitlab.freedesktop.org/drm/intel/issues/new
> > boot with "log_buf_len=3D4M drm.debug=3D0xe" passed to kernel cmdline, =
and
> > attach the resulting dmesg to the bug.
>=20
> Thank you for your answer, I have just opened the issue as requested.
>=20
> https://gitlab.freedesktop.org/drm/intel/-/issues/8480
>=20

Thanks for the ticket link. Now telling regzbot (and updating the
culprit since you also mention the mainline commit that I assume to
be the culprit [please verify if it is indeed the case]):

#regzbot introduced: e1c71f8f918047
#regzbot link: https://gitlab.freedesktop.org/drm/intel/-/issues/8480

--=20
An old man doll... just what I always wanted! - Clara

--EoPTFpm/moMAQdNP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZGYopAAKCRD2uYlJVVFO
o8G8APwJFW+7qatzqJqrpNTFfK9bpbBnUHaHoPoNI1Tyx0MpYwEAlnopo9cQ2Zxe
70ZgR4r8JbUANNEcYs8gkToi/+ClAQs=
=J/5J
-----END PGP SIGNATURE-----

--EoPTFpm/moMAQdNP--
