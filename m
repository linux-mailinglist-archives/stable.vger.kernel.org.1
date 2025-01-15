Return-Path: <stable+bounces-108706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D5BA11FC7
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0221881B10
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BA41E98E7;
	Wed, 15 Jan 2025 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Z4g2mKad"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA10C1E98E5;
	Wed, 15 Jan 2025 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937326; cv=none; b=Jy9tnVKGF5sHzutJYLZeQrAVT87UE3+MyxZ+T1cByIcHlBDBIrzBjipuVSqBg3bqdpspFRXG/9gcpi4t1SJWWe8ljzllXPPpfbKSGb9TrZjVs3tqa64ZKgDpXothbBg/+85cA0uR5N2gEfTGDM9uhVcE5Kh1FfiLRbG5ZIsl8IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937326; c=relaxed/simple;
	bh=LKu+nuTanuJR57AIFG21BG4awbCPh3k0STsHWOB8IIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REEd0WW5lUWbNHHQuEf4kh01QFFXNMax3LzcjKpMIvBOSyOQ609eEPglbfhNHoTKPp1wfvAeJe9wJdO/8E6bVaMLYGoymq5MCtwfQJkk5qOA0fGveh2hYhSryE6RPlYX4XKABfYuJ7QEEFP5AQ6qh/+8yiNZ63bfPUEyi1UpYGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Z4g2mKad; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7679340E0269;
	Wed, 15 Jan 2025 10:35:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id orokJiHTn_GF; Wed, 15 Jan 2025 10:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1736937315; bh=vECBGBrtSiXwmZmow9g+w++aMVZcE3pjeKiqZi31PRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z4g2mKad2fZrWCjActVoq2ERvnYQFqD/BaixngsGolITK4xuPzu12M7ErZi8XJ/Uu
	 +/aj8TH4RtcgYB237YCfCtm2oEdgCgEQO/Kl+AKfQBa3OES1VpsvDHEwCYcP3f/HyG
	 KmE1xrbBl8Fak2jZbYAHTsG/ddh8V4bM1NExXaOdQXFUiaiZBmye78B60Yv4MXg1OJ
	 Nv/LlbZic7RwEUzKyGSBp2+6Wv0/PPE57ksv05mZ+ooIiJPDGtqr94103jSDdt/riO
	 VUoTZI86StQnuAq5tGnhkjgFrNGw8aObJGxNCfR61BrArI27uB7CD4K+cU2c2WgFCA
	 ENG2GdrX4cKYC86YIA5pFjDchoDmiuqSbLyI27qdcTPJpLppEySPONaDDX6k979oXB
	 nX07XFKETMdZQFe3Td5eejPuNAzD+y1MGbH99O4kbZTHhgjmNNYRoz+iHUOK4nNB2J
	 KXh71yx8BOM/0LpxwetonPkvEK/VjHAkh2wsDSsQFjAWskLa7U5K3GXw8MQvxPJXqQ
	 FPtVsmDmr0yb3CECWFFsHYLH92tWUIqwKwgnIchvH1sCpZOMbb2e920L5Z0ShPwvd6
	 +5zdyaO0VkU/e5AFTwKsxgscW4mWh65aPHSJB+kvS5kUHKd49aMyT2HBp2uyC0ZrDq
	 /poj4GRNbAEsBfsNrHYQ6BQU=
Received: from zn.tnic (p200300EA971F93A7329C23FfFeA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93a7:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 104C440E0277;
	Wed, 15 Jan 2025 10:34:45 +0000 (UTC)
Date: Wed, 15 Jan 2025 11:34:38 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Chan <ericchancf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kai Huang <kai.huang@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Russell King <linux@armlinux.org.uk>,
	Samuel Holland <samuel.holland@sifive.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, stable@vger.kernel.org,
	Ashish Kalra <ashish.kalra@amd.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCHv3 2/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as
 encrypted by default
Message-ID: <20250115103438.GAZ4ePPs5pxvLLOmIO@fat_crate.local>
References: <ff8daeb1-4839-b070-dd94-a7692ac94008@amd.com>
 <mvosqsybplnqfh6wadw5ue7u3plqnfo5ojusvaq6htzzhtfce2@bbgogdund3ho>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mvosqsybplnqfh6wadw5ue7u3plqnfo5ojusvaq6htzzhtfce2@bbgogdund3ho>

On Wed, Jan 15, 2025 at 12:23:54PM +0200, Kirill A. Shutemov wrote:
> I am okay with the change above. Borislav, is it acceptable direction for
> you?

Yes, Tom and I have been talking offlist about making the *map code figure out
itself what type of encryption setting it should use, based on the platform.
It'll need a proper analysis, though, what all the possible usages are to see
whether that scheme would be adequeate.

Something to experiment with after the merge window.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

