Return-Path: <stable+bounces-144217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6A7AB5C6D
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0195F4A7B40
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F9E2BFC70;
	Tue, 13 May 2025 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVaVTU0S"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544892BFC6F
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747161571; cv=none; b=nI2/5vVTE7TQ6k7HwlnqzEzLPKeEX1/tHLyjBTcCYVUs0yAxzcLrBrVwZCUTjYwiwg6bIchoza/YnMwl2S5ZHDbERjcFJNZCz/3pIlToQcetMqlyYAdQNpcPsE4bmkl0GEWxESctmEwVHVCXsSM/omS0PkXqWIRchRAC61EeUBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747161571; c=relaxed/simple;
	bh=6MlCYK0KC27pJqxhgArtOJiciB1+hKa5thGbK7f5pQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m20uLhuxQohFilb2QPmIwb+k1M2mYLjvsoUVK/zLFBAKVtWwaBgSvo4L0AcmQnqMjFUaeOvCJYqM1mtOLflPBhUf9sQc7R10fKhLu8EI7PCrr4ldUkszVHG5AxdGRMP4RcfrXKpggOdlZYPaYfpmI1NKW70EYXzKP/3Q+2TN0HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVaVTU0S; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22e423394feso7119735ad.1
        for <stable@vger.kernel.org>; Tue, 13 May 2025 11:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747161569; x=1747766369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeSFDgZBgYjm3mhWQLfA97pjPHc8r1eeA74RDgLjocA=;
        b=FVaVTU0SJQFtlkSs9rtJ96x99yQGS8GGVR9zYykzDAarJ6donLrgRad6HtRQfAknoS
         AZe0yapQz3JEIp3ZnJB6ZWQbEDVL2MwXKiDXLwRYAZYiaq2DHOMRA06UagfR/dmJLQUo
         q7+WldbitQvQlkrL8rOaDVT5PMT9CYJHDgPNh/eQ4McUj2dCNX8V+iZo9D8J+3znNsUG
         bDOLO1X2F+N3qHpcjM2JgXXW2nbCDrrTHiX7CjH/mLfwoCvQKhQ0X+qiZNnShWf3UPiA
         gOLERq6+MP1oD96BFVaqJ/LBiO1HOhKIQtC4iYCUlTgBjC08VuIHsu5Gr5L14BVY0UJ5
         Q2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747161569; x=1747766369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeSFDgZBgYjm3mhWQLfA97pjPHc8r1eeA74RDgLjocA=;
        b=A/zzMAk1DuEbj5W1jbv8n8vYrrx5Z0wRJTBtrX9cAOKGpZyTfcoSnLP91I1uXd8e46
         lBusKpy5FDK3eevTHO6GA9uzxXHAXKQ7yl2l+zkLmORvRiTlYxw1MKFW7R2m+hs7Et+U
         8vnOQwD/55SYUxjfNV3slMN5LQ0sXAEEVwkXVT44XvN0ebpynHnUgPqFXiLIexsE78XW
         MrMoCAlMhZLjtzwLqPtUaa4YSF2+MJE2L6wbbPauFv35oI983+SpYFuegZGnJY+Gb/lI
         qji7lMiVVOWbs+85Z5ungCUO47uiFwG9Di1+6336zhmql+Y9ggf0EKbRJdiyFjr+/zbN
         MXPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQuMVoEutfzFeg7+79GDi1966sNHM7LHZNVPSyyQD6gHqULF/upZB6wTWe2K/Uaq7SJanWfpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNgjrjfD9QGP8WTchPG1NEo16t2WMQ3DyVDjHzl9y4E3X31/T9
	CA3djDn0M/kiCpQq5SQB8wdqNOKKFxYdjx3Htyp+t8FLO0kQdlbaeI2XYuX1ZNaEkaDjK7L95IU
	O7iuaE4o4wK39RJG4K1kUzJYVArE=
X-Gm-Gg: ASbGncsMYKuiFHbGuimxTJfHy7cfUXcpGfzhipYuQMKknv3CrtvzqRwvSBTUwm3V8hK
	GxIWxKSARaFEnIlwa1iVT58tc8D+MRiv4H3nbO2KDvo2ceJBYsuGgE0NsUJ4KuoTzN1HA+Firqo
	h1L30N6v9eCkTDMykEwYd4kxC9RFQ6PGa5
X-Google-Smtp-Source: AGHT+IEJVCK9KIRtAfD8UaJbTZhHDynI0APK1xZ+d876UDrwNh149XBJidFcMewCnee5Sc3YLXDrLw/I5Ox03yA5BVk=
X-Received: by 2002:a17:903:248:b0:215:435d:b41a with SMTP id
 d9443c01a7336-231980ce4d3mr2681605ad.1.1747161569573; Tue, 13 May 2025
 11:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513182307.642953-1-David.Wu3@amd.com>
In-Reply-To: <20250513182307.642953-1-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 May 2025 14:39:18 -0400
X-Gm-Features: AX0GCFtd89wE4tDE9Sg1rgrjihi7OvYXBuB8EcJ1TER_zc8KtbZrJNJYjDryxpY
Message-ID: <CADnq5_PGOb9msPRH=-YzRTQp_wCyONqKnXUJRwfAZOW-Y3O=uw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] drm/amdgpu: read back register after written for
 VCN v4.0.5
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, 
	alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com, 
	ruijing.dong@amd.com, stable@vger.kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 2:23=E2=80=AFPM David (Ming Qiang) Wu <David.Wu3@am=
d.com> wrote:
>
> V2: not to add extra read-back in vcn_v4_0_5_start as there is a
>     read-back already. New comment for better understanding.
>
> On VCN v4.0.5 there is a race condition where the WPTR is not
> updated after starting from idle when doorbell is used. The read-back
> of regVCN_RB1_DB_CTRL register after written is to ensure the
> doorbell_index is updated before it can work properly.
>
> Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
> Cc: stable@vger.kernel.org
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index ed00d35039c13..e55b76d71367d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1034,6 +1034,10 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu=
_vcn_inst *vinst,
>                         ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__=
SHIFT |
>                         VCN_RB1_DB_CTRL__EN_MASK);
>
> +       /* Keeping one read-back to ensure all register writes are done, =
otherwise
> +        * it may introduce race conditions */
> +       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
> +
>         return 0;
>  }
>
> --
> 2.34.1
>

