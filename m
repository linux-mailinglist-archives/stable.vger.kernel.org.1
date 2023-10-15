Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132157C9800
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 07:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjJOF3q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 01:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjJOF3p (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 01:29:45 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C10B7
        for <stable@vger.kernel.org>; Sat, 14 Oct 2023 22:29:44 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4180d962b68so24380921cf.1
        for <stable@vger.kernel.org>; Sat, 14 Oct 2023 22:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697347783; x=1697952583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ef7vv1cgYlTiF0Hvsk6gW7YFSMoM6pwzu7ykklDFFYE=;
        b=NaF8ezbFkVofpYnswQEeGG4h/Ma30dLhDfivILc+4CDfIXhe5KlnDjQdjVuLMxLUtI
         wna9qilXGMRONI+va4y1sThQGmnHeQAwoe59qfwYd1Tys4cVOK1jTnMVi2lJJQXdShEy
         YIJfyhcHXceIe9x1koIbx+L+XeN927/7o1x2ktH2s7WOPrr/LjkQFYw2uZUF4dWaXnz7
         rNRlO6e4s6YE0v26rkCogub3SYpIKPZxXbD87Vetq1WCnUbCCqZC7LvoPLDXJnmPU9ei
         N8yrtA/hrIiXh/hDuAWQvZr5xJ39vdyxslTLYT3BJ2aCvAL2YEGjvr2Ft2/rSijRNMd7
         kDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697347783; x=1697952583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ef7vv1cgYlTiF0Hvsk6gW7YFSMoM6pwzu7ykklDFFYE=;
        b=QS11BhispXs6VnmBI9NyB51Z0m4NdvQqSjb0LRi5/DazgCin8cDpAl5Ya1Fk58xAGS
         eI00xLIazfdOaeRs3NCn2nYuBrQaE9Eigwlo22VT9i/S5r/SW/97fNhWAOG4Kf/Fv0bn
         Py1TPjHYO4kCmmVtIMSSZvZ5zZ7/LBsF97wb3zi/98BhjuPGHo200v/9KxbaB9NB7zPC
         UkyfGstVO8qETn/cUZKGxmALAQ6LsNGYCJZPDczLJtZgVPynNMBg+/biFuQGQbJBXOD/
         iyVDWXlURBaQYbZGXaVGgl7xoLMz7EXJr33PkfSxtaWMcZZ4sDJ/s7EBkC36VZyQSSs6
         ZN1g==
X-Gm-Message-State: AOJu0Yyy+PBHkmHfUm8ySe37bvpTxPtR8KQ2g/s1kcnfqUfoqrN43dHb
        DQ1xw38Za2iRk0AP+0EkTUSS3o26kIY=
X-Google-Smtp-Source: AGHT+IGK9AgNN2mo+ayx7DzybWVY5IbZA9j1H0EJulu1i3mniVi1J+MAp5+3ySwqqtgWzVHtJ8lWgQ==
X-Received: by 2002:ac8:4e56:0:b0:403:ca55:6ac5 with SMTP id e22-20020ac84e56000000b00403ca556ac5mr41157024qtw.18.1697347783110;
        Sat, 14 Oct 2023 22:29:43 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902eb1200b001c5fc291ef9sm6293338plb.209.2023.10.14.22.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 22:29:42 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0A055A25D313; Sun, 15 Oct 2023 12:29:38 +0700 (WIB)
Date:   Sun, 15 Oct 2023 12:29:37 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Marek Vasut <marex@denx.de>, Linux Stable <stable@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: Possibly broken Linux 5.10.198 backport spi: spi-zynqmp-gqspi:
 Fix runtime PM imbalance in zynqmp_qspi_probe
Message-ID: <ZSt4wfx1EMeC0lnX@debian.me>
References: <9afe9285-6f46-46d9-bd21-2ea5c4dc43c0@denx.de>
 <ZSjYC_ATX193mJOA@debian.me>
 <ZSrERw6ucvl1wLWX@sashalap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="77rmlWxZ44xZNn1P"
Content-Disposition: inline
In-Reply-To: <ZSrERw6ucvl1wLWX@sashalap>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--77rmlWxZ44xZNn1P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 14, 2023 at 12:39:35PM -0400, Sasha Levin wrote:
> On Fri, Oct 13, 2023 at 12:39:23PM +0700, Bagas Sanjaya wrote:
> > On Thu, Oct 12, 2023 at 06:39:10PM +0200, Marek Vasut wrote:
> > > Linux 5.10.198 commit
> > > 2cdec9c13f81 ("spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in
> > > zynqmp_qspi_probe")
> > >=20
> > > looks very different compared to matching upstream commit:
> > > a21fbc42807b ("spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in
> > > zynqmp_qspi_probe")
> > >=20
> > > The Linux 5.10.198 change breaks a platform for me and it really look=
s like
> > > an incorrect backport.
> > >=20
> > > Dinghao, can you have a look ?
> > >=20
> >=20
> > Thanks for the regression report. I'm adding it to regzbot (as stable-s=
pecific
> > one):
> >=20
> > #regzbot ^introduced: 2cdec9c13f81
>=20
> I'm going to revert it from 5.10.
>=20

OK, thanks!

Don't forget to add Link: to this regression report and most importantly,
Fixes: to the culprit commit when reverting.

--=20
An old man doll... just what I always wanted! - Clara

--77rmlWxZ44xZNn1P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZSt4wQAKCRD2uYlJVVFO
o2oxAQDemQvJ179CQYJ0coRWaZ55FTtmTVisfsz5uxEM466dXQD/T6GCbeigArv7
b4FJMks1BydkUp6p/pXyyt9OFM9k5Ac=
=RV4T
-----END PGP SIGNATURE-----

--77rmlWxZ44xZNn1P--
