Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4099F7000FA
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 09:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239826AbjELHDg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 03:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240046AbjELHDd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 03:03:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7851DDC69
        for <stable@vger.kernel.org>; Fri, 12 May 2023 00:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683875011; x=1715411011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LtPlhxHOwQugOwOHOjEO7fk0GRbFf4BbzS6zVCeiMAE=;
  b=HfNxjYita0HVP3rnNSJbOL3MMFsNq7ZqixL5gwv9CRnYqBtc4tmoDg4/
   GRGLi2mjMXHuGELfFeHvyX4TFlG6hpqlbVtFPH+To6YYdzoYVq8I/9MC3
   3lS2d26/VVPuL2IMW2JjLDYD2YGrFsvtYIYmd5F1aGMXeoFAawDIZoGy/
   I3avKsEeKb6JkavXVbDvSab48wZ8rbQ5ZlchoVIHr9RWhSqX5zkFO2cNs
   Rut40a+73iWq67k4qNhDSzHiI364nJHDSQEhAE+WrafyiryR08jXM02wR
   +VYi48P8LQ+UX4cGatW6v9zUl/yR4vNdRyyebBFQ3atfJDJesQ7EmBQtr
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,269,1677567600"; 
   d="asc'?scan'208";a="213561238"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 May 2023 00:03:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 12 May 2023 00:03:27 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 12 May 2023 00:03:26 -0700
Date:   Fri, 12 May 2023 08:03:06 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     Conor Dooley <conor@kernel.org>, <stable@vger.kernel.org>,
        <palmer@dabbelt.com>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6.1 v1] RISC-V: fix lock splat in
 riscv_cpufeature_patch_func()
Message-ID: <20230512-reversion-spotter-7b1b49707100@wendy>
References: <20230509-suspend-labrador-3eb6f0a8ac77@spud>
 <ZF18raXiQKGbxl76@sashalap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NkRyUwBMpssRns0d"
Content-Disposition: inline
In-Reply-To: <ZF18raXiQKGbxl76@sashalap>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

--NkRyUwBMpssRns0d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 07:39:25PM -0400, Sasha Levin wrote:
> On Tue, May 09, 2023 at 10:36:42PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Guenter reported a lockdep splat that appears to have been present for a
> > while in v6.1.y & the backports of the riscv_patch_in_stop_machine dance
> > did nothing to help here, as the lock is not being taken when
> > patch_text_nosync() is called in riscv_cpufeature_patch_func().
> > Add the lock/unlock; elide the splat.
>=20
> Is this not a problem upstream?

It is not. Nor is it a problem in 6.2 either.
In fact, looking at it at a time other than 22h30, I notice that this is
not a complete patch. Instead we need to backport commit 9493e6f3ce02
("RISC-V: take text_mutex during alternative patching") and bf89b7ee52af
("RISC-V: fix taking the text_mutex twice during sifive errata patching")
to 6.1. The automagic version failed:
https://lore.kernel.org/stable/a2a21e9c-41ec-46dd-b792-6314c5fa4241@spud/

And I was of the opinion that this was not needed for kernels without
commit 702e64550b12 ("riscv: fpu: switch has_fpu() to
riscv_has_extension_likely()").

I'll go send those now, I am surprised noone has complained about the
SiFive errata causing a splat, but I guess noone with that hardware is
testing stable. The T-HEAD errata has no functional users in 6.1.

Thanks,
Conor.

--NkRyUwBMpssRns0d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZF3kqgAKCRB4tDGHoIJi
0mgcAP9AoMeqCuPUlxQV9Qx6qH+fs2vDjS6eeGEsVw6Tk1T6awD/Z8LETHZorMW4
QL/Dr9vPDNR1dsAWt+j65nWKKKFkmwE=
=kEH7
-----END PGP SIGNATURE-----

--NkRyUwBMpssRns0d--
