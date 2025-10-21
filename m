Return-Path: <stable+bounces-188347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D55CBBF6D91
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 15:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5F51884B64
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 13:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DCD337BBB;
	Tue, 21 Oct 2025 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="dS3lVEZs"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEF4337B8B;
	Tue, 21 Oct 2025 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054198; cv=none; b=rz4IgZpHH/h9sfEgwNoCWKFr9zfoneIh4r1QI2h77lVqYBELH1sz8/CCw3hFXMaRKjyULh/Un0T7ZzrJOt4jxpsqCPPX10UvUMjZrc6ES3iWdf7Gfal/GtGseq71o/MYibJbxx+yd7kq8ZmW1aC5lPMZ+AdjA08cVrYnW3WSrEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054198; c=relaxed/simple;
	bh=mpK3ezibKvY3uzcEgGUUBcfPTtWhfi+hnGBxUGRKVmM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KpUKYriuYCansuYFpdY4BlYjWQkYnIWlrA4gZt7ESlVRxTHSPDDhdfHIQSV2WV2EndLKo5qXTlP0lMUi0f/7xNFXmT2WoPih1CJWFHEoGbsGZJV3MW9N9sAQE7g0FJSV11Y61XEzYMRTAts1Ua8vNQ9x5XJn8KOfl1ytfyEyjBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=dS3lVEZs; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1761054196;
	bh=dCc1qsdBRy7SYcIPxmtuXQYymu4dwxpRn9e2HfEw5dk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dS3lVEZsijFlGGULptjm2C7FCaKmsq5fE2NTCbqXMreN1Eo64BhDJsmYjDMWFQ6g9
	 ahyIQM72GYKnmbtHzSNDU3BRpo+lR+On4xb5x9zVqvKIbNMwGUVABmu17cCI//aHos
	 e+datmJZWk7TPOzu0Ebt6vfjD2exqnCUe/Q/IScg=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 9D96F66EF0;
	Tue, 21 Oct 2025 09:43:12 -0400 (EDT)
Message-ID: <c29fcf14b87c0c0bfa1ba304c89fe8c410aac03b.camel@xry111.site>
Subject: Re: [PATCH] acpica: Work around bogus -Wstringop-overread warning
 since GCC 11
From: Xi Ruoyao <xry111@xry111.site>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, 
	loongarch@lists.linux.dev, Mingcong Bai <jeffbai@aosc.io>, Guenter Roeck	
 <linux@roeck-us.net>, stable@vger.kernel.org, Saket Dumbre	
 <saket.dumbre@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown	
 <lenb@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, "open list:ACPI
 COMPONENT ARCHITECTURE (ACPICA)"	 <linux-acpi@vger.kernel.org>, "open
 list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <acpica-devel@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
Date: Tue, 21 Oct 2025 21:43:10 +0800
In-Reply-To: <CAJZ5v0iy8wChaPYGmc=mWJRrA+uXnGF2Ar7aMCMRoUqS6877aQ@mail.gmail.com>
References: <20251021092825.822007-1-xry111@xry111.site>
	 <CAJZ5v0iy8wChaPYGmc=mWJRrA+uXnGF2Ar7aMCMRoUqS6877aQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 15:35 +0200, Rafael J. Wysocki wrote:
> On Tue, Oct 21, 2025 at 11:28=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> w=
rote:
> >=20
> > When ACPI_MISALIGNMENT_NOT_SUPPORTED, GCC can produce a bogus
> > -Wstringop-overread warning, see https://gcc.gnu.org/PR122073.
> >=20
> > To me it's very clear that we have a compiler bug here, thus just
> > disable the warning.
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: a9d13433fe17 ("LoongArch: Align ACPI structures if ARCH_STRICT_A=
LIGN enabled")
> > Link: https://lore.kernel.org/all/899f2dec-e8b9-44f4-ab8d-001e160a2aed@=
roeck-us.net/
> > Link: https://github.com/acpica/acpica/commit/abf5b573

/* snip */

> Please submit ACPICA changes to the upstream ACPICA project on GitHub
> as pull requests (PRs).=C2=A0 After a given PR has been merged upstream, =
a
> corresponding Linux patch can be submitted with a Link: tag pointing
> to the upstream commit, but note that upstream ACPICA material is
> automatically transferred to Linux, so it should not be necessary to
> do so unless timing is important.

The Link: tag is above.  The issue here is this bug is preventing
automatic test of arch/loongarch (see another Link: tag).
>=20

--=20
Xi Ruoyao <xry111@xry111.site>

