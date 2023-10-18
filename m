Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769DC7CD810
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 11:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjJRJbB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 05:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjJRJaq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 05:30:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87CEFE
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 02:30:36 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507c78d258fso859127e87.2
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 02:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697621435; x=1698226235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+z3LrvywvH2G6NIfVU/XJ/JLCRcetjXjsTm8sPFYUo=;
        b=yXoFEihES3j8scQ3Dh2zCh4lXhBwzLtTpe+vEOdrOuzWE7NOEg47QTE0gJ1eVKkx6U
         fKANZvaJWKRWNFwNURbcKYAfcuQjQGerVt9pFXTGCuLe8ut21MhC/pQ0/fUqSn7KNCnd
         nC3QwCpnuCdgPHyeKHd8jafnPjq7qLW+TEn122nGoi4B+csWzGRkUS83uVZcKswCdJ68
         svjablSwPdZpUaB2jUvWpbgkaPXRsVkLMO8IUzq7t7D0v4UgbkA5LB9UU3Ysk0a2Ws5J
         iqpsxP9skYDkD3N2VSGiMyXzGPL/uhX8GnW1H3lq/V4VhiCy8MkwNBhILYieQWGl3kDw
         /LoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697621435; x=1698226235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+z3LrvywvH2G6NIfVU/XJ/JLCRcetjXjsTm8sPFYUo=;
        b=EbQXIhdW39znVeXG8LMkg7W3iqa60/ISFb2RxVdEhOSe2wFciCMXc732J+EhdKicU5
         P9/2sSRgeSULWJgA86exnnMYeqz8g8voIMKSm9ROhniGkVgARmDzfz1Y+6JuzYoQ0Bh0
         tyjcrZEIZ9uczbAuuHAg+qIk8vxIqZTPGYIPiLgDdlKLg4vuqSlgsCgHFmejXbCLrduN
         +J5YVBilu0GORVTAff+vp703Zfq+2jBJZMOT2GXn93viCKQnMQ6TDTxuUlzobJQvUx8L
         VGKHp6dk+qIY5v45lfaEm5dxJG2FsOP4UoWoNWAD15MhljmsSBXC88b5/qCOw2O96oNx
         BIcw==
X-Gm-Message-State: AOJu0Yx8TYRYYa8cJAg5fDjStyHjJ8gIyPCyZKdShfk9iaiViYFUbMQU
        DVfjwjw77urvS2lxlYAfjvbFkykqIYGDUODL//eYmg==
X-Google-Smtp-Source: AGHT+IH2uQl/Fyj8SvKhXifub5DJW84yf3ZAxCw8sNP+SVz2+WDQW00+UrhEUCDO9c7YO/aRloQrvnHIDGn00Q/iL1Y=
X-Received: by 2002:a05:6512:3102:b0:507:9b70:1f0e with SMTP id
 n2-20020a056512310200b005079b701f0emr3807189lfb.24.1697621434724; Wed, 18 Oct
 2023 02:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <Nh-DzlX--3-9@bens.haus> <CAMj1kXFKe6piagNLdSUhxUhwLB+RfNHqjNWt8-r2CNS-rBdJKA@mail.gmail.com>
 <817366c2-33e0-4908-90ec-57c63e3eb471@canonical.com>
In-Reply-To: <817366c2-33e0-4908-90ec-57c63e3eb471@canonical.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Wed, 18 Oct 2023 12:29:58 +0300
Message-ID: <CAC_iWjJB3OTWiYX5YsJmNcPQw+rHSm955c1Z5pUajedWGM5QgA@mail.gmail.com>
Subject: Re: [REGRESSION] boot fails for EFI boot stub loaded by u-boot
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Ben Schneider <ben@bens.haus>,
        Regressions <regressions@lists.linux.dev>,
        Linux Efi <linux-efi@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi all,

On Wed, 18 Oct 2023 at 12:17, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 10/18/23 10:34, Ard Biesheuvel wrote:
> > (cc Heinrich)
> >
> > Hello Ben,
> >
> > Thanks for the report.
> >
> > On Wed, 18 Oct 2023 at 03:19, Ben Schneider <ben@bens.haus> wrote:
> >>
> >> Hi Ard,
> >>
> >> I have an ESPRESSObin Ultra (aarch64) that uses U-Boot as its bootload=
er. It shipped from the manufacturer with with v5.10, and I've been trying =
to upgrade. U-Boot supports booting Image directly via EFI (https://u-boot.=
readthedocs.io/en/latest/usage/cmd/bootefi.html), and I have been using it =
that way to successfully boot the system up to and including v6.0.19. Howev=
er, v6.1 and v6.5 kernels fail to boot.
> >>
> >> When booting successfully, the following messages are displayed:
> >>
> >> EFI stub: Booting Linux Kernel...EFI stub: ERROR: FIRMWARE BUG: efi_lo=
aded_image_t::image_base has bogus value
> >> EFI stub: ERROR: FIRMWARE BUG: kernel image not aligned on 64k boundar=
y
> >> EFI stub: Using DTB from configuration table
> >> EFI stub: ERROR: Failed to install memreserve config table!
> >> EFI stub: Exiting boot services...
> >> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
> >>
> >> I suspect many of the above error messages are simply attributable to =
using U-Boot to load an EFI stub and can be safely ignored given that the s=
ystem boots and runs fine.
>
> These messages are not typical for launching a kernel via the EFI stub
> from U-Boot. It should look like this:

The alignment one might be true depending on the U-Boot version that's used=
.
The alignment was fixed on commit ebdea88d57d5e ("efi_loader: Fix
loaded image alignment")
The rest indeed make little sense for now

>
> =3D> load mmc 0:1 $fdt_addr_r boot/dtb
> 28846 bytes read in 6 ms (4.6 MiB/s)
> =3D> load mmc 0:1 $kernel_addr_r boot/vmlinuz
> 53686664 bytes read in 2223 ms (23 MiB/s)
> =3D> setenv bootargs root=3D/dev/mmcblk0p1 efi=3Ddebug earlyprintk
> initrd=3Dboot/initrd.img
> =3D> bootefi $kernel_addr_r $fdt_addr_r
> Card did not respond to voltage select! : -110
> Failed to load EFI variables
> Booting /boot\vmlinuz
> EFI stub: Booting Linux Kernel...
> EFI stub: EFI_RNG_PROTOCOL unavailable
> EFI stub: Loaded initrd from command line option
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services...
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
>

[...]

Cheers
/Ilias
