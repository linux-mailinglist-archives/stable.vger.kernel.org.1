Return-Path: <stable+bounces-76980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3269843FA
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 12:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028BD2885EB
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 10:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA2F1A3A9A;
	Tue, 24 Sep 2024 10:48:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from MSK-MAILEDGE.securitycode.ru (msk-mailedge.securitycode.ru [195.133.217.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018E919E972;
	Tue, 24 Sep 2024 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.217.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174889; cv=none; b=iKMPpfM1o68a6NfObiVK70iDlJOgLXXleYaC994vQoA7mWFexFPRxu0ZdQ4zzeR5KfqIIabuLpJciKtaY31Klt4ZlqUKcKi5fHNXd353hDBjyBMOEwSGB/AIAA3Y8Q1nzvEOBdBdukZL6DVGEE6TGZ6z5mNi2IIEfBQ48rJYfp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174889; c=relaxed/simple;
	bh=GKn+W0VDsGgKD/6+iLR+VS9JVxXQWyiz/c9pZjsf4Dw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JNrjexjb9OcM0PAtETmBvZYd7H1WEkUGLF96uvwWKzKBrgv7mCR5v71wdaXYxX/X7hUYzaIX+8aqHTIMeJaAS4bbB7UgKZuC7I4LmL4Waz7xugaUvKzyj+GkBnVKQbNwAb3VCFCrN8BH2nyOpVnvuFqpHyHe38FD1RVHvWyRZG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=securitycode.ru; spf=pass smtp.mailfrom=securitycode.ru; arc=none smtp.client-ip=195.133.217.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=securitycode.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=securitycode.ru
From: George Rurikov <g.ryurikov@securitycode.ru>
To: Jani Nikula <jani.nikula@linux.intel.com>
CC: George Rurikov <g.ryurikov@securitycode.ru>, Rodrigo Vivi
	<rodrigo.vivi@intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, <intel-gfx@lists.freedesktop.org>,
	<intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.og>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH] drm: Add check for encoder in intel_get_crtc_new_encoder()
Date: Tue, 24 Sep 2024 13:47:22 +0300
Message-ID: <20240924104722.1049588-1-g.ryurikov@securitycode.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SPB-EX2.Securitycode.ru (172.16.24.92) To
 MSK-EX2.Securitycode.ru (172.17.8.92)

If the video card driver could not find the connector assigned to the
current video controller, or if the hardware status has changed so that
a pre-existing connector is no longer active, none of the state
connectors will meet the assignment criteria for the current crtc video
controller.

In the drm_WARN function, encoder->base.dev is called, so
'&encoder->base.dev' will be dereferenced since encoder will still be
initialized NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e12d6218fda2 ("drm/i915: Reduce bigjoiner special casing")
Cc: stable@vger.kernel.org
Signed-off-by: George Rurikov <g.ryurikov@securitycode.ru>
---
 drivers/gpu/drm/i915/display/intel_display.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm=
/i915/display/intel_display.c
index b4ef4d59da1a..a5e24d64f909 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -819,9 +819,10 @@ intel_get_crtc_new_encoder(const struct intel_atomic_s=
tate *state,
                num_encoders++;
        }

-       drm_WARN(state->base.dev, num_encoders !=3D 1,
-                "%d encoders for pipe %c\n",
-                num_encoders, pipe_name(primary_crtc->pipe));
+       if (encoder)
+               drm_WARN(state->base.dev, num_encoders !=3D 1,
+                       "%d encoders for pipe %c\n",
+                       num_encoders, pipe_name(primary_crtc->pipe));

        return encoder;
 }
--
2.34.1

=D0=97=D0=B0=D1=8F=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BE =D0=BA=D0=BE=
=D0=BD=D1=84=D0=B8=D0=B4=D0=B5=D0=BD=D1=86=D0=B8=D0=B0=D0=BB=D1=8C=D0=BD=D0=
=BE=D1=81=D1=82=D0=B8

=D0=94=D0=B0=D0=BD=D0=BD=D0=BE=D0=B5 =D1=8D=D0=BB=D0=B5=D0=BA=D1=82=D1=80=
=D0=BE=D0=BD=D0=BD=D0=BE=D0=B5 =D0=BF=D0=B8=D1=81=D1=8C=D0=BC=D0=BE =D0=B8 =
=D0=BB=D1=8E=D0=B1=D1=8B=D0=B5 =D0=BF=D1=80=D0=B8=D0=BB=D0=BE=D0=B6=D0=B5=
=D0=BD=D0=B8=D1=8F =D0=BA =D0=BD=D0=B5=D0=BC=D1=83 =D1=8F=D0=B2=D0=BB=D1=8F=
=D1=8E=D1=82=D1=81=D1=8F =D0=BA=D0=BE=D0=BD=D1=84=D0=B8=D0=B4=D0=B5=D0=BD=
=D1=86=D0=B8=D0=B0=D0=BB=D1=8C=D0=BD=D1=8B=D0=BC=D0=B8 =D0=B8 =D0=BF=D1=80=
=D0=B5=D0=B4=D0=BD=D0=B0=D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=D1=8B =D0=B8=
=D1=81=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE =
=D0=B4=D0=BB=D1=8F =D0=B0=D0=B4=D1=80=D0=B5=D1=81=D0=B0=D1=82=D0=B0. =D0=95=
=D1=81=D0=BB=D0=B8 =D0=92=D1=8B =D0=BD=D0=B5 =D1=8F=D0=B2=D0=BB=D1=8F=D0=B5=
=D1=82=D0=B5=D1=81=D1=8C =D0=B0=D0=B4=D1=80=D0=B5=D1=81=D0=B0=D1=82=D0=BE=
=D0=BC =D0=B4=D0=B0=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE =D0=BF=D0=B8=D1=81=D1=8C=
=D0=BC=D0=B0, =D0=BF=D0=BE=D0=B6=D0=B0=D0=BB=D1=83=D0=B9=D1=81=D1=82=D0=B0,=
 =D1=83=D0=B2=D0=B5=D0=B4=D0=BE=D0=BC=D0=B8=D1=82=D0=B5 =D0=BD=D0=B5=D0=BC=
=D0=B5=D0=B4=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE =D0=BE=D1=82=D0=BF=D1=80=D0=B0=
=D0=B2=D0=B8=D1=82=D0=B5=D0=BB=D1=8F, =D0=BD=D0=B5 =D1=80=D0=B0=D1=81=D0=BA=
=D1=80=D1=8B=D0=B2=D0=B0=D0=B9=D1=82=D0=B5 =D1=81=D0=BE=D0=B4=D0=B5=D1=80=
=D0=B6=D0=B0=D0=BD=D0=B8=D0=B5 =D0=B4=D1=80=D1=83=D0=B3=D0=B8=D0=BC =D0=BB=
=D0=B8=D1=86=D0=B0=D0=BC, =D0=BD=D0=B5 =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=
=D0=B7=D1=83=D0=B9=D1=82=D0=B5 =D0=B5=D0=B3=D0=BE =D0=B2 =D0=BA=D0=B0=D0=BA=
=D0=B8=D1=85-=D0=BB=D0=B8=D0=B1=D0=BE =D1=86=D0=B5=D0=BB=D1=8F=D1=85, =D0=
=BD=D0=B5 =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D0=B8 =D0=BD=D0=B5 =
=D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D1=83=D0=B9=D1=82=D0=B5 =D0=B8=D0=BD=D1=84=
=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8E =D0=BB=D1=8E=D0=B1=D1=8B=D0=BC =
=D1=81=D0=BF=D0=BE=D1=81=D0=BE=D0=B1=D0=BE=D0=BC.

