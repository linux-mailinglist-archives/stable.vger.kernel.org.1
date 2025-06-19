Return-Path: <stable+bounces-154786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B94DBAE029E
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 12:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C6B1BC327B
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 10:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417E9222594;
	Thu, 19 Jun 2025 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kOhlaa8x"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADB9222584;
	Thu, 19 Jun 2025 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750328830; cv=none; b=lVOnqIVwcRBz/ZNkzRQLHpbvNCx1/xNaHk4uX/be4SiNELmrhkvWbmWgw+SgiG1SqSwjcLSjijjqY31oNtDQrZNfQjUEKNQV+USsIAkVYanVML2MGXx9wpeC2WWuWnUthT/1Wkhg96bwA1kNPf/BoRUXIbb12w0vK5pQYDrcE+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750328830; c=relaxed/simple;
	bh=5/aop65CR+vlEsCatlTw7RGHDa9DEji1ocp8kIn0uxc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjzkRgAHnCmX/wfyDepDUmURU4MHbGQdK0fjTaz+u08m92+YPpjbIWb1RVxhnpzalDsJtuBfIpt2BXEGCRvicbtCTfFfJkbd8BiEKkOxO6Xwhw+Tg9Kde+FQEy9riR+GlhObCuP2nNKAc53JRUouLcGQ2P8Iq2fsWnK/diwKOVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kOhlaa8x; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1750328828; x=1781864828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5/aop65CR+vlEsCatlTw7RGHDa9DEji1ocp8kIn0uxc=;
  b=kOhlaa8xZnLYlv33woJMMruRdPQ9uwWaQiwjYy7ev4L9vYK5VDtdb66O
   RfZikdNchHC3Z6q7aRVM/+Ya5HMTDATLnpBaJXBwQkgg9/P+NeNsaBIMA
   v9sAoF1VRHjZBe6gFAYmICyQVuQidbRSP8erkYIVCULh5Ya4AjQhlViHa
   wTibpFKCJuD1yelyXmLvl6Im/s5Sax7ZaHkCHuqfoq5/W26BgkyRK4xKt
   Xv3AC8xWYSQ+lzPMlOcF0U4iISgMbGjAH69ggOynpc7EFI0P1LjXIj+bt
   lO1VBHru5RJzy25dsTYTFjImFx4A6UfYcufRveSOpaMdWvfFkaJNlAdor
   g==;
X-CSE-ConnectionGUID: M0gjpEXFSBW2SwzkaqjX3Q==
X-CSE-MsgGUID: MLPHmx72S5WWXxMy6v5fAQ==
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="asc'?scan'208";a="210468383"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2025 03:27:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Jun 2025 03:26:26 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44 via Frontend
 Transport; Thu, 19 Jun 2025 03:26:24 -0700
Date: Thu, 19 Jun 2025 11:25:16 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Klara Modin <klarasmodin@gmail.com>
CC: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <valentina.fernandezalanis@microchip.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] riscv: export boot_cpu_hartid
Message-ID: <20250619-rummage-cache-93f48564b7fb@wendy>
References: <20250617125847.23829-1-klarasmodin@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K+4uvyVlEFQHzawD"
Content-Disposition: inline
In-Reply-To: <20250617125847.23829-1-klarasmodin@gmail.com>

--K+4uvyVlEFQHzawD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 02:58:47PM +0200, Klara Modin wrote:
> The mailbox controller driver for the Microchip Inter-processor
> Communication can be built as a module. It uses cpuid_to_hartid_map and
> commit 4783ce32b080 ("riscv: export __cpuid_to_hartid_map") enables that
> to work for SMP. However, cpuid_to_hartid_map uses boot_cpu_hartid on
> non-SMP kernels and this driver can be useful in such configurations[1].
>=20
> Export boot_cpu_hartid so the driver can be built as a module on non-SMP
> kernels as well.
>=20
> Link: https://lore.kernel.org/lkml/20250617-confess-reimburse-876101e099c=
b@spud/ [1]
> Cc: stable@vger.kernel.org
> Fixes: e4b1d67e7141 ("mailbox: add Microchip IPC support")

I'm not sure that this fixes tag is really right, but I have no better
suggestions
Acked-by: Conor Dooley <conor.dooley@microchip.com>

> Signed-off-by: Klara Modin <klarasmodin@gmail.com>
> ---
>  arch/riscv/kernel/setup.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index f7c9a1caa83e..14888e5ea19a 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -50,6 +50,7 @@ atomic_t hart_lottery __section(".sdata")
>  #endif
>  ;
>  unsigned long boot_cpu_hartid;
> +EXPORT_SYMBOL_GPL(boot_cpu_hartid);
> =20
>  /*
>   * Place kernel memory regions on the resource tree so that
> --=20
> 2.49.0
>=20

--K+4uvyVlEFQHzawD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaFPliwAKCRB4tDGHoIJi
0lPyAP9gMiXsh08benYHPcPqTgNhjeE8a5n+yyRd3aZZYh0GYAEAhTEaO5q5d/2f
cvx/ry5nKYC8JqWHaY7wNNuGitftMgY=
=dTnR
-----END PGP SIGNATURE-----

--K+4uvyVlEFQHzawD--

