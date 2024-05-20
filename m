Return-Path: <stable+bounces-45460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50B58CA1BA
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 20:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED911C21670
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 18:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7685138482;
	Mon, 20 May 2024 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="g3O7I5yv"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D346137C21
	for <stable@vger.kernel.org>; Mon, 20 May 2024 18:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716228099; cv=none; b=TUfszVeWIzUj4SUPAzAQuabHYc3KvZgYIYaZYgpcM2IPEyOZz3oT06SIyehgnYQdx4eojSju3iiYKZ8qbRvwnWA7XjZK7QYcMjXg23aYndmIZokf6LglSAfbAD/myZ/JRc0MwD7xNNF4CW7VCVQcARAURkhPl3oDOfRHqvPc5cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716228099; c=relaxed/simple;
	bh=y357Gf++Lwv58DsPTP+EhrVLy2CyZ3UEDFn8PhgucMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=roSNdQd99oqLpNKPG2UVNBUFv5uwSW9/QCyMjI5dV0oGNRtYBFrFTKqtQoM1QqpwkGEBIFclEV5d4+VRy6MidIGpq95ut4UrS1TW+tm1mfa0LfhkEZxYWXVwXCxGJWIYo+pxUUyKtH/Km/FkRakhdqUeP7rNCNTKTRuuUw3wcqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=g3O7I5yv; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Envelope-To: linux-rockchip@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1716228095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jj/JcQQpB8rmUIcI3E2ag3tbR7mqdkzfH4b6x0esQhc=;
	b=g3O7I5yvMu9BQoVNpVIDnLYPyNi7NwX8hmmEKjuqewJcwAQp9o1XdauJ7NZPRoEHYOYxQA
	ug/1qUk+eUqizfl3GRl5CBWKGbBMx7VMwl7F3GXH/lC+ndwLoVXE1b1Q6sJHQm2eftbRRe
	y+y+RObaKCTOyCBCbBJux6tbC7StmkR86+RotipWkVZ1VnOKdWLSW3uXxTdKryVY7zA46p
	58Wm/250r/dVMCYp77nFirTiqtTWXbDlxbjtUCiVJQGatPfX7qK+71wi9ytzjZKprRCP1P
	iSMutYNXONzjLRg+57bTjDWFB5VWsQ9OYCRcUingZaT1TeEvUq83LdocP20+ZQ==
X-Envelope-To: dsimic@manjaro.org
X-Envelope-To: heiko@sntech.de
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: devicetree@vger.kernel.org
X-Envelope-To: robh+dt@kernel.org
X-Envelope-To: krzk+dt@kernel.org
X-Envelope-To: conor+dt@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: stable@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: linux-rockchip@lists.infradead.org, Dragan Simic <dsimic@manjaro.org>
Cc: heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: Fix the DCDC_REG2 minimum voltage on
 Quartz64 Model B
Date: Mon, 20 May 2024 20:01:24 +0200
Message-ID: <28082151.hHkOrr57cY@bagend>
Organization: Connecting Knowledge
In-Reply-To:
 <e70742ea2df432bf57b3f7de542d81ca22b0da2f.1716225483.git.dsimic@manjaro.org>
References:
 <e70742ea2df432bf57b3f7de542d81ca22b0da2f.1716225483.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6401850.1aQqFvIbO2";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart6401850.1aQqFvIbO2
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Date: Mon, 20 May 2024 20:01:24 +0200
Message-ID: <28082151.hHkOrr57cY@bagend>
Organization: Connecting Knowledge
MIME-Version: 1.0

On Monday, 20 May 2024 19:20:28 CEST Dragan Simic wrote:
> This also eliminates the following warnings in the kernel log:
> 
>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000, not
> supported by regulator panfrost fde60000.gpu: _opp_add: OPP not supported
> by regulators (200000000) core: _opp_supported_by_regulators: OPP minuV:
> 825000 maxuV: 825000, not supported by regulator panfrost fde60000.gpu:
> _opp_add: OPP not supported by regulators (300000000) core:
> _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000, not
> supported by regulator panfrost fde60000.gpu: _opp_add: OPP not supported
> by regulators (400000000) core: _opp_supported_by_regulators: OPP minuV:
> 825000 maxuV: 825000, not supported by regulator panfrost fde60000.gpu:
> _opp_add: OPP not supported by regulators (600000000)

Can confirm those messages are no longer there in ``dmesg``, I see no other 
error/warning messages appear and my Q64-B still works. So

Tested-by: Diederik de Haas <didi.debian@cknow.org>

Thanks!

Cheers,
  Diederik
--nextPart6401850.1aQqFvIbO2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZkuP9AAKCRDXblvOeH7b
bpi3AQDm7qbYfHudSUzrr2LFgBeDIsZBSArY/04vtRyNrGk0hAEAmADoy6OdU918
gVzI7Zmmt1pEwCDGj6bnrQhovKNdlAI=
=L7k7
-----END PGP SIGNATURE-----

--nextPart6401850.1aQqFvIbO2--




