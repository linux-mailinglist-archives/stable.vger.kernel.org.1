Return-Path: <stable+bounces-69866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1595B95AF57
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 09:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B8D2B23356
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 07:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222531537C8;
	Thu, 22 Aug 2024 07:32:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE2CA933;
	Thu, 22 Aug 2024 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724311957; cv=none; b=NtIwH7vb4RshWtcCr90vChBErkW8XQn3rp3ctfJTNn0G8QCanh+8T+YrROhVbes3EfuxAYXKyxgRNHfibJhF/yniP0gSEa1oAwPQZ4PZzfa/kbKoZm84MBhyevBVZTfxBoSCjpwYWq5NTnW+hI843eGkbA4f0QWRttQglGlIf9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724311957; c=relaxed/simple;
	bh=rejtDuSbAAHoI5DORZiSF55Up+/uzv9jWrY6IiPvtRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KoEVRKUcEA4vpT7GUp330IWpmzu+v3jiQlLwN2hdOFRZQTYjyV31VtPPpj2T9RXdbIScf6w7YChOehrjLTnCCBBbfgRNG+8Et8CbRlspI3bCh0zMCOOH57F5lDG5x1yuFkuznzgyrEkb5moAtwzYwEKzM2rW/x6wFfs1k4TfqRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowADHcEB06cZm0tnuCA--.25308S2;
	Thu, 22 Aug 2024 15:32:17 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: alexdeucher@gmail.com
Cc: HaoPing.Liu@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	akpm@linux-foundation.org,
	alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	aurabindo.pillai@amd.com,
	christian.koenig@amd.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	hamza.mahfooz@amd.com,
	joshua@froggi.es,
	linux-kernel@vger.kernel.org,
	make24@iscas.ac.cn,
	marek.olsak@amd.com,
	mwen@igalia.com,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] drm/amd/display: avoid using null object of framebuffer
Date: Thu, 22 Aug 2024 15:32:04 +0800
Message-Id: <20240822073204.1618876-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CADnq5_OzY97etD0LW5Tw-xCnnTYonGkvxA875xdAfMgxAtu_DQ@mail.gmail.com>
References: <CADnq5_OzY97etD0LW5Tw-xCnnTYonGkvxA875xdAfMgxAtu_DQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:zQCowADHcEB06cZm0tnuCA--.25308S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW5ur13tr4DKr4DGrW3Wrg_yoW8CFyDpa
	n3AFyUAr4DZFy2y347CF109FW5KayfKF1xKFWDuw10vw15trnrJrnxGrs7uFs7uFW29w4S
	qFZrZFWS9F1qvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRKCJmDUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Alex Deucher<alexdeucher@gmail.com> wrote:=0D
> On Wed, Aug 21, 2024 at 3:45=E2=80=AFAM Ma Ke <make24@iscas.ac.cn> wrote:=
=0D
> >=0D
> > Instead of using state->fb->obj[0] directly, get object from framebuffe=
r=0D
> > by calling drm_gem_fb_get_obj() and return error code when object is=0D
> > null to avoid using null object of framebuffer.=0D
> >=0D
> > Cc: stable@vger.kernel.org=0D
> > Fixes: 5d945cbcd4b1 ("drm/amd/display: Create a file dedicated to plane=
s")=0D
> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>=0D
> > ---=0D
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 9 +++++++--=
=0D
> >  1 file changed, 7 insertions(+), 2 deletions(-)=0D
> >=0D
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c=0D
> > index a83bd0331c3b..5cb11cc2d063 100644=0D
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c=0D
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c=0D
> > @@ -28,6 +28,7 @@=0D
> >  #include <drm/drm_blend.h>=0D
> >  #include <drm/drm_gem_atomic_helper.h>=0D
> >  #include <drm/drm_plane_helper.h>=0D
> > +#include <drm/drm_gem_framebuffer_helper.h>=0D
> >  #include <drm/drm_fourcc.h>=0D
> >=0D
> >  #include "amdgpu.h"=0D
> > @@ -935,10 +936,14 @@ static int amdgpu_dm_plane_helper_prepare_fb(stru=
ct drm_plane *plane,=0D
> >         }=0D
> >=0D
> >         afb =3D to_amdgpu_framebuffer(new_state->fb);=0D
> > -       obj =3D new_state->fb->obj[0];=0D
> > +       obj =3D drm_gem_fb_get_obj(new_state->fb, 0);=0D
> =0D
> Is it possible for obj to be NULL here?=0D
> =0D
> Alex=0D
Thank you for your response to the vulnerability I submitted. Yes, we =0D
believe there is a similar issue. As described in CVE-2024-41093, the obj =
=0D
will return as NULL and lead to a dereferencing problem, and a similar =0D
issue exists in this code. The discovery of this problem was confirmed =0D
through manual review of the code and compilation testing.=0D
--=0D
Regards,=0D
=0D
Ma Ke=


