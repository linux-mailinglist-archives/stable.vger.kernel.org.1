Return-Path: <stable+bounces-106752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C706A016A1
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 21:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45403A3382
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 20:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F70191494;
	Sat,  4 Jan 2025 20:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="gdYAxMyI";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="U+fTYE3L"
X-Original-To: stable@vger.kernel.org
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E523814A629;
	Sat,  4 Jan 2025 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=72.84.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736021354; cv=fail; b=epIpqPMN5Vt9YxviC/TRIHGrWefQB5Cww2rhvl2PSIJmlsNYe7mo3guv+xjg3MZvazxlbbwCzaG2SqV7RVZ5g0OmoPDnsR9PYjNMbJ8CMOPpNOXqNJlBBqSsX5iIiy3lJc8j5F8l0ACTjRPy3HBdXi8m8/OhDQme6uaCoA9A9ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736021354; c=relaxed/simple;
	bh=TXXMK3ueHNVgj1Xw102IRPlmmg+47Vt2x/v9kCxDVjs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iz8o9+AS9TqKZ99VXJ9uUyo5qAp4J7CajdzVoBndmkACJQh1B1bxLwYyXpHT1aLR6NCIUu9inlRTPFeas6jIgnL/ELY7ApPI5alEZgbTh4loGU49EhMGij57FmsOhLhrXptmy4RSTt/USMKag0OVeCKDb53Xgc72U2+bBz/JzbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com; spf=pass smtp.mailfrom=sapience.com; dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b=gdYAxMyI; dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b=U+fTYE3L; arc=fail smtp.client-ip=72.84.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sapience.com
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.sapience.com (srv8.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id B34CC480A2B;
	Sat, 04 Jan 2025 15:09:11 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1736021351;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=7ggGgX62pkjAuf332zjLZgniYwxyVyVEojisAlm65fw=;
 b=gdYAxMyINb+GmfEn5cT2I5ExCsgJPbPowCrwETvPjFrIwcbWf+WgNhbmC1blGi7cTLuq7
 FQg7snQsPpUj88uDQ==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1736021351;
	cv=none; b=vZieBKqdMwEAZr6S7rJXlgZy1WxTpN+Y5C8hqfKVkUSsLGSvPG2Y16ID984jdM6n5gOq3VJnkAurk3qFDdmbxG4pzgeLaX2FuL5Snph5TT3rS2BO3wa+wxm04D9WGR3UUMGraKVdJxak1p+COgEUJUlPJGX5M7EKl30jE/2jSsTFJzmVkeqcWXnwHM8ea965pYmUHSGqgM7VcChNDA0uzL3VNjfV8LWdjaAjXsX7+W5CmO+JpRMZl5AnJVWXZdTduhTKLxakzPDgSO4uWYIVvSK/mgEfmFjsmQok13oApqr3u6E7fEtqH/pMd6IWrFjyI1IuTW0GFQao6A5nkxfdUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1736021351; c=relaxed/simple;
	bh=TXXMK3ueHNVgj1Xw102IRPlmmg+47Vt2x/v9kCxDVjs=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:
	 MIME-Version; b=ctxCc4ZVMgtJr65pJ1vToXP/eGTDgw7XIZwsFUHS//PTs4mXLdEFUVgyyvtTMsIQzMJIaxb3sLx+OTXYb5cog7ooHQ2xF82x2yfAqHfbG/TeNmOkXwmgPiYnNbWX/vy+fIThY6WLZcqyHlnShNKY9X/V1jrhbe5/KRSxvuBuLhq2O/lZWwZUPZipBYPx5hqwDyCEe7cmDTQJ+Q3xQzTWVoUeNFySIDe3TG8VSrk08QgsSEir39k02dIkYH9NxxhpkYp8PgVZ0uixg2XRWmotb1LE17J0+bhawLfUwvsXok2tE97D3DsZ0KtnuX8ravYLf1Al9DCb7ln5pqaIOT8gBA==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1736021351;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=7ggGgX62pkjAuf332zjLZgniYwxyVyVEojisAlm65fw=;
 b=U+fTYE3LbZx+hEbXF3PjXCcX02uHutJLrPeFG+ic+F0WsdB7DOCFsmoGtcpndv4YgPwOt
 +XkOyhsvTqpOQWh9UaEeJ1FX5kd8PMVH9hJ/rNMs/DLSmIxMk9vFx6Bf57tsXvq63lHNtgY
 wk1D8+YfBHxCXmTQcrqYqqeBBHWBFdKwDBkGe/5iQAVNZXzB/tFvxnQjRkzj4Ki2QoWbV1v
 flYDNcUiQLGoOIthpyQH+HY0oR6f2rXMWTQTdcFVoRr0tml+dv5jyB46+BBdsiwiM8lt8rh
 egpUr6sKCsW/g1a0Wbwkgl90tMTf7xII+jzTmuQNQo10qO722aBQNW42ezNw==
Received: from lap7.sapience.com (lap7w.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by srv8.sapience.com (Postfix) with ESMTPS id 76D94280011;
	Sat, 04 Jan 2025 15:09:11 -0500 (EST)
Message-ID: <d5ef54d76188ec51d9e053fd097dc3f5bb6e6519.camel@sapience.com>
Subject: Re: [REGRESSION][BISECTED] Re: 6.12.7 stable new error: event
 xe_bo_move has unsafe dereference of argument 4
From: Genes Lists <lists@sapience.com>
To: Andrea Amorosi <andrea.amorosi76@gmail.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, lucas.demarchi@intel.com, 
	regressions@lists.linux.dev, rostedt@goodmis.org, stable@vger.kernel.org, 
	thomas.hellstrom@linux.intel.com
Date: Sat, 04 Jan 2025 15:09:10 -0500
In-Reply-To: <73129e45-cf51-4e8d-95e8-49bc39ebc246@gmail.com>
References: <9dee19b6185d325d0e6fa5f7cbba81d007d99166.camel@sapience.com>
	 <73129e45-cf51-4e8d-95e8-49bc39ebc246@gmail.com>
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mDMEXSY9GRYJKwYBBAHaRw8BAQdAwzFfmp+m0ldl2vgmbtPC/XN7/k5vscpADq3BmRy5R
 7y0LU1haWwgTGlzdHMgKEwwIDIwMTkwNzEwKSA8bGlzdHNAc2FwaWVuY2UuY29tPoiWBBMWCAA+Ah
 sBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE5YMoUxcbEgQOvOMKc+dlCv6PxQAFAmPJfooFCRl
 vRHEACgkQc+dlCv6PxQAc/wEA/Dbmg91DOGXll0OW1GKaZQGQDl7fHibMOKRGC6X/emoA+wQR5FIz
 BnV/PrXbao8LS/h0tSkeXgPsYxrzvfZInIAC
Content-Type: multipart/signed; micalg="pgp-sha384";
	protocol="application/pgp-signature"; boundary="=-Cksclr6ZgK3uvhQ/YUvo"
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Cksclr6ZgK3uvhQ/YUvo
Content-Type: multipart/alternative; boundary="=-hlkAZ8gh2/Rp7zinC2F3"

--=-hlkAZ8gh2/Rp7zinC2F3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2025-01-04 at 18:43 +0100, Andrea Amorosi wrote:
> Hi to all,
>=20
> I've just updated my archlinux to |6.12.8-arch1-1 and I still get the
> same issue:|
>=20
>=20
Right - 6.12.8 (and Arch build of same) does not have Steve Rostedt's
patch.
The patch is in mainline and I believe it will be in 6.12.9.

Since the warning logged is a false positive it is benign.


--=20
Gene


--=-hlkAZ8gh2/Rp7zinC2F3
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><style>pre,code,address {
  margin: 0px;
}
h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}
ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}
blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}
</style></head><body><div>On Sat, 2025-01-04 at 18:43 +0100, Andrea Amorosi=
 wrote:</div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-l=
eft:2px #729fcf solid;padding-left:1ex"><div>Hi to all,<br></div><div><br><=
/div><div>I've just updated my archlinux to |6.12.8-arch1-1 and I still get=
 the <br></div><div>same issue:|<br></div><div><br></div><div><br></div></b=
lockquote><div>Right - 6.12.8 (and Arch build of same) does not have Steve =
Rostedt's patch.</div><div>The patch is in mainline and I believe it will b=
e in 6.12.9.</div><div><br></div><div>Since the warning logged is a false p=
ositive it is benign.</div><blockquote type=3D"cite" style=3D"margin:0 0 0 =
.8ex; border-left:2px #729fcf solid;padding-left:1ex"></blockquote><div><br=
></div><div><span><pre>-- <br></pre><div><span style=3D"background-color: i=
nherit;">Gene</span></div><div><br></div></span></div></body></html>

--=-hlkAZ8gh2/Rp7zinC2F3--

--=-Cksclr6ZgK3uvhQ/YUvo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYJAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCZ3mVZgAKCRA5BdB0L6Ze
29bOAQCva2nE9UkY4r7NY6ZxOBYBSiK+zSNJ4X6xuDreHzc8AgEAsviZ9znI2WfU
nHJ8Ky3w16QE0ubSMYekNRu/z6FL0gw=
=tVZk
-----END PGP SIGNATURE-----

--=-Cksclr6ZgK3uvhQ/YUvo--

