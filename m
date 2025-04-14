Return-Path: <stable+bounces-132409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A787FA87A02
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 10:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6285E3B165D
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 08:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7572B2580C6;
	Mon, 14 Apr 2025 08:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="jWym5UQb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XPYnSyK/"
X-Original-To: stable@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8341B3929;
	Mon, 14 Apr 2025 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744618607; cv=none; b=JxqwswrE+tcohi4sorCT0GwPXD/P9McufkI3AtiifAX4qOdG+KxvLAAnuBWqYWRcDiZM1CAAt+TWyg4EP7zrH4rfm1liPx3a1w6zE02uEFFLO8WWRsQuiW0U9v4fO8t69bYQQ2yTdUSWYNwEV+YlvSPqL8GisNBnFIUhGNRn3G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744618607; c=relaxed/simple;
	bh=9sWbOMW+IVMom0RcqnNNgqEEMH9cNEP+F8MFK/vk3kY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdsH37sTmFcg93RP3dyFsoxc53ZBFxZO68bubfhKFIxCgLNhNXH089V75fs6Jskf1dt4A61RJMmgjmBpsx5bYdVeX0zG8hQQK358zgMmmCUofQsheZwP7zpmXsra6n5Auu3BNhJ9h7QPrmf0bS13JqjfrbJn4xm924Drol7ZSso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=jWym5UQb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XPYnSyK/; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B75BF138057D;
	Mon, 14 Apr 2025 04:16:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 14 Apr 2025 04:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744618603; x=1744705003; bh=A+ViW78CsL
	GmjWmMDqqTl7B6L5Ulz3wieWbNf+7iWQk=; b=jWym5UQbgP/QvYcU5V0/PPR31I
	/2Dya5jjAABVsp83aJm9gPKCQXfno/NA2Jj3I1+qooGs1LcYo2N5sXtduA20pTfm
	RTK8zzWk/KTbSalbNGWcdy6t9fjVsGza2vdvXGf6jXC1o0RcxzldoVg2ZryS8e8q
	fWPmqvtsOihaAZY6ydUAsGwouKqax3lUiiozCNnpapfCiGgb/8UHWDceEi13NibW
	0GErYG5gNnROrg7VtxwmO3eAVPaGt8JnyFct3tTmkl5v87NvnuIivtdFy+yRnFxu
	hfFxOWDjHKTtyn/tMN4ZpAq0tRigisIW+qW942gXCPAxb+vbac9QFmf36UcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744618603; x=1744705003; bh=A+ViW78CsLGmjWmMDqqTl7B6L5Ulz3wieWb
	Nf+7iWQk=; b=XPYnSyK/j2extvAcUJrS74a6QXVmAZA+oYNCAgSbnX5eAEtdYMG
	VZD+2FCwYmll7ELv2C995hobVyyOMEAsQpg49VeRexEEdjuo3h1xsT41b8T8W+Kc
	+6FqVMzNn8oYJKjV3UFdOL8SOlPcuRRglXBqraq3CQ1Ra0G9PITHBp4hPTjJJnFG
	aca43HZcOlwlAesn0jsBVbJbILkGhm/vFJL1UL9DgDVbY6BFpKNaeg2lYgTPYVov
	S780FprBNyWK+cHHOTFaEh4vjdHhGOraBYmyoUocdpZ735AtK1kH85tEgW3butoV
	lQ03z8d3/GwU5BYFTXfSWuCHDpZL8tmEWEA==
X-ME-Sender: <xms:a8T8Z1992qqwQWSn9_FFPXTNliXk19pHgUd4SGMd1vTjLjaIdkWpYg>
    <xme:a8T8Z5vXNEmfMz3CTqwlq-W3pvWtLSlcE-DV7txIuW_vcK73ofHokhnAQt7hYBrK1
    FWyFhX1bonDgGp-Soc>
X-ME-Received: <xmr:a8T8ZzBneclz8GfueAqkj0Z6t6xSabBaxOnSLcmg6neovzFHVx0u9D577pfo2dz4GdzwnlEIHnBg5CCV_dBSO9xgdyY_SutEEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddttdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
    cuggftrfgrthhtvghrnhepheeviefggfeivdfgueefudejgfffveejteefffefieetkedt
    hfevheeutefgieeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlih
    hnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtph
    htthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhimhhonhgr
    sehffhiflhhlrdgthhdprhgtphhtthhopehlhihuuggvsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdho
    rhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:a8T8Z5d7ieCezpEBtdbDvZNnyN5V5aJbdsakaYevy0gTE3DJW1GpxA>
    <xmx:a8T8Z6MNCz3kB1VN1p_-lX8JcMUY193s2Y87ApSVef0iDV8JIt1XIA>
    <xmx:a8T8Z7ncH1mmXasihCrlRX6NoA6cvt4i8nCpPNFrfHAyKe6LeXOAng>
    <xmx:a8T8Z0vCCO68d2L0hRTHv7zFfLZlTGbo4NdiQzojkEabn3UzHXNgng>
    <xmx:a8T8Z3yCab7A1l8wz_cLjHYYMebvhrq3_QvUmTtWUpIUC6DJZTDRkzVW>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 04:16:42 -0400 (EDT)
Date: Mon, 14 Apr 2025 10:16:40 +0200
From: Janne Grunau <j@jannau.net>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm: Select DRM_KMS_HELPER from
 DRM_DEBUG_DP_MST_TOPOLOGY_REFS
Message-ID: <20250414081640.GA8400@robin.jannau.net>
References: <20250304-drm_debug_dp_mst_topo_kconfig-v1-1-e16fd152f258@jannau.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304-drm_debug_dp_mst_topo_kconfig-v1-1-e16fd152f258@jannau.net>

Hej,

On Tue, Mar 04, 2025 at 08:12:14PM +0100, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
> 
> Using "depends on" and "select" for the same Kconfig symbol is known to
> cause circular dependencies (cmp. "Kconfig recursive dependency
> limitations" in Documentation/kbuild/kconfig-language.rst.
> DRM drivers are selecting drm helpers so do the same for
> DRM_DEBUG_DP_MST_TOPOLOGY_REFS.
> Fixes following circular dependency reported on x86 for the downstream
> Asahi Linux tree:
> 
> error: recursive dependency detected!
>   symbol DRM_KMS_HELPER is selected by DRM_GEM_SHMEM_HELPER
>   symbol DRM_GEM_SHMEM_HELPER is selected by RUST_DRM_GEM_SHMEM_HELPER
>   symbol RUST_DRM_GEM_SHMEM_HELPER is selected by DRM_ASAHI
>   symbol DRM_ASAHI depends on RUST
>   symbol RUST depends on CALL_PADDING
>   symbol CALL_PADDING depends on OBJTOOL
>   symbol OBJTOOL is selected by STACK_VALIDATION
>   symbol STACK_VALIDATION depends on UNWINDER_FRAME_POINTER
>   symbol UNWINDER_FRAME_POINTER is part of choice block at arch/x86/Kconfig.debug:224
>   symbol <choice> unknown is visible depending on UNWINDER_GUESS
>   symbol UNWINDER_GUESS prompt is visible depending on STACKDEPOT
>   symbol STACKDEPOT is selected by DRM_DEBUG_DP_MST_TOPOLOGY_REFS
>   symbol DRM_DEBUG_DP_MST_TOPOLOGY_REFS depends on DRM_KMS_HELPER
> 
> Fixes: 12a280c72868 ("drm/dp_mst: Add topology ref history tracking for debugging")
> Cc: stable@vger.kernel.org
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  drivers/gpu/drm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index fbef3f471bd0e5101699cf576542f7350bea3982..bd228dc77e99b4356b09de02d9001237eb2423e2 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -188,7 +188,7 @@ config DRM_DEBUG_DP_MST_TOPOLOGY_REFS
>          bool "Enable refcount backtrace history in the DP MST helpers"
>  	depends on STACKTRACE_SUPPORT
>          select STACKDEPOT
> -        depends on DRM_KMS_HELPER
> +        select DRM_KMS_HELPER
>          depends on DEBUG_KERNEL
>          depends on EXPERT
>          help
> 

Can this change be merged? I do not see it in v6.15-rc1.

thanks
Janne

