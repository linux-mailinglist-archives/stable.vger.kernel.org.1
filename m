Return-Path: <stable+bounces-209987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC40D2BB63
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 06:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC1FA30373BA
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 05:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DE5349B16;
	Fri, 16 Jan 2026 05:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QF84nhio"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBCC381C4;
	Fri, 16 Jan 2026 05:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768539755; cv=none; b=Hm/VcQHnNz7LXX0flhn04NcseC5kGjappXIcdqq6Azq0uvUxxnHmNM+hv53eH0f/maDYv5zet6bqaItz0++w5uuMFvL6hjNaz1OxpgUWdphJYfq4P2jOjcTD66FSxfWV1YoD+glZTBbZvBgGj18lN55Xr3j6krf3TEXxpO18I/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768539755; c=relaxed/simple;
	bh=2lzUz9h1vua/H2JQTmqw5HA3FkojC1JTpQPO7x8oVY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Klk2/Cc1oVYS+x96n77QASt/+Zm5jTOa6OHDwF4Yvl2XNlgLRRnpaVuk2bqcvBaYwl/ltFHvImHg0szn9wlfiT5Uh40bV5M1Qi+WS4Wp6vLuR+9YqkDq72dq7713HEG53Wv6gDhEAvH0QZo+ONZ/nBvzCFJZHn88qoR8+XtKtI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QF84nhio; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=xDzU4ApYApKN39wDu9fSahS1bVmty/puJiOGtVwxREg=;
	b=QF84nhiosDjCdPxB5bqnBCO4p9oyZSP+22awo7nFdzq4rliUzFsw4sbmC/Ah1l
	KUtC7M5YA6KuIjaayS7ZshIIgWLU3uboH8wc8PDz7AMQ5XRFIJRsO9afHKz4OiJz
	8hSZvIAvZzuAwq7KLqE0dbgazXt1Jcslrb1mhs6U01zdk=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAHb3NPxmlp82WtHA--.35186S2;
	Fri, 16 Jan 2026 13:02:08 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Gaosheng Cui <cuigaosheng1@huawei.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH v5.15] drm/ttm: fix undefined behavior in bit shift for TTM_TT_FLAG_PRIV_POPULATED
Date: Fri, 16 Jan 2026 13:02:05 +0800
Message-Id: <20260116050205.2296956-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHb3NPxmlp82WtHA--.35186S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr43tr43trW8ZF13uw13CFg_yoWrXFWrpa
	15G343Ar45trs8uw4xXFy0ya4qyanrtF4DZrs5Ar1xZrs2yr129FWDKw13WFyUGrWUJryf
	XFnayr95Z3Wq9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pM0PfUUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC+RJ6FGlpxlKV0wAA3X

From: Gaosheng Cui <cuigaosheng1@huawei.com>

[ Upstream 387659939c00156f8d6bab0fbc55b4eaf2b6bc5b commit ]

Shifting signed 32-bit value by 31 bits is undefined, so changing
significant bit to unsigned. The UBSAN warning calltrace like below:

UBSAN: shift-out-of-bounds in ./include/drm/ttm/ttm_tt.h:122:26
left shift of 1 by 31 places cannot be represented in type 'int'
Call Trace:
 <TASK>
 dump_stack_lvl+0x7d/0xa5
 dump_stack+0x15/0x1b
 ubsan_epilogue+0xe/0x4e
 __ubsan_handle_shift_out_of_bounds+0x1e7/0x20c
 ttm_bo_move_memcpy+0x3b4/0x460 [ttm]
 bo_driver_move+0x32/0x40 [drm_vram_helper]
 ttm_bo_handle_move_mem+0x118/0x200 [ttm]
 ttm_bo_validate+0xfa/0x220 [ttm]
 drm_gem_vram_pin_locked+0x70/0x1b0 [drm_vram_helper]
 drm_gem_vram_pin+0x48/0xb0 [drm_vram_helper]
 drm_gem_vram_plane_helper_prepare_fb+0x53/0xe0 [drm_vram_helper]
 drm_gem_vram_simple_display_pipe_prepare_fb+0x26/0x30 [drm_vram_helper]
 drm_simple_kms_plane_prepare_fb+0x4d/0xe0 [drm_kms_helper]
 drm_atomic_helper_prepare_planes+0xda/0x210 [drm_kms_helper]
 drm_atomic_helper_commit+0xc3/0x1e0 [drm_kms_helper]
 drm_atomic_commit+0x9c/0x160 [drm]
 drm_client_modeset_commit_atomic+0x33a/0x380 [drm]
 drm_client_modeset_commit_locked+0x77/0x220 [drm]
 drm_client_modeset_commit+0x31/0x60 [drm]
 __drm_fb_helper_restore_fbdev_mode_unlocked+0xa7/0x170 [drm_kms_helper]
 drm_fb_helper_set_par+0x51/0x90 [drm_kms_helper]
 fbcon_init+0x316/0x790
 visual_init+0x113/0x1d0
 do_bind_con_driver+0x2a3/0x5c0
 do_take_over_console+0xa9/0x270
 do_fbcon_takeover+0xa1/0x170
 do_fb_registered+0x2a8/0x340
 fbcon_fb_registered+0x47/0xe0
 register_framebuffer+0x294/0x4a0
 __drm_fb_helper_initial_config_and_unlock+0x43c/0x880 [drm_kms_helper]
 drm_fb_helper_initial_config+0x52/0x80 [drm_kms_helper]
 drm_fbdev_client_hotplug+0x156/0x1b0 [drm_kms_helper]
 drm_fbdev_generic_setup+0xfc/0x290 [drm_kms_helper]
 bochs_pci_probe+0x6ca/0x772 [bochs]
 local_pci_probe+0x4d/0xb0
 pci_device_probe+0x119/0x320
 really_probe+0x181/0x550
 __driver_probe_device+0xc6/0x220
 driver_probe_device+0x32/0x100
 __driver_attach+0x195/0x200
 bus_for_each_dev+0xbb/0x120
 driver_attach+0x27/0x30
 bus_add_driver+0x22e/0x2f0
 driver_register+0xa9/0x190
 __pci_register_driver+0x90/0xa0
 bochs_pci_driver_init+0x52/0x1000 [bochs]
 do_one_initcall+0x76/0x430
 do_init_module+0x61/0x28a
 load_module+0x1f82/0x2e50
 __do_sys_finit_module+0xf8/0x190
 __x64_sys_finit_module+0x23/0x30
 do_syscall_64+0x58/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
 </TASK>

Fixes: 3312be8f6fc8 ("drm/ttm: move populated state into page flags")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20221031113350.4180975-1-cuigaosheng1@huawei.com
Signed-off-by: Christian König <christian.koenig@amd.com>
[ The context change is due to the commit 43d46f0b78bb
("drm/ttm: s/FLAG_SG/FLAG_EXTERNAL/") in v5.16
which is irrelevant to the logic of this patch.
In addition, v6.1 has included the fix. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 include/drm/ttm/ttm_tt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
index b20e89d321b0..4c35802209c4 100644
--- a/include/drm/ttm/ttm_tt.h
+++ b/include/drm/ttm/ttm_tt.h
@@ -43,7 +43,7 @@ struct ttm_operation_ctx;
 #define TTM_PAGE_FLAG_SG              (1 << 8)
 #define TTM_PAGE_FLAG_NO_RETRY	      (1 << 9)
 
-#define TTM_PAGE_FLAG_PRIV_POPULATED  (1 << 31)
+#define TTM_PAGE_FLAG_PRIV_POPULATED  (1U << 31)
 
 /**
  * struct ttm_tt
-- 
2.34.1


