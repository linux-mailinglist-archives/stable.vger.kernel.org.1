Return-Path: <stable+bounces-121548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D4FA57BF3
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 17:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC943B0198
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 16:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192881C84C1;
	Sat,  8 Mar 2025 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HBwrCnu8"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F5F7E0E4;
	Sat,  8 Mar 2025 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741451427; cv=none; b=qgdL5B//GXjneYJPiTsYCF9GgyHK9wLDOqUHQ5zzs2iHLOXOn5EpS8e1unh5LZF3SEXSeKTivbBiQTrzxz7ZFxHiLUsb1H92NZOYM75IA2jq3UIhjeYi3g4R7gm0AvYkvIxVyJ7Xks75UWV6NJFJvzvasw1lEBQGN7BkNFOTX4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741451427; c=relaxed/simple;
	bh=aTYcRp57bT1OYG9nxqDyJy9XQ3/Br3Dm895WpJh602Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3oivje402J+/X1w1Rq0SpH8OKIySlie76m/sgqL2NfDdVfqyMuS+aAOdsKVMVtXv/rXQk1Tx+ZWu16r22PFa1ChtzKz7AyElN+lsjXrWC3cJ/aTrh711hlzVx2ksu0CoJN3lnIjfaTeIs6kUhCRHwVD3aVgrm8J6qThB8F+HLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HBwrCnu8 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D927940E016E;
	Sat,  8 Mar 2025 16:30:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YmxSReM9hOEA; Sat,  8 Mar 2025 16:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741451418; bh=UI/rGNRBIENnzde8FpGvTKytRqVdRwI04dKrP3cm2Ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBwrCnu8gEu3ySxfgChbEaSzMfiBfkgdTWSyuiLjJxePtnQ3RzsHGAE1xcPZg6038
	 e6hGr8J3QbXfIa23rIrH3hKUfWBuROEzSdwk7GzvCqi+cYVYjSu0Fp8QAA6KthOLVw
	 57692u+amc5KGWcuHJQlGnNxlTjzd7Sj2UWduC0f/09NAqDlUykaBbryi9lx7B94WC
	 ZJnMAWrX1PiA4iH/lu96+astl91T1Ijr0PEzIiuWWuFVpnlX22/FM4iYwiTSn6A0YE
	 MqulJHFqjkBMz+FR+EXm4svCQDyPvN/JuWC4uMmA037ug9A5jOb8NlFs7pmXHICBd+
	 JoPORfUfltZFgp1Vo71H7MOyaSecQ/77ngb4lfA5D9Zo2oWRIOdmqWTd1WpDBS/fPa
	 Yqmc7RN4DdSQ3t07S3QJgQjVOR37pFS6HW1T0zWHmVKKdCw0OwqY+WVZa3VrmV2cr2
	 ot+aMIJoXdKV8IJGrsuXcho65Ju/QuX5Cqt7CsJpqT7NDtf0GjjiwJF3kSDCYKfJRy
	 DCjeIPBMHbX0vfrO6VA6BNg+l9vNg7sLTqj5arf3PZ3T2Q1YxBFQvzw7BMYMECc2vk
	 5GajemWMsW1i6WR51t5SWoC2ygpDdFuJmn/yHRRwZdL1QQaeCKA69vnIXphyz4iYBc
	 WnmvHCVucsUCtf3aHu0m81Ic=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6C5CC40E01D1;
	Sat,  8 Mar 2025 16:30:09 +0000 (UTC)
Date: Sat, 8 Mar 2025 17:30:03 +0100
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?Q?J=C3=B6rg-Volker?= Peetz <jvpeetz@web.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org,
	x86@kernel.org, lwn@lwn.net, jslaby@suse.cz
Subject: Re: Linux 6.13.6
Message-ID: <20250308163003.GDZ8xwi0u3rAAX0J23@fat_crate.local>
References: <2025030751-mongrel-unplug-83d8@gregkh>
 <1b3ea3ce-7754-494c-a87b-0b70b2d25f99@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b3ea3ce-7754-494c-a87b-0b70b2d25f99@web.de>
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 08, 2025 at 05:03:08PM +0100, J=C3=B6rg-Volker Peetz wrote:
> [    0.000000] microcode: You should not be seeing this. Please send th=
e
> following couple of lines to x86-<at>-kernel.org
> [    0.000000] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa=
500011

This should fix it:

https://lore.kernel.org/r/20250307220256.11816-1-bp@kernel.org

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

