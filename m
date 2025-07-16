Return-Path: <stable+bounces-163176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0EDB07B01
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 18:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F147E1C41F57
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC79D2F5C5F;
	Wed, 16 Jul 2025 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G8cLaHYl"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FB32F5326
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682683; cv=none; b=oSTmXkHy/PhobLuP3xCo43QrJ51x2sekQuZKibUvBdREkwT6M2l1Dyl5UYyP749y4cDAy3ZqYkoTHjNMjHH53ksmyW0UcLyGgPqY/D6SrAXbNYHTmmiV8KKh93SRShd0jwoBEUerJgReBfpXG164yroLGlYzE/kES1js+2/kbEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682683; c=relaxed/simple;
	bh=PSBpWZvHiONB6XIHh8Lwy17sfK8030QTvaG6nhruCTc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nWKaI9XvEQufrpXCIWeEhyn4pLXGNOwhzRV3dQOOm5m5bZ0uV4e+2TQG6rKD1fQx22UeHULbuRjzKKGy9BoJU2Pc80gEJKLZ1OQci862oh+TZQddftBnQwCjMkRamAILhAK3/d9TUDmDWL0RHKw/WXc3wgG+1yN8z1tBF2BaqrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G8cLaHYl; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4ab856c0efeso1094521cf.3
        for <stable@vger.kernel.org>; Wed, 16 Jul 2025 09:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752682680; x=1753287480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ir9Dm1iVDlHTBwvNdOyXbTQs6IQAHDlj1oD0nETDHQY=;
        b=G8cLaHYlzXG4kdCwcz7rt8tVC9h7GN1jcYa9lGixpAlbzP8BUUK18CXNloxdg4xWi1
         6lJzszfK87m+u0KnrEsxWYOiKcII2OyLcDKc5zfMlxfPsvUfSM8vSrqINffiFWIuL5I2
         pE91Kd1dz/QjERNZ4q380MA7jxQ1x8wD+rwYaUN5NTJlsw5umjiFr6z6dd7Y7fStCnLj
         mu6H/VSSxicDfA7brkMnkmrzJoqWd/juOFkLfl31wWp8e/Kcqhu4qzYdYjJL7eNtoHVw
         PR57z+mW2XdAWY9USgD5TFamj1fan8vDJctsC3Vr4VARJhYkWvo2Wq/u0QV+yTumBjxJ
         pgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682680; x=1753287480;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ir9Dm1iVDlHTBwvNdOyXbTQs6IQAHDlj1oD0nETDHQY=;
        b=QesAzIsenu22M/lBgHaeq2Aa2Fg33XanTli2pfGp9VJN7FkZMy95zN7FZrnF5RlHcs
         LH93KU16vNewe9cBfEFMQVh3APHNknwzcCZliqR4yt0r+SCrw8plXNM1zNzWPmaMyzPJ
         8XKuaaWQmVoKw7XQQ0Dwr1sp2RyevjqerHP2uBnj0142X8JYrRrYlRgcO/J5lbEWFoFC
         qf9WU8zyWjZSXPen+aCtVajcmyRRIhfYykURITGAsDqQNlVvufHx2c4qz6WtUVJK+Vc7
         rhzwFrSzR0Uxd7cPk1fOE2w53Re/HCeRqoAWhgY+PoTNPG3fSJK/owMVW3OoqhCW5ivQ
         70BA==
X-Forwarded-Encrypted: i=1; AJvYcCXuuI1GeYqaxI9X1zLoR4oYMghySizu/chgv72tvXc2Hl2itVAgcIkp1gW5UMlWZG3XiByap0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAzi1BJwxEBLSyEmo10UX7qB5F5YWeKPybYHs8seokR3bdT0tl
	xJzgLKvy5CoakboNdY12auxHbfYsRAIbwb85dAuQ+2YqiQsMt7hTjORjo3Uhh3atwGDPV9IRImD
	/EkodAwwjqw==
X-Google-Smtp-Source: AGHT+IG9kv7zcxxXhqHYD61hjoxEfyvcBYEDFuMJtskgL4tPmm+bSRk8+1YujdpUvyDf2JW2/N9qNordXZz0
X-Received: from qts19.prod.google.com ([2002:a05:622a:a913:b0:4aa:bba4:8012])
 (user=bgeffon job=prod-delivery.src-stubby-dispatcher) by 2002:ac8:6f0a:0:b0:4ab:6964:7845
 with SMTP id d75a77b69052e-4ab93de8a60mr49263361cf.51.1752682679790; Wed, 16
 Jul 2025 09:17:59 -0700 (PDT)
Date: Wed, 16 Jul 2025 16:17:53 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716161753.231145-1-bgeffon@google.com>
Subject: [PATCH] drm/amdgpu: Raven: don't allow mixing GTT and VRAM
From: Brian Geffon <bgeffon@google.com>
To: Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>, 
	Pratap Nirujogi <pratap.nirujogi@amd.com>, Luben Tuikov <luben.tuikov@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Garrick Evans <garrick@google.com>, 
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, Brian Geffon <bgeffon@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Commit 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v2)")
allowed for newer ASICs to mix GTT and VRAM, this change also noted that
some older boards, such as Stoney and Carrizo do not support this.
It appears that at least one additional ASIC does not support this which
is Raven.

We observed this issue when migrating a device from a 5.4 to 6.6 kernel
and have confirmed that Raven also needs to be excluded from mixing GTT
and VRAM.

Fixes: 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v2)")
Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.1+
Tested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index 73403744331a..5d7f13e25b7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1545,7 +1545,8 @@ uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu=
_device *adev,
 					    uint32_t domain)
 {
 	if ((domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) &&
-	    ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_type =3D=3D CHI=
P_STONEY))) {
+	    ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_type =3D=3D CHI=
P_STONEY) ||
+	     (adev->asic_type =3D=3D CHIP_RAVEN))) {
 		domain =3D AMDGPU_GEM_DOMAIN_VRAM;
 		if (adev->gmc.real_vram_size <=3D AMDGPU_SG_THRESHOLD)
 			domain =3D AMDGPU_GEM_DOMAIN_GTT;
--=20
2.50.0.727.gbf7dc18ff4-goog


