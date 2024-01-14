Return-Path: <stable+bounces-10843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC76982D0AE
	for <lists+stable@lfdr.de>; Sun, 14 Jan 2024 14:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F987B2139C
	for <lists+stable@lfdr.de>; Sun, 14 Jan 2024 13:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B0E210D;
	Sun, 14 Jan 2024 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b="JfpNLtjS"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2A6374
	for <stable@vger.kernel.org>; Sun, 14 Jan 2024 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705237232; x=1705842032; i=friedrich.vock@gmx.de;
	bh=d1EiUqV9QNyVLSuVVI3goT61s5eVAetbj4p77LRXWjE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=JfpNLtjSThnpRTkC9dABYSuAAOVXtg5vNsQ/SsXvHxpDrWk0XxFfdatGPBFdVspU
	 eZBsPFqgNC1Z0JU3ajTLQNTgkw4A4M95q7w55RRQK7GlIMXqoAQzzi2i72wYeRqv8
	 mPc5KCzo6JjR70M9b/+qCdmodx38zfcTGSesLmSMyF+g+wFcjcStwLZ/CZn/SYxHI
	 i9vdplzoEQb+cJtWkrmftdud76FZIXPTM0X1NKnuSwtQjhz+PJCTtSwKOLcKpx0um
	 y99BKh7+5G6UUd638kHK54GKo53+5KdX8p2Z9S0PCRVZ7r6b948sr+4zNC6dzkmez
	 fSd5i4lq72lz0Kk52w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from arch.fritz.box ([213.152.118.80]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjjCL-1qiGUN1j8F-00lGC4; Sun, 14
 Jan 2024 14:00:32 +0100
From: Friedrich Vock <friedrich.vock@gmx.de>
To: amd-gfx@lists.freedesktop.org
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
	Joshua Ashton <joshua@froggi.es>,
	Alex Deucher <alexander.deucher@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit after writing rptr
Date: Sun, 14 Jan 2024 14:00:07 +0100
Message-ID: <20240114130008.868941-1-friedrich.vock@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I89wkvWOgo5HXeIHYqjPGj6cncUsKZ0qpmRAa9jHLxqwyTFv7bc
 2Xm/asuzNmS+wQb9rR0RGvP8l+mIG7ynXiSr3nCf0iq9SgA4V8lTqbsF+FayfKl5irviCzC
 5245H8sv/B64wHHuhLMvHkDqh8F0D9kAd6xRFNRZTrzqBZifhEUo0hEZqREC0aNNpiS/9c0
 mxcB92F/LLaXlzObjTcBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W/K3HoVEOH4=;FFzn3RUnSaVlpid0WALdKXC93fB
 jTsUjZHDQsbmGo3WGro0IphHkxlACEXEYGdaupb7PlQ7l+blkUJyG0kuugV4tw2xMg99uSCXz
 LeEFHAPI2Vq0fj4vSB9EqGm5srqSt2BKShBKwi0dizKCJXGMj5vs1WzwfMkYpgwcLATNJaPbQ
 J35AKcZdGUGXgvH+rQwo7u0yNkuCY19f5WIBuwbj0RRp1a/Q9xOG1UpoDFGmFi08E4PLsWkAQ
 4UIaQPi7e1v7mOvLgS4VKN77lcsWK7nuxHrGzcutitdU7y82SzOfhkpMhn++YvGWffuQYgsS2
 cS2nrsFuDhhyA+XdvTPIy+NQByipOXphpgfQXWJTdIdkbB+ieid/2mPVue+f04MWoH674gjLP
 8fKqmxp682tr+hJ5LJJK+yF9M0qQ5dj9D2+5s/N8zYwJZQVl0INGcmJeNL0XhnEcEugq58D1v
 drL2jyGi6vNYJ4r2HwwYh0PnguPZ6ykuHyZUhfOMnh7ZLCj2zVpmzoEm1ZnVdca+YfUGiRJIb
 UdYVV4f0YuItSLrhvFHAsUvGgEwHatTCTru9BOCh9P8R3ZzmOn0Z7P/P6mOXA82z29e69FJxg
 9b9gZTMZB0VAcFNEHL11OBto7HavDGMLGx9eoCA+dZMGHnGoFL7x1flENzbItGKVfPApmaMGK
 3Kaqf2KhPxGXLgQLGn8QXqofZ66yeW9MPBes7la2FRu4Caf8PJKdLiBaR4RmZTiwltP9+g0ry
 LdhIkcXY6RGEL68htVK6fQex4LD6uRN3NEvkSVslsbAVFKFr73z4fHoVeu5ib2hNjEoLiUN5Q
 3qHmLu8w0oPR53Jpndpx/NkYa30XQ4cJ83F6yU0tpEWaXykYq26pYAP5IGRjG9mcGFWzbNyyt
 DWKlDIjpL88hY4/+GtMI0m6Yg+/hFH1hWAp5pu/p56JEdw0RFvrdDIJ+/sUt7aoMOnqK2HCuD
 wrXFKTvV/UDD3A7wDozx5Lw/pC4=

Allows us to detect subsequent IH ring buffer overflows as well.

Cc: Joshua Ashton <joshua@froggi.es>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  |  2 ++
 drivers/gpu/drm/amd/amdgpu/cik_ih.c     | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/cz_ih.c      | 14 +++++++++++++-
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 14 +++++++++++++-
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c    | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c    | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c  | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/si_ih.c      | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c   | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c  | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 12 ++++++++++++
 11 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ih.h
index 508f02eb0cf8..6041ec727f06 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -69,6 +69,8 @@ struct amdgpu_ih_ring {
 	unsigned		rptr;
 	struct amdgpu_ih_regs	ih_regs;

+	bool overflow;
+
 	/* For waiting on IH processing at checkpoint. */
 	wait_queue_head_t wait_process;
 	uint64_t		processed_timestamp;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amd=
gpu/cik_ih.c
index 6f7c031dd197..807cc30c9e33 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -204,6 +204,7 @@ static u32 cik_ih_get_wptr(struct amdgpu_device *adev,
 		tmp =3D RREG32(mmIH_RB_CNTL);
 		tmp |=3D IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
 		WREG32(mmIH_RB_CNTL, tmp);
+		ih->overflow =3D true;
 	}
 	return (wptr & ih->ptr_mask);
 }
@@ -274,7 +275,19 @@ static void cik_ih_decode_iv(struct amdgpu_device *ad=
ev,
 static void cik_ih_set_rptr(struct amdgpu_device *adev,
 			    struct amdgpu_ih_ring *ih)
 {
+	u32 tmp;
+
 	WREG32(mmIH_RB_RPTR, ih->rptr);
+
+	/* If we overflowed previously (and thus set the OVERFLOW_CLEAR bit),
+	 * reset it here to detect more overflows if they occur.
+	 */
+	if (ih->overflow) {
+		tmp =3D RREG32(mmIH_RB_CNTL);
+		tmp &=3D ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
+		WREG32(mmIH_RB_CNTL, tmp);
+		ih->overflow =3D false;
+	}
 }

 static int cik_ih_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdg=
pu/cz_ih.c
index b8c47e0cf37a..076559668573 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -215,7 +215,7 @@ static u32 cz_ih_get_wptr(struct amdgpu_device *adev,
 	tmp =3D RREG32(mmIH_RB_CNTL);
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32(mmIH_RB_CNTL, tmp);
-
+	ih->overflow =3D true;

 out:
 	return (wptr & ih->ptr_mask);
@@ -266,7 +266,19 @@ static void cz_ih_decode_iv(struct amdgpu_device *ade=
v,
 static void cz_ih_set_rptr(struct amdgpu_device *adev,
 			   struct amdgpu_ih_ring *ih)
 {
+	u32 tmp;
+
 	WREG32(mmIH_RB_RPTR, ih->rptr);
+
+	/* If we overflowed previously (and thus set the OVERFLOW_CLEAR bit),
+	 * reset it here to detect more overflows if they occur.
+	 */
+	if (ih->overflow) {
+		tmp =3D RREG32(mmIH_RB_CNTL);
+		tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+		WREG32(mmIH_RB_CNTL, tmp);
+		ih->overflow =3D false;
+	}
 }

 static int cz_ih_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd=
/amdgpu/iceland_ih.c
index aecad530b10a..1a5e668643d1 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -214,7 +214,7 @@ static u32 iceland_ih_get_wptr(struct amdgpu_device *a=
dev,
 	tmp =3D RREG32(mmIH_RB_CNTL);
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32(mmIH_RB_CNTL, tmp);
-
+	ih->overflow =3D true;

 out:
 	return (wptr & ih->ptr_mask);
@@ -265,7 +265,19 @@ static void iceland_ih_decode_iv(struct amdgpu_device=
 *adev,
 static void iceland_ih_set_rptr(struct amdgpu_device *adev,
 				struct amdgpu_ih_ring *ih)
 {
+	u32 tmp;
+
 	WREG32(mmIH_RB_RPTR, ih->rptr);
+
+	/* If we overflowed previously (and thus set the OVERFLOW_CLEAR bit),
+	 * reset it here to detect more overflows if they occur.
+	 */
+	if (ih->overflow) {
+		tmp =3D RREG32(mmIH_RB_CNTL);
+		tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+		WREG32(mmIH_RB_CNTL, tmp);
+		ih->overflow =3D false;
+	}
 }

 static int iceland_ih_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/ih_v6_0.c
index d9ed7332d805..ce8f7feec713 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -418,6 +418,8 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *adev=
,
 	tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+	ih->overflow =3D true;
+
 out:
 	return (wptr & ih->ptr_mask);
 }
@@ -459,6 +461,7 @@ static void ih_v6_0_irq_rearm(struct amdgpu_device *ad=
ev,
 static void ih_v6_0_set_rptr(struct amdgpu_device *adev,
 			       struct amdgpu_ih_ring *ih)
 {
+	u32 tmp;
 	struct amdgpu_ih_regs *ih_regs;

 	if (ih->use_doorbell) {
@@ -472,6 +475,16 @@ static void ih_v6_0_set_rptr(struct amdgpu_device *ad=
ev,
 		ih_regs =3D &ih->ih_regs;
 		WREG32(ih_regs->ih_rb_rptr, ih->rptr);
 	}
+
+	/* If we overflowed previously (and thus set the OVERFLOW_CLEAR bit),
+	 * reset it here to detect more overflows if they occur.
+	 */
+	if (ih->overflow) {
+		tmp =3D RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
+		tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+		WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
+		ih->overflow =3D false;
+	}
 }

 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/am=
dgpu/ih_v6_1.c
index 8fb05eae340a..668788ad34d9 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -418,6 +418,8 @@ static u32 ih_v6_1_get_wptr(struct amdgpu_device *adev=
,
 	tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+	ih->overflow =3D true;
+
 out:
 	return (wptr & ih->ptr_mask);
 }
@@ -459,6 +461,7 @@ static void ih_v6_1_irq_rearm(struct amdgpu_device *ad=
ev,
 static void ih_v6_1_set_rptr(struct amdgpu_device *adev,
 			       struct amdgpu_ih_ring *ih)
 {
+	u32 tmp;
 	struct amdgpu_ih_regs *ih_regs;

 	if (ih->use_doorbell) {
@@ -472,6 +475,16 @@ static void ih_v6_1_set_rptr(struct amdgpu_device *ad=
ev,
 		ih_regs =3D &ih->ih_regs;
 		WREG32(ih_regs->ih_rb_rptr, ih->rptr);
 	}
+
+	/* If we overflowed previously (and thus set the OVERFLOW_CLEAR bit),
+	 * reset it here to detect more overflows if they occur.
+	 */
+	if (ih->overflow) {
+		tmp =3D RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
+		tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+		WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
+		ih->overflow =3D false;
+	}
 }

 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/=
amdgpu/navi10_ih.c
index e64b33115848..0bdac923cb4d 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -442,6 +442,7 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *ad=
ev,
 	tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+	ih->overflow =3D true;
 out:
 	return (wptr & ih->ptr_mask);
 }
@@ -483,6 +484,7 @@ static void navi10_ih_irq_rearm(struct amdgpu_device *=
adev,
 static void navi10_ih_set_rptr(struct amdgpu_device *adev,
 			       struct amdgpu_ih_ring *ih)
 {
+	u32 tmp;
 	struct amdgpu_ih_regs *ih_regs;

 	if (ih =3D=3D &adev->irq.ih_soft)
@@ -499,6 +501,16 @@ static void navi10_ih_set_rptr(struct amdgpu_device *=
adev,
 		ih_regs =3D &ih->ih_regs;
 		WREG32(ih_regs->ih_rb_rptr, ih->rptr);
 	}
+
+	/* If we overflowed previously (and thus set the OVERFLOW_CLEAR bit),
+	 * reset it here to detect more overflows if they occur.
+	 */
+	if (ih->overflow) {
+		tmp =3D RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
+		tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+		WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
+		ih->overflow =3D false;
+	}
 }

 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdg=
pu/si_ih.c
index 9a24f17a5750..ff35056d2b54 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -119,6 +119,7 @@ static u32 si_ih_get_wptr(struct amdgpu_device *adev,
 		tmp =3D RREG32(IH_RB_CNTL);
 		tmp |=3D IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
 		WREG32(IH_RB_CNTL, tmp);
+		ih->overflow =3D true;
 	}
 	return (wptr & ih->ptr_mask);
 }
@@ -147,7 +148,18 @@ static void si_ih_decode_iv(struct amdgpu_device *ade=
v,
 static void si_ih_set_rptr(struct amdgpu_device *adev,
 			   struct amdgpu_ih_ring *ih)
 {
+	u32 tmp;
+
 	WREG32(IH_RB_RPTR, ih->rptr);
+
+	/* If we overflowed previously (and thus set the OVERFLOW_CLEAR bit),
+	 * reset it here to detect more overflows if they occur.
+	 */
+	if (ih->overflow) {
+		tmp =3D RREG32(IH_RB_CNTL);
+		tmp &=3D ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
+		WREG32(IH_RB_CNTL, tmp);
+	}
 }

 static int si_ih_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/tonga_ih.c
index 917707bba7f3..6f5090d3db48 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -218,6 +218,7 @@ static u32 tonga_ih_get_wptr(struct amdgpu_device *ade=
v,
 	tmp =3D RREG32(mmIH_RB_CNTL);
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32(mmIH_RB_CNTL, tmp);
+	ih->overflow =3D true;

 out:
 	return (wptr & ih->ptr_mask);
@@ -268,6 +269,8 @@ static void tonga_ih_decode_iv(struct amdgpu_device *a=
dev,
 static void tonga_ih_set_rptr(struct amdgpu_device *adev,
 			      struct amdgpu_ih_ring *ih)
 {
+	u32 tmp;
+
 	if (ih->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
 		*ih->rptr_cpu =3D ih->rptr;
@@ -275,6 +278,16 @@ static void tonga_ih_set_rptr(struct amdgpu_device *a=
dev,
 	} else {
 		WREG32(mmIH_RB_RPTR, ih->rptr);
 	}
+
+	/* If we overflowed previously (and thus set the OVERFLOW_CLEAR bit),
+	 * reset it here to detect more overflows if they occur.
+	 */
+	if (ih->overflow) {
+		tmp =3D RREG32(mmIH_RB_CNTL);
+		tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+		WREG32(mmIH_RB_CNTL, tmp);
+		ih->overflow =3D false;
+	}
 }

 static int tonga_ih_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/=
amdgpu/vega10_ih.c
index d364c6dd152c..bb005924f194 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -372,6 +372,7 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *ad=
ev,
 	tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+	ih->overflow =3D true;

 out:
 	return (wptr & ih->ptr_mask);
@@ -413,6 +414,7 @@ static void vega10_ih_irq_rearm(struct amdgpu_device *=
adev,
 static void vega10_ih_set_rptr(struct amdgpu_device *adev,
 			       struct amdgpu_ih_ring *ih)
 {
+	u32 tmp;
 	struct amdgpu_ih_regs *ih_regs;

 	if (ih =3D=3D &adev->irq.ih_soft)
@@ -429,6 +431,16 @@ static void vega10_ih_set_rptr(struct amdgpu_device *=
adev,
 		ih_regs =3D &ih->ih_regs;
 		WREG32(ih_regs->ih_rb_rptr, ih->rptr);
 	}
+
+	/* If we overflowed previously (and thus set the OVERFLOW_CLEAR bit),
+	 * reset it here to detect more overflows if they occur.
+	 */
+	if (ih->overflow) {
+		tmp =3D RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
+		tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+		WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
+		ih->overflow =3D false;
+	}
 }

 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/=
amdgpu/vega20_ih.c
index ddfc6941f9d5..bb725a970697 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -420,6 +420,7 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *ad=
ev,
 	tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+	ih->overflow =3D true;

 out:
 	return (wptr & ih->ptr_mask);
@@ -462,6 +463,7 @@ static void vega20_ih_irq_rearm(struct amdgpu_device *=
adev,
 static void vega20_ih_set_rptr(struct amdgpu_device *adev,
 			       struct amdgpu_ih_ring *ih)
 {
+	u32 tmp;
 	struct amdgpu_ih_regs *ih_regs;

 	if (ih =3D=3D &adev->irq.ih_soft)
@@ -478,6 +480,16 @@ static void vega20_ih_set_rptr(struct amdgpu_device *=
adev,
 		ih_regs =3D &ih->ih_regs;
 		WREG32(ih_regs->ih_rb_rptr, ih->rptr);
 	}
+
+	/* If we overflowed previously (and thus set the OVERFLOW_CLEAR bit),
+	 * reset it here to detect more overflows if they occur.
+	 */
+	if (ih->overflow) {
+		tmp =3D RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
+		tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+		WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
+		ih->overflow =3D false;
+	}
 }

 /**
=2D-
2.43.0


