Return-Path: <stable+bounces-200501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1740DCB1855
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 01:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C48253016941
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 00:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6921474CC;
	Wed, 10 Dec 2025 00:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J377Y9ux"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9825417A309
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 00:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765327242; cv=none; b=aLw7YVc0961qiVZ7tIyN9KDo3aH/zDbQLzlYCYQxKATCUtUP49r42vnU3R3IG9LuPKosuPJbzFHMpKoE4j46cMcbeSC9gcvETzEGdRDI2zDOX239CZG7aT5epo3d4izIuI1WdbcgL4ANrYGO09A86ZAQRlN2uybKz+pbG646H/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765327242; c=relaxed/simple;
	bh=9PNNttN5QrtDRNQFq3Gb4Xjm+FCbk8hrM9n0Q77pesU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5fRgX0IDj1o658KUC2JourkgMIZL6mCq+6ef/sGYkBrnWzD/J4yUrX4PfyR0zE+Qv+ouKLQ4Rjv4HfE6NQ4+FbZh6FMZ7FmtBywfEM9V6n6onm8zvkIpuEOyWMCGBafcTnRUbQh0julqbE+uVh3xboF4eDROz0RHCsi4dZNv2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J377Y9ux; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee1e18fb37so57897941cf.0
        for <stable@vger.kernel.org>; Tue, 09 Dec 2025 16:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765327239; x=1765932039; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6wymOcLk7grT72mfA5h3N8IHYwLlfL5lz9NpBSo3BMM=;
        b=J377Y9uxqU35eF4XwjDlKcF014Ii8vd+SMnSffNsfEjfTP7Mv+duciyNHuIa3HhTw7
         OEesILZO/t/SkoxSeH38CfZRhtHFOPArxF2lsoqnhkOWWQIKG+BFuL0xuKifMOje/V3D
         qVKSSjztxpswKU/VSB6snU1aK+P+e9DnbmBW+ur5CYFDOzBIvKsYx7aZs/3k7kIesJp3
         LdZzu0A6D44XgVK+AnyJ/1i6defvHBV4EModW/1L6wHXxPxepbj4yiSWISKsQoCaUjEg
         BAuAjQRPiRw190PUXXzGj3dAogtlmbHN+6FXlARNT9gacS4rS3ifEvYtnRQTB3qpqGrM
         c6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765327239; x=1765932039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wymOcLk7grT72mfA5h3N8IHYwLlfL5lz9NpBSo3BMM=;
        b=KjV7DH7FcpDHbeMptGzMeOUShpILIWhw3Uf9+SQORFxgJKM5ZVtUO/+UNSN77U9P0J
         rRX7VhPo85XBE6S4/xwb8QlXHG778JrZLKY+yuYuka5TI79zQV7cuEhWZVRV0b0HUzt1
         Lve2BuX1GqYp4CLFxtR9DpoEtEophWZMbrnfmQ2B0XJ1TbuUPoGNLXU0ect/Row2kEnS
         NOq/dwGFNV54HL41K6XUYy3En6p5gNoIilYGuQFa//Nko9qlCRCCRQcc7KOW9fb6nWfl
         kjY34cHuNB8bFrbjBI9GJc0U2D2DC1Akm+KSi2i2y0Xy0Ovzugoofqq4sBPfc8F+0N/L
         e1QQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+BHKzPzvqd9pq+QhDKOeyr9JU58LQEBGYUW1dJI2Ps44aXfTBItAmsBOp09JDXQ8J3LcsOAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdbwNYuvmuH0+WX8+U0OnEh2GEtWkllceaYcaMPFSEeapCSk/q
	ms/XpYG2yKLHQ/kASUpdXEc7MIroyab+UkFgBfySQdlvdHsCPqtdNzTwtMha5y/yNPPPoG7pGXD
	fh7e5yWyh3Qb4fE882C++kcp6UbbhsCA=
X-Gm-Gg: ASbGncsesIjffpLcZzDKysRVH+VNjd0/PwJ6qBM62k26INTNp36bc/IK4RuMdh7Blqf
	JyK41SRhRZzhgIKiiJqjuAHtHAg1eDPY1AUq+y2jBGSF51L2jiS3H0GglBU8Pc8bo3WogD0uegH
	DwbP2FPdhjBhQTKHlrE7RIWXGcTbHRR6sm+fF3oQsgGn7Yft4l7zS2g2cCHmlekLdtN0cymFnVO
	p8jDop801jfzQcJQf0PKUPnw2VXinacoaCggcMPDXvY3b6omJUgOWQxjMuV8PbPScQ/q+n8DQ==
X-Google-Smtp-Source: AGHT+IF/YC0wH4HTdXv6pBm0higZhgIr6sri+RQProT90pYcXmiv4UEnt1bnDECpeUGNAkSQJpp1ZNSu2G91t4JCDtM=
X-Received: by 2002:a05:622a:4814:b0:4ed:e0c1:44d5 with SMTP id
 d75a77b69052e-4f1b1a071ccmr9294931cf.19.1765327239484; Tue, 09 Dec 2025
 16:40:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205213156.2847867-1-lyude@redhat.com>
In-Reply-To: <20251205213156.2847867-1-lyude@redhat.com>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 10 Dec 2025 10:40:28 +1000
X-Gm-Features: AQt7F2olu1ewz5U3w0AuR9qHG-FpMcQsFdcic-uQjr_AUIrpcOyV2fiEy8XZ48c
Message-ID: <CAPM=9txpeYNrGEd=KbHe0mLbrG+vucwdQYRMfmcXcXwWoeCkWA@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/dispnv50: Don't call drm_atomic_get_crtc_state()
 in prepare_fb
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, nouveau@lists.freedesktop.org, 
	Faith Ekstrand <faith.ekstrand@collabora.com>, Dave Airlie <airlied@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Ben Skeggs <bskeggs@nvidia.com>, 
	Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Maxime Ripard <mripard@kernel.org>, Danilo Krummrich <dakr@kernel.org>, James Jones <jajones@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Dec 2025 at 07:32, Lyude Paul <lyude@redhat.com> wrote:
>
> Since we recently started warning about uses of this function after the
> atomic check phase completes, we've started getting warnings about this in
> nouveau. It appears a misplaced drm_atomic_get_crtc_state() call has been
> hiding in our .prepare_fb callback for a while.
>
> So, fix this by adding a new nv50_head_atom_get_new() function and use that
> in our .prepare_fb callback instead.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>
> Fixes: 1590700d94ac ("drm/nouveau/kms/nv50-: split each resource type into their own source files")
> Cc: <stable@vger.kernel.org> # v4.18+
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/atom.h | 13 +++++++++++++
>  drivers/gpu/drm/nouveau/dispnv50/wndw.c |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/atom.h b/drivers/gpu/drm/nouveau/dispnv50/atom.h
> index 93f8f4f645784..85b7cf70d13c4 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/atom.h
> +++ b/drivers/gpu/drm/nouveau/dispnv50/atom.h
> @@ -152,8 +152,21 @@ static inline struct nv50_head_atom *
>  nv50_head_atom_get(struct drm_atomic_state *state, struct drm_crtc *crtc)
>  {
>         struct drm_crtc_state *statec = drm_atomic_get_crtc_state(state, crtc);
> +
>         if (IS_ERR(statec))
>                 return (void *)statec;
> +
> +       return nv50_head_atom(statec);
> +}
> +
> +static inline struct nv50_head_atom *
> +nv50_head_atom_get_new(struct drm_atomic_state *state, struct drm_crtc *crtc)
> +{
> +       struct drm_crtc_state *statec = drm_atomic_get_new_crtc_state(state, crtc);
> +
> +       if (IS_ERR(statec))
> +               return (void*)statec;
> +

So I was at kernel summit and someone was talking about AI review
prompts so I threw this patch at it, and it we shouldn't use IS_ERR
here, and I think it is correct.

get_new_crtc_state only returns NULL not an error.

Dave.

