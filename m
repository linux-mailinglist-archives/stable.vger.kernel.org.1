Return-Path: <stable+bounces-77904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC8D988422
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60A228154D
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9816318BB91;
	Fri, 27 Sep 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="NaLIuosm"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EC518C00D;
	Fri, 27 Sep 2024 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439852; cv=none; b=NNJixtM6qBIAvYDB3KZeSAlZpHoryvvAgaFbDMGFceiLwltpEybn22pwbHyp4/568X5x99NvoyELa6XhbOp+q7+WvqetUO781eRk/LUWbHJLRG5UV2yT7SkkDE4f21py7ESMgq5a+hhkCLFSieemEfDaccLr/ZCEEAmms3R+mRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439852; c=relaxed/simple;
	bh=UQ5JGAQjcS9YxwrwHB2AYa0apBAuFOpcKQkp/NJzVI4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=re59TXT+s7kW8GDg7sDqogmUxQCdqkrcFbIVe2UmzDJ+SMyE+l605YB7b7uRwF75PGDFHlZF6MPJ1iZNwYxIK7rRiZdRod5ysJq0ZUYG5nKTDwGUea3VRxNH4GASzAF4+r23E3u+ySfcgcDgLDwFyVlLXhmKBtoTx3KnpvLgI4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=NaLIuosm; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1727439841; x=1728044641; i=christian@heusel.eu;
	bh=UQ5JGAQjcS9YxwrwHB2AYa0apBAuFOpcKQkp/NJzVI4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NaLIuosmBC8LWUmSMHh3SPTe4GmdVk4Mg84/lCbpDQ+tCF45TqP6kzFfREW1D68l
	 8fKX7ThLXusKZ/jK/3zwkZqvLXSx9odAxjZ1MpVEDKIET1rB2odDvAbfmucCLat1m
	 RwVkgy4OJX2bJTnG1RKnCf0XS/c95mDpsGOVndGPXBp8u289k05e8TNWXpcVYrOK2
	 2y5J1e+CQVG/EO+QwWhwfi3TKd/L9suJJMD9rr3jyOs4k99dJNCrYiv1HOXsCPyRC
	 XQuoyUvnggDKB+vZbzBCd7rollpuBQn1eBd5dM4NUU0hxs2kuwlbXpJV0IWGdLJch
	 vxvGamg0D10l026yhg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([84.170.92.4]) by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N4R0a-1rsoRr2QZK-012EXG; Fri, 27
 Sep 2024 14:24:01 +0200
Date: Fri, 27 Sep 2024 14:24:01 +0200
From: Christian Heusel <christian@heusel.eu>
To: regressions@lists.linux.dev
Cc: stable@vger.kernel.org
Subject: How do we track regressions affecting multiple (stable) trees?
Message-ID: <2e6fc26a-26f8-4fb0-af5b-261e3eda6416@heusel.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4g67fpjasknl5cxz"
Content-Disposition: inline
X-Provags-ID: V03:K1:AEhuDUQkx1n7idHbutt3g6tQwayslwWRFlLxsJFOmKM5KdPD/Oz
 /sB79KOnCo36KoC4x3LXTzStt499JS5TZ9oz+jlW+VzOoflFMxwd4+xLUvLjRnoUkt5Y7mv
 jn+/NDTgveZIvO0Gn/tFq5jMVhYP4QATrzAg0u5NvQEwCtuHTEwppoCfWJUGVDGPIL0L+fP
 YFtMi/8PcJfEavZNfVMig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:17reSYlFIyE=;HUy+lyZMeCclffuEOe1r3y9iHSP
 FnQbQMs6PXyCtOZc/qps/xkdIAXKBqxOa7gJfdxJKtDl3YmQgkmt3/LUXpvQcJks1hv1m22vl
 fqSIu/kRQQQvnLlE8Z+HjZIgv7WO7FZ7oxzDYz0E3I+jzTiq43rsJ9dCovBS8rYsAgEJM1mf2
 +1OH7c4+cT8snX3AGnsZokP39YVLyOiyW92eLCOFRDkrxiKzvWNtcYalb7fYFQqF9PuDFcA4Q
 7LM8/Mk3uuX6WMRejiPqL82gwdPXhHMJ9/8OhqeKjRehIcQRvX5iR4jtqSLOEIVG1xz4mFiKI
 aBsxvQ/ilNDGziqhQjW34FFN4uD0B4Fzx/w0nxEPr15EjB5xgY3rY91IS5zqi/zvDqU+5PLT8
 snTG/IgdpN48geuDvDLJpZb2vilSghiVU5LhrNvzO+aWxAx8ilbOk7VuaXlxOtcaekYGmfDzT
 Ej+KyDSMqpie92Rx1SSInY8IeU3jYAJrYNOhkyY1GAyKQlAJVq3Dt58K5T1GhVu0LzGo0qDht
 HR/IKldkD4hs6Ez857WFQLlOn/HPOHIKNJZf/Jq7JWeWbAjRnoCuvuTUzl2Z2W0oSc5LD4yM3
 ySU9NgkXP3n/kv6BROsYr/spC3LqUKkUj+Ak5Ewgwu+FDUAvPu0KZ/kyKzj+rk5QH+InBYvIA
 JM+dyeOWccpwrLV+Qo13QNJb9OyBd2o1Mh8M/0jOZVS4ZjzxPdTgwOrczpQskSbPO6jXRSMtU
 OJSlDwasx2I1jbJSbNM1ocxNu400EyhnQ==


--4g67fpjasknl5cxz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello everyone,

I wondered a few times in the last months how we could properly track
regressions for the stable series, as I'm always a bit unsure how proper
use of regzbot would look for these cases.

For issues that affect mainline usually just the commit itself is
specified with the relevant "#regzbot introduced: ..." invocation, but
how would one do this if the stable trees are also affected? Do we need
to specify "#regzbot introduced" for each backported version of the
upstream commit?!

IMO this is especially interesting because sometimes getting a patchset
to fix the older trees can take quite some time since possibly backport
dependencies have to be found or even custom patches need to be written,
as it i.e. was the case [here][0]. This led to fixes for the linux-6.1.y
branch landing a bit later which would be good to track with regzbot so
it does not fall through the cracks.

Maybe there already is a regzbot facility to do this that I have just
missed, but I thought if there is people on the lists will know :)

Cheers,
Chris

P.S.: I hope everybody had a great time at the conferences! I hope to
also make it next year ..

[0]: https://lore.kernel.org/all/66bcb6f68172f_adbf529471@willemb.c.googlers.com.notmuch/

--4g67fpjasknl5cxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmb2o+AACgkQwEfU8yi1
JYXmgRAAqEj1D/g9vr3Yuk48vIZn4vl6JtnVms++hJVW7GwrGy9/6NSMaijsQYkQ
lhgQHMh86WXp4htxb19QvZuQTc5Gmy3cmEhxV5ynJQF/SRgiq4jxJkv5XjMFi6re
l93GNvX2Z1pmX2Rp2HScDYP7heZ25TeOH9sONowT0uAjNVas2EmdbehopQUt/n+C
0vfRbvT1qwmDXz1pikT15JWANJLNB0uT051cAI6mKsUhtNVu3TEzqm1VJ1xS5zaX
IaAtA09kKSZI5X/QI6o0qlnxVdafrqJP439z2fdmS7FRu2vsl/84yRe6sa7q+/LO
AEVw6Rd425DOB/fELxY98mGdD3w7tacoLz3qBAFGlOB7zTfE3JV9kWPaHklCRJ1C
kDgm2lXW+e6lWlBGxEmU0LbES/HUaxDjfbqsna+j87wrRaHRB/euys8ZKilU1riO
AgH6c378OCQaboyx6j1qGP1DHmdUGl9adCIvD0siUfIseOycagL1Rho1fa23TwAj
lcPgfiV3Vd/wSTbikBZLJeQSDQxYpWCgBe/aZ/kLCUz2cyrdE9GKWVA40EhmLHn4
Qdq6t1YUkjeQpiJf1fuTIRxOFjTNvHLtIy9mTt5mTmjMzzPkSECVdKDWIaThjLAv
Gewq0TOpESTQSfbIch0rypQCax+hucGzzScM+/WWkSBtP02cNKM=
=WpeS
-----END PGP SIGNATURE-----

--4g67fpjasknl5cxz--

