Return-Path: <stable+bounces-94861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72FC9D7138
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF789B34A2E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7152B1E0B6F;
	Sun, 24 Nov 2024 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtGwxTso"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D55A1E0B65;
	Sun, 24 Nov 2024 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452858; cv=none; b=Gqy353MVOv1ZvHXqTBg76R4cyt7g8R+02mTDdr+ZSv87yr1nUH0Cq98kp9qVB/iHfCCmCppo1xDSE4DZoMh5vjtWgSzCi7IiNTo9J8MQQXu9mdWs3cW71ctKk6bCM8qGp2dieuwxIdw/vXmzx2uLj16z7XeXI3UrNR0No6ZN+zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452858; c=relaxed/simple;
	bh=HKKrd/9ejXh8zqIrhkLs5Zf9PUe7WaZwVYDH2QXXWzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZih4g5zVANo8pHiPcqAF1BeE7PR7ej53GblHPpUeMNKWFG05gKYBw7e8WDjyLLVP5Vy7E8uJtyDwb17wJL8xgENnFT4GAj7F3c0diW2vPewenPTqAsTEbwWgguVlzMW6KJym4n3if5+cNX/NstbrPmGLRKds9j8FaX/gliNY2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtGwxTso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073B4C4CECC;
	Sun, 24 Nov 2024 12:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452857;
	bh=HKKrd/9ejXh8zqIrhkLs5Zf9PUe7WaZwVYDH2QXXWzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BtGwxTsoOe3wuGl4x72UBM9IQJXV5NdDJHJY9kLsVf06+SBO5+t6n8bTKAaka8HWX
	 Co3AHidF+WTKi3Vu2M+jYbPLSaVYoyufi2KSeGtqsdtNvbE9hPYcQT2B6B1pOnmXEj
	 v0n3dyA3mty9EsB+GLi+bvQHmWI1MFowiKV+Lqm5fG6kZfQn5XdAjQGrC2JyAp3d7e
	 DKQ/4hrjTwBQOUUL4m/jyhQbdCZ8qcJR0eeVFrDUlDUAqr5O//M+YOSZZb6ommLpCN
	 OZsUSs0Ea4PMSOnZ/j9i601HgB691cJ6zZPjkyfgqz//cEHxq8v+VJn2QaL9Z4v+3O
	 zYEB+u5c5Kg+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 6.6 13/16] regmap: maple: Provide lockdep (sub)class for maple tree's internal lock
Date: Sun, 24 Nov 2024 07:52:31 -0500
Message-ID: <20241124125311.3340223-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124125311.3340223-1-sashal@kernel.org>
References: <20241124125311.3340223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit 1ed9b927e7dd8b8cff13052efe212a8ff72ec51d ]

In some cases when using the maple tree register cache, the lockdep
validator might complain about invalid deadlocks:

[7.131886]  Possible interrupt unsafe locking scenario:

[7.131890]        CPU0                    CPU1
[7.131893]        ----                    ----
[7.131896]   lock(&mt->ma_lock);
[7.131904]                                local_irq_disable();
[7.131907]                                lock(rockchip_drm_vop2:3114:(&vop2_regmap_config)->lock);
[7.131916]                                lock(&mt->ma_lock);
[7.131925]   <Interrupt>
[7.131928]     lock(rockchip_drm_vop2:3114:(&vop2_regmap_config)->lock);
[7.131936]
                *** DEADLOCK ***

[7.131939] no locks held by swapper/0/0.
[7.131944]
               the shortest dependencies between 2nd lock and 1st lock:
[7.131950]  -> (&mt->ma_lock){+.+.}-{2:2} {
[7.131966]     HARDIRQ-ON-W at:
[7.131973]                       lock_acquire+0x200/0x330
[7.131986]                       _raw_spin_lock+0x50/0x70
[7.131998]                       regcache_maple_write+0x68/0xe0
[7.132010]                       regcache_write+0x6c/0x90
[7.132019]                       _regmap_read+0x19c/0x1d0
[7.132029]                       _regmap_update_bits+0xc0/0x148
[7.132038]                       regmap_update_bits_base+0x6c/0xa8
[7.132048]                       rk8xx_probe+0x22c/0x3d8
[7.132057]                       rk8xx_spi_probe+0x74/0x88
[7.132065]                       spi_probe+0xa8/0xe0

[...]

[7.132675]   }
[7.132678]   ... key      at: [<ffff800082943c20>] __key.0+0x0/0x10
[7.132691]   ... acquired at:
[7.132695]    _raw_spin_lock+0x50/0x70
[7.132704]    regcache_maple_write+0x68/0xe0
[7.132714]    regcache_write+0x6c/0x90
[7.132724]    _regmap_read+0x19c/0x1d0
[7.132732]    _regmap_update_bits+0xc0/0x148
[7.132741]    regmap_field_update_bits_base+0x74/0xb8
[7.132751]    vop2_plane_atomic_update+0x480/0x14d8 [rockchipdrm]
[7.132820]    drm_atomic_helper_commit_planes+0x1a0/0x320 [drm_kms_helper]

[...]

[7.135112] -> (rockchip_drm_vop2:3114:(&vop2_regmap_config)->lock){-...}-{2:2} {
[7.135130]    IN-HARDIRQ-W at:
[7.135136]                     lock_acquire+0x200/0x330
[7.135147]                     _raw_spin_lock_irqsave+0x6c/0x98
[7.135157]                     regmap_lock_spinlock+0x20/0x40
[7.135166]                     regmap_read+0x44/0x90
[7.135175]                     vop2_isr+0x90/0x290 [rockchipdrm]
[7.135225]                     __handle_irq_event_percpu+0x124/0x2d0

In the example above, the validator seems to get the scope of
dependencies wrong, since the regmap instance used in rk8xx-spi driver
has nothing to do with the instance from vop2.

Improve validation by sharing the regmap's lockdep class with the maple
tree's internal lock, while also providing a subclass for the latter.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Link: https://patch.msgid.link/20241031-regmap-maple-lockdep-fix-v2-1-06a3710f3623@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/internal.h       | 1 +
 drivers/base/regmap/regcache-maple.c | 3 +++
 drivers/base/regmap/regmap.c         | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 9a9ea514c2d81..a29f24b15928c 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -59,6 +59,7 @@ struct regmap {
 			unsigned long raw_spinlock_flags;
 		};
 	};
+	struct lock_class_key *lock_key;
 	regmap_lock lock;
 	regmap_unlock unlock;
 	void *lock_arg; /* This is passed to lock/unlock functions */
diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index 0b6c2277128b4..fb5761a5ef6ee 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -356,6 +356,9 @@ static int regcache_maple_init(struct regmap *map)
 
 	mt_init(mt);
 
+	if (!mt_external_lock(mt) && map->lock_key)
+		lockdep_set_class_and_subclass(&mt->ma_lock, map->lock_key, 1);
+
 	if (!map->num_reg_defaults)
 		return 0;
 
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index c5b5241891a5a..1f17c6816850c 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -745,6 +745,7 @@ struct regmap *__regmap_init(struct device *dev,
 						   lock_key, lock_name);
 		}
 		map->lock_arg = map;
+		map->lock_key = lock_key;
 	}
 
 	/*
-- 
2.43.0


