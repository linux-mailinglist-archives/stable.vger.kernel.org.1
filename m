Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014457C7D18
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 07:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjJMFje (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 01:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJMFjc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 01:39:32 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1024B7
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 22:39:30 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c9de3f66e5so12343975ad.3
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 22:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697175570; x=1697780370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hqvz2L9RlTj7o4qf/07nZV0iXz8QiAUyy9nom9V5I+w=;
        b=gWwShCjUHEUafxtgXxtUD5WFE4KWTHF9EyBlDC8yzgEh1UjEjqAzdBB1K9Z+Fc/lgg
         CXUn32acOAzcrl9Ublun3R0dnfiEnPXZW9zwkFLTSDYwPfS/DkhJwsHxa+hBghOyfrWO
         jFHQ5v2R5//LvEU63SGKyaQocOODxQ4dBovmmkBO75RAOMzLU3Qal9+WabI0lNEznieo
         dph3BaMAbnP7qAC7h/gciUu7duURkkd6XAiSnrk2xymT6PZN7b6epER00w3COxfH7GO3
         e1Yz15qh+JZhB728a+HyhYv2BsjNtxX+WwWsiA0JPJUZa+fueRya4CbDZeKmnjAsZ4Ou
         aWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697175570; x=1697780370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqvz2L9RlTj7o4qf/07nZV0iXz8QiAUyy9nom9V5I+w=;
        b=Vm9cD5isDoUhiJ0sTpa3xaFZvH8ubEG0p7+DMpWlM6fGg7k3IsEu96oZuwPhgLkLq6
         wTJj1GYlgrjF3XWyBS4mUXWG1seXzqgctecAYtfW3Q5g4UFgYY63WPZxHBHxqepHOPL3
         /Ycmfb/7fBUakMGqm2ptxWLmctK0T25wQ+OYJbUC9sDh/VRmmT3NPtSM0xDC5tsgJK1f
         vCfycTYrxisTge45sBmpmKjUTwVxwkVFiWUtA/7F9xPS3j8qR84v3v5D/jdFh22sT/4i
         faIM9fzYfvaWsW8GCg/YYglOBNCdi0UzfzAaR2S43YdugtXw+45I53nMsU4RA6VGZ+v4
         osfQ==
X-Gm-Message-State: AOJu0Yysb+XyKOQ7xVrm5vbC1SApjTfPXbQArj1Jhdyy8n9gAiBolLkI
        4fZ+zgvxpVmhjQg/ZqLMXvE=
X-Google-Smtp-Source: AGHT+IE3lroCE11A0UobeXWWaOiCXY7jo4Dw4Vq3MrKFr1cVgpmUdEU6kd+uy4EfaA5FfC2Xso1feA==
X-Received: by 2002:a17:903:1c6:b0:1bf:7d3b:4405 with SMTP id e6-20020a17090301c600b001bf7d3b4405mr28903948plh.14.1697175570083;
        Thu, 12 Oct 2023 22:39:30 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902ea0700b001b9c5e07bc3sm2932611plg.238.2023.10.12.22.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 22:39:29 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6C60C8000455; Fri, 13 Oct 2023 12:39:24 +0700 (WIB)
Date:   Fri, 13 Oct 2023 12:39:23 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Marek Vasut <marex@denx.de>, Linux Stable <stable@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: Possibly broken Linux 5.10.198 backport spi: spi-zynqmp-gqspi:
 Fix runtime PM imbalance in zynqmp_qspi_probe
Message-ID: <ZSjYC_ATX193mJOA@debian.me>
References: <9afe9285-6f46-46d9-bd21-2ea5c4dc43c0@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PoPuT7NtGdw9ffR9"
Content-Disposition: inline
In-Reply-To: <9afe9285-6f46-46d9-bd21-2ea5c4dc43c0@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--PoPuT7NtGdw9ffR9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 06:39:10PM +0200, Marek Vasut wrote:
> Linux 5.10.198 commit
> 2cdec9c13f81 ("spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in
> zynqmp_qspi_probe")
>=20
> looks very different compared to matching upstream commit:
> a21fbc42807b ("spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in
> zynqmp_qspi_probe")
>=20
> The Linux 5.10.198 change breaks a platform for me and it really looks li=
ke
> an incorrect backport.
>=20
> Dinghao, can you have a look ?
>=20

Thanks for the regression report. I'm adding it to regzbot (as stable-speci=
fic
one):

#regzbot ^introduced: 2cdec9c13f81

--=20
An old man doll... just what I always wanted! - Clara

--PoPuT7NtGdw9ffR9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZSjYCwAKCRD2uYlJVVFO
oyWYAP40Z+sVvyaa9jLDWR9cZbUp77xO7jSpRp0tmZeZB3tb5QD/VHamAOmYGs2a
CZy64ZA8XKIpVn4CNkbvqL3OParn2gE=
=43B7
-----END PGP SIGNATURE-----

--PoPuT7NtGdw9ffR9--
