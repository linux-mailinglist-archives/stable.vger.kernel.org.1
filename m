Return-Path: <stable+bounces-73995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E3B971529
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 12:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE57B284114
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 10:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF4E1B3F3E;
	Mon,  9 Sep 2024 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LBhzIK9r"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532711B29D9;
	Mon,  9 Sep 2024 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725877122; cv=none; b=VX/SHvhCcK8yKIBAxqE8c1lwTgiFSlP3WDpGPdPOENrK91J0aJKMUteEwhNEyBuE913Z1KYm3292w1zdDXlgzzBMUpQ28hWlka9pYzxoIv+q0bklc23Hyr92+gW1ElQcxlwNw3SxIPN3YPWNzP4buD2LTcTNvGeDKkkeOovBcvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725877122; c=relaxed/simple;
	bh=tIl/YJLpYvs/TThG/hy945WRcGfsN7p0+d+XW5VLkZ8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAq7BESL939CUX6tU7XxKrqJzlCjxKz7VIpDD8YRf4V3mTYhtguttLvfu4ftyfnkOkn4PXXXwSIO+WwUcarY627vYSOUvcdU8O74tij3VpgN1EW3xkvUt+5YQlg3qQco+e2IQ56+uIya2zHSGBgqRaOpRavbVcV1ZJfla94UxPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LBhzIK9r; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725877121; x=1757413121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tIl/YJLpYvs/TThG/hy945WRcGfsN7p0+d+XW5VLkZ8=;
  b=LBhzIK9r1ARHRn3Nu4xjNpUY1LO+hq7NuCoWZzfFc/8OgsJ8CcSwzHUR
   93+gvsODsYEtA0UOuxFQccrIki3fB2FhXkWxOxTsTf5hNpJJDpAWrf6Jv
   W3fQ/pGGSB7xV3Ghfvj6gs0YcSo/SPfx4MunwFJrxRk1QuyER+DW/Dp5u
   fJ2C9O1p3lIWiR5u2YXAAuTiRLFzJjkL9nSzuuBRyAT4rW+iV+zo/er8J
   uhyx7u79azcD3CDEb2csGmnt4k3lex2yONaDd4/qeh1GqJ0oFIf88lvVW
   PegFhf56xB51aJuV+TnPLbxtFn6xylhLCHpMEYxr/SyakU9BDuvY7g+zd
   A==;
X-CSE-ConnectionGUID: FaCcdkUXQ1iQi8THvrR/tA==
X-CSE-MsgGUID: /bM7iPiJR8ultVWPqJQGxA==
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="asc'?scan'208";a="31498624"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 03:18:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 03:18:34 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 9 Sep 2024 03:18:30 -0700
Date: Mon, 9 Sep 2024 11:17:58 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: WangYuli <wangyuli@uniontech.com>
CC: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>, <william.qiu@starfivetech.com>,
	<emil.renner.berthing@canonical.com>, <xingyu.wu@starfivetech.com>,
	<walker.chen@starfivetech.com>, <robh@kernel.org>,
	<hal.feng@starfivetech.com>, <kernel@esmil.dk>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH 6.6 1/4] riscv: dts: starfive: add assigned-clock* to
 limit frquency
Message-ID: <20240909-fidgeting-baggage-e9ef9fab9ca4@wendy>
References: <D200DC520B462771+20240909074645.1161554-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rBzuFpmdaeKLjDQC"
Content-Disposition: inline
In-Reply-To: <D200DC520B462771+20240909074645.1161554-1-wangyuli@uniontech.com>

--rBzuFpmdaeKLjDQC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2024 at 03:46:27PM +0800, WangYuli wrote:
> From: William Qiu <william.qiu@starfivetech.com>
>=20
> In JH7110 SoC, we need to go by-pass mode, so we need add the
> assigned-clock* properties to limit clock frquency.
>=20
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>

What makes any of the patches in this 4 patch series stable material?

Confused,
Conor.

--rBzuFpmdaeKLjDQC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZt7LVgAKCRB4tDGHoIJi
0r3UAP9HR5mU/RutuFppy65U3q0D7i129EDL2Zh5HCsiIL48YwEAvSdcIMGjnuaH
T/LYM7x+opdeozaYtb1S58WtiVokywE=
=di5l
-----END PGP SIGNATURE-----

--rBzuFpmdaeKLjDQC--

