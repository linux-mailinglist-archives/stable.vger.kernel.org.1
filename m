Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8E36FBB02
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 00:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjEHWZU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 18:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEHWZT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 18:25:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC8C5B94
        for <stable@vger.kernel.org>; Mon,  8 May 2023 15:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 319C7642EF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 22:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2911CC433D2;
        Mon,  8 May 2023 22:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683584717;
        bh=+24NZK20euhTIHhF/hFlIInj5mJDirTWkqTzuBG0cro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PtzITS83aKZOICG17cF2dp9g4OaOHtCw/d1VH/SFuvBfBNXK6zasqq13M1uHp/sdI
         MwNeZ+QZZ59v9fgSlhu4RWu9R6nnN4hvFfui/18zZAkaVABkblbfq2Je5/qwxdKF/3
         /c5RC3ZreWA2RZuEDFW2gTbJH9ZI4K/ufVshhLw1L/CzBoCrSp2hQRMXVSlWRnALKm
         VJ+YmQ0nltmweepBb2dt0NY5C5oSzlyDxhMUdIwHItGcv58Qyy/PJTw10EfTQpOBLG
         vyIEIhKhjEJj/koMp4/pZDlzFz7Vm6cW3MAzNewFiKWIvdJ7cu/rkwnAm218pzXUy1
         3SQlwIc5ldptQ==
Date:   Mon, 8 May 2023 23:25:13 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Dhruva Gole <d-gole@ti.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.2 500/663] spi: bcm63xx: remove PM_SLEEP based
 conditional compilation
Message-ID: <20230508-curtsy-vision-018e07a7ff85@spud>
References: <20230508094428.384831245@linuxfoundation.org>
 <20230508094444.763317964@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m7Iv6Pxl+cADR/P0"
Content-Disposition: inline
In-Reply-To: <20230508094444.763317964@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--m7Iv6Pxl+cADR/P0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 11:45:26AM +0200, Greg Kroah-Hartman wrote:
> From: Dhruva Gole <d-gole@ti.com>
>=20
> [ Upstream commit 25f0617109496e1aff49594fbae5644286447a0f ]
>=20
> Get rid of conditional compilation based on CONFIG_PM_SLEEP because
> it may introduce build issues with certain configs where it maybe disabled
> This is because if above config is not enabled the suspend-resume
> functions are never part of the code but the bcm63xx_spi_pm_ops struct
> still inits them to non-existent suspend-resume functions.
>=20
> Fixes: b42dfed83d95 ("spi: add Broadcom BCM63xx SPI controller driver")
>=20
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> Link: https://lore.kernel.org/r/20230420121615.967487-1-d-gole@ti.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This breaks the build on RISC-V.

Seems to be messing around happening on the same patch in 6.1 w/ a fixup
patch, but sounds like the fixup didn't apply properly either:
https://lore.kernel.org/stable/2023050845-pancreas-postage-5769@gregkh/

The fixup would be needed here too, provided it (:

Cheers,
Conor.

--m7Iv6Pxl+cADR/P0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFl2yQAKCRB4tDGHoIJi
0iRxAP4+76OESclqrkXfCO+k50AQw3eCWrgsEhREaS+Py4Qu5QEA50MfiV050J3s
hJplDV8qC1ZzhkvOwtuAFc34euXZkw4=
=gs3I
-----END PGP SIGNATURE-----

--m7Iv6Pxl+cADR/P0--
