Return-Path: <stable+bounces-10844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC2082D0AD
	for <lists+stable@lfdr.de>; Sun, 14 Jan 2024 14:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2561C20D00
	for <lists+stable@lfdr.de>; Sun, 14 Jan 2024 13:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC132113;
	Sun, 14 Jan 2024 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b="OjZIpdk9"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6B420F1
	for <stable@vger.kernel.org>; Sun, 14 Jan 2024 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705237233; x=1705842033; i=friedrich.vock@gmx.de;
	bh=duszS7bM++dpqcffrIBvbtLByssm8/g+HtXTUzxcDfM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=OjZIpdk9MewEveNkfT0l51snl471FOs5ZB58CqPOqzMuir3g7rB3P2keFgfaJTMI
	 XfaY6ZJxU46d11ZU6zAw4vG1QRlVSJ24k2JhliQqHPt8Iegfbm0r8AIh001vme5/d
	 H/SU/fyHmWSRQ9zwuRBYU0EmKjQfPLBXvphXbAqrfbMRI8J+a9ori6UloptVgYExO
	 pbstZnbzDCkthCSKe24s+l5PnuJveEGZyn1g7U1GxDdp9QVu5TNCedPcUIGknrlAJ
	 iYx5i/2kW43xyWhzqDoQ2RqQaaFUr0es5OpOqYZ0suPvQew7xL528yxzBeYMmc5Ev
	 H7pz6Mq5Yd6g6pVskg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from arch.fritz.box ([213.152.118.80]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf0K-1qgLbv2V50-00imI1; Sun, 14
 Jan 2024 14:00:33 +0100
From: Friedrich Vock <friedrich.vock@gmx.de>
To: amd-gfx@lists.freedesktop.org
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
	Joshua Ashton <joshua@froggi.es>,
	Alex Deucher <alexander.deucher@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm/amdgpu: Process fences on IH overflow
Date: Sun, 14 Jan 2024 14:00:08 +0100
Message-ID: <20240114130008.868941-2-friedrich.vock@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114130008.868941-1-friedrich.vock@gmx.de>
References: <20240114130008.868941-1-friedrich.vock@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+y2u0kKULksfAXaib3mMiV5MCxb1UDjZ7zh98+Bj872gSbqZFiN
 JrOWTczPq81QgVSgG6GEkaw1PbKoQI7f4DVfOItfGAYljJakVIJZlwlxigm9MsHNWaB14Rq
 UXkTbH5gwHlkmDQvlFcumNpl8IdiWxiiMTjx43hFJq7ZTsT+mlAWleA+gPmWgDLbMmxl5va
 8oxYXBDJX7AfqQvwPRD5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zJDRpmbbAWg=;OC0MYsNeqx5kFAYmv4Xzyl5rcEp
 e+5q1uKjMLI1AaYfzs+2qALv8sy/y+hdYGHm6pJkT7fOJ483XUZvhwzA/zrgFhsfx8rX96epT
 WB6kWvJHfcdHT3vbEhMtcfg6nggbOVnP4Ce41TyAqxZ5xYIspti/7hwhsmt9Fep/81GVTCLzG
 4+n6jYZzqVSMN6QZXnOS9iLNvS3rIHw7RS2Azc0MD43M6fyKJ953eVN9lBm6rmMsW6QRBtpag
 LdTQrw4QPnbFa6Fj2gcqawhKKoP18Is3t9BHYdDV8offNz+OIk6WS1GFZ1d/T2tXpDZpEhat+
 SQfTjZeZOk/J2TBQ5yuyeimj7yRrxP/lCnjze+kWDL7SJtLp19vGwBMbVLJ9Ltoq/CXhIaK4L
 rJx01DjqEmtuvcWTmA5+6qGNfsSKrQ5C8WG09d7P0l4MfPBxwiEi2iXOB9R4Icyptdr4Dn8He
 wWi4nbPFB2tNvulPcDxZl0CKnps9mReLDXo4XS+ZpzEUpOZMMO4KKvnh9bBJ/efnLOGBIprff
 wV7dbw2eTDGRZRSBUpnmUyM2/81cxE8kcW1lRsL37ij1MqHXmXquU+pI+BwixjEp1nq9ZU5Y+
 0+DuDF0+yx8sZ9Br/NNYBQjOY8yAPtLODRNoGXSIe6zKK6j1n4P+BcCKYKNlM5YCI+TzC93M3
 aH1hLO4+6Qgqae/Mxe6oSpR6ILEve09x3MBUYPt/bgwwgAHM6WB7bKZhd1p+nLI7O1rhOj9Jx
 0VATccmdvEGgn7I/NJkGg8RH4w8U1rSxMzIKkaq873UyK7uRwz/KX+Uzp1qxrlWEsjasrm6Y4
 UHKKy3BpuCh9R+YVlrt2WfEy0gFVEyQY+pm9lo6hCAyt4fEeHbjcAYsil91AjhI42y1Oh3wql
 Ytx/6mMWATxoAo7YrzPU8GYsR6ILU3X27o1EVTZgXWMWWHj5n0LEkdAwFkT7mitCWQyODUClc
 4K73hTM7NwR1lTgfP+fQKqzliaE=

If the IH ring buffer overflows, it's possible that fence signal events
were lost. Check each ring for progress to prevent job timeouts/GPU
hangs due to the fences staying unsignaled despite the work being done.

Cc: Joshua Ashton <joshua@froggi.es>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ih.c
index f3b0aaf3ebc6..2a246db1d3a7 100644
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
@@ -227,6 +228,20 @@ int amdgpu_ih_process(struct amdgpu_device *adev, str=
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
+	}
+
 	amdgpu_ih_set_rptr(adev, ih);
 	wake_up_all(&ih->wait_process);

=2D-
2.43.0


