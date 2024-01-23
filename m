Return-Path: <stable+bounces-15519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9987838DF6
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639C31F24AA6
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 11:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FC05D902;
	Tue, 23 Jan 2024 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b="SC8RGv5i"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C05A5DF34
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010769; cv=none; b=kOMebAavCeA6lfH7ZeKfR20ldUV1kxA1WxbkqI/0O8NuLBiO0875zorg/ONd+mO1s0AdAaZkOHOFyxBVqCNQCJRVLnERY/28qlEVYisBPinBhrFSib17lSkqRSO3XUB1jpI4+L1R0JzFaAFf5Qtuk1vLS13R/4YSeOuQLfLtVps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010769; c=relaxed/simple;
	bh=kLRu9ltHtid3Zj0YJvK3iTr6QmXC8OKaq03zaMF8bgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FufnmCwhrYGbWYGwGsD4VhJVoGDDpIzSnkxJIP8P+Pun+8r6NJ0kZpgNnnciIzyXBcpMq84UDw4O5tLEsIsIFZvUdd1LwdSAXAIe2LZC4dEiQ1gYJbGK78usITSDaaHrsZwETc2FNxkUsk6EhLhD0eKQtfDrFMvDi3Bh98eqFts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b=SC8RGv5i; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706010759; x=1706615559; i=friedrich.vock@gmx.de;
	bh=kLRu9ltHtid3Zj0YJvK3iTr6QmXC8OKaq03zaMF8bgk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=SC8RGv5i2V8MYSm7p+PuwKVM9kYJRzKbS13nf+N07xpeP7cMCfmZ1ofNVBJk87Pr
	 VmqDXdd5OuGyusdSvUtFubmJsKMmogXBAwZRG5EUHqTPRBgVTzEUb7dd8GqB8zaHs
	 fDGVfJEXD7/oATzLEP2g6y2ZnB8GhHZzA+djKr0leZbWlgfql8yenKwLz5G6imfXS
	 N891OqzzA0clglY9LqTs8UwVwmdnQZ6TrgZglQcPfFyRAz6SnjG4uD9isKfvzS+c4
	 LlgZr+FeaRzwQ3BMQ1n7FCXhv6tueyRGrZA7dtgJx+H5BAvz6h/8Sss3YTSBYUtjH
	 ltnaR5x7cy+GJcY81Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from arch.fritz.box ([213.152.113.218]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCK6-1rnEf50FPA-00N8hd; Tue, 23
 Jan 2024 12:52:39 +0100
From: Friedrich Vock <friedrich.vock@gmx.de>
To: amd-gfx@lists.freedesktop.org
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
	Joshua Ashton <joshua@froggi.es>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] drm/amdgpu: Process fences on IH overflow
Date: Tue, 23 Jan 2024 12:52:04 +0100
Message-ID: <20240123115204.194523-2-friedrich.vock@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123115204.194523-1-friedrich.vock@gmx.de>
References: <20240123115204.194523-1-friedrich.vock@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tTIIWK9syZwuWsiicA9LKVhLcHPAm5YGDVDqAOgoCCkW4zEGr5k
 9JacC4c82AiHKqTtNO8ymUsp03JbbgCo6X1+CJ8e9s6QTTwgnb/qfd+vdJ3khZiFtVZ5234
 ABrMbcyKGP7NU4joLNe3TYKdr5uwo6fI0UogIW6lhGm4s7aYKsYNuC1AxMhxQof6NqsNVpn
 vDv12WwoOAxZyGBUpxjxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xkqNDeqaY1c=;mckF7hrHFGCgvb5OLDuZoD4NZPz
 hMC5gUO3qGnG+qC4XqkhPuQIg59qikrl4g7YrSVSXKuspj1m/3D4CXsrNfy/dpWeHFrzstDwo
 rPSI9gUgABpopGTRagtxjKh/3nN8U7EafzONQMH4N987ouwq9CDYWUShURIzwL6ZPxeAjJyT1
 g1LYVP4+zIM2iR6e1PQmjbOEDRZNgAWKeJw51yHl9WC9VRuJkdSCJ0ZlV4zdSFY5CtGU2sxBd
 pn2FmxY3uLjRp4utMwG/WNBmYv3xFTblAyxMROCzvTuWb+JiS53iG72StmbxEe18KG+4Y8NLE
 uJdglOZYlho2ZT8cLfAJ7JPzCiC01DWeFVfyD17LfrGW3Q5DfngLvNT1lsPZOOhJ1/KD/yNBg
 iQR/ZgFUUFe8dfob06Vtby/cLxQDPmM/sUIgtKRh8UD7ND5crO49rJSxihrSJGbSUImIkOhcE
 h5i9/ZXDQQst/0ScH5gNxKOBTsXsTHcoV/riD/14TpbfBsA4oS9sIEYMgyU2GYeZnopLblo3v
 qlsbHSJyvvRgFDlFO+BKdmdNcM8APwrq67vlX5Y130D/lrlzpOg7Eo/l5Yhc5e+FG/PE5gihR
 Wi3zUMXpjNTgWLUrJeTjYxbD5VfV5UIJp/4QWyNsT1Jehs5X4thFfSxXSL+8Fbu2p6zXUBXy9
 jB0oaly3FZjcqKqSlE8OzRBDkLye1j18eYbO4snJfb91JZ2PHKf1irnrwTPeav6zx6h3w+QbX
 3uT7Dvw4c5xllMqiv6Fe8LrvAMhQSx6lGqueDcIV391XjLsNZfP0+2Z0M3VaTngcCF31wtbj7
 qzWQq65dUZ+oHD/CY6YWtmGtLLbMGQJEEUoaUkrG9FIm/BJw96aCKb7Hz8nT0DgJI8yDBhvE/
 718eoymX7fbYC+YHSutfd3itPKu4ARHLt9MF/VGabk54HN1dOaiY8KHZLWqPY+4EA46UXsozq
 RJEfCMFChbEIOdp7DGA6vTtBK00=

If the IH ring buffer overflows, it's possible that fence signal events
were lost. Check each ring for progress to prevent job timeouts/GPU
hangs due to the fences staying unsignaled despite the work being done.

Cc: Joshua Ashton <joshua@froggi.es>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
Cc: stable@vger.kernel.org

Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
=2D--
v2: Set ih->overflow to false after processing fence
v3: Move everything related to fence processing on overflow to patch 2

 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  |  2 ++
 drivers/gpu/drm/amd/amdgpu/cik_ih.c     |  1 +
 drivers/gpu/drm/amd/amdgpu/cz_ih.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c |  1 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/si_ih.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c  |  1 +
 12 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ih.c
index f3b0aaf3ebc6..4e061f7741d8 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -209,6 +209,7 @@ int amdgpu_ih_process(struct amdgpu_device *adev, stru=
ct amdgpu_ih_ring *ih)
 {
 	unsigned int count;
 	u32 wptr;
+	int i;

 	if (!ih->enabled || adev->shutdown)
 		return IRQ_NONE;
@@ -227,6 +228,21 @@ int amdgpu_ih_process(struct amdgpu_device *adev, str=
uct amdgpu_ih_ring *ih)
 		ih->rptr &=3D ih->ptr_mask;
 	}

+	/* If the ring buffer overflowed, we might have lost some fence
+	 * signal interrupts. Check if there was any activity so the signal
+	 * doesn't get lost.
+	 */
+	if (ih->overflow) {
+		for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
+			struct amdgpu_ring *ring =3D adev->rings[i];
+
+			if (!ring || !ring->fence_drv.initialized)
+				continue;
+			amdgpu_fence_process(ring);
+		}
+		ih->overflow =3D false;
+	}
+
 	amdgpu_ih_set_rptr(adev, ih);
 	wake_up_all(&ih->wait_process);

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
index f24e34dc33d1..bbadf2e530b8 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -210,6 +210,7 @@ static u32 cik_ih_get_wptr(struct amdgpu_device *adev,
 		 */
 		tmp &=3D ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
 		WREG32(mmIH_RB_CNTL, tmp);
+		ih->overflow =3D true;
 	}
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdg=
pu/cz_ih.c
index c19681492efa..e5c4ed44bad9 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -221,6 +221,7 @@ static u32 cz_ih_get_wptr(struct amdgpu_device *adev,
 	 */
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
 	WREG32(mmIH_RB_CNTL, tmp);
+	ih->overflow =3D true;

 out:
 	return (wptr & ih->ptr_mask);
diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd=
/amdgpu/iceland_ih.c
index 2c02ae69883d..075e5c1a5549 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -220,6 +220,7 @@ static u32 iceland_ih_get_wptr(struct amdgpu_device *a=
dev,
 	 */
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
 	WREG32(mmIH_RB_CNTL, tmp);
+	ih->overflow =3D true;

 out:
 	return (wptr & ih->ptr_mask);
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/ih_v6_0.c
index ad4ad39f128f..d0a5a08edd55 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -424,6 +424,7 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *adev=
,
 	 */
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+	ih->overflow =3D true;
 out:
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/am=
dgpu/ih_v6_1.c
index b8da0fc29378..6bf4f210ef74 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -424,6 +424,7 @@ static u32 ih_v6_1_get_wptr(struct amdgpu_device *adev=
,
 	 */
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+	ih->overflow =3D true;

 out:
 	return (wptr & ih->ptr_mask);
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/=
amdgpu/navi10_ih.c
index de93614726c9..cdbe7d01490e 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -448,6 +448,7 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *ad=
ev,
 	 */
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+	ih->overflow =3D true;
 out:
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdg=
pu/si_ih.c
index cada9f300a7f..398fbc296cac 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -125,6 +125,7 @@ static u32 si_ih_get_wptr(struct amdgpu_device *adev,
 		 */
 		tmp &=3D ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
 		WREG32(IH_RB_CNTL, tmp);
+		ih->overflow =3D true;
 	}
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/tonga_ih.c
index 450b6e831509..1d1e064be7d8 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -224,6 +224,7 @@ static u32 tonga_ih_get_wptr(struct amdgpu_device *ade=
v,
 	 */
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
 	WREG32(mmIH_RB_CNTL, tmp);
+	ih->overflow =3D true;

 out:
 	return (wptr & ih->ptr_mask);
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/=
amdgpu/vega10_ih.c
index bf68e18e3824..619087a4c4ae 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -378,6 +378,7 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *ad=
ev,
 	 */
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+	ih->overflow =3D true;

 out:
 	return (wptr & ih->ptr_mask);
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/=
amdgpu/vega20_ih.c
index db66e6cccaf2..f42f8e5dbe23 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -426,6 +426,7 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *ad=
ev,
 	 */
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+	ih->overflow =3D true;

 out:
 	return (wptr & ih->ptr_mask);
=2D-
2.43.0


