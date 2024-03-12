Return-Path: <stable+bounces-27442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B340D87910D
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 10:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43811C21F75
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 09:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B7F77F3E;
	Tue, 12 Mar 2024 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BaqBDrmK"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42377826B
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236164; cv=none; b=hi7BpUzSUm/z3VUz2lHo8yqNDqJQdFT/VHjOQPRWEp15Ly8RFE3g3tfGo0mn3RWniWZscNkMp3vRAPCA7JIhWeuYNq+wUAHp5AGnqRUndhOx7kiq9hlwwuQi4P6GjCWxvReLCyoXyF6MVkSP7nONVP3Xel1GhmqRy0Y9tIigA9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236164; c=relaxed/simple;
	bh=nmVqxAOsqkIQKkepuQ9eUV6bIt5gw9prcP80FlzkR+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UZnNpCeS0VtkdF2VNxXKjruIXvSx5n/GDUkOy7WzwCRUGJ46dI/TIRkxlX5Tc7ipEnlw2qHXfIP3hKHGEcumvuCDJd88rV7Pjvk+tV+24/xIBNDwvxrIY2M9sH88QY0oHVi1r6Hmzfr4oKZsEcRH40dMe9fq9fP8TtoVqqyUQHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BaqBDrmK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710236161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UpQt4rFmaG+pnh1jxHreV7eEP/lKtwbHt1vwmJNiSUE=;
	b=BaqBDrmKttYUalqVaZ5HPhF+athHz3eUrouk+myaSZW7pZKP8hwcC+iPccaq6o0MWs01VW
	S4QYUkxVGFjjd1k1m1F1oQUuh4p795JQofefibOIZENVnQpX798fHEQMVOOxUCznXuXW0g
	L9ma7PjrULHw9x431M+tHArQJncHr+0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-ULZCs2HVMSCMs3spfJNIXQ-1; Tue,
 12 Mar 2024 05:35:58 -0400
X-MC-Unique: ULZCs2HVMSCMs3spfJNIXQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E612F3801F52;
	Tue, 12 Mar 2024 09:35:57 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 084A12022EDB;
	Tue, 12 Mar 2024 09:35:55 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: dri-devel@lists.freedesktop.org,
	zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	tzimmermann@suse.de,
	airlied@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	daniel@ffwll.ch
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] vmwgfx: Create debugfs ttm_resource_manager entry only if needed
Date: Tue, 12 Mar 2024 10:35:12 +0100
Message-ID: <20240312093551.196609-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

The driver creates /sys/kernel/debug/dri/0/mob_ttm even when the
corresponding ttm_resource_manager is not allocated.
This leads to a crash when trying to read from this file.

Add a check to create mob_ttm, system_mob_ttm, and gmr_ttm debug file
only when the corresponding ttm_resource_manager is allocated.

crash> bt
PID: 3133409  TASK: ffff8fe4834a5000  CPU: 3    COMMAND: "grep"
 #0 [ffffb954506b3b20] machine_kexec at ffffffffb2a6bec3
 #1 [ffffb954506b3b78] __crash_kexec at ffffffffb2bb598a
 #2 [ffffb954506b3c38] crash_kexec at ffffffffb2bb68c1
 #3 [ffffb954506b3c50] oops_end at ffffffffb2a2a9b1
 #4 [ffffb954506b3c70] no_context at ffffffffb2a7e913
 #5 [ffffb954506b3cc8] __bad_area_nosemaphore at ffffffffb2a7ec8c
 #6 [ffffb954506b3d10] do_page_fault at ffffffffb2a7f887
 #7 [ffffb954506b3d40] page_fault at ffffffffb360116e
    [exception RIP: ttm_resource_manager_debug+0x11]
    RIP: ffffffffc04afd11  RSP: ffffb954506b3df0  RFLAGS: 00010246
    RAX: ffff8fe41a6d1200  RBX: 0000000000000000  RCX: 0000000000000940
    RDX: 0000000000000000  RSI: ffffffffc04b4338  RDI: 0000000000000000
    RBP: ffffb954506b3e08   R8: ffff8fee3ffad000   R9: 0000000000000000
    R10: ffff8fe41a76a000  R11: 0000000000000001  R12: 00000000ffffffff
    R13: 0000000000000001  R14: ffff8fe5bb6f3900  R15: ffff8fe41a6d1200
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #8 [ffffb954506b3e00] ttm_resource_manager_show at ffffffffc04afde7 [ttm]
 #9 [ffffb954506b3e30] seq_read at ffffffffb2d8f9f3
    RIP: 00007f4c4eda8985  RSP: 00007ffdbba9e9f8  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 000000000037e000  RCX: 00007f4c4eda8985
    RDX: 000000000037e000  RSI: 00007f4c41573000  RDI: 0000000000000003
    RBP: 000000000037e000   R8: 0000000000000000   R9: 000000000037fe30
    R10: 0000000000000000  R11: 0000000000000246  R12: 00007f4c41573000
    R13: 0000000000000003  R14: 00007f4c41572010  R15: 0000000000000003
    ORIG_RAX: 0000000000000000  CS: 0033  SS: 002b

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
Fixes: af4a25bbe5e7 ("drm/vmwgfx: Add debugfs entries for various ttm resource managers")
Cc: <stable@vger.kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index d3e308fdfd5b..c7d90f96d16a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1444,12 +1444,15 @@ static void vmw_debugfs_resource_managers_init(struct vmw_private *vmw)
 					    root, "system_ttm");
 	ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw->bdev, TTM_PL_VRAM),
 					    root, "vram_ttm");
-	ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw->bdev, VMW_PL_GMR),
-					    root, "gmr_ttm");
-	ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw->bdev, VMW_PL_MOB),
-					    root, "mob_ttm");
-	ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw->bdev, VMW_PL_SYSTEM),
-					    root, "system_mob_ttm");
+	if (vmw->has_gmr)
+		ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw->bdev, VMW_PL_GMR),
+						    root, "gmr_ttm");
+	if (vmw->has_mob) {
+		ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw->bdev, VMW_PL_MOB),
+						    root, "mob_ttm");
+		ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw->bdev, VMW_PL_SYSTEM),
+						    root, "system_mob_ttm");
+	}
 }
 
 static int vmwgfx_pm_notifier(struct notifier_block *nb, unsigned long val,

base-commit: b33651a5c98dbd5a919219d8c129d0674ef74299
-- 
2.44.0


