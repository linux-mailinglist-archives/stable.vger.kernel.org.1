Return-Path: <stable+bounces-163154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBF3B0783D
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 16:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6917A3A37B7
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 14:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34199253359;
	Wed, 16 Jul 2025 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b="KCiLvom6"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E38A21B9DE
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676576; cv=pass; b=qF73k1EtnsNDMYixBXpGSmn//hBdyrS4PQENpEdJOMShTpjtiNHwXXP6g9Q0F7EyG3NPfGE0O/dBmSkaZH4U9TyaG4KKqN3PIyNgyLzUFk596tOrRwK23qZzmISQXypmC6O4F/q0xranHCCsXmH/4mls/OeKQ7dR4qFMLZbl0Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676576; c=relaxed/simple;
	bh=ODHL7ADV8mUyW3tmT7td/7ghxtPkZ47PmrQcii5eRB4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nMhivgM/Iwkwt/df0igvexD02P5CNGjBDclGBdx9sCrQsQ5fpIt8eZSEVJj6BN1hKgZxKOltOoNwn0+GDLDu1A51bVURlK3tw6rnfghVi+i2DsOD2C62PGNpZjlDjca3xygCfyz66eoua/oCOb+VbiQxQ9g2Tm17uzz/X+eI+wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b=KCiLvom6; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752676567; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QWk4GZ3BsNG+IoMYjF1v3dFGUpnT9vH7mpH0Dvr/n1qWaz7CsidJgM2zbBrpVkT9Cg8wKQo+AC2co9n68LC6Se4l2KwLsnYk0mIfYM5/EFeeZ5j2Jjyuf3P+ZQSVwDzn6Crr/wsKa7utYS0DMwyeJ+HQSY/yfjNhg/m4uegYsEU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752676567; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ODHL7ADV8mUyW3tmT7td/7ghxtPkZ47PmrQcii5eRB4=; 
	b=a4M8QPDcW12DLFEodfOOHxGAtOosATW6+AHMkKg/Uist1jQVjDr+MX8xEc05t/0vxtGcTepXCACATV0ZG+rJ9CfFI8hINypJh33ZZORdrdCphHurgvvQ0Zc6/l6+Scw5aP4KPbIyWYsktjc99lykR17mLxXpdQWjWLzM2y/9zeM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=gus@collabora.com;
	dmarc=pass header.from=<gus@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752676567;
	s=zohomail; d=collabora.com; i=gus@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=ODHL7ADV8mUyW3tmT7td/7ghxtPkZ47PmrQcii5eRB4=;
	b=KCiLvom6QYZ3uCuIlGMhwZfFvAjUEJfsu833IEPXryVpBGulx+BHmOr6bz5friaQ
	xd8rHUz+dFu3iDusmKVYbnXz7Gg8ahK+M8Ulk+Odyx7xZgtK/+s5lC0YAxSoFoteIyc
	ZVM0Rj9F+k24ENv7asa7oN/NrDvuStX6uzqEO7F8=
Received: by mx.zohomail.com with SMTPS id 1752676566201838.0538823370508;
	Wed, 16 Jul 2025 07:36:06 -0700 (PDT)
Message-ID: <9899229dc635f4912615525b80642b82a14e1741.camel@collabora.com>
Subject: Re: [TEST REGRESSION] stable-rc/linux-6.12.y:
 kselftest.seccomp.seccomp_seccomp_benchmark_per-filter_last_2_diff_per-filter_filters_4
 on bcm2837-rpi-3-b-plus
From: Gustavo Padovan <gus@collabora.com>
To: Mark Brown <broonie@kernel.org>, kernelci-results@groups.io, 
	bot@kernelci.org
Cc: stable@vger.kernel.org
Date: Wed, 16 Jul 2025 11:36:02 -0300
In-Reply-To: <bb9ea244-8d9f-4243-97cd-9506546a162f@sirena.org.uk>
References: <175266998670.2811448.3696380835897675982@poutine>
	 <bb9ea244-8d9f-4243-97cd-9506546a162f@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Wed, 2025-07-16 at 13:58 +0100, Mark Brown wrote:
> On Wed, Jul 16, 2025 at 12:46:28PM -0000, KernelCI bot wrote:
>=20
> > kselftest.seccomp.seccomp_seccomp_benchmark_per-
> > filter_last_2_diff_per-filter_filters_4 running on bcm2837-rpi-3-b-
> > plus
>=20
> FWIW the seccomp benchmarks are very unstable on a fairly wide range
> of
> hardware.=C2=A0 We probably need some filtering on the tests that get
> reported.

Indeed. However, for the previous 17 executions it passed 12 with 5
infra issues unrelated to the test. That's is why we sent this report.

But to your point, we really need clear understanding of patterns to
flag something as regression vs it being an unstable test.

Best,

- Gus



