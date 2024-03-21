Return-Path: <stable+bounces-28517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 656D7881CCF
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 08:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002241F21C46
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 07:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A274D9E7;
	Thu, 21 Mar 2024 07:15:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343EB69314
	for <stable@vger.kernel.org>; Thu, 21 Mar 2024 07:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711005353; cv=none; b=IbLbrp3pe03MQeXPL0+By1ttJIzx9ArG9U18pwyUGfKuufqlg2U/wTC35cAgIs+s1NOH4llx8heJKdrBX05XWzrgreNROpbLMTDQs/A1dAPGWEXWHJ0W78aTSJHDKp//AWVv3nk+Ak3K6Ah6XTa3HQIe1V1hnDnN+x0+fIhkrxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711005353; c=relaxed/simple;
	bh=l1DPPk0G8aT58R7Bkm96noh8Um2KT0ETIyTs1PS22AU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U0Ga3YW8npgM04CuwL70B/G0huLOTtd1xJRA3cQiu1aWDmdbmmlMHKVjf97qMSWgQ5Wc3NP6Rv8K6mtmRitLtx8o4M1uAtqx/ALnhgg63R5JJxqHggBhu4gt6E1GMiZ5KJIhQytZKiJBRFckz3y+XtPGUSlXi1yLDdanzwpeeHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V0cB120c1z1h31k;
	Thu, 21 Mar 2024 15:13:13 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F95918005F;
	Thu, 21 Mar 2024 15:15:47 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 21 Mar
 2024 15:15:46 +0800
From: Guo Mengqi <guomengqi3@huawei.com>
To: <stable@vger.kernel.org>
CC: <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
	<xuqiang36@huawei.com>
Subject: [PATCH] drm/vkms: call drm_atomic_helper_shutdown before drm_dev_put()
Date: Thu, 21 Mar 2024 15:07:52 +0800
Message-ID: <20240321070752.81405-1-guomengqi3@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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


