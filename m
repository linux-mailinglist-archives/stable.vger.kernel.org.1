Return-Path: <stable+bounces-15518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2D6838DF5
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20CF91F24976
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 11:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16935D8FD;
	Tue, 23 Jan 2024 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b="VxGxDJ9q"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E32C5DF2E
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010768; cv=none; b=IVcyD75LpTTmslPPy7qaYcw7uXK576ejIa1xITAY8M3gm0ECTV1xwIDSfix9DxWWaXPcbbQsHkD9cwY2qieiAzfaywrrAK9aYos6xfdEBOdScBTviylPOFuXrQuzuHPAeTAgSEShyXF5bnPj3lY7rStFtXdHJQJPomBAbyvHWSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010768; c=relaxed/simple;
	bh=cwcjso3Z/1ljSMStOJYtqB+TdJ5pj+fRWg85INUhxG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ovsflhusAsHdWn0ujkNNeP9+6aYzv1TD75xpu4XafMmBCoh++WuP4lxLgKEqjX7FUSkCPUuOih3uuPI4DvCGgK0q3R+It5cSEwFEN3sfmQlVUzxl9zu/8H61WMszi/xyUFKrlNbLyZle+w0bt/KE5j5sVGtqUUoy/dqZ80Ly23s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b=VxGxDJ9q; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706010758; x=1706615558; i=friedrich.vock@gmx.de;
	bh=cwcjso3Z/1ljSMStOJYtqB+TdJ5pj+fRWg85INUhxG4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=VxGxDJ9q5RadEMNJ32NjYacY51EAAk2p3hJBqJ2UkAj3bqtz4RHeybMhc0Kp6vNB
	 BAkLmqDs5VbL72AgJR6Bzcer9VOoAnL2770g3YFxnZ4CIfvGweDUXza8ia+HSzOZk
	 C2e11oXLBXHTZWFllIAViHHWuam3o/qUtOwRoMiMDSESFsc0dT/GQI6b9tEYNpR8P
	 JXPQSvJLI3WBZln0L3sXGntOY/uuh+YefOSW5IWzd1shkwMrkpze6XnpPq44RrxJD
	 WqIHByw0AI4Y0nJPjkzdCOMKTV5SwBdjVm31Qfd2ZAe7tcs18AYLnecFWXqtFM2g0
	 oGZ31HnavrLA5VGyMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from arch.fritz.box ([213.152.113.218]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McpJg-1qsMY00gSI-00a0Lv; Tue, 23
 Jan 2024 12:52:38 +0100
From: Friedrich Vock <friedrich.vock@gmx.de>
To: amd-gfx@lists.freedesktop.org
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
	Joshua Ashton <joshua@froggi.es>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit
Date: Tue, 23 Jan 2024 12:52:03 +0100
Message-ID: <20240123115204.194523-1-friedrich.vock@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aYUxQODG1TlDJmbcbFJ3D84T7gAHRpnmK7s1FzZLroGF6P/K4fW
 D7HYgOEORs2m8lo0uqUcfFXGnD9cN/CeqdW8WqaZ9swGlK8HdbfiXW1DqvKJmPsOpeyUpOL
 bMy6qJtD00Awzw3WysZtlcyKZ1Bhjc0ceuIcqV03Ii6fFQQ4+0jj9UAJoYbewhsJfVRtQTV
 8VozNcb7gAt+44o+N6bEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:czmb2BuU+Mc=;HxDwRL62l1uHuxXfqLCSc1OkFuc
 dtUw6bJJpDZ4MHQ6yDOJA2a8mfXITXs/C5Oy5ljDjQDOE+70sEwOi3+qUC1gkQhpkhQfh5oCN
 OuVOijjFqyODiyR6TLhBycSmipycoYP0WdGfZCWGaNVxardjg5fuitZ6I5Aja+AGSZcvqgx1/
 uzcZ8QtbrdZzVLLXV6iaJtaodIXWfLduG7raHIS5jPUgNy2CLA4Z69E8HupxMOQghuQBzFKaZ
 GeRE6CJqTQTaI7igTsgHiqHkb5cbb2jatW2oMRu8ER2oSeLcs15PLvxM+EB6H+sUniaf3WG7o
 Ls2Ppxxs1PcAIfeJaytA4B1wLsbYMRgcw3yJVtIy0EzKoWnbndSYV2W3QjwvG2+TKFn6TSlTq
 ofV2PC/bDej3nsgoK962/gyRIsQMpD9RpBb+85jFz4qF7oCpEhxqkPuH2JayYYE/tMVZ0WH54
 I13bo4afDc7LujytG4HoP5dI21qClM+x0TSTLR7ZWx80E4Jvci1dKnzzT2qYwFUTmUT4B9uUJ
 HrphE9Dr+yAbQpnKo8exR2JJiSIjpn8hcMGPzOn4vnqCgCiIV6vhiHemtpzl5o1fD09sK4cus
 LWYyOhH7FFfgAGq18ih+64Xg74fVvTmBpXHC3HGZEQhxt16EueiKvCjfXb57gyw5LMB1RCM0T
 urux6EjXhk63B8swsVNnXriDBYmtY5Q0S9S1+5zmvdxX4Fz9DjzfEHBsj1G4N+FPxZkaKhCS1
 4zPfxsa+dvjrsIEOti3+J7BFhB41ro8WDgSrd0n1K82cgcEF1YAQYXGCXWNiNQeWk1HstWwaF
 Jzux2WuH+5B7cB2th274WGS1dvuZtM+CQQN9sT3EQHNF866bls+80Xj/NdYEP2XU3Msy0j7ob
 XFLfzbIsEVOxhs+r4Q8E7iltSaI50l6tnqPfQy/hRVwtTyt7ccJdaearH8Mi8mDy8wvD8kCyC
 dCWEkMhheG9JxQYuGIv+/72taQQ=

Allows us to detect subsequent IH ring buffer overflows as well.

Cc: Joshua Ashton <joshua@froggi.es>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
Cc: stable@vger.kernel.org

Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
=2D--
v2: Reset CLEAR_OVERFLOW bit immediately after setting it
v3: Move everything related to fence processing on overflow to patch 2

 drivers/gpu/drm/amd/amdgpu/cik_ih.c     | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/cz_ih.c      | 5 +++++
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c    | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c    | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c  | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/si_ih.c      | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c   | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c  | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 6 ++++++
 10 files changed, 59 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amd=
gpu/cik_ih.c
index 6f7c031dd197..f24e34dc33d1 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -204,6 +204,12 @@ static u32 cik_ih_get_wptr(struct amdgpu_device *adev=
,
 		tmp =3D RREG32(mmIH_RB_CNTL);
 		tmp |=3D IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
 		WREG32(mmIH_RB_CNTL, tmp);
+
+		/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+		 * can be detected.
+		 */
+		tmp &=3D ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
+		WREG32(mmIH_RB_CNTL, tmp);
 	}
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdg=
pu/cz_ih.c
index b8c47e0cf37a..c19681492efa 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -216,6 +216,11 @@ static u32 cz_ih_get_wptr(struct amdgpu_device *adev,
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32(mmIH_RB_CNTL, tmp);

+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32(mmIH_RB_CNTL, tmp);

 out:
 	return (wptr & ih->ptr_mask);
diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd=
/amdgpu/iceland_ih.c
index aecad530b10a..2c02ae69883d 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -215,6 +215,11 @@ static u32 iceland_ih_get_wptr(struct amdgpu_device *=
adev,
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32(mmIH_RB_CNTL, tmp);

+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32(mmIH_RB_CNTL, tmp);

 out:
 	return (wptr & ih->ptr_mask);
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/ih_v6_0.c
index d9ed7332d805..ad4ad39f128f 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -418,6 +418,12 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *ade=
v,
 	tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+
+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
 out:
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/am=
dgpu/ih_v6_1.c
index 8fb05eae340a..b8da0fc29378 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -418,6 +418,13 @@ static u32 ih_v6_1_get_wptr(struct amdgpu_device *ade=
v,
 	tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+
+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+
 out:
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/=
amdgpu/navi10_ih.c
index e64b33115848..de93614726c9 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -442,6 +442,12 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *a=
dev,
 	tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+
+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
 out:
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdg=
pu/si_ih.c
index 9a24f17a5750..cada9f300a7f 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -119,6 +119,12 @@ static u32 si_ih_get_wptr(struct amdgpu_device *adev,
 		tmp =3D RREG32(IH_RB_CNTL);
 		tmp |=3D IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
 		WREG32(IH_RB_CNTL, tmp);
+
+		/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+		 * can be detected.
+		 */
+		tmp &=3D ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
+		WREG32(IH_RB_CNTL, tmp);
 	}
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/tonga_ih.c
index 917707bba7f3..450b6e831509 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -219,6 +219,12 @@ static u32 tonga_ih_get_wptr(struct amdgpu_device *ad=
ev,
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32(mmIH_RB_CNTL, tmp);

+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32(mmIH_RB_CNTL, tmp);
+
 out:
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/=
amdgpu/vega10_ih.c
index d364c6dd152c..bf68e18e3824 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -373,6 +373,12 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *a=
dev,
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);

+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+
 out:
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/=
amdgpu/vega20_ih.c
index ddfc6941f9d5..db66e6cccaf2 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -421,6 +421,12 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *a=
dev,
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);

+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+
 out:
 	return (wptr & ih->ptr_mask);
 }
=2D-
2.43.0


