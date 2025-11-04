Return-Path: <stable+bounces-192385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32742C31389
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 14:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AFCA4F86ED
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 13:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97A62F691B;
	Tue,  4 Nov 2025 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JJqJFsnK"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45B2F83AE;
	Tue,  4 Nov 2025 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262521; cv=none; b=Cn9zJfLRbHlikVmI7uDMeyekNzdZc8KDpxcdJ5993DmWP/uioczNLHevJpkVaEzrRdu35Sjn3HDwYKntxjrjfkMoyqMfew56lId4sAsSldOq+q2PhPwjVtxNEaZURF+XD32n89EJfCBSMQ2IeImHzE+IjZyu3/RrnyvXc/+3uks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262521; c=relaxed/simple;
	bh=A8uNsn01/WnKgfXHXpP9rtbba4JgRI3AzKgqACHqeJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I21F/IhtoIS8qC5HyQyAypqwLnpYUQol4/E44tjrOEpgtdrV9o5Cy7iFzTrQBqu+1shO0VP1cZKIcU842/hV1TkedQDxex4d6kMWMGnXjNwIroqW47GjSDjztKV99ipn6GLHvbWGDNsT05j/K9tRYBCydu5Zitx7+uI7T/mAXMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JJqJFsnK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 67FD540E01CD;
	Tue,  4 Nov 2025 13:21:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Lf8_NI5z6oTE; Tue,  4 Nov 2025 13:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762262503; bh=uWN8A3k4MptfZyPCNRH5jFhgxBi6r1ClNs78sPDO9Ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JJqJFsnKXnlO3wIcz2hAl+sI6cA+ur0co+0Yf5CYbQ6goujdlO3VzhDWulK7STaMB
	 FIC1xrXq3tIhjWVGv9GQJgFTO/kDFMRYlrHg3ANtAacL0Yk6dG26AjIxMNyWNuvO2u
	 Rs+p8Ns8TYZAdSr6WVbbmt2ZAjm5EuUrlciVIqR7YdhYeZvj+/FShqaoPgNB284J2G
	 /XWeIaQ6dc9uCjQyp1Od7TH3HkXquol1TRVcYiWUtgbcvdmyfENV4JalrLflHnlzdD
	 HBTfxOCmsuQU0zd64JJURX3zNKbPrwMn4z4bcUT5kA9KX1oqcaUrc3XOfsB3hzFtd5
	 DOQzLjnALoSrADn8rHXtasmqlFirhAOnQbaJ6/BzBJQZebC7g/tetMulqzMrsRlbzH
	 +/cHH0+ym73wVAHQipwWbEU1mAS9lxnbVwCPcg7bulUc5v/aSSFp87ACUBdHgaVdpq
	 06HLPAIY4/SJ3YShygmPqQbyA/7ASs2QdMvJlosOowy5kDY6EhM5ffrNxM4tlcJ8Ee
	 i3AidWp88999Oav/3yj6Gld55y3G2dM+KP6eCaus4FjnRQ32XwhSiwzcizkLyt+XPi
	 CeGuJtwClGgace29+HBTxAZwQnh2mqpx4yyATY5UvfSjw9o3H+Sa43kabHp0/Y34kE
	 ieAU85bG75xj3C5JNYbwKyJg=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id B221F40E021C;
	Tue,  4 Nov 2025 13:21:24 +0000 (UTC)
Date: Tue, 4 Nov 2025 14:21:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Christopher Snowhill <chris@kode54.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Gregory Price <gourry@gourry.net>, x86@kernel.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
	mario.limonciello@amd.com, riel@surriel.com, yazen.ghannam@amd.com,
	me@mixaill.net, kai.huang@intel.com, sandipan.das@amd.com,
	darwi@linutronix.de, stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/amd: Disable RDSEED on AMD Zen5 because of an
 error.
Message-ID: <20251104132118.GCaQn9zoT_sqwHeX-4@fat_crate.local>
References: <aPT9vUT7Hcrkh6_l@zx2c4.com>
 <176216536464.37138.975167391934381427@copycat>
 <20251103120319.GAaQiaB3PnMKXfCj3Z@fat_crate.local>
 <176221415302.318632.4870393502359325240@copycat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <176221415302.318632.4870393502359325240@copycat>

On Mon, Nov 03, 2025 at 03:55:53PM -0800, Christopher Snowhill wrote:
> https://lore.kernel.org/lkml/9a27f2e6-4f62-45a6-a527-c09983b8dce4@cachyos.org/

tglx already summed up what the options are:

https://lore.kernel.org/all/878qgnw0vt.ffs@tglx

> Qt is built with -march=znver4, which automatically enables -mrdseed.
> This is building rdseed 64 bit, but then the software is also performing
> kernel feature checks on startup. There is no separate feature flag for
> 16/32/64 variants.

No, there aren't.

And the problem here is that, AFAICT, Qt is not providing a proper fallback
for !RDSEED. Dunno, maybe getrandom(2) or so. It is only a syscall which has
been there since forever. Rather, it would simply throw hands in the air.

Soon there will be client microcode fixes too so all should be well.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

