Return-Path: <stable+bounces-127020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB57A75A66
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 16:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9E3167DC7
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 14:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865451C3F02;
	Sun, 30 Mar 2025 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMKTmMya"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E363A1B87EE
	for <stable@vger.kernel.org>; Sun, 30 Mar 2025 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743346397; cv=none; b=GlXcWGBnJkL17YIay6xMhRHSu2SbfI0mL7Us5CFAVT9uIBIDUFa+0GtHWyC/KKHO1gLyuRmQN9fHjlIaJ24KF7ODFc30FcGm08Q1jilfER9MTurK/gSiHsftX5u3PRduLSW/UA+XfGIrmWjdd+U6mZAcc088iXsmycFbEQ6a14o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743346397; c=relaxed/simple;
	bh=883aU6M4P8B1Gvoywvx1N+4lquH75UhP5vvd8twaVuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkGMGKo25f0BUAjWDivzKIbl8bwmRejM6qkUMBUqMDjMHm12jNMvUihYkJ6Ls7uNJPas0A3TsJK+MmxRza9ZxxSjCzSlkA+CiGZzNFbwQUCu6zk/6Ran5wFIu9EA9Upnipks9nThd54aLCjd1AdmjJcC6K0/DYYpM5Js2YSBR24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMKTmMya; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-227cf12df27so52962865ad.0
        for <stable@vger.kernel.org>; Sun, 30 Mar 2025 07:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743346394; x=1743951194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1gpBpp857KGUKkj2FFhAtCqlWpQJppTa6XQGxc0B3vY=;
        b=UMKTmMyaHu3R64ekyAshzOpFsZdKAjBdNxbl5koT1jfY/qw5aQSQ90roKKH7poF2OA
         BJPwhc8/JlSGQDw7jZR8+Y4AaLcLPvBGWKZSOH8ESwmN5/ZXbk4oomNRjInBoj+mLV+g
         YxPYltyfMBRjTIvIXDmWsyfLCjpgReXe/wYg1jNMJ3tgmSflChM53DeI7cbeEXfT8wAZ
         gaPbEdwY90xYLvEU+mhqDpfi6a+Nf62N0LjaH6b5ywssMfAdSkbOldGtEH/lDfikAYRh
         peMW2D7PTSSzkP2UWSi1I31+QXlkgNT3bfvw7CzP8IDCTHRvj0LaQBUJmfhKGRGExdsn
         YQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743346394; x=1743951194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gpBpp857KGUKkj2FFhAtCqlWpQJppTa6XQGxc0B3vY=;
        b=m+HJoOMZxnBORQiIJ8RUHwwU8egDlcwbkmrlKVPOstlC30f5LhRBoWjxhCzCNCfTqZ
         0od85+TedmqHRaCg+wMA00zg2vYlL2l0VJrqNyFceqtig2lZRpScHnUAQMk29G2/XOGa
         korFvj+pXpatwTnYZVZ4mjF5E4YO5lokFZYrr0eh3pfVX6HoETAHmOkpwlh8pTqa4r4U
         1R8JqwV3/esWsIX6DcOGASjsoqzcXryYDcPqw/YNL3Q0gLW7UKbEr7+FHqSk/rqrQKl2
         AazZzpORF2sSatjIXfgIMEJeAU+Fh212KT+7yQggjF/3qgyfIeN+XDPaFqcgqTBxqghn
         Bcfw==
X-Forwarded-Encrypted: i=1; AJvYcCULWEo8Bz6eXFg5MPzB06Evy+WbTOWpFr28ACnu/1KZBB4yNcj9wnPSBbUnbLTorJJ1uNxjd+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyim3a108DIuQsZi/OThvSkOKul/NzFs+Qc9U0ZJV24zjthMau/
	21mFRxpDuyx4J/Q2JC52r+YmS9PR4H18aW2X7wEOD9tf6AdvvVAJ
X-Gm-Gg: ASbGncu2/mU2/st9FJn1NL6fVuc971duLkg5cuNmz97I1h1tIn9FF9KAIrazFMwZXXv
	1xdoFlWSoZLL0yoTHQ0/B2RDZ81cA/NUC4QSc+Vjz57HW+ZdscuCuAE7G5tBmvKyFDuA5gLrFNR
	rD2KDtE0n628yJgbqK735UjzNIy3yks2E10WD0iJ/9xl67BB2VuYVusnntF9LBJXDNjBHh4QD+Y
	dY82w1EKj2pd9obeNW2ZGFT7KDVesA9VBNLegB/a8M+dumJA3hfXrt+MD/wv9qHEkve+KLDlDAk
	gN19LMxOfe1efF19zXCRZLxSuhWKHdzEOKQb+uRi64flimYAG4u/ttCZAsK8UTLjyD/iwUkYC5h
	NolVkyK0=
X-Google-Smtp-Source: AGHT+IGu9HKANB/ggGladsYzfGeGJ99b5Mg3rsHMq3G79NuqEoNtlnzVXXVYjeAGCo8eMt4EAoYRfQ==
X-Received: by 2002:a17:902:ec90:b0:221:1356:10c5 with SMTP id d9443c01a7336-22921ca4193mr129887945ad.9.1743346394332;
        Sun, 30 Mar 2025 07:53:14 -0700 (PDT)
Received: from localhost (om126233180002.36.openmobile.ne.jp. [126.233.180.2])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3039e10baa2sm8653661a91.24.2025.03.30.07.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 07:53:14 -0700 (PDT)
Date: Sun, 30 Mar 2025 23:53:10 +0900
From: Zhenyu Wang <zhenyuw.linux@gmail.com>
To: Jani Nikula <jani.nikula@intel.com>
Cc: intel-gfx@lists.freedesktop.org, Kees Cook <kees@kernel.org>,
	Nicolas Chauvet <kwizart@gmail.com>,
	Damian Tometzki <damian@riscv-rocks.de>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gvt: fix unterminated-string-initialization
 warning
Message-ID: <Z-la1kFHvH4zu_X5@dell-wzy>
References: <20250327124739.2609656-1-jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327124739.2609656-1-jani.nikula@intel.com>

On Thu, Mar 27, 2025 at 02:47:39PM +0200, Jani Nikula wrote:
> Initializing const char opregion_signature[16] = OPREGION_SIGNATURE
> (which is "IntelGraphicsMem") drops the NUL termination of the
> string. This is intentional, but the compiler doesn't know this.
>

Indeed...

> Switch to initializing header->signature directly from the string
> litaral, with sizeof destination rather than source. We don't treat the
> signature as a string other than for initialization; it's really just a
> blob of binary data.
> 
> Add a static assert for good measure to cross-check the sizes.
> 
> Reported-by: Kees Cook <kees@kernel.org>
> Closes: https://lore.kernel.org/r/20250310222355.work.417-kees@kernel.org
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13934
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Tested-by: Damian Tometzki <damian@riscv-rocks.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---

Reviewed-by: Zhenyu Wang <zhenyuw.linux@gmail.com>

>  drivers/gpu/drm/i915/gvt/opregion.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
> index 509f9ccae3a9..dbad4d853d3a 100644
> --- a/drivers/gpu/drm/i915/gvt/opregion.c
> +++ b/drivers/gpu/drm/i915/gvt/opregion.c
> @@ -222,7 +222,6 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
>  	u8 *buf;
>  	struct opregion_header *header;
>  	struct vbt v;
> -	const char opregion_signature[16] = OPREGION_SIGNATURE;
>  
>  	gvt_dbg_core("init vgpu%d opregion\n", vgpu->id);
>  	vgpu_opregion(vgpu)->va = (void *)__get_free_pages(GFP_KERNEL |
> @@ -236,8 +235,10 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
>  	/* emulated opregion with VBT mailbox only */
>  	buf = (u8 *)vgpu_opregion(vgpu)->va;
>  	header = (struct opregion_header *)buf;
> -	memcpy(header->signature, opregion_signature,
> -	       sizeof(opregion_signature));
> +
> +	static_assert(sizeof(header->signature) == sizeof(OPREGION_SIGNATURE) - 1);
> +	memcpy(header->signature, OPREGION_SIGNATURE, sizeof(header->signature));
> +
>  	header->size = 0x8;
>  	header->opregion_ver = 0x02000000;
>  	header->mboxes = MBOX_VBT;
> -- 
> 2.39.5
> 

