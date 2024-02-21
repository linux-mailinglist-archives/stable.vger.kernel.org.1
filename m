Return-Path: <stable+bounces-23199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3048285E264
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 17:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D991C2087C
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 16:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D065069D05;
	Wed, 21 Feb 2024 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="b6lkggqY"
X-Original-To: stable@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932FA823CA
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531228; cv=none; b=n7hbiwTy9BltSybGXywpusdt8AkkL+H6lJImbAmZ143GOv4vV4c+r4Tfhakm46TSNwloPnnZFRyhwWUBCXyJ/6ur7yDCNeLWc5VEGkycBikMeTgyjHzI/3htpo9u3SIXC+7l/T2/OWtivvV7oloAPPqBAJVnc5niSMMLAJ9g0rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531228; c=relaxed/simple;
	bh=iLzZEaIIb7nONvllSFxKllpjccVdh747caWYiWadJbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IdggADtDSkcmhKqwYbxgSjERTip8bOfLd8B/cmI0w06JPFgkfb4/7o5w/nA9FqicHUeS5oIxshqcBDiIqcjKLVISULfKtj4UzCkcWbA+GbGjuiS1G8INKwPSsaN6ZkMHDA0uMOAjQo30g7347Dl+UE2ICJsH3RzTyPocba0aPVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=b6lkggqY; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id C51F3635B057;
	Wed, 21 Feb 2024 17:00:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1708531217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVzKHavSue5Bj2ZdCpOec98aN+NumZEMWDQ9JF3grao=;
	b=b6lkggqYHYJlCyq8KleBXA7NMqeg713sBfyHqtUPrs6t9CysXI+UAPqaGVOzA7LFX6lqab
	F0M7jPIOGZqXiEMzmcmZtt1DloHaB4+AVyQP9g/80EcNjsQS8u+ECLpHuUds26pgqW+fLN
	2a5Lf/9H6LtmPjl/5M0EQnuPED83TsU=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Greg KH <gregkh@linuxfoundation.org>, Jiri Benc <jbenc@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 Vlastimil Babka <vbabka@suse.cz>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: fs/bcachefs/
Date: Wed, 21 Feb 2024 17:00:05 +0100
Message-ID: <4900587.31r3eYUQgx@natalenko.name>
In-Reply-To: <2024022103-municipal-filter-fb3f@gregkh>
References:
 <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <uknxc26o6td7g6rawxffvsez46djmvcy2532kza2zyjuj33k7p@4jdywourgtqg>
 <2024022103-municipal-filter-fb3f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4549049.LvFx2qVVIh";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4549049.LvFx2qVVIh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: fs/bcachefs/
Date: Wed, 21 Feb 2024 17:00:05 +0100
Message-ID: <4900587.31r3eYUQgx@natalenko.name>
In-Reply-To: <2024022103-municipal-filter-fb3f@gregkh>
MIME-Version: 1.0

On st=C5=99eda 21. =C3=BAnora 2024 15:53:11 CET Greg KH wrote:
> 	Given the huge patch volume that the stable tree manages (30-40 changes
> 	accepted a day, 7 days a week), any one kernel subsystem that wishes to
> 	do something different only slows down everyone else.

Lower down the volume then? Raise the bar for what gets backported? Stable =
kernel releases got unnecessarily big [1] (Ji=C5=99=C3=AD is in Cc). Those =
40 changes a day cannot get a proper review. Each stable release tries to m=
imic -rc except -rc is in consistent state while "stable" is just a bunch o=
f changes picked here and there.

[1] https://lwn.net/Articles/962131/

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart4549049.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmXWHgUACgkQil/iNcg8
M0uZCw//cCAX88t/OScNWPKYTjvmadYkYSbgIwoY/hoNTCuVSfpHLfBpx2530JIl
Q+cF6gqHbkrtbfR5hOAIvRmFsEcvgU7csrhelQga6NvJeb8K2qXGu6pMgKgIknhj
4LNUi80cRgKqfMlC71d8ZDAdZw+aOCR02NEsf5ltUGrhyQMPDEJfCl+p/vKYSieP
8zQv1r9HZkSeRyeRoAINimhkgs4dSjIUD/qHCm5aEQzoabp/UGEpLlKdjjIGiEXE
qPbz68xw1VzpwmO9Thx5EcKm8+uWqNdkqeZdIU/j7OpygP1NFJDiePyvKslaku7/
oNElzybM72IYrbwLIj06UjvVqN2dTgHtFo2Axsemlr5uAeKz9rj6/TSqwDi5sXKV
6R32Vz2yqx0ZrXUd3+aWFx8bveCVnCeEOTmes7+v8pX5lSzWxUuRyMEfvP6kp+oM
OO0jbPD30IhLNorH8g8gE3VTaS5FY9XaxDPBJxl3KFchG/xgNgpLMjj/sI6PSrEp
mL/1JZ+ncW1iliOsPTl/MWwVk3afK9YCzjS4ObUX7QDX9X82VjgyG1nnEV08Y+wW
fnFlupR9lQBlFUwwILcPWsgz72fyJCQfVouZwoeGf8bVqQEb66IWuSjINwxImzRJ
CEyjlKT1vAGsOsmqvdkFc99zIwdleyepi8Js44zV1svN7tc/ML0=
=Gt4j
-----END PGP SIGNATURE-----

--nextPart4549049.LvFx2qVVIh--




