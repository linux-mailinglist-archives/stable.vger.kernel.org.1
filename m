Return-Path: <stable+bounces-243932-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JkDsDNIr+Wk86QIAu9opvQ
	(envelope-from <stable+bounces-243932-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 01:29:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 761A94C4D0F
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 01:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C9543011585
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 23:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B293D1704;
	Mon,  4 May 2026 23:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Txu2oCiT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526E736C9CC;
	Mon,  4 May 2026 23:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777937357; cv=none; b=AaidGWg4BuyUWZm2krXLxw5zpoDfKxn2FqHo74m2sKEhdTBJKBu53CiiXhl+LEkwojeCpmfjWslmCy4pcjbNt+iMPsk+LcWPPIqbyU2Lv45M99/OgVrYU49SUZTO4byy1mtZeah36tGPQdiJ06DoENssj8xyaAWvLuExNfsqR9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777937357; c=relaxed/simple;
	bh=2ZEeWJRlASx/z0MrAxgryYwvmf7cezzVkLS6/sdyq5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drMwN/pSO7M3qeEUkCRq+DQbSwgRl1L8c9Yd8ZL2QXzm8Tcen+E935Xpnll5iaXMaGh1iFVxzZOqINXgoE5E9ZX6w9iayEcZHrPuRxVslzdDjRj2+DKW81xWnYquxO3Yiq6sGV8HQPPqL6Ovfsn1jTGmXXhipmk/VH5ZfBjrwY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Txu2oCiT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777937355; x=1809473355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2ZEeWJRlASx/z0MrAxgryYwvmf7cezzVkLS6/sdyq5w=;
  b=Txu2oCiT86gvQcdwS5qmueJIiXn0NaKRld5WrfWUPD8QOEqNLqWO7Se/
   cVU0Ye/rbpkfI2rQFyEu8U2cFWAmZ78LhV7mmW/xYJPw5UJ9QIvd3ms5d
   SQf2ro/XHH86jAHIet/4T2iKLnrr+AIUM2XosherUY5tPLCoT14ZzphnV
   28b1wBGFUZFq/JftE063IBwbKkCZlxr/Wsn9omg0s3i6no3IPiI7ze4e7
   ZSyBwa9EJHWqX4kD+QoegESBnsgFLYBnp7R1QSmDDCGXrmVv9YNw2W3Wg
   YdN8fPT3Pf+x2LJ+UV0Fl1JljM5U5ibYFWavQH2la6sFUlj1pPprek4Al
   A==;
X-CSE-ConnectionGUID: SKLfRvqUTsuB+PYzLjPYWg==
X-CSE-MsgGUID: vAgCZOSYS/WLZPfOh6p9sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89497277"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="89497277"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 16:29:14 -0700
X-CSE-ConnectionGUID: BFjMmAb/Qcur+Ilvs3qsFA==
X-CSE-MsgGUID: bLHzTB8SSWyB5EoD5uDuKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="239626114"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 16:29:14 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/ttm: Drop tt->restore after successful restore
Date: Mon,  4 May 2026 16:29:09 -0700
Message-Id: <20260504232910.3249376-2-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504232910.3249376-1-matthew.brost@intel.com>
References: <20260504232910.3249376-1-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 761A94C4D0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,amd.com,intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243932-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.freedesktop.org:email]

ttm_pool_restore_and_alloc() can successfully complete the restore
process via ttm_pool_restore_commit(), but tt->restore is not dropped
afterward. As a result, subsequent backup/restore flows observe what
appears to be a completed restore, while in reality shmem handles are
still installed in tt->pages, leading to the stack trace below.

Fix this by freeing and dropping tt->restore in
ttm_pool_restore_and_alloc() upon successful completion of the restore.

20545 [  309.784531] RIP: 0010:sg_alloc_append_table_from_pages+0x38c/0x490
20547 [  309.809570] RSP: 0018:ffffc9000623b838 EFLAGS: 00010206
20548 [  309.814827] RAX: 0000000000001000 RBX: ffff88816e42a160 RCX: 0000000000000000
20549 [  309.821986] RDX: 0000000000002000 RSI: 0000000000000003 RDI: 0000000000001000
20550 [  309.829147] RBP: ffff88816e42a168 R08: 0000000000000002 R09: 000000007ffff000
20551 [  309.836310] R10: ffffc9000623b928 R11: 0000000000000000 R12: 000000007ffff000
20552 [  309.843471] R13: ffff88815ba5a100 R14: 0000000000000000 R15: 0000000000000001
20553 [  309.850634] FS:  00007f9ff305e700(0000) GS:ffff888276c94000(0000) knlGS:0000000000000000
20554 [  309.858749] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
20555 [  309.864519] CR2: 00007f9fca701000 CR3: 00000001565e2005 CR4: 0000000008f70ef0
20556 [  309.871678] PKRU: 55555558
20557 [  309.874403] Call Trace:
20558 [  309.876866]  <TASK>
20559 [  309.878988]  sg_alloc_table_from_pages_segment+0x60/0x100
20560 [  309.884415]  ? ttm_resource_manager_usage+0x36/0x60 [ttm]
20561 [  309.889845]  ? xe_tt_map_sg+0x7d/0xd0 [xe]
20562 [  309.894045]  xe_tt_map_sg+0x7d/0xd0 [xe]
20563 [  309.898037]  xe_bo_move+0x927/0xaa0 [xe]
20564 [  309.902029]  ttm_bo_handle_move_mem+0xba/0x170 [ttm]
20565 [  309.907022]  ttm_bo_validate+0xbe/0x190 [ttm]
20566 [  309.911405]  xe_bo_validate+0x9a/0x120 [xe]
20567 [  309.915663]  xe_gpuvm_validate+0xd9/0x140 [xe]
20568 [  309.920206]  drm_gpuvm_validate+0x2f0/0x5b0 [drm_gpuvm]
20569 [  309.925459]  ? drm_exec_lock_obj+0x63/0x210 [drm_exec]
20570 [  309.930627]  xe_vm_validate_rebind+0x46/0xb0 [xe]
20571 [  309.935428]  xe_exec_fn+0x20/0x40 [xe]
20572 [  309.939249]  drm_gpuvm_exec_lock+0x78/0xc0 [drm_gpuvm]
20573 [  309.944410]  xe_validation_exec_lock+0x5a/0xa0 [xe]
20574 [  309.949385]  xe_exec_ioctl+0x806/0xc30 [xe]
20575 [  309.953639]  ? ttwu_queue_wakelist+0xd9/0xf0
20576 [  309.957935]  ? __pfx_xe_exec_fn+0x10/0x10 [xe]
20577 [  309.962449]  ? __wake_up_common+0x73/0xa0
20578 [  309.966482]  ? __pfx_xe_exec_ioctl+0x10/0x10 [xe]
20579 [  309.971263]  drm_ioctl_kernel+0xa3/0x100
20580 [  309.975209]  drm_ioctl+0x213/0x440
20581 [  309.978637]  ? __pfx_xe_exec_ioctl+0x10/0x10 [xe]
20582 [  309.983415]  xe_drm_ioctl+0x67/0xd0 [xe]
20583 [  309.987408]  __x64_sys_ioctl+0x7f/0xd0

Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper to shrink pages")
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 278bbe7a11ad..084768d6d9b1 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -931,8 +931,11 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 			if (ret)
 				return ret;
 		}
-		if (!alloc.remaining_pages)
+		if (!alloc.remaining_pages) {
+			kfree(tt->restore);
+			tt->restore = NULL;
 			return 0;
+		}
 	}
 
 	return __ttm_pool_alloc(pool, tt, ctx, &alloc, restore);
-- 
2.34.1


