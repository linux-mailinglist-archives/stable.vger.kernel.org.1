Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA4D7CB12E
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 19:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjJPRRI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 13:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjJPRRH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 13:17:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900C0F0
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 10:17:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8717C433C7;
        Mon, 16 Oct 2023 17:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697476625;
        bh=0svgKD8q03qNFj/yDnanu/HhaI98xOBeV/adHnQEaus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e4j51N/m3ivwxwJrQdl5MUamYmgTjpFGOGXSGEeq/YbHb5b7Xvu4OSSpWV9pQXHZn
         3RPRjRfAM35X0tNEZCMkkb45oveHYnvRAqwxcvBDsxJN3pK/NxllWpLm/0+M94qMiy
         1GAFCezHOv3Rb7nZkdwuO1ZQ0ugxApcC4LRmKVjVTYtl7geJMxQLCVs8bXCKWoYlTZ
         nsvyxC6C7F3FRwbSzlVAUQR876jfkAWk9wbd0gDC9AcSVThts6bqzXU8RYSO3T83Tw
         ioQr4Le3BzEeyIR9zBIlkCP9tXJGUT28bX3yJGPweQ8y4/BlYsU8J3xbDcPolGkZS3
         36PhZ+jWaxdYg==
Date:   Mon, 16 Oct 2023 18:17:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Alex Bee <knaerzche@gmail.com>
Cc:     kernelci-results@groups.io, bot@kernelci.org,
        stable@vger.kernel.org
Subject: Re: stable-rc/linux-5.10.y bisection:
 baseline.bootrr.deferred-probe-empty on rk3399-rock-pi-4b
Message-ID: <c19f3a91-7960-4887-9afc-4122db7911b7@sirena.org.uk>
References: <652d6d70.170a0220.a00b6.1beb@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DuoQgozuhKqdG3rZ"
Content-Disposition: inline
In-Reply-To: <652d6d70.170a0220.a00b6.1beb@mx.google.com>
X-Cookie: If you're happy, you're successful.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--DuoQgozuhKqdG3rZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 10:05:52AM -0700, KernelCI bot wrote:

The KernelCI bisection bot has found out that the new feature enablement
in 77806f63c317 ("arm64: dts: rockchip: add ES8316 codec for ROCK Pi 4")
in v5.10-rc is missing some dependency, it causes there to be a device
that fails deferred probe.  Full report below with logs and so on:

> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>=20
> stable-rc/linux-5.10.y bisection: baseline.bootrr.deferred-probe-empty on=
 rk3399-rock-pi-4b
>=20
> Summary:
>   Start:      f622826e6370 Linux 5.10.199-rc1
>   Plain log:  https://storage.kernelci.org/stable-rc/linux-5.10.y/v5.10.1=
98-84-gf622826e6370/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-ro=
ck-pi-4b.txt
>   HTML log:   https://storage.kernelci.org/stable-rc/linux-5.10.y/v5.10.1=
98-84-gf622826e6370/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-ro=
ck-pi-4b.html
>   Result:     77806f63c317 arm64: dts: rockchip: add ES8316 codec for ROC=
K Pi 4
>=20
> Checks:
>   revert:     PASS
>   verify:     PASS
>=20
> Parameters:
>   Tree:       stable-rc
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x-stable-rc.git
>   Branch:     linux-5.10.y
>   Target:     rk3399-rock-pi-4b
>   CPU arch:   arm64
>   Lab:        lab-collabora
>   Compiler:   gcc-10
>   Config:     defconfig
>   Test case:  baseline.bootrr.deferred-probe-empty
>=20
> Breaking commit found:
>=20
> -------------------------------------------------------------------------=
------
> commit 77806f63c317cab3392f3ab7d4c6d392fb4a5da9
> Author: Alex Bee <knaerzche@gmail.com>
> Date:   Fri Jun 18 20:12:55 2021 +0200
>=20
>     arm64: dts: rockchip: add ES8316 codec for ROCK Pi 4
>    =20
>     [ Upstream commit 65bd2b8bdb3bddc37bea695789713916327e1c1f ]
>    =20
>     ROCK Pi 4 boards have the codec connected to i2s0 and it is accessible
>     via i2c1 address 0x11.
>     Add an audio-graph-card for it.
>    =20
>     Signed-off-by: Alex Bee <knaerzche@gmail.com>
>     Link: https://lore.kernel.org/r/20210618181256.27992-5-knaerzche@gmai=
l.com
>     Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>     Stable-dep-of: cee572756aa2 ("arm64: dts: rockchip: Disable HS400 for=
 eMMC on ROCK Pi 4")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/ar=
m64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> index 6dc6dee6c13e..f80cdb021f7f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> @@ -31,6 +31,12 @@ sdio_pwrseq: sdio-pwrseq {
>  		reset-gpios =3D <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
>  	};
> =20
> +	sound {
> +		compatible =3D "audio-graph-card";
> +		label =3D "Analog";
> +		dais =3D <&i2s0_p0>;
> +	};
> +
>  	vcc12v_dcin: dc-12v {
>  		compatible =3D "regulator-fixed";
>  		regulator-name =3D "vcc12v_dcin";
> @@ -417,6 +423,20 @@ &i2c1 {
>  	i2c-scl-rising-time-ns =3D <300>;
>  	i2c-scl-falling-time-ns =3D <15>;
>  	status =3D "okay";
> +
> +	es8316: codec@11 {
> +		compatible =3D "everest,es8316";
> +		reg =3D <0x11>;
> +		clocks =3D <&cru SCLK_I2S_8CH_OUT>;
> +		clock-names =3D "mclk";
> +		#sound-dai-cells =3D <0>;
> +
> +		port {
> +			es8316_p0_0: endpoint {
> +				remote-endpoint =3D <&i2s0_p0_0>;
> +			};
> +		};
> +	};
>  };
> =20
>  &i2c3 {
> @@ -435,6 +455,14 @@ &i2s0 {
>  	rockchip,playback-channels =3D <8>;
>  	rockchip,capture-channels =3D <8>;
>  	status =3D "okay";
> +
> +	i2s0_p0: port {
> +		i2s0_p0_0: endpoint {
> +			dai-format =3D "i2s";
> +			mclk-fs =3D <256>;
> +			remote-endpoint =3D <&es8316_p0_0>;
> +		};
> +	};
>  };
> =20
>  &i2s1 {
> -------------------------------------------------------------------------=
------
>=20
>=20
> Git bisection log:
>=20
> -------------------------------------------------------------------------=
------
> git bisect start
> # good: [da742ebfa00c3add4a358dd79ec92161c07e1435] Linux 5.10.191
> git bisect good da742ebfa00c3add4a358dd79ec92161c07e1435
> # bad: [f622826e6370c6d2feea54f778f491562a3df5d7] Linux 5.10.199-rc1
> git bisect bad f622826e6370c6d2feea54f778f491562a3df5d7
> # bad: [ffed0c8fcf043946f2bf09bd2a9caa1ca5289959] scsi: mpt3sas: Perform =
additional retries if doorbell read returns 0
> git bisect bad ffed0c8fcf043946f2bf09bd2a9caa1ca5289959
> # bad: [92704dd05521841357173973e43d822f99af477b] media: pulse8-cec: hand=
le possible ping error
> git bisect bad 92704dd05521841357173973e43d822f99af477b
> # bad: [23e59874657c6396abb82544f6f60d100d84ee6a] objtool/x86: Fixup fram=
e-pointer vs rethunk
> git bisect bad 23e59874657c6396abb82544f6f60d100d84ee6a
> # good: [3b76d92636791261c004979fd1c94edc68058d3e] tracing/probes: Fix to=
 update dynamic data counter if fetcharg uses it
> git bisect good 3b76d92636791261c004979fd1c94edc68058d3e
> # bad: [fba59a4b55ae582b0b2a86cb2f854385c69f2761] arm64: dts: rockchip: a=
dd SPDIF node for ROCK Pi 4
> git bisect bad fba59a4b55ae582b0b2a86cb2f854385c69f2761
> # good: [bd30aa9c7febb6e709670cd5154194189ca3b7b5] xfrm: add NULL check i=
n xfrm_update_ae_params
> git bisect good bd30aa9c7febb6e709670cd5154194189ca3b7b5
> # good: [0a9040dedec21fbf362437d35f5e6f57735c06d2] i40e: fix misleading d=
ebug logs
> git bisect good 0a9040dedec21fbf362437d35f5e6f57735c06d2
> # good: [73990370d63d7416e5efd41669d4a8407bc41e92] bus: ti-sysc: Flush po=
sted write on enable before reset
> git bisect good 73990370d63d7416e5efd41669d4a8407bc41e92
> # good: [1411c3e86e66cc30f4dee15937276ed33598b787] arm64: dts: rockchip: =
use USB host by default on rk3399-rock-pi-4
> git bisect good 1411c3e86e66cc30f4dee15937276ed33598b787
> # bad: [77806f63c317cab3392f3ab7d4c6d392fb4a5da9] arm64: dts: rockchip: a=
dd ES8316 codec for ROCK Pi 4
> git bisect bad 77806f63c317cab3392f3ab7d4c6d392fb4a5da9
> # first bad commit: [77806f63c317cab3392f3ab7d4c6d392fb4a5da9] arm64: dts=
: rockchip: add ES8316 codec for ROCK Pi 4
> -------------------------------------------------------------------------=
------
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#47485): https://groups.io/g/kernelci-results/message/=
47485
> Mute This Topic: https://groups.io/mt/102000345/1131744
> Group Owner: kernelci-results+owner@groups.io
> Unsubscribe: https://groups.io/g/kernelci-results/unsub [broonie@kernel.o=
rg]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20
>=20

--DuoQgozuhKqdG3rZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUtcAsACgkQJNaLcl1U
h9BvVAgAgLM8vQZ9y6YklWDx/HoVWCTpIcdvZDPLK2BpsLcDUlDkh9IZTE5JN6aA
fvG3M5NjHQzIIanVniw3wJpls5rundelYaLfG6doF2kA1aOTMkweVh3LPdwRcVLJ
KhNhhIQbm+j9jTMHjUxGg6sPCFSyFJBpiovyesQAvyUuv7F5sZhrET5IpHGu2gLa
nq9Myvc7YhwX3tDO4wx4NkeCW8am12ZLahs0v+1bjYjjmV/Nt44wt11ZKRlfvmqi
OPj2GIbudQYBP9GPX7BsuKB0ZtFZd3OmXlnJtY5oBLHyYuf5cCI+kCM3c0lrNMA7
svHUp7NlpAMfcRbU9d8m3ZO7eDd+pw==
=mhpl
-----END PGP SIGNATURE-----

--DuoQgozuhKqdG3rZ--
