Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEF36FBD53
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 04:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjEICea (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 22:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjEICe3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 22:34:29 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB37124
        for <stable@vger.kernel.org>; Mon,  8 May 2023 19:34:28 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6439f186366so2889239b3a.2
        for <stable@vger.kernel.org>; Mon, 08 May 2023 19:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683599668; x=1686191668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qhy4w0IjkM+PWeSbvLHzo5+g5hnFq+cJcuoBMdh0LsA=;
        b=B83eWqRqsKjXZjA9gViIe60acKANzXq0UhUKGp6A+oNDy3MuttCZQFyuLDr+Lz5LL4
         BgmjqhJFrdUUa7C3eQDTbs/zQEcr++Cgpd66kXEbPAWtbEvQtEgEWesOXYMhhHEV7xRC
         kGdgJAgxv1AiJQSje8DONLHdKPet7e4KpSF7HEUP16ocH0pLNxYnp7aCb9G+YzE1/UwO
         WOni0mQyx/z198sZrcXLNzNI3mLj13dBy+kaQzuZ9wVlCQNuoXVfqAKvIFfp73hnx83z
         pC7sn+uqKPX3YH6V0CzdiD+XbMRK6yCNE5AK0EHzjRKEHTY3zfHK5QtOvwumzMnUPeS+
         +sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683599668; x=1686191668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhy4w0IjkM+PWeSbvLHzo5+g5hnFq+cJcuoBMdh0LsA=;
        b=eMS8BX1zxjeHVGmbuMrDH9+Wuhb4AjUro3GKlBcG8TjFd6DJvuQ0w+0u7NjVS+sB21
         ZY1jaVZMnUm4SkHhWVh0SHVRilVcjZpI2+TLCYy7LfzvJuaa/U3KgO8Vjm6ZTm6FrdYj
         QRtZurOavzytmh6sI74TkznSqq7ns5wg9o3x4M42SiTRrg8xQ2JJLOyFOjCCh7zlE2G5
         UFKAAtVRnDrtAZAVB0sqET3gL7KxNx2S8EoCeOIIdov7SX0ehKSo5wXFJZD4jKdT8ghW
         D322VbU1fxCbLJF9J+e9GjDAzHKKC6V5zuf/AJ8c8mxpJ2BRWMRszj+wwQXyLNLi7NNv
         EmzA==
X-Gm-Message-State: AC+VfDx7lA333rSx/oakq1QvrEIvA4dozzQiEJsjVJ9rnRn95SkRdTnV
        gn5tjQQlK31lTZ2Z07UuZJDDUdHDbIw=
X-Google-Smtp-Source: ACHHUZ4DPf3roi3GkB59FUIBuNt++pEI45LtBDI1/rux8OiOoql17AWahtcsFOMZAwoZMNB8bysV2g==
X-Received: by 2002:a05:6a00:1787:b0:627:6328:79f1 with SMTP id s7-20020a056a00178700b00627632879f1mr18270118pfg.34.1683599667849;
        Mon, 08 May 2023 19:34:27 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-7.three.co.id. [180.214.232.7])
        by smtp.gmail.com with ESMTPSA id i2-20020aa78b42000000b006352a6d56ebsm613723pfd.119.2023.05.08.19.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 19:34:27 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id D4D3110628F; Tue,  9 May 2023 09:34:24 +0700 (WIB)
Date:   Tue, 9 May 2023 09:34:24 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ping Cheng <pinglinux@gmail.com>,
        Linux Stable <stable@vger.kernel.org>
Subject: Re: [PATCH] HID: wacom: Set a default resolution for older tablets
Message-ID: <ZFmxMO6IyJx2/R1O@debian.me>
References: <20230409164229.29777-1-ping.cheng@wacom.com>
 <CAF8JNhJudYKrzBuyaT5aYy+fzeaxtB6HALRrbHwYzjcwz+=S0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ckZjq6fqawOmZ2fE"
Content-Disposition: inline
In-Reply-To: <CAF8JNhJudYKrzBuyaT5aYy+fzeaxtB6HALRrbHwYzjcwz+=S0g@mail.gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--ckZjq6fqawOmZ2fE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 06:05:02PM -0700, Ping Cheng wrote:
> Hi Stable maintainers,
>=20
> This patch, ID 08a46b4190d3, fixes an issue for a few older devices.
> It can be backported as is to all the current Long Term Supported
> kernels.
>=20

Now that your fix has been upstreamed, can you provide a backport
for each supported stable versions (v4.14 up to v6.3)?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ckZjq6fqawOmZ2fE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFmxMAAKCRD2uYlJVVFO
ozuzAQC36AiPX6eFxuyAEsnxvIKZJ9ToQFS372fpEpwVzSvGJAEAuIOxiqipsUCF
OPauGYJbMbEVHfqlDKg/yuC5ozlFBwk=
=VUOl
-----END PGP SIGNATURE-----

--ckZjq6fqawOmZ2fE--
