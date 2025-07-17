Return-Path: <stable+bounces-163294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 236B2B093B8
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 20:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C623A3420
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 18:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AC02FE314;
	Thu, 17 Jul 2025 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="SwCZ/vJ9"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9146A1F5413;
	Thu, 17 Jul 2025 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752775591; cv=pass; b=kkbkOs2808gGrIBFr7EcWrbzEFC1vVE9sghNZOdo5KSdeWPklD22IERAm3iUpXrn/jkIsWwkrB3BJrPfhgbfNmNhSPVJ2DiJjeG2Porya5XoqwiqA7qxc9H07Ed+fAksALDgrgmowUj73tOPv1WdEpZ7IQj3OnZkklwq7iy3Gnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752775591; c=relaxed/simple;
	bh=FXg1dYWGSii4DjUMlyrVneV6Xn97Xpr3Kr/riOfsIYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QySga56LZgmFYXBvdHOiOEJAz14UNq7dLOZNQlwe2Oxc54ww/WXGUwHOYLAHIfWAU/ENryYHlNhgYQly3O6hWaAv9uGW40EcDkpCQ3yxC7VlC/QXR7psKsrwsw5VVyV/FKIf3ksg1PQd1tZs9tre5kKsp4Iy5bvRfnGPh7zesF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=SwCZ/vJ9; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752775549; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CK32CHh5vg2Atgu6w3X/c+qp2bIgiNpXLf/qou+4uzU3T8J2B7MBbkkGlpRi9a7aFOPbAcx/ed/hehbUHmfkNDVC1gvdrAu52yvcNuZA13WgROhUMMwdlKtz8OKZvgW8NFiU3C7ehOTyB9QIbprOljH3aVW3KmPv063jztllO8A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752775549; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FXg1dYWGSii4DjUMlyrVneV6Xn97Xpr3Kr/riOfsIYY=; 
	b=E/qbRLzsvmUKmaNDObWFIoTaCZjIScKMfy0T/S8SBZdIqeSkjYCOGYOgJyiY4UQtepqnyNXm6O1ddga+yhs9xvqw8JoQEJ0LdCFAUdqOBO/iezIbEvsrnhWp56YAxASyw3RxVQLh1MueRGawo37sDFYn+fgYuNo7BE8OmOYgeR0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752775549;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=FXg1dYWGSii4DjUMlyrVneV6Xn97Xpr3Kr/riOfsIYY=;
	b=SwCZ/vJ90JIKCZlK91Wh7/s84kp7Nb2L2WsoVqMZMCyflGkVAuNfNfWbE51qeUoF
	eS7jhtQ8QS7CKcdniLDBE3lROgxQfzhlQ3p3W/zBPlg5U7WWseNCLjnHkmdZKBojz37
	R0Fw5c8ETG9Ir0vk+3vGHr6PI42pYLxqp3AsPs+s=
Received: by mx.zohomail.com with SMTPS id 175277554571018.84005306388258;
	Thu, 17 Jul 2025 11:05:45 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 169001805FF; Thu, 17 Jul 2025 20:05:42 +0200 (CEST)
Date: Thu, 17 Jul 2025 20:05:42 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Yueyao Zhu <yueyao@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fusb302: cache PD RX state (fix for 6.16)
Message-ID: <dm5us2ylnretvzpnfrptr2feyk27llqpmtxx5m43qc446u7y5v@jdz3otjcy2pi>
References: <20250704-fusb302-race-condition-fix-v1-1-239012c0e27a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wpngwxf3jc5tvrra"
Content-Disposition: inline
In-Reply-To: <20250704-fusb302-race-condition-fix-v1-1-239012c0e27a@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/252.767.34
X-ZohoMailClient: External


--wpngwxf3jc5tvrra
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] usb: typec: fusb302: cache PD RX state (fix for 6.16)
MIME-Version: 1.0

Hi,

> This patch fixes a race condition communication error, which ends up in
> PD hard resets when losing the race. [...]

Gentle ping, since it has been sent two weeks ago in a few hours
and ideally I would like to see this fix in 6.16, which isn't that
far away anymore :)

If my mail somehow got lost in your INBOX, lore has a copy:

https://lore.kernel.org/linux-usb/20250704-fusb302-race-condition-fix-v1-1-239012c0e27a@kernel.org/

Greetings,

-- Sebastian

--wpngwxf3jc5tvrra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmh5O2kACgkQ2O7X88g7
+pqpFw/+PMNN4JGvQ+Hu/lU/H48LydsAN9Um64I8jbTfde2eRXi5VqhJy90C839W
xDhMKiveQWsfF6Vqtcm67ga1d56YNl51vYv/j0PHvjJPIhb1kq3YsWQ/BdKJyYVd
0b/uXr1OpAFg+30PcCxwPYQw/uEUeNsBhQuurE1FW3WQGq/0eZpXtm+8LINuK+jP
9nENvvr9HgW7sxJxPoJKZUNhz02oxhKKrxkeoYP6fy8aYA4aCdcCLPOV+gNUOtSA
ypSu5ywljyXixp6b2z3FHMFRksBFZMjL/2FrHLZ02MJ4JM661TMVAiBTij919adb
oFum7xfCxZfIfYKhLXVRcEPF6nzU86pe4fLVjNKGmZAX+8ao4j/F8IPf952T7Fbx
LWKXIiPuG99f1LFNau3PbsmoEbKMEnifJnASdTZ/K1r9a7wmjbiFHsgxFn5dBbKD
KmzTG3CdB/+A/wOgyWIsbPm2Wxkkze79qbrzjT2l8f8IsYSOcrhbSIJcmyIhTLJ+
yw9RvzhWFF6Vay0mBeJgwQRGcgf+yjPNayrTEx9/Bw9CnyRE2T8xZ34/ZHq2mfXE
yEfjjeEwORnlmZs8YnoNGxntSiRM5j9yba6u4y/66Vscja1jIs8c0Q6o+NqVd21D
WwyTXOwpVyGI/FXps6D3tOaHLRjyisVxLlK7Zpi744yqKGYKlRs=
=SHH/
-----END PGP SIGNATURE-----

--wpngwxf3jc5tvrra--

