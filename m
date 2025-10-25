Return-Path: <stable+bounces-189275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D6AC0909C
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 15:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1997E1A67BC0
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 13:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710591E0E08;
	Sat, 25 Oct 2025 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="X7yKepI2"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8760316DC28;
	Sat, 25 Oct 2025 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761397381; cv=none; b=T6hX2pPsQrhXzpBhng2IQpFQfbkjHrCndHfl2YbYv2LuK8hWQHO6Hg5I1a+jP5yuH3GuEnBRTV29nJ22UnKJ4P5Idz6ftDYfXmer3xYGqjA65TAffq8z9VPCfC4rgCnTJoC7X/3rMXsszAd6XPa2owORCC+MaE482m3ZZxndBUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761397381; c=relaxed/simple;
	bh=ZgL11gmghu1u0zJJAQ8GJBKY01T3xvC5t4LkY4lQKMk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M02OpF8Td3ilBazYw42HudyMSNb6mcpujPtn9jz8Dp++c6EZRZPpnf9ZZXM17yJVz6aRRA2BVDgwW26QajMXG+m6F0mIdlZoH/9zDmhu5ruQIijqEBVYRTniRyfZ5Q6FXBv3DNa9yOVtLu+8D/espfbNC8GNUYJvzX0OxzVwoJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=X7yKepI2; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1761397372;
	bh=wa5kbvI1NcBJ15BDxTohZ2py5hqHQxhiLr45hAYayx8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=X7yKepI2uUSP2mSweLEeU73GKzletV1pu6JUimUejLupHE7CG8cVM/lNIzowCLdF5
	 Vb6Z1bktsORX6Uk47PohxEDM1gZADP0R0NG+g5CBYkGtKAmGuiXeF+ZpN7qSkmWpEX
	 4zO7DXKtRLkqF4NZY3+DXKSI0Vko3ara6Wve5KzY=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 621E466C0E;
	Sat, 25 Oct 2025 09:02:48 -0400 (EDT)
Message-ID: <274fe4e6ff05401bc43d952efe69908fe052d875.camel@xry111.site>
Subject: Re: [PATCH V2] LoongArch: Align ACPI structures if
 ARCH_STRICT_ALIGN enabled
From: Xi Ruoyao <xry111@xry111.site>
To: Guenter Roeck <linux@roeck-us.net>, Huacai Chen <chenhuacai@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Huacai Chen
 <chenhuacai@loongson.cn>, 	loongarch@lists.linux.dev, Xuefeng Li
 <lixuefeng@loongson.cn>, Guo Ren	 <guoren@kernel.org>, Xuerui Wang
 <kernel@xen0n.name>, Jiaxun Yang	 <jiaxun.yang@flygoat.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,  Binbin Zhou
 <zhoubinbin@loongson.cn>
Date: Sat, 25 Oct 2025 21:02:45 +0800
In-Reply-To: <0104bccd-d3a2-4f6b-8838-0acf0563c4b6@roeck-us.net>
References: <20250910091033.725716-1-chenhuacai@loongson.cn>
	 <20250920234836.GA3857420@ax162>
	 <CAAhV-H5S8VKKBkNyrWfeuCVv8jS6tNED6YNeAD=i-+wkaoRSDQ@mail.gmail.com>
	 <899f2dec-e8b9-44f4-ab8d-001e160a2aed@roeck-us.net>
	 <c1f9e36dbdff64298ed2c6418247fb37dcd1f986.camel@xry111.site>
	 <0104bccd-d3a2-4f6b-8838-0acf0563c4b6@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-26 at 11:27 -0700, Guenter Roeck wrote:
> > > I see that the patch made it into the upstream kernel, now breaking b=
oth
> > > mainline and 6.16.y test builds of loongarch64:allmodconfig with gcc.
> > >=20
> > > Since this is apparently intentional, I'll stop build testing
> > > loongarch64:allmodconfig. So far it looks like my qemu tests
> > > are not affected, so I'll continue testing those for the time being.
> >=20
> > See=C2=A0https://gcc.gnu.org/PR122073=C2=A0and
> > https://github.com/acpica/acpica/pull/1050.
> >=20
>=20
> I understand that. Every compiler has bugs. Normally workarounds are impl=
emented.
> Since that won't happen here, my remedy is to stop testing the affected
> configuration(s). I do this whenever I learn that a known problem won't b=
e fixed.
> The above is not a complaint, just an information.

Hi Guenter,

The mainline should be already fixed with 6e3a4754717a ("ACPICA: Work
around bogus -Wstringop-overread warning since GCC 11") now.  The commit
is Cc'ed to stable so we can expect 6.16.y will be fixed soon as well.

--=20
Xi Ruoyao <xry111@xry111.site>

