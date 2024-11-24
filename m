Return-Path: <stable+bounces-94845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB669D6F9E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD358161B1D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AB41F7087;
	Sun, 24 Nov 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcQ7ClOK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1361DF73A;
	Sun, 24 Nov 2024 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452749; cv=none; b=lSHf3LHjO7RZZPYIR/b9yBWU4qlFJxt/Dnu1KdH7X4ZjQZ2IqE5nZNm1aKC/w5qBm2mfo7XGUzpZSI6x76tDBBkk48PY26i1czUaFZ5xJOBDJOUVl1MI01y/HMqgXlWjsPRvd56VDaAtlqklpR58LyJ6Tb1UKISEhE9CiP6H2C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452749; c=relaxed/simple;
	bh=IfjgwbCexv9RuzYkXn/h5NMdo8iG8s5hfwfbvh719rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hD5jquljkd2DF6rAE08e1tjKD1Bo+PHCQrNsfF19LfJ0/jQkZ27zcRR7hY1yIU9SQxT2J8+q9v2sDxUUsg6h4GbiqeWv9w+FPZ023L7oFph7UywWMtS9JAbGk2WJBVZzN86ZjIxVNnprXjDj8RJp4iXjAIE0pyseAZE3H7YzfpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcQ7ClOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B11BC4CECC;
	Sun, 24 Nov 2024 12:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452749;
	bh=IfjgwbCexv9RuzYkXn/h5NMdo8iG8s5hfwfbvh719rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DcQ7ClOKXyeMuQ3EMW42+f3bg7pLDKhNcogVbQtVTPYdtri66vPhEI40wQ4B88Qnc
	 Ch1uf2bYsV4xKSQn3f4GND3BPrxKf1GgU7sJiDdaMZJxECBHs8reBfHWQ1ZOdQh1nm
	 QMeziz07yHayZAQ6IcE3feqfwyKHQh9vGyZNS6kqyEhvdue8qmOxCWgSwtqLwn/JEf
	 X47XqvW23k4JVA4TZXocnaVueJh2izD79SfL6aHjNQKnrLybIQ0puHij8IN2lEow7R
	 vYU40Gp+OuJuJJftXMSlTacL61pjrJmTyRzFexS3P5D4kPyup/C7blpUx35NrkAuUG
	 0yJb6fnyqIrFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 6.11 17/20] regmap: maple: Provide lockdep (sub)class for maple tree's internal lock
Date: Sun, 24 Nov 2024 07:50:47 -0500
Message-ID: <20241124125124.3339648-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124125124.3339648-1-sashal@kernel.org>
References: <20241124125124.3339648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index 83acccdc10089..bdb450436cbc5 100644
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
index 2dea9d259c493..e98c05f9d216f 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -355,6 +355,9 @@ static int regcache_maple_init(struct regmap *map)
 
 	mt_init(mt);
 
+	if (!mt_external_lock(mt) && map->lock_key)
+		lockdep_set_class_and_subclass(&mt->ma_lock, map->lock_key, 1);
+
 	if (!map->num_reg_defaults)
 		return 0;
 
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index bfc6bc1eb3a4a..b60a6036c2cd1 100644
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


