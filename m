Return-Path: <stable+bounces-202802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D75CC77A9
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 13:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16F53300502A
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 12:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1BE33C501;
	Wed, 17 Dec 2025 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMPMFNO6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C2533C1A0;
	Wed, 17 Dec 2025 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973046; cv=none; b=bK6jKeQQoCy6k//gzEXByB6O6VyCtXwvedLYOcN0h1VDSss5QQZyRGk9+zHqVw+S22ic3OZ3zIb6GLiO/txipOdtamzpP5gn0PDLE8+ktsEhYAZ0WdXviqKi3E+gsMpcxhGL3h+mzw4pjoAW1k91bYVpgvJCPRl9s4Sej6DC0pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973046; c=relaxed/simple;
	bh=T2KDTg6ox1HQefM6lQ7EP+/QKDIgXtwlmqV+CyRgR9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA21OrbJExS7GmGxu1oDyrJ/HaWi5Y3J5ap3ehjleB+41mfq2GyJdjMH9oea+UkkT6pwl11GqUA2HiaEut4PWJ5lBqHRxIC9CCk96J36WfWNyKa111W9NHA87YrlladnO1Z2AfbTCqt7VTCzMlG2aFPNlzkPV58lcYCwpCDdC1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMPMFNO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1130C113D0;
	Wed, 17 Dec 2025 12:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765973044;
	bh=T2KDTg6ox1HQefM6lQ7EP+/QKDIgXtwlmqV+CyRgR9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FMPMFNO6q8kHCr0doybsn2wHWjl3f0rtc8aKj7bzuzF2sEbsVYe4uCMCTvWiqbUjl
	 PWEMUc43EvmPxopJUlFYQlxlLD8onJnb5q2yiaWR8vgfL/KpTv3gO0h8XKavinlwhB
	 SJcvbV1RIEpIhC92EuI7EuK/KXmQ2W3UCpkCqApMMq9OWrhGDWhTRCaTIYyT+cuMvX
	 6EH+yWl6em3TL+jCeNahm2jGys6J5Cow/JfLIm4JpDnxdSw6ZjsKwpXEJAq3N2GIAc
	 +2UwEjF3D1gucG9SRXK7ct1cRK4gfsAx8rqEUH3gYJN/tpYizbtQ/guuyXL9/KDbr2
	 UHkNypnNCV4hw==
Date: Wed, 17 Dec 2025 12:04:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	seppo.ingalsuo@linux.intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/8] ASoC: SOF: ipc4-topology: Correct the allocation
 size for bytes controls
Message-ID: <652a147c-2012-469f-b0e0-c73a1385cacb@sirena.org.uk>
References: <20251215142516.11298-1-peter.ujfalusi@linux.intel.com>
 <20251215142516.11298-3-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1AgTeC1z1t6H3FOZ"
Content-Disposition: inline
In-Reply-To: <20251215142516.11298-3-peter.ujfalusi@linux.intel.com>
X-Cookie: For recreational use only.


--1AgTeC1z1t6H3FOZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 15, 2025 at 04:25:10PM +0200, Peter Ujfalusi wrote:

> Fixes: a062c8899fed ("ASoC: SOF: ipc4-topology: add byte kcontrol support")

Commit: d80b24e6a5a1 ("ASoC: SOF: ipc4-topology: Correct the allocation size for bytes controls")
	Fixes tag: Fixes: a062c8899fed ("ASoC: SOF: ipc4-topology: add byte kcontrol support")
	Has these problem(s):
		- Subject does not match target commit subject
		  Just use
			git log -1 --format='Fixes: %h ("%s")'

a062c8899fed is "ASoC: SOF: ipc4-control: Add support for bytes control
get and put".

--1AgTeC1z1t6H3FOZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlCnC8ACgkQJNaLcl1U
h9AokQf9H1CebL9MeXnYcTFTgqOxo22lsjO9P11iEjX3KtWYLe+Wvb8V7Z8rOyFP
h9LQuumDMiN1SWXbxCimwhk4mAe1j1APbc9H/gF26M5XoxK98HS2JZEDivCaKkcu
wEOWmfkN795Wmst1QFKig6SjgX+J+XUmeXxmaVa+6dUmUqA2Heedb2GvY7xKuUBA
9x6zukuoy+EMvR5OJecy4KhOqEuovHy/XIG+/EOLrzyOUtsucLkPlDCwYt2S4dqJ
9LsqwVIWSz5nKKPavY1mXFBNZIkLQ229w0OqXM0b6EEXjlhi361C+/5jqRLmMd/s
jggqwGVWNdICw+UJq8K6KFtoC/bndA==
=b6iZ
-----END PGP SIGNATURE-----

--1AgTeC1z1t6H3FOZ--

