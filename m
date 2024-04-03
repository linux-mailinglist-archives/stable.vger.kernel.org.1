Return-Path: <stable+bounces-35687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2365896B26
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 11:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD9F28D55F
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 09:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5E01350CF;
	Wed,  3 Apr 2024 09:55:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E99A134CEF
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 09:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138145; cv=none; b=edxNhOSz9aOHs5GVrK0Y2bAosd/izCwmIAQYwGujF1Qo6oHq/QTmDHhviB6QonkMu8zPj6U3okVb3gmlCLmKTfzlSHFX3EzmwvqQpTWaxP7jU3/oCqVPL0yrEvYClN50oaDdFpSe2hJdG3KsvmT6cpHzEte+jJGdUTPM12HRARc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138145; c=relaxed/simple;
	bh=fvNXg4fOLmioUKMUQFpmfLSUW4yQ4ccPsGZlQEDE1vU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UvJpf50WCciRQLyhT6iyYV8yJStw0hG8O6/XoTsJorxCK+qkX7lohnqRBCCi/K5V6MNGRiIZPS4FVY45NhOzWA1JXL3k3qAJ15sqhKeIpNwGR/RhwaLi43bHZRxVsW7N6SbNVIPzg2P0Ayb8x/hTVtOojJ97d6pYo7N7XiFEXI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4V8g6R50FRz1QC5q;
	Wed,  3 Apr 2024 17:53:03 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id CCBC21402C7;
	Wed,  3 Apr 2024 17:55:37 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 17:55:37 +0800
From: Guo Mengqi <guomengqi3@huawei.com>
To: <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
	<stable@vger.kernel.org>
CC: <xuqiang36@huawei.com>, <zhangchangzhong@huawei.com>
Subject: [PATCH 4.19.y] drm/vkms: call drm_atomic_helper_shutdown before drm_dev_put()
Date: Wed, 3 Apr 2024 17:47:16 +0800
Message-ID: <20240403094716.80313-1-guomengqi3@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)

commit 73a82b22963d ("drm/atomic: Fix potential use-after-free
in nonblocking commits") introduced drm_dev_get/put() to
drm_atomic_helper_shutdown(). And this cause problem in vkms driver exit
process.

vkms_exit()
  drm_dev_put()
    vkms_release()
      drm_atomic_helper_shutdown()
        drm_dev_get()
        drm_dev_put()
          vkms_release()    ------ null pointer access

Using 4.19 stable x86 image on qemu, below stacktrace can be triggered by
load and unload vkms.ko.

root:~ # insmod vkms.ko
[  142.135449] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[  142.138713] [drm] Driver supports precise vblank timestamp query.
[  142.142390] [drm] Initialized vkms 1.0.0 20180514 for virtual device on minor 0
root:~ # rmmod vkms.ko
[  144.093710] BUG: unable to handle kernel NULL pointer dereference at 00000000000000a0
[  144.097491] PGD 800000023624e067 P4D 800000023624e067 PUD 22ab59067 PMD 0
[  144.100802] Oops: 0000 [#1] SMP PTI
[  144.102502] CPU: 0 PID: 3615 Comm: rmmod Not tainted 4.19.310 #1
[  144.104452] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[  144.107238] RIP: 0010:device_del+0x34/0x3a0
...
[  144.131323] Call Trace:
[  144.131962]  ? __die+0x7d/0xc0
[  144.132711]  ? no_context+0x152/0x3b0
[  144.133605]  ? wake_up_q+0x70/0x70
[  144.134436]  ? __do_page_fault+0x342/0x4b0
[  144.135445]  ? __switch_to_asm+0x41/0x70
[  144.136416]  ? __switch_to_asm+0x35/0x70
[  144.137366]  ? page_fault+0x1e/0x30
[  144.138214]  ? __drm_atomic_state_free+0x51/0x60
[  144.139331]  ? device_del+0x34/0x3a0
[  144.140197]  platform_device_del.part.14+0x19/0x70
[  144.141348]  platform_device_unregister+0xe/0x20
[  144.142458]  vkms_release+0x10/0x30 [vkms]
[  144.143449]  __drm_atomic_helper_disable_all.constprop.31+0x13b/0x150
[  144.144980]  drm_atomic_helper_shutdown+0x4b/0x90
[  144.146102]  vkms_release+0x18/0x30 [vkms]
[  144.147107]  vkms_exit+0x29/0x8ec [vkms]
[  144.148053]  __x64_sys_delete_module+0x155/0x220
[  144.149168]  do_syscall_64+0x43/0x100
[  144.150056]  entry_SYSCALL_64_after_hwframe+0x5c/0xc1

It seems that the proper unload sequence is:
	drm_atomic_helper_shutdown();
	drm_dev_put();

Just put drm_atomic_helper_shutdown() before drm_dev_put()
should solve the problem.

Note that vkms exit code is refactored by 53d77aaa3f76 ("drm/vkms: Use
devm_drm_dev_alloc") in tags/v5.10-rc1.

So this bug only exists on 4.19 and 5.4.

Fixes: 73a82b22963d ("drm/atomic: Fix potential use-after-free in nonblocking commits")
Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index b1201c18d3eb..d32e08f17427 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -39,7 +39,6 @@ static void vkms_release(struct drm_device *dev)
 	struct vkms_device *vkms = container_of(dev, struct vkms_device, drm);
 
 	platform_device_unregister(vkms->platform);
-	drm_atomic_helper_shutdown(&vkms->drm);
 	drm_mode_config_cleanup(&vkms->drm);
 	drm_dev_fini(&vkms->drm);
 }
@@ -137,6 +136,7 @@ static void __exit vkms_exit(void)
 	}
 
 	drm_dev_unregister(&vkms_device->drm);
+	drm_atomic_helper_shutdown(&vkms_device->drm);
 	drm_dev_put(&vkms_device->drm);
 
 	kfree(vkms_device);
-- 
2.17.1


