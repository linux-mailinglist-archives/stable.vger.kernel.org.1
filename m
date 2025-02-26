Return-Path: <stable+bounces-119740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF18A46ABB
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 20:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DACE7A75FF
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 19:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6591222540A;
	Wed, 26 Feb 2025 19:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMWDKE+0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6EC41C71;
	Wed, 26 Feb 2025 19:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597407; cv=none; b=kr2qiRiIs0HDXZTYIwSi2StYPXmxYKGbNL1+SWBim7WPvHfBJnpawfxyDNrz2pfGFtIfdthJqR1tAAniN6ZQufLBgnu1Tu0e9RHr8RXpCbu69cloTEhjxrBzi4eAjBwIcGk5a/jtmI6Y7MOZUHSt5V58AZ+Odk/piQ4lpm+1VvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597407; c=relaxed/simple;
	bh=WQUaj7X7NpJYCAvtzOtOiiMuzqCHQE0yCubMbtYl564=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFN2zCCBJLiRpZE38KOzM7HmamROYbUZ8cqdtXjNS34aVffP+iX3u9fQaldGpnh2bNXY+lwAAfA6s5Y8MSsQGTjU9ogKBIKDGuIg1EXw+AgLwfz4ddmp7PtXwVyvQCwM2HOlmpJpLIbhS8UjaRZDA3dwqlsG8PtAl+ZCYi/JCvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMWDKE+0; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fc29ac55b5so46545a91.2;
        Wed, 26 Feb 2025 11:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740597405; x=1741202205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjtNitstYYf60IMnZQOoZ5YL1+sKrxwbs6AgHj0hDAQ=;
        b=lMWDKE+0R5f8EZvPq7WgSO/SNfpI/ROBA8PFZIWFBKioqvGR0DaIJRM+irbZD3LKyc
         bDk2VjvzMEdRaxEvUZr2diQc6P0oLmIEa9MElf0kz4YoyjmayRQkcvGD/EFFGk8Fox5E
         06aee3BiiDAesmrFvdU06oy8nQ9+inS7hJxeZflKzC9L/HzyZ5ru3RGHaimWS2ewJ6Ld
         esAdXhfnPATk1C1l79RKn48UX1tpX6dKZn3LojQzT7anAMN6iwBVDHHu/umVS6VwNfCs
         QZVojjOAqiLOZ3IAaiTRSGFuFZwEz0ir00ow1kO1/IIi/K1TfGkZy9Ua5xxWubds0pd5
         /hNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740597405; x=1741202205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjtNitstYYf60IMnZQOoZ5YL1+sKrxwbs6AgHj0hDAQ=;
        b=GsVIR7CoW0pT3s3pvaEJx8uT0WF60iDFMhM4o2ozL4OT/66jjzPFHPdWBC3AzBfoFz
         AFH7MSJIylEOOePRDVDIgzRI937aQfUcN5SEJka7d21lccoz4gC57ENVibIdXQ0/2/K5
         0OMBN2f4F/fuVmZt4+Wp5BMd5MoKsRenM5qmNFOgk4m7Pip4bQgZ0P2tm0CV1YCZTwEr
         tNoRwNRgMuvB8UeEis2DTatd+BlhgPes59EAMtpe+223rl9sHhfQlrUkkC+sSml9GXGx
         lm5B1jjIhnsX34IoFKqYbN7sxOMCsXAn9FObOctw+rdy7XSbBkqMqdAaPI8oagFuVY/X
         Whhw==
X-Forwarded-Encrypted: i=1; AJvYcCVVVl7QjuLS3xG4itrosfZwN3tW+dN9sGTgNrCWqUbJqW4ebCvB3SFOckEuvqdTfYXf0a8Z2h5Z@vger.kernel.org, AJvYcCWwQTvTdSKE4MaEk+LL5WkdmX95z6kBIKeNAGpngwASFDOQ3tbctFJPoniZoJLY93fBjG70ucs4WamvAlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxXC4KYCtY6Ypac3sfwthlYdOqCtTAeGjqGV/pa9lnScN/6lrV
	BhSelr/CbuJcqG5QyDzVuy2iwgvuMFbyY7CYrItpXGXQg1T3fQl6wlTWGlll+zbXmdEICfWgePT
	ilWWNK1U1tC9H1kK8TyoRBLn4V6Uj2w==
X-Gm-Gg: ASbGncsKzxXz4K/ti23eVHBf1Yh1Uq2t3QJDV02kbC1HP/3zf5Xcswrx3ZvJ/SprW1z
	i/GRKTjmCSWkZjiP+1VDWr9M3ni3HVosfh4jnoorihQHCcl1PGXLNkhgLYwpxKjWVPv77uVHX9G
	cWdk9qfEU=
X-Google-Smtp-Source: AGHT+IHgWo4yFmzqB/Z9FUw87haS2aL6MUTOk2Od04bWbhTEwvhKuzoJHg77mviLKvY13jtSsscAzch+iDPY4BA442c=
X-Received: by 2002:a17:90b:3848:b0:2ee:cbc9:d50b with SMTP id
 98e67ed59e1d1-2fce7aef973mr14367404a91.4.1740597404926; Wed, 26 Feb 2025
 11:16:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226083731.3584509-1-make24@iscas.ac.cn> <749a1601-fa9f-468b-92d1-1a1548a08471@amd.com>
In-Reply-To: <749a1601-fa9f-468b-92d1-1a1548a08471@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Feb 2025 14:16:33 -0500
X-Gm-Features: AQ5f1JqZKQbC5NjwnQBDg9bLvkGO3Y_FuwCdAgPbNdvGDi3qHR2ihJQAqXVMKn0
Message-ID: <CADnq5_NJKwmiGfcP2RwK+pZD7YXA_pbe7VtsWYoNt_nVRFO5iw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Fix null check for
 pipe_ctx->plane_state in resource_build_scaling_params
To: Alex Hung <alex.hung@amd.com>
Cc: Ma Ke <make24@iscas.ac.cn>, dillon.varone@amd.com, Samson.Tam@amd.com, 
	chris.park@amd.com, aurabindo.pillai@amd.com, george.shen@amd.com, 
	gabe.teeger@amd.com, Yihan.Zhu@amd.com, Tony.Cheng@amd.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Wed, Feb 26, 2025 at 2:04=E2=80=AFPM Alex Hung <alex.hung@amd.com> wrote=
:
>
> Reviewed-by: Alex Hung <alex.hung@amd.com>
>
> On 2/26/25 01:37, Ma Ke wrote:
> > Null pointer dereference issue could occur when pipe_ctx->plane_state
> > is null. The fix adds a check to ensure 'pipe_ctx->plane_state' is not
> > null before accessing. This prevents a null pointer dereference.
> >
> > Found by code review.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 3be5262e353b ("drm/amd/display: Rename more dc_surface stuff to =
plane_state")
> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> > ---
> > Changes in v2:
> > - modified the patch as suggestions.
> > ---
> >   drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/driver=
s/gpu/drm/amd/display/dc/core/dc_resource.c
> > index 520a34a42827..a45037cb4cc0 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > @@ -1455,7 +1455,8 @@ bool resource_build_scaling_params(struct pipe_ct=
x *pipe_ctx)
> >       DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
> >
> >       /* Invalid input */
> > -     if (!plane_state->dst_rect.width ||
> > +     if (!plane_state ||
> > +                     !plane_state->dst_rect.width ||
> >                       !plane_state->dst_rect.height ||
> >                       !plane_state->src_rect.width ||
> >                       !plane_state->src_rect.height) {
>

