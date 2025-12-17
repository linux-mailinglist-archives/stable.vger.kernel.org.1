Return-Path: <stable+bounces-202811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57498CC7AB5
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 13:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DD0C3043817
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 12:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5644F327BFE;
	Wed, 17 Dec 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHkrYrlO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEF91C5D57;
	Wed, 17 Dec 2025 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975028; cv=none; b=QDy0dOszZ7Sx5SRrOX3NIhp0mIpJSktgzVpJGMbCHmY4JZXUuATcM8OlQA56sfVhtfoC8Yh3R+cR+rsiq2MD1VSMMFgG/EvI12u/X4i6/2AVX8sCErFsDDAIC5/eDjDTU/wFiCWGUzaOQOeMtiqamYsnNtsgLq7hY9FxUjGC2LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975028; c=relaxed/simple;
	bh=A2ShE8a52Wx2Bq4wqP9nR8aI4NaMPg3fYmbWb49MMMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hh2ghzYAsYIFSiHDGPl3/PYQ+F0Pu/swnbHMBofZA9uRhoL+uZHk0Z9/ZZdsAia52DCWsgKIGoOJsdu57SSh2sZDdghEzh4LPn76+ZlXbpemEbOL4Jp4zjqTRZStMO7C6co9fCJwbsho041JSLKfhZvQDsjcP+0gBhV4fSphB4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHkrYrlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC606C4CEF5;
	Wed, 17 Dec 2025 12:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765975027;
	bh=A2ShE8a52Wx2Bq4wqP9nR8aI4NaMPg3fYmbWb49MMMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZHkrYrlO2srqO32bw0JoTwWjkzNcCS582ZhURzptUWqWSx+68TJq95VT6yIwPL/PI
	 y7OHB/w2fVSMrH7mDyLdVYMXSkG/IIUOQDzFbjJagCiSiAAV5t1A57S+O+YZbx0T20
	 ZGVuWrDzfUTR+RheHJqIaDKByYzUFDFpw5bh+el4aoQ+IctUj/Is6eK5I8IqKcZJSs
	 frm/TjENw7X/qelRUy1W03/lEQZlpQB1CcN4qsRp2WciTadOtU+C0Nq+I6uHEhiRSf
	 O8cTEm4udfEY8C4wkJJNTsNdzL5fpmGARu0j2UvDw1oOGXI9ZhihExk2UfCN3KRydm
	 L1mbdxdt06KeA==
Date: Wed, 17 Dec 2025 12:37:02 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	seppo.ingalsuo@linux.intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/8] ASoC: SOF: ipc4-topology: Correct the allocation
 size for bytes controls
Message-ID: <7cfb208e-9273-4fef-af07-9771cee11656@sirena.org.uk>
References: <20251215142516.11298-1-peter.ujfalusi@linux.intel.com>
 <20251215142516.11298-3-peter.ujfalusi@linux.intel.com>
 <652a147c-2012-469f-b0e0-c73a1385cacb@sirena.org.uk>
 <329a3007-de85-41c6-9b63-ca79e3bfbdef@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CJFsEXFwjcO803JK"
Content-Disposition: inline
In-Reply-To: <329a3007-de85-41c6-9b63-ca79e3bfbdef@linux.intel.com>
X-Cookie: Big book, big bore.


--CJFsEXFwjcO803JK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 02:35:17PM +0200, P=E9ter Ujfalusi wrote:

> uh, oh, the correct tag for this should have been:
> Fixes: a382082ff74b ("ASoC: SOF: ipc4-topology: Add support for TPLG_CTL_=
BYTES")

> but the SHA in tag is also fine as that is the point when this code is fi=
rst used.

> Should I resend the series?

Please.

--CJFsEXFwjcO803JK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlCo+4ACgkQJNaLcl1U
h9ByBwf/e7+9YUzzT23qkDAI5jgzh3Y1QSLekhcBZ+X2rtfZ6wcRDjx+gJDXcVV8
Vj0Z3DcJ9DvZiFRtQ5kEHuoRAqDB2mRmk5B38sT45UOlNbRokRrvOXkVD9UkshPc
ED9aQfwAWhSmXnaSX/SVS3di2okGDZeDWSEM0kYkYLRYgENq8TQ8GcLo7JnvqQaw
wTJdaPZOg4LQOJSL+Z1/PAWcv3gCb0opFVKe1Pp5sCcX/5Dpp/cmyT2umVExjLVq
4ShrICSUgyoZVnYj2JbTp8dwj2XRWvIWn6S3+DLkrofcmQTxCbb4WBoXASicSJBg
OCnzbXnmUzOPqe2G0Tv5T/gmDIGu1g==
=EIe6
-----END PGP SIGNATURE-----

--CJFsEXFwjcO803JK--

