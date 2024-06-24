Return-Path: <stable+bounces-55101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12118915643
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 20:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33ED31C21441
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 18:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD0119FA92;
	Mon, 24 Jun 2024 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqMPig+f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADC919D8B4;
	Mon, 24 Jun 2024 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252700; cv=none; b=c+BMjOhrV/uJ2T8zh3SFcjxBu8oGRDgpMlV4KaQjTQ8Rhn/FCz7V0Y9n1efZhF1EwiUv5eUbzEmCWR8nhcRmyCcBnNclaekQFT4w6zjs+SVrypFu5+u6CgFG3O6QM0pWOqGq23j6Bqnldihs/pbJLYAZ332pUOhuLnN9nihurDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252700; c=relaxed/simple;
	bh=LMQM4ggkNAmyZtbcQnIjN/xx2r5UXt3+sfPf7Izs3Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lli7QBN4a3k3HzB+KobMFzRIQV17GN7HrL2SSTsmsqGZFxIM6cLZaKZXrsFpWX3BLN8KrVzO0meFocjkfv+qgmnZI+CNP/keNHGR9T0daOvLPxKu8F1TAPFRYo/eAI8qMab+DaFZk0iyqAfMAixJIzOmvcUgDI0XZs5Ogb2V4aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqMPig+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F66C2BBFC;
	Mon, 24 Jun 2024 18:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719252699;
	bh=LMQM4ggkNAmyZtbcQnIjN/xx2r5UXt3+sfPf7Izs3Bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SqMPig+fKRfPD9amnFFJ2z6A6QAgchFEO6lAZm+DiRbuMGOC5Q5BkfamFOirb5YF1
	 xCqVt1UJ5vPOpIGj4IyP32fpsTF0zsnPpqc9aGs71cmWLO4BAgZspTZ/LnHNNiuv60
	 5cJOKWnohBicmHM2R/p92xtjmlo1naNYnVCwkDFuR77FYc/wNGrxJCaB716g7eR4Q2
	 wOLzEMIVUebf3q0Hq+Be+QKFb0Clk1Be9pCgEXh3I++kEAQ5oObamVdI6WO/8Iy068
	 d2j5J0y5rWXaNy4tNoRnIUKLHaPVBD60O7EGHJ0AmhP7Y4q1AgZmns4TogD2Ek316a
	 RFZRk146j1YsA==
Date: Mon, 24 Jun 2024 19:11:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.de,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] ASoC: SOF: ipc4-topology: Use correct queue_id for
 requesting input pin format
Message-ID: <61a68a33-7c65-4b0f-af3b-a258bb1544a5@sirena.org.uk>
References: <20240624121519.91703-1-pierre-louis.bossart@linux.intel.com>
 <20240624121519.91703-3-pierre-louis.bossart@linux.intel.com>
 <ec992bf9-667c-48a4-81ed-3a1232123987@sirena.org.uk>
 <7372501f-0393-4ba5-9e05-71d59dc1449b@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e4ptfVfnpd/tRlJd"
Content-Disposition: inline
In-Reply-To: <7372501f-0393-4ba5-9e05-71d59dc1449b@linux.intel.com>
X-Cookie: Allow 6 to 8 weeks for delivery.


--e4ptfVfnpd/tRlJd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2024 at 05:26:32PM +0200, Pierre-Louis Bossart wrote:
> On 6/24/24 14:36, Mark Brown wrote:
> > On Mon, Jun 24, 2024 at 02:15:18PM +0200, Pierre-Louis Bossart wrote:
> >> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> >> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> >> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >> Cc: <stable@vger.kernel.org> # v6.8+

> > Please put fixes at the start of serieses, or send them separately -
> > it makes things much easier to handle if they're separate.  This ensures
> > that the fixes don't end up with spurious dependencies on non-fix
> > changes.

> Agree, I wasn't sure if this was really linux-stable material, this
> patch fixes problems on to-be-released topologies but it doesn't have
> any effect on existing user setups. At the same time, it certainly fixes
> a conceptual bug. Not sure if the tag is needed for those cases?

Given the enthusiasm with which stable backports things it's probably
fine, I suspect the device quirks might end up getting pulled back.

--e4ptfVfnpd/tRlJd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ5ttYACgkQJNaLcl1U
h9DAEwf/ZuByiNrlInuQ8Dol95wy3z5F8WHBuuyD6/CxhHerYx8ICHQRC4/0kZnI
vmE0gKsMi/idFkGE1ZTpBzCMGyrZeAFF2S8J6qDXMg1V1t8q+aZSg69sXUVHdaT3
mnGgJtfeiF7ctTl2GNUB1NOzLpkFaoU19jDBPCJXgUN6sGhzEDNkrqNvrsBFAhBQ
hhtQ2ynn6o/l5rg6kX+fovYG1J1CRr8GeczeJAfcjcALJlwI8ZgJNLf9Wa75q+uJ
TqabyUqoQO9L86BW7TBMJCvun6hMiL9i5JUbF5KcZN9ndAJ0tnHGGhhWp91a0iho
5J0J8jCaXa1bGl+1h1ZzMgRxEvkdtg==
=x3+9
-----END PGP SIGNATURE-----

--e4ptfVfnpd/tRlJd--

