Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777E6705B8D
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 02:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjEQABt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 20:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjEQABs (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 20:01:48 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF11E5A
        for <stable@vger.kernel.org>; Tue, 16 May 2023 17:01:46 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-24e5d5782edso261869a91.0
        for <stable@vger.kernel.org>; Tue, 16 May 2023 17:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684281706; x=1686873706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MvsEvFVDx0IBGWuKqANeU6vQcnt6lgqO49xLqoTcsxU=;
        b=BFhIKsePdPIRgVNT14aYnGJZ33xINqsAt7yFREoDk40mivZUQfPqmz6DVBODHZwgt9
         4k10ZY8CeFumgFxdyDlhcnCMY5O6ZCrRUBsTDZQUIBhNVmPeAvMH01fGsJado1SuzViq
         X4vXlXacKOIFkBcindxPpTwNIDKdteLSGXdufDT9MjlmCfuQY6acd4gC6YwSAnqpRNXK
         Ozzml99YjKS5rpJcAhkF7pQHpEu+h9N8BRQOr7l6DabIB8IIClI2kqmQrBm+kd4Z+yzl
         f6o1SSvP3H1HmNz9bP5etGzqMB0j8OxRrRO9LaetdPMsad9LisyMl3AJ84bGHXQC35iM
         tpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684281706; x=1686873706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvsEvFVDx0IBGWuKqANeU6vQcnt6lgqO49xLqoTcsxU=;
        b=MyQHPtox/xoost5B3ye5xvIZykrxLksA9+hZ0Kpi2/KK2lH1sWaRlmNxxlxJfPE9Za
         T0trCy+OUzPZbIMZtz/4LTQAGmqSpnw+05OAL1AKIDUz3kUfbjJ6ki11Tlhl14Ox996C
         I0AN0Mz9dSaBBT2X7IbIYISzlHi9qzsKiw3tFW3EGrHvP6RUurgsOaRglcV6mUBcpeKT
         N0FT5S3GPF8bcvY8w/SZxHsh8+n14rsEfn0E39j3rBF6RxFOanWKQxzzCIAubRv4ZNZt
         GULyqAgxmrpEnjsBAhr/eL/r4Y5rS+XMbsUL+ODiynDkTZ2+XViQjh0XCLr2quv48rtm
         olDg==
X-Gm-Message-State: AC+VfDwOqvULI7Dv1vdvSK1vOrXCaxKz4ecwTYEWKYzBB8l5nAUEsxfY
        irSdiyTYPDC5sdsLmmV0CNI=
X-Google-Smtp-Source: ACHHUZ6zHZiIf3rm4L3Ru0HbO9C+Jq3EmD6eNuJnusXLSHxkUdL1cYKiLQgmQbo3nPGIqSczVvPeOw==
X-Received: by 2002:a17:90b:a54:b0:246:681c:71fd with SMTP id gw20-20020a17090b0a5400b00246681c71fdmr39011787pjb.6.1684281705831;
        Tue, 16 May 2023 17:01:45 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-58.three.co.id. [116.206.28.58])
        by smtp.gmail.com with ESMTPSA id f16-20020a17090a639000b0024e05b7ba8bsm155799pjj.25.2023.05.16.17.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 17:01:45 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 8AAD8106276; Wed, 17 May 2023 06:51:45 +0700 (WIB)
Date:   Wed, 17 May 2023 06:51:44 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     =?utf-8?B?w4lyaWM=?= Brunet <eric.brunet@ens.fr>,
        stable@vger.kernel.org
Cc:     regressions@lists.linux.dev, ville.syrjala@linux.intel.com,
        jouni.hogander@intel.com, jani.nikula@intel.com,
        gregkh@linuxfoundation.org
Subject: Re: Regression on drm/i915, with bisected commit
Message-ID: <ZGQXELf3MSt4oUsR@debian.me>
References: <3236901.44csPzL39Z@skaro>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HFKyM4/krgFaudN0"
Content-Disposition: inline
In-Reply-To: <3236901.44csPzL39Z@skaro>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--HFKyM4/krgFaudN0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2023 at 03:04:53PM +0200, =C3=89ric Brunet wrote:
> Hello all,
>=20
> I have a HP Elite x360 1049 G9 2-in-1 notebook running fedora 38 with an =
Adler=20
> Lake intel video card.
>=20
> After upgrading to kernel 6.2.13 (as packaged by fedora), I started seein=
g=20
> severe video glitches made of random pixels in a vertical band occupying =
about=20
> 20% of my screen, on the right. The glitches would happen both with X.org=
 and=20
> wayland.
>=20
> I checked that vanilla 6.2.12 does not have the bug and that both vanilla=
=20
> 6.2.13 and vanilla 6.3.2 do have the bug.
>=20
> I bisected the problem to commit e2b789bc3dc34edc87ffb85634967d24ed351acb=
 (it=20
> is a one-liner reproduced at the end of this message).
>=20
> I checked that vanilla 6.3.2 with this commit reverted does not have the =
bug.
>=20

Can you also check that its mainline counterpart (e1c71f8f918047c) also
exhibits this regression?

> I am CC-ing every e-mail appearing in this commit , I hope this is ok, an=
d I=20
> apologize if it is not.
>=20
> I have filled a fedora bug report about this, see https://bugzilla.redhat=
=2Ecom/
> show_bug.cgi?id=3D2203549 . You will find there a small video (made with =
fedora=20
> kernel 2.6.14) demonstrating the issue.
>=20
> Some more details:
>=20
> % sudo lspci -vk -s 00:02.0
> 00:02.0 VGA compatible controller: Intel Corporation Alder Lake-UP3 GT2 [=
Iris=20
> Xe Graphics] (rev 0c) (prog-if 00 [VGA controller])
>         DeviceName: Onboard IGD
>         Subsystem: Hewlett-Packard Company Device 896d
>         Flags: bus master, fast devsel, latency 0, IRQ 143
>         Memory at 603c000000 (64-bit, non-prefetchable) [size=3D16M]
>         Memory at 4000000000 (64-bit, prefetchable) [size=3D256M]
>         I/O ports at 3000 [size=3D64]
>         Expansion ROM at 000c0000 [virtual] [disabled] [size=3D128K]
>         Capabilities: [40] Vendor Specific Information: Len=3D0c <?>
>         Capabilities: [70] Express Root Complex Integrated Endpoint, MSI =
00
>         Capabilities: [ac] MSI: Enable+ Count=3D1/1 Maskable+ 64bit-
>         Capabilities: [d0] Power Management version 2
>         Capabilities: [100] Process Address Space ID (PASID)
>         Capabilities: [200] Address Translation Service (ATS)
>         Capabilities: [300] Page Request Interface (PRI)
>         Capabilities: [320] Single Root I/O Virtualization (SR-IOV)
>         Kernel driver in use: i915
>         Kernel modules: i915
>=20
> Relevant kernel boot messages: (appart from timestamps, these lines are=
=20
> identical for 6.2.12 and 6.2.14):
>=20
> [    2.790043] i915 0000:00:02.0: vgaarb: deactivate vga console
> [    2.790089] i915 0000:00:02.0: [drm] Using Transparent Hugepages
> [    2.790497] i915 0000:00:02.0: vgaarb: changed VGA decodes:=20
> olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
> [    2.793812] i915 0000:00:02.0: [drm] Finished loading DMC firmware i91=
5/
> adlp_dmc_ver2_16.bin (v2.16)
> [    2.825058] i915 0000:00:02.0: [drm] GuC firmware i915/adlp_guc_70.bin=
=20
> version 70.5.1
> [    2.825061] i915 0000:00:02.0: [drm] HuC firmware i915/tgl_huc.bin ver=
sion=20
> 7.9.3
> [    2.842906] i915 0000:00:02.0: [drm] HuC authenticated
> [    2.843778] i915 0000:00:02.0: [drm] GuC submission enabled
> [    2.843779] i915 0000:00:02.0: [drm] GuC SLPC enabled
> [    2.844200] i915 0000:00:02.0: [drm] GuC RC: enabled
> [    2.845010] i915 0000:00:02.0: [drm] Protected Xe Path (PXP) protected=
=20
> content support initialized
> [    3.964766] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on =
minor=20
> 1
> [    3.968403] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no=
 =20
> post: no)
> [    3.968981] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/
> PNP0A08:00/LNXVIDEO:00/input/input18
> [    3.977892] fbcon: i915drmfb (fb0) is primary device
> [    3.977899] fbcon: Deferring console take-over
> [    3.977904] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
> [    4.026120] i915 0000:00:02.0: [drm] Selective fetch area calculation=
=20
> failed in pipe A
>=20
> Is there anything else I should provide? I am willing to run some tests, =
of=20
> course.
>=20

Anyway, thanks for regression report. I'm adding it to regzbot:

#regzbot ^introduced: e2b789bc3dc34ed
#regzbot title: Selective fetch area calculation regression on Alder Lake c=
ard
#regzbot link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2203549=20

--=20
An old man doll... just what I always wanted! - Clara

--HFKyM4/krgFaudN0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZGQW8gAKCRD2uYlJVVFO
o0QOAP9TVNQlBvdgVZXIh9qkfSGA8RwR00iXEI1eFRGhRQnHLwD/avkAe86hUON1
+4UycDzIB/3oS1jb4+t2cQx1992UQgI=
=GU6k
-----END PGP SIGNATURE-----

--HFKyM4/krgFaudN0--
