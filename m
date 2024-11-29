Return-Path: <stable+bounces-95822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2D89DE7E6
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 14:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697B91613FF
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 13:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA859199230;
	Fri, 29 Nov 2024 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="hTUje02A"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C6F1EA90
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887920; cv=none; b=ANAKJ16LDovwrIcu0WFcQ2FLclvAJzwye2D8ZDEsTcK9vdBDTvbXL34QYGy4OW5m9tf/MMOb5AGQypWJJsw5e4z6nQOt/bq2L0Jm3UTcjMNC2aGS2yL+c0Ue5PcsM1QnoU8xRT652M3Cip+FMO02wXkeS02AdyO1qBgAm91IPx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887920; c=relaxed/simple;
	bh=jguxpio4XolWCDaQwE/3Hur40X/avkP7MbgQGLKv1iE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZScQtvfV//PVtD3FvZ+NiMlQ6c+oSnSsH4S78+IaHM0MsX4ymJJpVs5HXIdxh2iH3hXTpf2FKVcsjtrW3uzt04mZf0Wy5iUQJANjQj7ELZwpuuilGgOCSfYvDyf7B3fEueNAUdbOC1k7YDMD6kUegtYd6ulMbhCr2x+FA4U1DH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=hTUje02A; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1732887911;
	bh=fqt73PL8niZVQUoikfti6Kgtqh4sV2CnyNWCHfrB+T0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hTUje02A2dVEDSV82kj33xW8SqDShVuKasU7hlfSNongJGHBEDYLYH7PnWrBlRcOH
	 H2vtB5lQzYLLi5n33lJKhWWN1ojK4IoLTo2kL9yTCS8Ek+sLBghO+zUjC74gfm8GcA
	 141ajYHoOUl5oBFfLep9eWZflpi+YvWP7D+xlIeU=
Received: from [192.168.124.9] (unknown [113.200.174.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 68B9166AC7;
	Fri, 29 Nov 2024 08:45:10 -0500 (EST)
Message-ID: <f8e0aa133f1409b70d2f1526991a1ddcce3bc8a0.camel@xry111.site>
Subject: Re: [PATCH 1/4] drm/i915/fb: Relax clear color alignment to 64 bytes
From: Xi Ruoyao <xry111@xry111.site>
To: Ville Syrjala <ville.syrjala@linux.intel.com>, 
	intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org, Sagar Ghuge <sagar.ghuge@intel.com>, Nanley
 Chery	 <nanley.g.chery@intel.com>
Date: Fri, 29 Nov 2024 21:45:08 +0800
In-Reply-To: <20241129065014.8363-2-ville.syrjala@linux.intel.com>
References: <20241129065014.8363-1-ville.syrjala@linux.intel.com>
	 <20241129065014.8363-2-ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-29 at 08:50 +0200, Ville Syrjala wrote:
> From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>=20
> Mesa changed its clear color alignment from 4k to 64 bytes
> without informing the kernel side about the change. This
> is now likely to cause framebuffer creation to fail.
>=20
> The only thing we do with the clear color buffer in i915 is:
> 1. map a single page
> 2. read out bytes 16-23 from said page
> 3. unmap the page
>=20
> So the only requirement we really have is that those 8 bytes
> are all contained within one page. Thus we can deal with the
> Mesa regression by reducing the alignment requiment from 4k
> to the same 64 bytes in the kernel. We could even go as low as
> 32 bytes, but IIRC 64 bytes is the hardware requirement on
> the 3D engine side so matching that seems sensible.
>=20
> Cc: stable@vger.kernel.org
> Cc: Sagar Ghuge <sagar.ghuge@intel.com>
> Cc: Nanley Chery <nanley.g.chery@intel.com>
> Reported-by: Xi Ruoyao <xry111@xry111.site>
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13057
> Closes: https://lore.kernel.org/all/45a5bba8de009347262d86a4acb27169d9ae0=
d9f.camel@xry111.site/
> Link: https://gitlab.freedesktop.org/mesa/mesa/-/commit/17f97a69c13832a6c=
1b0b3aad45b06f07d4b852f
> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

Tested-by: Xi Ruoyao <xry111@xry111.site>

> ---
> =C2=A0drivers/gpu/drm/i915/display/intel_fb.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_fb.c b/drivers/gpu/drm/i9=
15/display/intel_fb.c
> index 6a7060889f40..223c4218c019 100644
> --- a/drivers/gpu/drm/i915/display/intel_fb.c
> +++ b/drivers/gpu/drm/i915/display/intel_fb.c
> @@ -1694,7 +1694,7 @@ int intel_fill_fb_info(struct drm_i915_private *i91=
5, struct intel_framebuffer *
> =C2=A0		 * arithmetic related to alignment and offset calculation.
> =C2=A0		 */
> =C2=A0		if (is_gen12_ccs_cc_plane(&fb->base, i)) {
> -			if (IS_ALIGNED(fb->base.offsets[i], PAGE_SIZE))
> +			if (IS_ALIGNED(fb->base.offsets[i], 64))
> =C2=A0				continue;
> =C2=A0			else
> =C2=A0				return -EINVAL;

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

