Return-Path: <stable+bounces-76097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936C19786A5
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 19:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66AE284B25
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 17:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F6B82D7F;
	Fri, 13 Sep 2024 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKf16Lsy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102B66F31E;
	Fri, 13 Sep 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726248293; cv=none; b=uMRc6mle90BxKnOw0O4n3ryYoWzvWPjCSc4LHOVvwrRMXBE5DUsuG8GClsv9eEZhpJl/c738gx0m4qi1FyxlNzobNau+ulGkFmOLMjReSrUA4BSUr8nSYTXAq7q6yrLSUzPKTaiA3m9IXhzK7rBUedXHV5rEMPw7k5QJuLQaG84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726248293; c=relaxed/simple;
	bh=PnxiBuLP2r+FlaRXWWuCH9SooIjCuVke4h/VjCYOCNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pV85O2NWqOUvPHmsUC5rGQ8O5mvSb7gjQ4J5HD+5Cu1/ANTklcxKwifrwMSZw2AWpyJ/37FKWjzn2ssJarWDa/3Qeo2e+LCBZiw2yE1tpAqsmXU/gOZJmkszCpFfuu3BIl4eFTVBtX+ZQ30eMt3PgCtu8acVIahMGqW86QN+gPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKf16Lsy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC2AC4CEC0;
	Fri, 13 Sep 2024 17:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726248292;
	bh=PnxiBuLP2r+FlaRXWWuCH9SooIjCuVke4h/VjCYOCNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UKf16Lsyktzjkf9OKskVaxOsM9QAx34cF8UO+z9ZcgTKgzFyeaXHCe1SzRaYRE0wh
	 /MwiPJ7GzibU49760jGEkOMElo2e+r15+1oDNLoR2uXQLLnh0Iqme0YFzA2eQL0NGM
	 PSMC63H7SuUeQ6cy5LiQWrkW0trozSOMn8RZei6o2IZI+IKfDW1nCqQ/K7BWBLkdpP
	 vlJxKiDvEq3XZjnlnatu0PTdN39GDS7Pa8qw1hOZGo1MQ0EVj4WXsp4OUaRpKd0XMo
	 PF4AMM5pR35WguMKcHn61BLEbNu+YJDYYyUJ96LEFuX5hqvM8fnOE+ird31npSIGt/
	 9O4VEju03b0xg==
Date: Fri, 13 Sep 2024 18:24:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, stable@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: serial: rs485: Fix rs485-rts-delay
 property
Message-ID: <20240913-sulk-threaten-79448edf988a@spud>
References: <1b60e457c2f1bfa2284291ad58af02c982936ac8.1726224922.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rqNS0kyIGTMLDBX1"
Content-Disposition: inline
In-Reply-To: <1b60e457c2f1bfa2284291ad58af02c982936ac8.1726224922.git.michal.simek@amd.com>


--rqNS0kyIGTMLDBX1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 12:55:23PM +0200, Michal Simek wrote:
> Code expects array only with 2 items which should be checked.
> But also item checking is not working as it should likely because of
> incorrect items description.
>=20
> Fixes: d50f974c4f7f ("dt-bindings: serial: Convert rs485 bindings to json=
-schema")
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Cc: <stable@vger.kernel.org>
> ---
>=20
> Changes in v2:
> - Remove maxItems properties which are not needed
> - Add stable ML to CC
>=20
>  .../devicetree/bindings/serial/rs485.yaml     | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Docume=
ntation/devicetree/bindings/serial/rs485.yaml
> index 9418fd66a8e9..9665de41762e 100644
> --- a/Documentation/devicetree/bindings/serial/rs485.yaml
> +++ b/Documentation/devicetree/bindings/serial/rs485.yaml
> @@ -18,16 +18,15 @@ properties:
>      description: prop-encoded-array <a b>
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>      items:
> -      items:
> -        - description: Delay between rts signal and beginning of data se=
nt in
> -            milliseconds. It corresponds to the delay before sending dat=
a.
> -          default: 0
> -          maximum: 100
> -        - description: Delay between end of data sent and rts signal in =
milliseconds.
> -            It corresponds to the delay after sending data and actual re=
lease
> -            of the line.
> -          default: 0
> -          maximum: 100
> +      - description: Delay between rts signal and beginning of data sent=
 in
> +          milliseconds. It corresponds to the delay before sending data.
> +        default: 0
> +        maximum: 50

I would expect to see some mention in the commit message as to why the
maximum has changed from 100 to 50 milliseconds.

> +      - description: Delay between end of data sent and rts signal in mi=
lliseconds.
> +          It corresponds to the delay after sending data and actual rele=
ase
> +          of the line.
> +        default: 0
> +        maximum: 100
> =20
>    rs485-rts-active-high:
>      description: drive RTS high when sending (this is the default).
> --=20
> 2.43.0
>=20

--rqNS0kyIGTMLDBX1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuR1XwAKCRB4tDGHoIJi
0vfwAP0TfUUdDtg6AO2HGHUxJaYOIeAhds57L3Zm/Cdtut8DIwEA1zocxXYyK33w
6LSjDjUNRjqlKfpC0Rgmq7fgwoE4KgY=
=vUf3
-----END PGP SIGNATURE-----

--rqNS0kyIGTMLDBX1--

