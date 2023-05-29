Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C117141E5
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 04:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjE2CQh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 22:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2CQg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 22:16:36 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BDB90
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:16:35 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2564c6a2b7dso771275a91.3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685326595; x=1687918595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FHu1AMiiN4Y6Up//uEWSZ/W+Uhb3QYYyAScxor3BAf0=;
        b=YnNS5FVrqFkj8E1vRXDeZPUksP694IU95hoBYR/20IrBAZS1zJepqG/NlFSaSGRpKw
         cCFQWZS/93y3QDtCQprqoRCX+Qhw7hxhuPiKS7qekrfEoXAj0F7jMmIhZM/6ltDCLzZv
         9pupZ5kXyqhZpVQTlenRiedaSKD2NkxMxeXbxQ8hxOxwbQuS4HHF90IzJU0FD6Tl3Oh/
         b28R7I8SdJPrx7EzL99sac+lX/OfzzjiJ79bywg/p5bpvsDTwizqt17o27z8fEoz5cOY
         fA5sRss8v4pDB2qVU8I0O2JdPCmH2hO0rIxiL07m3YPe77oDh0pqB9IgRVw2h6LWhiru
         VWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685326595; x=1687918595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHu1AMiiN4Y6Up//uEWSZ/W+Uhb3QYYyAScxor3BAf0=;
        b=YzYkvrWiez1ATS8aCxNbQfVmRGKlbrj47hHhZu+FRTbTN2Niq0TooKnb9RZt7AIsuZ
         cnTrifjqoCA8WQRsxUSEZrPZWJQ2+KF07CORqqCFxb1JpzIvZdENLmjK0AbIeijvfOPb
         11BeVXa39fuYKrEqm8fciP4sCo5IWRov2KI+fqGSrZ2OwDTZhI0+apBI+8BB/mTjOq19
         qDFTEApxfduzNbe7+3iT0EPik3659RQrp9DeH2d54Br3eG8+nokTr4mRIotAeDjYZW2M
         YiAAfIRXu9VKuAuJkQn3fr2GHmadFt74BGwl8mjVa7MFi0t++CtNKHcknUFqHfC0HdFF
         fDYg==
X-Gm-Message-State: AC+VfDzPjrwdybA4NV8OM5ObwXlzWhvdmrmOnC9M/+/eCgBqlDpe6nud
        EX51WZpkD90CTMUxJHeWJB9gWG4IDmw=
X-Google-Smtp-Source: ACHHUZ5cK2F6tu1Co48s2LF7ZQ0kqhhav2qOxmIbsLH47kydp0eTnoxG0NcyfjXLbKleR89GML6taA==
X-Received: by 2002:a17:90a:ba87:b0:256:4cd3:95c5 with SMTP id t7-20020a17090aba8700b002564cd395c5mr6083545pjr.5.1685326594598;
        Sun, 28 May 2023 19:16:34 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-34.three.co.id. [116.206.12.34])
        by smtp.gmail.com with ESMTPSA id k4-20020a632404000000b0053423447a12sm6021528pgk.73.2023.05.28.19.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 19:16:34 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id B8AB3106A0B; Mon, 29 May 2023 09:16:29 +0700 (WIB)
Date:   Mon, 29 May 2023 09:16:29 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        beld zhang <beldzhang@gmail.com>
Cc:     stable@vger.kernel.org
Subject: Re: Fwd: 6.1.30: thunderbolt: Clear registers properly when auto
 clear isn't in use cause call trace after resume
Message-ID: <ZHQK_ZyW3NW3JXdz@debian.me>
References: <CAG7aomXv2KV9es2RiGwguesRnUTda-XzmeE42m0=GdpJ2qMOcg@mail.gmail.com>
 <ZHKW5NeabmfhgLbY@debian.me>
 <261a70b7-a425-faed-8cd5-7fbf807bdef7@amd.com>
 <CAG7aomVVJyDpKjpZ=k=+9qKY5+13eFjcGPEWZ0T0+NTNfZWDfA@mail.gmail.com>
 <CAG7aomXP0JHmHytsv5cMsyHzee61BQnG3fc-Y+NLzum7H3DyHA@mail.gmail.com>
 <2023052822-evaluate-essential-52a3@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jUEmp0j5BLDmXDFe"
Content-Disposition: inline
In-Reply-To: <2023052822-evaluate-essential-52a3@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--jUEmp0j5BLDmXDFe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 28, 2023 at 08:02:35PM +0100, Greg KH wrote:
> > sorry I have no idea how to fill a proper bug report at kernel
> > bugzilla, hope these shared links work.
> > btw I have no TB devices to test.
> >=20
> > dmesg:
> > https://drive.google.com/file/d/1bUWnV7q2ziM4tdTzmuGiVuvEzaLcdfKm/view?=
usp=3Dsharing
> >=20
> > config:
> > https://drive.google.com/file/d/1It75_AV5tOzfkXXBAX5zAiZMoeJAe0Au/view?=
usp=3Dsharing
>=20
> <formletter>
>=20
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how to do this properly.
>=20
> </formletter>

Hi Greg,

You confuse attaching bug artifacts (here dmesg and .config) with stable
kernel patches. The reporter doesn't have any patches to help fixing
this regression at the moment.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--jUEmp0j5BLDmXDFe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZHQK/QAKCRD2uYlJVVFO
oxQnAQDhF8EaEABQVR0FHJv2ibb+fej8CCvc8Balu3xmebEwIwEAz1jbQPAGtO9c
b2OuBSmgVPw8W7qTEZov4p5a4DwAYgY=
=yhYX
-----END PGP SIGNATURE-----

--jUEmp0j5BLDmXDFe--
