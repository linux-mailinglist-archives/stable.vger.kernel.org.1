Return-Path: <stable+bounces-203043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23453CCE68C
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 05:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2296302AE16
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 03:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00ED21ABBB;
	Fri, 19 Dec 2025 03:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PNs3f/EK"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F313D405F7;
	Fri, 19 Dec 2025 03:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766116651; cv=none; b=V2HmYaJVkj0Ylm6Vn2BYqLOOUyt0MvwEfSwBw9nZf2b5bbWkp8ZX6qy9SJK+lzhKcEeov8/6m1YcB1vyJUVc7PPK2Kthh98UThoEirD9I3r+e2D01V+Gc390wkXWEM4c5P9HzsWu2jQkUMW5tJjKMge3Bv/Y4mv5pPFwylGNMpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766116651; c=relaxed/simple;
	bh=xXt1NvgL4gL9GY7u1OgJrWSf0VPYNNMl7jaUNc35aEg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RMdWORFUqldmouhkqh69i27tlAhVBl8LZ+bFphNQHYeG5oEzu5vRbZaFrumWlI6COed6yYGfa9huMOvtxG2L+7GoIntvoiAHEdtnTU8yfz+jjAzgzTBtwil7h70C9GwpTMmw7vhx7F7H3GgcnX5e7ByQ1CBaMUUjP8zv2295AxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PNs3f/EK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 35C5540E00DA;
	Fri, 19 Dec 2025 03:57:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id a_tIQDRRnMi3; Fri, 19 Dec 2025 03:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1766116625; bh=9OoWm0rpVmuvoWbrBcuEyBUT/k9kR14cD7LfwTMMKnA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PNs3f/EK4SVpDLpJ1O4Z4JOT0NWqoiva2DRw0lFhC8vdabJkEzGCvAhVJIbzZwqO0
	 f65NhPmk8rdKYOIJsX8e4aNtBfKKYbgUoq5Dx3d1GeHA2tNePAkH2bjjA7RuK4Xr80
	 bXGaS4zMGQioLXh4/VRlU4lufTF9wvUU8zqFIHM3w+79gwZj6yMEIEE2FnG6dRc31g
	 Oelx7cry8MSLE9aqD/NxoELKQ3uZcyvFEpNLIVf9pXx0BrBbOj0y5PGhSx6yl5CEk/
	 n8FHhDE5Afc2KYq9mVXRP+J/jvZxzkVHw8DZxpHJjHxVwhDKTa+cLmjPuvftZYQAzH
	 L/QDL9XYIUIbKUUKbV6E1Mq9Zczz+oi6VgDJHtZjRpMV18TbOz+srKdavu27adrvEw
	 RiU0jvHdwgkqzvAAqFsx0MBW4sL9iGCUh9xsD8m8yx6kdCZ2WWPoiCB6Dv9b5DxbHC
	 yjY+4cFJxQf4CxqwshHOCkvoZ9UW7uor92OqUmUK14m96F+NyBBqH6eeoucOiRCbB9
	 7qZ9EBbJn2mrWRlJbUg1Hn+35dfYZhHAuKxVjfyPnJHokLr0R7VMINEdDQFQyB97bc
	 4LZZwuV6KoyuRaece5fovss1/02B7HcSBlnrXqtTiq9SaVcJtyq3SgOu3sq7sePR3R
	 uC0r+KLG26iYcCgKbmaHGDhM=
Received: from ehlo.thunderbird.net (unknown [IPv6:2a02:3036:262:5a0b:90b5:59c8:4fa2:6e0e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EED6A40E0200;
	Fri, 19 Dec 2025 03:56:45 +0000 (UTC)
Date: Fri, 19 Dec 2025 03:56:33 +0000
From: Borislav Petkov <bp@alien8.de>
To: Ariadne Conill <ariadne@ariadne.space>, linux-kernel@vger.kernel.org,
 seanjc@google.com
CC: mario.limonciello@amd.com, darwi@linutronix.de, sandipan.das@amd.com,
 kai.huang@intel.com, me@mixaill.net, yazen.ghannam@amd.com, riel@surriel.com,
 peterz@infradead.org, hpa@zytor.com, x86@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com,
 xen-devel@lists.xenproject.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/CPU/AMD: avoid printing reset reasons on Xen domU
User-Agent: K-9 Mail for Android
In-Reply-To: <20251219010131.12659-1-ariadne@ariadne.space>
References: <20251219010131.12659-1-ariadne@ariadne.space>
Message-ID: <7C6C14C2-ABF8-4A94-B110-7FFBE9D2ED79@alien8.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On December 19, 2025 1:01:31 AM UTC, Ariadne Conill <ariadne@ariadne=2Espac=
e> wrote:
>Xen domU cannot access the given MMIO address for security reasons,
>resulting in a failed hypercall in ioremap() due to permissions=2E
>
>Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
>Signed-off-by: Ariadne Conill <ariadne@ariadne=2Espace>
>Cc: xen-devel@lists=2Exenproject=2Eorg
>Cc: stable@vger=2Ekernel=2Eorg
>---
> arch/x86/kernel/cpu/amd=2Ec | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/arch/x86/kernel/cpu/amd=2Ec b/arch/x86/kernel/cpu/amd=2Ec
>index a6f88ca1a6b4=2E=2E99308fba4d7d 100644
>--- a/arch/x86/kernel/cpu/amd=2Ec
>+++ b/arch/x86/kernel/cpu/amd=2Ec
>@@ -29,6 +29,8 @@
> # include <asm/mmconfig=2Eh>
> #endif
>=20
>+#include <xen/xen=2Eh>
>+
> #include "cpu=2Eh"
>=20
> u16 invlpgb_count_max __ro_after_init =3D 1;
>@@ -1333,6 +1335,10 @@ static __init int print_s5_reset_status_mmio(void)
> 	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
> 		return 0;
>=20
>+	/* Xen PV domU cannot access hardware directly, so bail for domU case *=
/
>+	if (cpu_feature_enabled(X86_FEATURE_XENPV) && !xen_initial_domain())
>+		return 0;
>+
> 	addr =3D ioremap(FCH_PM_BASE + FCH_PM_S5_RESET_STATUS, sizeof(value));
> 	if (!addr)
> 		return 0;

Sean, looka here=2E The other hypervisor wants other checks=2E

Time to whip out the X86_FEATURE_HYPERVISOR check=2E
--=20
Small device=2E Typos and formatting crap

