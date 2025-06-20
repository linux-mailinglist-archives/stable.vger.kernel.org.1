Return-Path: <stable+bounces-155077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88992AE189B
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 12:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2037E1BC73F0
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93A928000D;
	Fri, 20 Jun 2025 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="nJuDkGL0"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1031FBEB9
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750414235; cv=none; b=HC5c+cIYyteD+uLwr4hDlgkMc5jp5c/njxVbUJ29pDyLuCbu9j4qdEY2V2Q1bNYo5Np5Ll6MAoFyA/qK8zxrYaMZeYL6N0EawuijjbUvr4zwNIfmj0LyTephgFJDl+sEibj7ajlpN/Bdi7dt4siPG6nE+4v0y/OkG6EkGvJ6Pu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750414235; c=relaxed/simple;
	bh=Rh5pIV8WkpI5HMeTJ5df7eJWevXbYQsSGtle3kqnKrE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FNxcD3NgEh8AFcOIiNdeaCxrtJsZGHGhrkUp4s5v5s086l6mpHyYN/fQmSlVz3TGARGSP7ET2wx1xaZ5p9F3DeJ1X99kFY2fv0P8ON0bgke3Mor1EFVgOlC+SfuhnSY0PpYR4VyXTpArth+/xMnMTf+wwABHjndclOJ921f1QmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=nJuDkGL0; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1750414227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh5pIV8WkpI5HMeTJ5df7eJWevXbYQsSGtle3kqnKrE=;
	b=nJuDkGL09UtmImqfvryADBKU0wujEnm2pxtNg2qi98hUv3Oq26UXz8d1At3pQ1c5FJ7z2m
	i7Y73alRZoz+/Hr8yCj+qCJhA4032jLzcd3BxrVFNLqQlE3rXD6HLFXPnNXehBSz7T3SZX
	DSdE4TWhVR/G0DPZit2LKRcM409BPIuBYgfI3dXodbZNXCPBhO1mSG2h565SVyUIC2qZE6
	Csv/1+MoU6j3vxEX6FwAT2A75J1GnTGeo0nz/sZXGjnhlFs4blrt2Rk2ppUvSk9ykjvWB5
	NGdzqJSeUtjW0i917JRpTkyukJPhyA3ylnMr9ICdBSgaX5C2PuBoUwVRnzqe+Q==
Content-Type: multipart/signed;
 boundary=3849aed8dc18aa9a4d5f113a0f5d2765faac8f215c4386c490a0ad7c38eb;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 20 Jun 2025 12:10:10 +0200
Message-Id: <DARA1V0ITPV5.T24DK4TVI0W7@cknow.org>
Cc: "Rob Herring" <robh@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <devicetree@vger.kernel.org>, "Detlev Casanova"
 <detlev.casanova@collabora.com>, <stable@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/4] arm64: dts: rockchip: enable further peripherals
 on ArmSoM Sige5
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Heiko Stuebner" <heiko@sntech.de>, "Alexey Charkov" <alchark@gmail.com>
References: <20250614-sige5-updates-v2-0-3bb31b02623c@gmail.com>
 <175036770856.1520003.17823147228060153634.b4-ty@sntech.de>
 <CABjd4Yzz9mh0G5BhpPOGAoadD-A5eX4kdsF8rGrWk82hAE-MYQ@mail.gmail.com>
 <5004008.8F6SAcFxjW@phil>
In-Reply-To: <5004008.8F6SAcFxjW@phil>
X-Migadu-Flow: FLOW_OUT

--3849aed8dc18aa9a4d5f113a0f5d2765faac8f215c4386c490a0ad7c38eb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Jun 20, 2025 at 10:44 AM CEST, Heiko Stuebner wrote:
> Am Freitag, 20. Juni 2025, 10:40:49 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Alexey Charkov:
>> On Fri, Jun 20, 2025 at 1:17=E2=80=AFAM Heiko Stuebner <heiko@sntech.de>=
 wrote:
>> >
>> > I've also fixed the wifi@1 node in the overlay - which was using
>> > spaces instead of tabs.
>>=20
>> Thanks Heiko! It's annoying that YAML doesn't like tabs, so copying
>> from binding examples is not a universally good idea :)
>>=20
>> By the way, is there any tool that helps catch those?
>
> checkpatch.pl would be the tool to do that, but I'm not sure it handles
> this at this time.
>
> I also only saw things when I looked at the patch in "mcedit", because
> it nicely distinguishes between tabs and spaces :-) .

In vim, ``:set list`` makes them visible as well.

--3849aed8dc18aa9a4d5f113a0f5d2765faac8f215c4386c490a0ad7c38eb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaFUzjQAKCRDXblvOeH7b
bs/QAP0WF4+k13q1KtXzF57NuU9bR7PWT5UFo1PZ4uovhmnPzQEAwWcTlpj6q/oo
whJ0eFpdigYeLRxSCw2IgXaWu2AV3gg=
=hqZi
-----END PGP SIGNATURE-----

--3849aed8dc18aa9a4d5f113a0f5d2765faac8f215c4386c490a0ad7c38eb--

