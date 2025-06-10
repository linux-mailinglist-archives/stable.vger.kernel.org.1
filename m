Return-Path: <stable+bounces-152278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1246CAD350C
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 13:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86763A927F
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 11:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D9A28003E;
	Tue, 10 Jun 2025 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7p+nAJM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB25B228CBC;
	Tue, 10 Jun 2025 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749555303; cv=none; b=TwDkRu3V2QtSa/Qjy4viBAQ3a7GifhF3wkN/naQlvYA5mdVriOw9BBvAl8plPhjr3fhbAw0mAHtW0vEcMX3ycv7q2Kla4JAdKl8O46OJWpKIzWfBn8R75lNMPoyH5Bb+/MBi1kVTcjLbYE02c8PJKUxf9+iMhRoU/EJinmYP0yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749555303; c=relaxed/simple;
	bh=OJQVmEGY1rUIwtRekYmXlQLuMdBPixlfvKReSm97tNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3A18RSzA4bMSfFay7ijsYkbVSDMpmin0UmCBw+iQl6EMzBS7dMuY4VHulOe+Nuk1MN/kpOCr8Gq4csSoWSS3mroRwWKdMWUBmlNYJRBboRaOp7CrV0/tNxJA03TZaXOHPoUJZRkxrbljcxxTuxH5MdIIpdNKY4PVNb++0vuUe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7p+nAJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9DEC4CEED;
	Tue, 10 Jun 2025 11:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749555303;
	bh=OJQVmEGY1rUIwtRekYmXlQLuMdBPixlfvKReSm97tNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7p+nAJMuAyWQ+vgj+xFAOYXPkTgskrO8PJvZsUvwl3HbdCmvTW/y0KUXY5NaY+3A
	 jSzseug+9TgQQKTIOP6BFkJjGzVaavPeCqSZLAUYvIT2m8ujtQTVOK/47vQiHcxYTM
	 cHMGfF6bhh2JT2PKFn2nCarLnW8xf7y4iSHIPbhE3T2y+HNULKYTD4fhGo9Zum5tLI
	 CLn5cy56SNJZkF/5574edaVgvFlHjKGgf8uUbF9gU76BPOoxkCOzNKhZF4EUhmSJgx
	 MSveZZJ0Soo2NHuG5CPGDuFe3pS+q5j02S1dPAoU8kJuSbV+va/KQDFiUbjG5Ou1SC
	 FZKnA9RTIFxvA==
Date: Tue, 10 Jun 2025 12:34:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Aishwarya <aishwarya.tcv@arm.com>, pulehui@huaweicloud.com,
	Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, mhiramat@kernel.org, oleg@redhat.com,
	peterz@infradead.org, pulehui@huawei.com, stable@vger.kernel.org,
	vbabka@suse.cz, Ryan.Roberts@arm.com, Dev.Jain@arm.com
Subject: Re: [PATCH v1 4/4] selftests/mm: Add test about uprobe pte be orphan
 during vma merge
Message-ID: <97432af8-da8f-4cc6-96f0-ccc8297b7029@sirena.org.uk>
References: <20250529155650.4017699-5-pulehui@huaweicloud.com>
 <20250610103729.72440-1-aishwarya.tcv@arm.com>
 <f5tx6ko7xu2ulvfwu6srlaly6omqcciez2qh6jmcd6fob3szgm@cedwkuqgw34b>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MlSDyrIEmwV2AHR7"
Content-Disposition: inline
In-Reply-To: <f5tx6ko7xu2ulvfwu6srlaly6omqcciez2qh6jmcd6fob3szgm@cedwkuqgw34b>
X-Cookie: When in doubt, follow your heart.


--MlSDyrIEmwV2AHR7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 10, 2025 at 12:27:28PM +0100, Pedro Falcato wrote:
> On Tue, Jun 10, 2025 at 11:37:29AM +0100, Aishwarya wrote:

> >   7155 12:46:54.650730  # # # handle_uprobe_upon_merged_vma: Test terminated by assertion
> >   7156 12:46:54.661750  # # #          FAIL  merge.handle_uprobe_upon_merged_vma
> >   7157 12:46:54.662030  # # not ok 8 merge.handle_uprobe_upon_merged_vma

> So, basically we're not finding the uprobe (I guess CONFIG_UPROBES isn't set in
> defconfig, and it's not in the mm/config either), and the test just fails instead
> of skipping.

Indeed:

$ grep UPROBES arch/arm64/configs/defconfig tools/testing/selftests/mm/config
$

--MlSDyrIEmwV2AHR7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhIGGAACgkQJNaLcl1U
h9DaWQf/cadm9TfJCaMBT7EYyvuri1Y7Cy2mQyfq3YY+k94ln1LlNvpGOae6rCqS
3P8O/v4hvf0JiEMFvOGDGDMWN0NGxlkh179vIGKmIFZ4lstx3pcwYC+w+yBCTxMM
cRojo86TKk1c3aWJjjP2YEjluxxODJjHcMrindp17cNGE0kN+yE4ToHYSObn1Bif
ZHVmvdQMw6t1vcn1H+BWFqAZERaUwvHbWEHy4AK2wy/jaE87AfLelWEgUH3T4Xev
Wy3HjrRrXkovehuRgtwNUfbXzcHsuiYyU82M3Xz9vhvtUdmPGuD1S8ucNVsXL5Pb
GYUS2FxpTZDnr953FYOUnLV0EwQ3Iw==
=7Aco
-----END PGP SIGNATURE-----

--MlSDyrIEmwV2AHR7--

