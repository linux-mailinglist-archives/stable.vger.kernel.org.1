Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E7D7F09D0
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 00:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjKSXPO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 19 Nov 2023 18:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKSXPN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 19 Nov 2023 18:15:13 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FBC12D;
        Sun, 19 Nov 2023 15:15:09 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5aa7172bafdso2329112a12.1;
        Sun, 19 Nov 2023 15:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700435709; x=1701040509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G6/k5GA4Zu2CBZHKMjmxzODMRb4rQCOlqXBDpojsfK4=;
        b=cfPH9RmsBgKpdCP3OWFxO47lJiw20itBdGv5+lIOc/FuutC5zcMWrLxJxeDjidMFYB
         aKR+C+08EKTbMTiUc+QxD4yAQlgNHpT4+RgimB3PUCi6E9BYGLCRMbLsN879oW6/5DwA
         c30f+KQAONFYClzCRYvfjb8XitrTipAjoUi1XYFA/Q7tmBE08ZJ0yd+JB2iKICe1Hdcd
         jxFSn5grlColyNHWdw+k44AtwCjvJOA8TWWOV14RZ61oYVPFOc3g/blyQKg8zWZaxdUO
         4KNv3vvCNsrb5QE9QrMDldF8ZUp15HIfvBdeyQfNHlei1UvS7LyMmg3gL+LDx+p1Bj5h
         D6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700435709; x=1701040509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6/k5GA4Zu2CBZHKMjmxzODMRb4rQCOlqXBDpojsfK4=;
        b=hR9IMFN4XjW5JV0/LmJdhIMgSEf9y/KyjCUT1MJf7428Aoj/E3nynw5I59A12qDBru
         Z/BIq2x1nyS4mrZ/zPdYVYQAnQEA2ySbbnbsuc+n9ln/bko/Trh6SoiBpDzfKraJf2A8
         g1VoSzBlLaBht+3D+V54ZVI40bx3ZCVwWj2zMpXfm4F2XCcyJHYu2NzjMTyoBQqzzcrb
         ptOpWa5F3IZeLZqr6wW9n0DtbmN/eDMzZtc7VhSa0EDAXKX3q3wXR4DhfIWXKGdwNHd1
         ybYDG/l58Qa2SSPfcuJcWVXi0LlcSl3ei3cij2ABgL3bdt+SbgYt3q/FhfX74VH8wdnc
         fc+g==
X-Gm-Message-State: AOJu0YzN/LPTBFQnwj/tzflTXasqQ1r5MHW8sKoi8huXMsplgbQ2rCWQ
        TYDtUkb6AKD9N/yTWb4p2tI=
X-Google-Smtp-Source: AGHT+IGZD+EOLCB2oniF4xIOMnu0nOKZnxU9Sb/a4aFuMwwTyHgjsXLjF0jrEAksNzjiyG0JL5bEQg==
X-Received: by 2002:a05:6a21:9812:b0:187:72e7:6d8c with SMTP id ue18-20020a056a21981200b0018772e76d8cmr3714726pzb.31.1700435709219;
        Sun, 19 Nov 2023 15:15:09 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id z10-20020a17090a1fca00b0028010142010sm7148064pjz.21.2023.11.19.15.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 15:15:08 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id AD6CE101D818B; Mon, 20 Nov 2023 06:15:05 +0700 (WIB)
Date:   Mon, 20 Nov 2023 06:15:05 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     =?utf-8?B?QW5kcsOp?= Kunz <donatusmusic@gmx.de>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Input Devices <linux-input@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Found a bug with my gaming gear
Message-ID: <ZVqW-Ux7NM2958MR@archie.me>
References: <bd1a6eb1-a8af-4181-b9e4-c7b8d3af1eea@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t4to0E1nKF26Mn34"
Content-Disposition: inline
In-Reply-To: <bd1a6eb1-a8af-4181-b9e4-c7b8d3af1eea@gmx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--t4to0E1nKF26Mn34
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 11:41:34PM +0100, Andr=C3=A9 Kunz wrote:
> Hey there guys,
>=20
> This is my first kernel "bug" report ever, so please bear with me if I
> didn't catch the precise right way to report this.
>=20
> The bug I've found:
>=20
> I'm running stable kernel 6.6.1-1 and as soon as I install it, many of
> my mouse's hardware buttons stop working. I have a Logitech G502 X Plus
> (it's a wireless mouse). As soon as I install 6.6.1 the mouse's hardware
> buttons won't work, i.e. only the two side-buttons would work, not the
> buttons (and/or my created profiles/macros) would. I have a few macros
> assigned to some buttons, which work perfectly fine under 6.5.11 (and
> earlier), but as soon as I'm on 6.6 they'd stop working.
>=20
> Just wanted to report this and I hope there can be a fix.
>=20

Thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: v6.5..v6.6
#regzbot title: only two side buttons of Logitech G502 X Plus works on kern=
el 6.6.1

--=20
An old man doll... just what I always wanted! - Clara

--t4to0E1nKF26Mn34
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZVqW9QAKCRD2uYlJVVFO
o8PPAQCq0F+cAeJ176ztPmrCMvN0ZhNToRKuvLv1ZWZyFDA1+AD+PRj9t7cEmyF5
dFgpz6+r6olAybxIkgk5DXSb/31v9Aw=
=Yfpq
-----END PGP SIGNATURE-----

--t4to0E1nKF26Mn34--
