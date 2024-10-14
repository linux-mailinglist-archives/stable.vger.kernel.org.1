Return-Path: <stable+bounces-85065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0711699D651
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 20:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E29EB20B29
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 18:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C531C3054;
	Mon, 14 Oct 2024 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0FE16h1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DAD1FAA
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929985; cv=none; b=n5jdXyQ0CQ8WIueHBJRSR5sEshUY3A+tqaUhFsj7M2pYJ2+c6Z1CqEkRai4r5yDUIHfyJvMsNFW8LrTlA3CkOkUQYxkAfpLjAvCK/FR5q366UV76vz/10jlDQ95ogdIyZqBS4+CFWL6N2FpbSzNjqD3jRq4LFxSIHvrjtD2JWso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929985; c=relaxed/simple;
	bh=oPsJFMLSXkGMmnPTiEx9wizj23TeMlu/DLvL6VtQFmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+W4f8hYvsm0/Q07kc/ahvoBPrzPL7Vi3kpkGdJi96pVXrx3V0Pn5YAF1ynp8bI23OJZ6Y9S6wIVxXv9lTH11bLve+yGzsycYFPN5eup1BQkODbkT3OCO5r/tWXbYqE9z6evK84iHSrC3fafu+FSahWAhSQK07o2EugO1mjY3+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0FE16h1; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea3e367ae6so450444a12.1
        for <stable@vger.kernel.org>; Mon, 14 Oct 2024 11:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728929984; x=1729534784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlrhKCqXu/xpOnojqdm6kWdO4bmpewu3VF9AXfLijTA=;
        b=Q0FE16h1/4PSDgGnGNi9u9bQ1ucMdacBoK+xYjDBVGlew5a10YF2ekfbXpS3k9KYu3
         L3yI/NlOLWQg9wkTU3yKp8DhRLKZo48iitNMIim33XaRKUn6tcbFoKccntmgC6xCqIbu
         0EGmj09ORLTmnlC7I6goc9Jb1ATz7evq8G78f5NvJW67Tz7u6fEXRHjwe1y+1689gc0z
         EeODB6RaejGWQYlZT0d2tZO95ZNpNGAoYBwXRX8pDCQZn0E98yTnSy5zhuNfdh0SEGFY
         UY6HRKmkUtS7jQqSmR5nIu8kEAFQF0O5O+0p0zaCZ/SA7DqjJiWPZks839qWfeAsJBt/
         PLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728929984; x=1729534784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlrhKCqXu/xpOnojqdm6kWdO4bmpewu3VF9AXfLijTA=;
        b=lYjWkJ1QXSHBqLO6Xuz5fI1unggoJnr/pkCAXyRiN7oLiyI/s0GKFquoVn8288ZLyI
         2PWSRyyhzrWHOA35t3MGUlH/PUe/GBt7DTG289r4YQwhW22O++GlUHlt+8A4D4u2xqFr
         h6xKWMEbIKmShqrWxVG4q755QiF2pGUWp+kdTjRj+ZKxXLMjvpedtDSAb/pAtq0LBM+1
         4HtYynaTGFItQrRuyts8BZ9R9NOxKsEob5wpnFzdlUEHXqu1fasAcHoWYvkMnVVPvwke
         r0KE5LW9ONpPfRAlmz62+tloh02B5a6rOgmZlxmez2V3PUKui8zLhSPwU/14FY3H+y/2
         htyw==
X-Forwarded-Encrypted: i=1; AJvYcCUPbSAzf27SUyOnqpIXRiR+rGXCBQAYUHFmBuz4goqSJpKiO3dWYOZJS0Y7sVnEwnTw5DhllWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAIT+QOaudLbiecjVtw0pa1pmZZIGSvqAbZrpMVHyT2Z3Xmp35
	R5UZl0zuXlEBInOmLNgm5tuyV515nm6lDPPl+M5ho81OvhliBELhyrMf30uavkdxiCHQjt+cHOX
	PGG8TkXFWfy9w7fKezfXUrVR7qRRz9A==
X-Google-Smtp-Source: AGHT+IHz0iYoNTcR1BPpqWsDc3FeBO9AltozaLKVpLoMJEAcNfz/mFfR4VRrHwFIkXcZ3pqnMjtZLIyHmENWpfVvvgE=
X-Received: by 2002:a17:90b:1d01:b0:2e3:1af7:6ead with SMTP id
 98e67ed59e1d1-2e31af76f40mr4526897a91.5.1728929983645; Mon, 14 Oct 2024
 11:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014160936.24886-1-ville.syrjala@linux.intel.com>
In-Reply-To: <20241014160936.24886-1-ville.syrjala@linux.intel.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Oct 2024 14:19:31 -0400
Message-ID: <CADnq5_NCf4JyP0nVVB0PZrpZa3iJWtV-S1rCfHtM45hgKpEOCg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Fix encoder->possible_clones
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
	amd-gfx@lists.freedesktop.org, stable@vger.kernel.org, 
	Erhard Furtner <erhard_f@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Mon, Oct 14, 2024 at 12:09=E2=80=AFPM Ville Syrjala
<ville.syrjala@linux.intel.com> wrote:
>
> From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>
> Include the encoder itself in its possible_clones bitmask.
> In the past nothing validated that drivers were populating
> possible_clones correctly, but that changed in commit
> 74d2aacbe840 ("drm: Validate encoder->possible_clones").
> Looks like radeon never got the memo and is still not
> following the rules 100% correctly.
>
> This results in some warnings during driver initialization:
> Bogus possible_clones: [ENCODER:46:TV-46] possible_clones=3D0x4 (full enc=
oder mask=3D0x7)
> WARNING: CPU: 0 PID: 170 at drivers/gpu/drm/drm_mode_config.c:615 drm_mod=
e_config_validate+0x113/0x39c
> ...
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: stable@vger.kernel.org
> Fixes: 74d2aacbe840 ("drm: Validate encoder->possible_clones")
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Closes: https://lore.kernel.org/dri-devel/20241009000321.418e4294@yea/
> Tested-by: Erhard Furtner <erhard_f@mailbox.org>
> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> ---
>  drivers/gpu/drm/radeon/radeon_encoders.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_encoders.c b/drivers/gpu/drm/r=
adeon/radeon_encoders.c
> index 0f723292409e..fafed331e0a0 100644
> --- a/drivers/gpu/drm/radeon/radeon_encoders.c
> +++ b/drivers/gpu/drm/radeon/radeon_encoders.c
> @@ -43,7 +43,7 @@ static uint32_t radeon_encoder_clones(struct drm_encode=
r *encoder)
>         struct radeon_device *rdev =3D dev->dev_private;
>         struct radeon_encoder *radeon_encoder =3D to_radeon_encoder(encod=
er);
>         struct drm_encoder *clone_encoder;
> -       uint32_t index_mask =3D 0;
> +       uint32_t index_mask =3D drm_encoder_mask(encoder);
>         int count;
>
>         /* DIG routing gets problematic */
> --
> 2.45.2
>

