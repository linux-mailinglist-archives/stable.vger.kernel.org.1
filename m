Return-Path: <stable+bounces-226020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL29D/1auWnYAgIAu9opvQ
	(envelope-from <stable+bounces-226020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:45:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA61C2AB292
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9EB3306E61B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5052EB87D;
	Tue, 17 Mar 2026 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy0TnZX5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78E22D592E;
	Tue, 17 Mar 2026 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754971; cv=none; b=KmvzHXMr5b+ChXiV7PmTvbGDO6E6hRfF4WoTIkos76IpaKk2Oe84ZMbD49x/1IyBPS0D+0eOu8+KoOf3xflnvsPctpJIxS6pvNQz24QColWtnbMagZUxryd1rKtUu62B/87qYw3bkwB859eMaBOJ4WP8Q38XZkiqESJUSBdc3sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754971; c=relaxed/simple;
	bh=cvWFM54q957EernSWzHaK9Acqjw396q6QTQo5GDsp5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShsouSxVeTlqZmV5yn4M8HKQaEZJ/s8m4zxE8C0Awnynqj5TO3kgHmVFhY58N1GaYx7wcyb0sXFU/tx5mRtID4AiAjJVR6JdHVHH217005vGPp310rWJdaeoPKPSfMQDsrILEbUPr32zxogHJP3cypCfV4gLqs36328SoEX12vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iy0TnZX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDBEC4CEF7;
	Tue, 17 Mar 2026 13:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773754971;
	bh=cvWFM54q957EernSWzHaK9Acqjw396q6QTQo5GDsp5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iy0TnZX5T2xqw3wl38rgvtDR9JClrVeBVTwEjQZgZeUSC1mQWBqW/7QANTOB+ItEh
	 ShMuJXNtUDliwfJuOm40uaMs7VLacYFs4/xaeXEHuP0wSrirTRQUbkPVUIy5LQqRBg
	 5FqbbtdDB6HEelqWDfyEDYrGwjyJR0xK/vDSLyQP0VRdzNtsewmCWmBhZdxRCQKhwX
	 UtjL/WYWVKM3oGNCuTfxvKwt4ApwDU0XE1YwK32qPu1CzE06K8OSKaNNjr+SM99ctm
	 IwndBkfvV/zVMP64fw2nCwDX4++guZiEpwi6CnKsiGxnn9bHiy/g4fHTg6er0m7Tod
	 qyBGCOjWy60qA==
Date: Tue, 17 Mar 2026 13:42:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	devicetree@vger.kernel.org, driver-core@lists.linux.dev,
	imx@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] device property: Make modifications of fwnode "flags"
 thread safe
Message-ID: <94dcb275-4af0-4ca1-9b4a-5769bcc2c777@sirena.org.uk>
References: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CESacuQ0/LxRTmli"
Content-Disposition: inline
In-Reply-To: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
X-Cookie: Must be over 18.
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226020-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,lunn.ch,linux.intel.com,gmail.com,davemloft.net,google.com,nxp.com,redhat.com,pengutronix.de,armlinux.org.uk,sang-engineering.com,lists.linux.dev,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,renesas];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: EA61C2AB292
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--CESacuQ0/LxRTmli
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 16, 2026 at 03:42:06PM -0700, Douglas Anderson wrote:
> In various places in the kernel, we modify the fwnode "flags" member
> by doing either:
>   fwnode->flags |= SOME_FLAG;
>   fwnode->flags &= ~SOME_FLAG;

Acked-by: Mark Brown <broonie@kernel.org>

--CESacuQ0/LxRTmli
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm5WlEACgkQJNaLcl1U
h9DSgAf6Ap5hH7yRkuhE3ZUXEU9Sw0nRKEWLWHq9c0Jd+k0j/ZH4K6YAePaTKleT
VU3Fsx4siP9rbVq9sWIZ4qtL2ChJw3LgqNNMe88HKsb5MLrcpbCzUEXe9mZHg9ke
tucJZVfd79aIWfTHelxkhI1ZuW+JNDId0+0NrI427Jrhou3kPYT7+gJmYXuMbWik
Pmc0B/+HNSZ5wx+ETM7Ki9+Yj+BY15QaBoNID1YqUpzKd6xrtRs/Ep414//xibo9
92kpTPrKdt92+B4iMU/YWQvPyUelIpmWR7aJ9I823NnLKHA5yvoEy1ff5WloKA6Q
MxtC9dhuaD1HfwqImmlLKtm0H6/ABQ==
=PgWz
-----END PGP SIGNATURE-----

--CESacuQ0/LxRTmli--

