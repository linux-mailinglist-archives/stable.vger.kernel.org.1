Return-Path: <stable+bounces-232728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKFKM+/azGnnWwYAu9opvQ
	(envelope-from <stable+bounces-232728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 10:44:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7427137707A
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 10:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AB013138B6C
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 08:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDA43B2FE0;
	Wed,  1 Apr 2026 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0LgG0zD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC653ACA68;
	Wed,  1 Apr 2026 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775032494; cv=none; b=s2OivYcObdS0QG/K3qufisgq2efI7XQnueGYYrYZWaAiLocMg1/bakYQc4Cpwtx21RdO3oqSfC7+PG85QyHj8Aa2NxpmFaMiwhHgVw/jw88rY2oSX6tDuZHpKrSHC1L9wT1QWWEco4aq2WhSbmSSMELz6CHv4A9O80+pwYNFyjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775032494; c=relaxed/simple;
	bh=8LWqVYVupsHf2WpfKI7Tx2LrsjGmOFFgtNiUEes0yjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lx+UXHayX2SuYsxbxy22lXR8pbuKuBhmyrj4fXNyIuTrgfUxMHj6c8Sv+wOarrisxEea0VxO/0hhXtSIjvGLy7qfEcEHoVR6Gez6y0i575LsyuDdWxJITKRVVMWY57rVDVFsS8UFO/ILSuuFD/0E0U3kH8gTiyB/bqcQNbqNKVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0LgG0zD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A767C4CEF7;
	Wed,  1 Apr 2026 08:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775032493;
	bh=8LWqVYVupsHf2WpfKI7Tx2LrsjGmOFFgtNiUEes0yjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t0LgG0zD3dUM/ufKi0thT18QpcgGKAgqSkXhM4b2GEobQAoUo+7ep2Fk6LstJl4Pe
	 QBINrjg8YYoO4E+DuhSth8pCIaXlNTdpBcF7WqfM6NfzFqfbU301w4XWcZbhiC0I8Z
	 UxU9VDG2M/SHLJjC/ohRGMDzXYMABeU4OOtH0pBfnutnO24LuRf7wML072iICRsCgw
	 FZjk6VfblcxMsGMzU6mtONdsuMgDNvbQQnt2KKU8hgD853TsmTb18FuqLafeTOJ6BK
	 gAwgQofQfNbm8og0/5/D4uqNDETWA+dgE/2DkjBFUZ8yQNMZCrupIKbY8RrpGa9r17
	 bFBXMsdY54SxA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id ADA3DF4006B;
	Wed,  1 Apr 2026 04:34:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 01 Apr 2026 04:34:52 -0400
X-ME-Sender: <xms:rNjMafuhn_FAUVDkXz3K70LYyVp6bUmqLflbZKgWHtFSwzPXg1f9TQ>
    <xme:rNjMaRrNBod4OHBZaHuiisaWZteqrom0D41m5p6HCdnmsLpzwvvZi19Hx0ck3QKhR
    CW9PXvQE_DRm9Tq4xbvaKzCpJYqeErhPCssJNX_0cttoNdXYy4dQBhG>
X-ME-Received: <xmr:rNjMaTOa3R6sEKH-YwyI8JxxQrZR7cBc_eloNciMIFONFq1yINqzrjT3-Uum5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcuufhh
    uhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epffffkeegffejgfekvdejgeegtddtleejkefhhfduieduhfeigfduuefghfehffdunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkhgvrh
    hnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedviedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrthhhhigrnhgrrhgrhigrnhgrnh
    drkhhuphhpuhhsfigrmhihsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohep
    thhglhigsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrth
    drtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegurghv
    vgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepgiekie
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgt
    phhtthhopehrihgtkhdrphdrvggughgvtghomhgsvgesihhnthgvlhdrtghomhdprhgtph
    htthhopehtshihrhhulhhnihhkohhvrdgsohhrhihssehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:rNjMaXn9MxrG_QpJ4zKSGey5QZafb9MNh3t5kGzKeMi3q4ta6Ov2DA>
    <xmx:rNjMaVsKz6Pnd9UvI5j6bBhbbgD-OjoIsIyx2_fB2lK-KtmvNMGijA>
    <xmx:rNjMaekKYaYGnmeLXjn02NY-a1tgjHugyI1H1vZxI1B0kx-rFO2Wow>
    <xmx:rNjMaWlZwR5oDMJeaYdhlkgPeTFIZaBuBNWhC8O5OG75XNNxirV10w>
    <xmx:rNjMaQenaN36Yt2L1gw_L2eT8FuTzYrugYLPb6qy_t5V_6FKeHyedLzC>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 04:34:52 -0400 (EDT)
Date: Wed, 1 Apr 2026 09:34:50 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/tdx: Fix off-by-one in port I/O handling
Message-ID: <aczYg5hk8yoIi05W@thinkstation>
References: <20260331112430.71425-1-kas@kernel.org>
 <20260331112430.71425-2-kas@kernel.org>
 <ee096f1e-b994-4d56-a78c-cb0e867ea047@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee096f1e-b994-4d56-a78c-cb0e867ea047@linux.intel.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232728-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,intel.com,gmail.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7427137707A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 02:57:32PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Hi Kirill,
> 
> On 3/31/2026 4:24 AM, Kiryl Shutsemau (Meta) wrote:
> > handle_in() and handle_out() in arch/x86/coco/tdx/tdx.c use:
> > 
> >     u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
> > 
> > GENMASK(h, l) includes bit h. For size=1 (INB), this produces
> > GENMASK(8, 0) = 0x1FF (9 bits) instead of GENMASK(7, 0) = 0xFF (8
> > bits). The mask is one bit too wide for all I/O sizes.
> > 
> > Fix the mask calculation.
> > 
> > Fixes: 03149948832a ("x86/tdx: Port I/O: Add runtime hypercalls")
> > Reported-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
> > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> 
> LGTM. Can you include a link to the bug report or related discussion in 
> the commit log? It will help understand the impact of this issue.

Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=bxowfZwxrATCBRg@mail.gmail.com/

It is relevant for both.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

