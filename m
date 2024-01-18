Return-Path: <stable+bounces-12209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 798B4831F63
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 19:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010B91F24042
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 18:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E822E3F3;
	Thu, 18 Jan 2024 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b="mDkpa7hX"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46172D629
	for <stable@vger.kernel.org>; Thu, 18 Jan 2024 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705604145; cv=none; b=Hqt3ZzeYx8LaVVDp7RHXbmSINXAYP6qbsa08Bu78GAqLMEwzGZ9wM6JUkM/pRaBNPDVIeNFrBYL8rKKTmqU7G1WV0haQRXAIercDzaB/svE6Ut0fX7cXzpQJ/dtU2D9ElFzusMHaXR+OxAbm55oGVDhPefsjBgH5du0ASJCJ51Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705604145; c=relaxed/simple;
	bh=BQot/HwWxxkVEnmFFNYRZKYKx1/1WdJ5aeSBjwMO1gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HEXYWUisEwuvLF0szdJhmPUhK4Q+YXxnp7oPx7kxfUWub2hX6LcOXDHA/H5LlG/5HH7tMW9MdD0Td7/7/m2CTHMbD2qhdx1EUTNWnccIufE2Z4AvzOBZU14RVtCwO+byu4i4mfsig6wRaaFfFDVaScjIUXGLp2PFKV9GJUP8Iuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b=mDkpa7hX; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705604109; x=1706208909; i=friedrich.vock@gmx.de;
	bh=BQot/HwWxxkVEnmFFNYRZKYKx1/1WdJ5aeSBjwMO1gc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=mDkpa7hXsUHIJ6TOsEDGBtfZfOF8fhAWR1nov3Ho0eISsDiYZQEfbBKhNBoA7Sh1
	 9P3ZrdKg8n7uMXBn5UAqKHaTSUvHYTuk8GzsR1Tm7zAN3if2pG0gTKGAe0f8cA6Yx
	 ORGTcO96P21F1nJ5bsqYSJstAXLg+o7KWeWNLfgcR1h36TwpEKtlH7WODvKqCf7aC
	 7SweUiFmynBGwqu2CV5aDduU2huCEsVnJ8dcL5RerkG1vTzeRi1XOxR2gsXCzanig
	 fyfTVMfcGZfwGmDCEEHEKgCmi74cIjf+I8HY56zdecyRl+wg3rf7PfaftNDiBnW9w
	 84wTDNrqqSJEum0KBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from arch.fritz.box ([213.152.118.80]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbgE-1rgyUj2MjU-00KxYY; Thu, 18
 Jan 2024 19:55:09 +0100
From: Friedrich Vock <friedrich.vock@gmx.de>
To: amd-gfx@lists.freedesktop.org
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
	Joshua Ashton <joshua@froggi.es>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit
Date: Thu, 18 Jan 2024 19:54:01 +0100
Message-ID: <20240118185402.919396-1-friedrich.vock@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GXAe47ypdqtPByJHeqZQn5TAOQl+vZBOZ5JrJeNTE/225rqM/G8
 m7cIy2xVWYtRJxRq0AxvdB9eH4JOm1TNS26uRUzpbD0XCTOPBR2VA30roLfoqtomiZy448g
 isz7En8rquYwKstofH9WReVAgIX7/8PlbxEqx6xPAfo4U0O26fKPaW3P/Zmq/CFA89YDHEb
 BVFAFQ45aWkv5eTYfaM/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mzc9lE8tzrI=;j2ZNATdezVYwG4eD7pvA1k4gIxW
 sFryjyqDrj5q+CL8ZTseXPHStDP9dR8B7S+2dLK36c4mWXxsaLNr15XBVSBRCG6xzWvhMF3Sb
 bAx+rM/06JAEWHxQ6oKEEvVDkTQ4FsUGDKfR2xV1Mh3dYokMEkW7uoR3pOckTLen0TSdzEbc6
 1qNsFCOojooS99/SexheDeDLT9IFLYxJKBfX+dVsi+l80GZTYbFaM3Hi0OcPoWzBa3Ed/d/Cf
 qge6yqj3pIIJpAdthOd1dgXTMNG0fVEFnNwnmeLOHAPefQzMFkya+WERhRQ76r9O+PqtCguoS
 uo4GJaDJPOoxmwI19IQYwmq0TQksk5EL1lonnNrjGBNdStTYFFll6xsgtqAucgzgJg2kY6Eoj
 dnr18aYe9WWa7cgrxcN9R3bM7fQPDN1+wCO1vSpYCEPiAjVSt0n4bxrskuCXXCsPvuOP8iDqC
 kxq1cuZ2VTp1M3yWmmOCkFjDLBGz0ZM7dvy/v2NXJ4MP7PHhd9nhUcuypgLssmJ+IqBPLA4hB
 Ge8Ooz/M3JNPdvf2FCwlifDX2H/uE68pSKxN/8CkMeGvJlCQVJf/H60H5cwx4ry3yfJHnB5EZ
 BjQPkcdzCrhDDBEIQxut+EsAUXJEUvd3DqzgjjsZdTmFyoSlIMHpzkrN9WUzWZxMO4oSAtPQ6
 9eGRftPmDhnCeSui1lTjILe60M1v0r5PluB7U7tNHbdPQ/hni40AbW44hKvoWLSjMlt/nSMyy
 RLGDvF8E/qSZv5eqF7WuESt+6P8a6Ac936bK6ArVJDUT+AU6WaGJc3z7k39q1fuvOfUdoXlxf
 6cYhmOIkbWaA1GHP78VVq3gkyztAeecGCVCeJKeQADo1+cPrCcQlruRUDYEjbdhic3MQNU/Yi
 SiKLSXgDPPgGYvtaifzzJKLlGygBY088BgxM088QyjRIvNe3NIZ0PuDpaT9oDm4zO2PIBbQw4
 f0/dlWWt0wErek4BB1EKQj2Qoy4=

Allows us to detect subsequent IH ring buffer overflows as well.

Cc: Joshua Ashton <joshua@froggi.es>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
Cc: stable@vger.kernel.org

Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
=2D--
v2: Reset CLEAR_OVERFLOW bit immediately after setting it

 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 2 ++
 drivers/gpu/drm/amd/amdgpu/cik_ih.c     | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/cz_ih.c      | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c    | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c    | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c  | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/si_ih.c      | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c   | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c  | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 7 +++++++
 11 files changed, 71 insertions(+)

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
index 6f7c031dd197..bbadf2e530b8 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -204,6 +204,13 @@ static u32 cik_ih_get_wptr(struct amdgpu_device *adev=
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
+		ih->overflow =3D true;
 	}
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdg=
pu/cz_ih.c
index b8c47e0cf37a..e5c4ed44bad9 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -216,6 +216,12 @@ static u32 cz_ih_get_wptr(struct amdgpu_device *adev,
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32(mmIH_RB_CNTL, tmp);

+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32(mmIH_RB_CNTL, tmp);
+	ih->overflow =3D true;

 out:
 	return (wptr & ih->ptr_mask);
diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd=
/amdgpu/iceland_ih.c
index aecad530b10a..075e5c1a5549 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -215,6 +215,12 @@ static u32 iceland_ih_get_wptr(struct amdgpu_device *=
adev,
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32(mmIH_RB_CNTL, tmp);

+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32(mmIH_RB_CNTL, tmp);
+	ih->overflow =3D true;

 out:
 	return (wptr & ih->ptr_mask);
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/ih_v6_0.c
index d9ed7332d805..d0a5a08edd55 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -418,6 +418,13 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *ade=
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
+	ih->overflow =3D true;
 out:
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/am=
dgpu/ih_v6_1.c
index 8fb05eae340a..6bf4f210ef74 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -418,6 +418,14 @@ static u32 ih_v6_1_get_wptr(struct amdgpu_device *ade=
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
+	ih->overflow =3D true;
+
 out:
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/=
amdgpu/navi10_ih.c
index e64b33115848..cdbe7d01490e 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -442,6 +442,13 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *a=
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
+	ih->overflow =3D true;
 out:
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdg=
pu/si_ih.c
index 9a24f17a5750..398fbc296cac 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -119,6 +119,13 @@ static u32 si_ih_get_wptr(struct amdgpu_device *adev,
 		tmp =3D RREG32(IH_RB_CNTL);
 		tmp |=3D IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
 		WREG32(IH_RB_CNTL, tmp);
+
+		/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+		 * can be detected.
+		 */
+		tmp &=3D ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
+		WREG32(IH_RB_CNTL, tmp);
+		ih->overflow =3D true;
 	}
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/tonga_ih.c
index 917707bba7f3..1d1e064be7d8 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -219,6 +219,13 @@ static u32 tonga_ih_get_wptr(struct amdgpu_device *ad=
ev,
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32(mmIH_RB_CNTL, tmp);

+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32(mmIH_RB_CNTL, tmp);
+	ih->overflow =3D true;
+
 out:
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/=
amdgpu/vega10_ih.c
index d364c6dd152c..619087a4c4ae 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -373,6 +373,13 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *a=
dev,
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);

+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+	ih->overflow =3D true;
+
 out:
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/=
amdgpu/vega20_ih.c
index ddfc6941f9d5..f42f8e5dbe23 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -421,6 +421,13 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *a=
dev,
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);

+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+	ih->overflow =3D true;
+
 out:
 	return (wptr & ih->ptr_mask);
 }
=2D-
2.43.0


