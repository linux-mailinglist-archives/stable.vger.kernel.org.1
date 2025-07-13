Return-Path: <stable+bounces-161786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F546B0320A
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 18:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072B43BE91B
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 16:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB50D27978B;
	Sun, 13 Jul 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cuxL2Iyc"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AAF53BE
	for <stable@vger.kernel.org>; Sun, 13 Jul 2025 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752423058; cv=none; b=lPQQwBDqi8p3A2puTMyGfonLh5xTXwBgyjR/Kaqca1N6sC6Iuq4ODZZktflYNOjEfORi4KSN0hJA2YU5ykEZ+O2FcZX3dAlyxrItNX285+EgVNqI8BtWxocs4XejGDLVFZk0j9qCnBZRUqU7twplJboyhNTsu6FExa46BFxOutY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752423058; c=relaxed/simple;
	bh=gzAL/EueJ0C8lly+6l5vUD51zodpiimwjNuUTAmhF/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iv5ry+VClX0/wnMSzCTIG/qfdl8SAXUiyM2if7fJGKUwlq729H7c6w8UPsNfluyJqHCqmrKKfVpmFSChWKxGkbHXuDMnVX64lgMqUMTt08MoqUc/5NdEjDi52D2334BlP7j5MHoYpLiVnnimCY/z1/Nb49xbMHVX5lop9jKjeZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cuxL2Iyc reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B3AF640E019D;
	Sun, 13 Jul 2025 16:10:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zR9hEDrrV1iJ; Sun, 13 Jul 2025 16:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752423041; bh=eEV6al1b4tlwbBWLC0lZ2kXqFkVfmKjct/ARV+PmJ7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cuxL2IycmBxO0hUCh9CtEid3rlOd4lGDheEcLgFbY0rFYe4xfUHUWWh75EHLxCLv+
	 8Y/aOXt/n9pYyXD/IQHrurh59643aP5o+gMjg1y+AuwW6y2TRLWMZs1aj62nNoGSYO
	 7uM8BzhyRroznlDVVqKeX/ybStIEhgWkKCmjM3foLT8HDSN+waIfiCpOJmMGmOFHhx
	 +kIwvwWzjqKiHqbLuPPYK6qNOlGGYSNS5N/oUP5BUg9tzDyvXN6GF/7Rfx7cisxFXR
	 Sq0zjZsafWxh+2Z/AnubIYTnZTxfh6V3MpaZoxrDbPC7PYLF6KfIPbrigKEN0P6p7H
	 DdhgfpEfnSO/Oai9kZKnVYmwGmGaxrcpsGa1bbgw3dKle2cGybESifgwXfREWnqsOH
	 hHLgwECtgogJYvitMHGsa4AprLsB3iQXiCV3jFClgpIXplzakpS57SELWk8TR9OYfy
	 ioOKQtspI7HZsqN5WDu/Xqjt0ZLe5Ngvr5CEhFg5c/3tFf0fAvhvjinjEVB/pIrQoy
	 wLr7BNBKKuCyx7UEZKTiAOdrRbwdTWj4UZ8VCJpU3DMZ4tIwA+RgcOo5Pkwv1cdS0p
	 Wh/Ky3RpmAPVmmBu+gUfc9O3DdBC0xx7nv64FPvBXZKd3d5WfOmu76MM7L6BwPWR8S
	 YZZpQ66tiX65joOYaXK8VUMo=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F3E6B40E0163;
	Sun, 13 Jul 2025 16:10:38 +0000 (UTC)
Date: Sun, 13 Jul 2025 18:10:32 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15-stable] x86/CPU/AMD: Properly check the TSA microcode
Message-ID: <20250713161032.GCaHPaeCpf5Y0_WBiq@fat_crate.local>
References: <20250711194558.GLaHFp9kw1s5dSmBUa@fat_crate.local>
 <20250712211157-88bc729ab524b77b@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250712211157-88bc729ab524b77b@stable.kernel.org>
Content-Transfer-Encoding: quoted-printable

Dear Sasha's backport helper bot,

On Sun, Jul 13, 2025 at 09:06:05AM -0400, Sasha Levin wrote:
> [ Sasha's backport helYper bot ]
>=20
> Hi,
>=20
> Summary of potential issues:
> =E2=9A=A0=EF=B8=8F Could not find matching upstream commit
>=20
> No upstream commit was identified. Using temporary commit for testing.

I think you need to be trained more to actually read commit messages too.
Because there it is explained why.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

