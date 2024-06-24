Return-Path: <stable+bounces-55006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 677FB914A3A
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 14:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC221F24052
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 12:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6052A13C693;
	Mon, 24 Jun 2024 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4gMb4kg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B61A13C67C;
	Mon, 24 Jun 2024 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719232591; cv=none; b=K1gG8aXtVlR9k0Zg4Rejhm0Y6hCsLIX1sIOVK4PGiXk9+XCrpvG3mS9YbzIIKCHlOAqhJN4eI8i30t3Mcs7XO4Z0KuJzMaGt6ZBZus+GKv6m0lBkbXfv9NJ8RBZ8XzJWbx944MHjc9JYZ5hus1RU8lxjplHGd+op7iG47D14vvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719232591; c=relaxed/simple;
	bh=VhurbZFA7Gb2R3cH1kKEN0MzJ83p+dO1GdwBiN0/gWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBgTmdlKPnjKk0qBAonNcEthnaJEgy4evt4NBwKW0QDhIjU8KccUSnS12IUUPlLr4NqWb60l1Ky0f01qQoZyfghigNO0VbiG5i+arN+2b1JZ2onAe5xSOufFG7ckmAeEUuGsDq6C5KsnvRA6rYYXr1dWzVZFITgENwJ7BYRbS4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4gMb4kg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFB6C32781;
	Mon, 24 Jun 2024 12:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719232590;
	bh=VhurbZFA7Gb2R3cH1kKEN0MzJ83p+dO1GdwBiN0/gWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4gMb4kgV4cGzMttn8KHyuP8htrKOo4XQD2tUbLsqByayHguV46787kuw4Mi9jjyc
	 D3lxr1Q66qpkY8irbGfqo/hybxWFN12QIlUoNkPWkrjTu/NtsL9s6r1UR6bkokuHcI
	 daHlrICrdsCzeQYZO+Qp6AsrFWqsxkzcXbvV2cNZT0Uccn9O9ZowrH8PJ4m7kfBEZt
	 25xqGr/cYHY/QaS3Zbp49IAP+V+D4Kiy8P4wTsafs/WatZI0PbK6U80FYI1afzLQKU
	 STziVuCXOvwQ1PTW9IDIDjH95A6hJG4lHIGuOQ4XqfWJjmj/GV8ZSlIwbwVQw3uVml
	 NbWGQl8ngvWWQ==
Date: Mon, 24 Jun 2024 13:36:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.de,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] ASoC: SOF: ipc4-topology: Use correct queue_id for
 requesting input pin format
Message-ID: <ec992bf9-667c-48a4-81ed-3a1232123987@sirena.org.uk>
References: <20240624121519.91703-1-pierre-louis.bossart@linux.intel.com>
 <20240624121519.91703-3-pierre-louis.bossart@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5pBrGhTLrwRGNC0f"
Content-Disposition: inline
In-Reply-To: <20240624121519.91703-3-pierre-louis.bossart@linux.intel.com>
X-Cookie: Allow 6 to 8 weeks for delivery.


--5pBrGhTLrwRGNC0f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2024 at 02:15:18PM +0200, Pierre-Louis Bossart wrote:
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---

Please put fixes at the start of serieses, or send them separately -
it makes things much easier to handle if they're separate.  This ensures
that the fixes don't end up with spurious dependencies on non-fix
changes.

--5pBrGhTLrwRGNC0f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ5aEkACgkQJNaLcl1U
h9CWEwf/Wtk/DTzMdgsjQzFf2YB0zOwvpw0DSBQgZpLSkWnOvPb0k6o/wsMhK07l
AtUfI6rSUzBTQ6fBhRDyLvYMGGDeyDZXcP8zQUUbk83zws7Mq9dSbBZR2JB8r9UK
D39PW7vG4mz7U8xWeiZUQcvpkDFb0gPCjXCd0DcZrRmBl1KPFwRYjQ6nogAZ0nVy
xvwwQEpmnp9yLMriXcBz53npaaiHj8CnGkwbp8i7tDn1ZOte/JM9LNYeJCI34ZIN
iQyezU3Wo4CRdFvPw1kqY0N6wRcgi1f8hrnYz5A2oQoekmEpIR7Xoo9mFFpJvWNg
H25FDFbhmMOLCH6c0FhZ5+phfpsj4A==
=zJlx
-----END PGP SIGNATURE-----

--5pBrGhTLrwRGNC0f--

