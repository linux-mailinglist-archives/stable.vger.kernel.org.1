Return-Path: <stable+bounces-20776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F07785B438
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 08:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A716284404
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 07:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169995BAD1;
	Tue, 20 Feb 2024 07:50:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B335A4CE
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 07:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708415425; cv=none; b=X0EvKU62gKGDSfKO7qXgJdMZEN5xabm9K10ADs51OGcvvOQTvIi2rjGs4b6luzq2rqwL+AYwAMqFw5IkbD9kdOiPQNIQXuHvFhW21CqMMokRc7rBJQ1yxQApvH+2GsN4yDpkTytBn+qfC0O6kJ+q2Oh4F29m8cNuUe5PYKOt7Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708415425; c=relaxed/simple;
	bh=pTYERY+h0YawQZ+bBq6biY6IZuaxrp1hGZHKt4xmvVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OepXmUEpxU9JrayCc9O+yEB999PwhfMk4OcEGCRhgmevS8NV6P+almUjgoeJh9s51uY8ntsxWz/n2ynIMv09T+pQAygC4E+oKQuzwyr7vYckBfKjbxkT8Gv/CLS+DNIuQIsoCJStcAN+29ZYnLp1meDAVpQg7I3uaOf/0uuOhy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0C7C43390;
	Tue, 20 Feb 2024 07:50:22 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pan@web.codeaurora.org, Xinhui <Xinhui.Pan@amd.com>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	Tianyang Zhang <zhangtianyang@loongson.cn>
Subject: [PATCH] drm/radeon: Call mmiowb() at the end of radeon_ring_commit()
Date: Tue, 20 Feb 2024 15:49:58 +0800
Message-ID: <20240220074958.3288170-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit fb24ea52f78e0d595852e ("drivers: Remove explicit invocations of
mmiowb()") remove all mmiowb() in drivers, but it says:

"NOTE: mmiowb() has only ever guaranteed ordering in conjunction with
spin_unlock(). However, pairing each mmiowb() removal in this patch with
the corresponding call to spin_unlock() is not at all trivial, so there
is a small chance that this change may regress any drivers incorrectly
relying on mmiowb() to order MMIO writes between CPUs using lock-free
synchronisation."

The mmio in radeon_ring_commit() is protected by a mutex rather than a
spinlock, but in the mutex fastpath it behaves similar to spinlock and
need a mmiowb() to make sure the wptr is up-to-date for hardware.

Without this, we get such an error when run 'glxgears' on weak ordering
architectures such as LoongArch:

radeon 0000:04:00.0: ring 0 stalled for more than 10324msec
radeon 0000:04:00.0: ring 3 stalled for more than 10240msec
radeon 0000:04:00.0: GPU lockup (current fence id 0x000000000001f412 last fence id 0x000000000001f414 on ring 3)
radeon 0000:04:00.0: GPU lockup (current fence id 0x000000000000f940 last fence id 0x000000000000f941 on ring 0)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)

Cc: stable@vger.kernel.org
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/gpu/drm/radeon/radeon_ring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/radeon_ring.c b/drivers/gpu/drm/radeon/radeon_ring.c
index 38048593bb4a..d461dc85d820 100644
--- a/drivers/gpu/drm/radeon/radeon_ring.c
+++ b/drivers/gpu/drm/radeon/radeon_ring.c
@@ -183,6 +183,7 @@ void radeon_ring_commit(struct radeon_device *rdev, struct radeon_ring *ring,
 	if (hdp_flush && rdev->asic->mmio_hdp_flush)
 		rdev->asic->mmio_hdp_flush(rdev);
 	radeon_ring_set_wptr(rdev, ring);
+	mmiowb(); /* Make sure wptr is up-to-date for hw */
 }
 
 /**
-- 
2.43.0


