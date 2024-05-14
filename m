Return-Path: <stable+bounces-44048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7088C50F2
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6BCF1F2156B
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2C712AACA;
	Tue, 14 May 2024 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y03vP6hX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A89F4F88C;
	Tue, 14 May 2024 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683904; cv=none; b=FF3ibfoK9UWqhxL/Pve0hZUuWziIf9K/aFWC8mDxSN/E3uYm9NVXr6USbN2F1FARSw4A54dXxLBxFMgEHvL1AUGH80CDzV1lFKCHI0N6//GPWIJuErZwE6PHxp5YHnP0biX6OrbMcJ4kZ3LaOsX0s7Yc6k9dFlWLDWoCQCl5yc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683904; c=relaxed/simple;
	bh=g7cBfOXBiUAwASY0LDYEj/efxeWcnfyjzhprsOCNNUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViKlzz83Tvuzeja+Qs4xoRyOXcp5GOq+iM4pB0LDTRe1RKeaUVWxFq8K5EsUn0QuhqxIiRi0ZMpLO0f5krdBgpFcQZR4J75R5tgaYbqA3NHAxPpEdsPwhuFci1nMZMq2U8bJ4uYgdyi6gdXoJUFhrwttC1GO9dJGdO3BWL3TWp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y03vP6hX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDCEC2BD10;
	Tue, 14 May 2024 10:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715683904;
	bh=g7cBfOXBiUAwASY0LDYEj/efxeWcnfyjzhprsOCNNUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y03vP6hXK7W/tHF/UzpZ+Bo2U9srI/JikjGzUf2bmYgCNwTF6lPcRjZD3kPMR8nJt
	 RbC6pVsFTwPlc9krPzn2o++VnVmJhE3GNddJ8B5Jzkux3EhIL1i1OiNLr60qA7VCuc
	 f3SkOjrbwnCtVriqT5XomJEfc3YRs6rJypjhxiDo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lyude Paul <lyude@redhat.com>,
	Dave Airlie <airlied@redhat.com>
Subject: [PATCH 6.8 293/336] drm/nouveau/firmware: Fix SG_DEBUG error with nvkm_firmware_ctor()
Date: Tue, 14 May 2024 12:18:17 +0200
Message-ID: <20240514101049.677585610@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit 52a6947bf576b97ff8e14bb0a31c5eaf2d0d96e2 upstream.

Currently, enabling SG_DEBUG in the kernel will cause nouveau to hit a
BUG() on startup:

  kernel BUG at include/linux/scatterlist.h:187!
  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 7 PID: 930 Comm: (udev-worker) Not tainted 6.9.0-rc3Lyude-Test+ #30
  Hardware name: MSI MS-7A39/A320M GAMING PRO (MS-7A39), BIOS 1.I0 01/22/2019
  RIP: 0010:sg_init_one+0x85/0xa0
  Code: 69 88 32 01 83 e1 03 f6 c3 03 75 20 a8 01 75 1e 48 09 cb 41 89 54
  24 08 49 89 1c 24 41 89 6c 24 0c 5b 5d 41 5c e9 7b b9 88 00 <0f> 0b 0f 0b
  0f 0b 48 8b 05 5e 46 9a 01 eb b2 66 66 2e 0f 1f 84 00
  RSP: 0018:ffffa776017bf6a0 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: ffffa77600d87000 RCX: 000000000000002b
  RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffa77680d87000
  RBP: 000000000000e000 R08: 0000000000000000 R09: 0000000000000000
  R10: ffff98f4c46aa508 R11: 0000000000000000 R12: ffff98f4c46aa508
  R13: ffff98f4c46aa008 R14: ffffa77600d4a000 R15: ffffa77600d4a018
  FS:  00007feeb5aae980(0000) GS:ffff98f5c4dc0000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f22cb9a4520 CR3: 00000001043ba000 CR4: 00000000003506f0
  Call Trace:
   <TASK>
   ? die+0x36/0x90
   ? do_trap+0xdd/0x100
   ? sg_init_one+0x85/0xa0
   ? do_error_trap+0x65/0x80
   ? sg_init_one+0x85/0xa0
   ? exc_invalid_op+0x50/0x70
   ? sg_init_one+0x85/0xa0
   ? asm_exc_invalid_op+0x1a/0x20
   ? sg_init_one+0x85/0xa0
   nvkm_firmware_ctor+0x14a/0x250 [nouveau]
   nvkm_falcon_fw_ctor+0x42/0x70 [nouveau]
   ga102_gsp_booter_ctor+0xb4/0x1a0 [nouveau]
   r535_gsp_oneinit+0xb3/0x15f0 [nouveau]
   ? srso_return_thunk+0x5/0x5f
   ? srso_return_thunk+0x5/0x5f
   ? nvkm_udevice_new+0x95/0x140 [nouveau]
   ? srso_return_thunk+0x5/0x5f
   ? srso_return_thunk+0x5/0x5f
   ? ktime_get+0x47/0xb0
   ? srso_return_thunk+0x5/0x5f
   nvkm_subdev_oneinit_+0x4f/0x120 [nouveau]
   nvkm_subdev_init_+0x39/0x140 [nouveau]
   ? srso_return_thunk+0x5/0x5f
   nvkm_subdev_init+0x44/0x90 [nouveau]
   nvkm_device_init+0x166/0x2e0 [nouveau]
   nvkm_udevice_init+0x47/0x70 [nouveau]
   nvkm_object_init+0x41/0x1c0 [nouveau]
   nvkm_ioctl_new+0x16a/0x290 [nouveau]
   ? __pfx_nvkm_client_child_new+0x10/0x10 [nouveau]
   ? __pfx_nvkm_udevice_new+0x10/0x10 [nouveau]
   nvkm_ioctl+0x126/0x290 [nouveau]
   nvif_object_ctor+0x112/0x190 [nouveau]
   nvif_device_ctor+0x23/0x60 [nouveau]
   nouveau_cli_init+0x164/0x640 [nouveau]
   nouveau_drm_device_init+0x97/0x9e0 [nouveau]
   ? srso_return_thunk+0x5/0x5f
   ? pci_update_current_state+0x72/0xb0
   ? srso_return_thunk+0x5/0x5f
   nouveau_drm_probe+0x12c/0x280 [nouveau]
   ? srso_return_thunk+0x5/0x5f
   local_pci_probe+0x45/0xa0
   pci_device_probe+0xc7/0x270
   really_probe+0xe6/0x3a0
   __driver_probe_device+0x87/0x160
   driver_probe_device+0x1f/0xc0
   __driver_attach+0xec/0x1f0
   ? __pfx___driver_attach+0x10/0x10
   bus_for_each_dev+0x88/0xd0
   bus_add_driver+0x116/0x220
   driver_register+0x59/0x100
   ? __pfx_nouveau_drm_init+0x10/0x10 [nouveau]
   do_one_initcall+0x5b/0x320
   do_init_module+0x60/0x250
   init_module_from_file+0x86/0xc0
   idempotent_init_module+0x120/0x2b0
   __x64_sys_finit_module+0x5e/0xb0
   do_syscall_64+0x83/0x160
   ? srso_return_thunk+0x5/0x5f
   entry_SYSCALL_64_after_hwframe+0x71/0x79
  RIP: 0033:0x7feeb5cc20cd
  Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89
  f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0
  ff ff 73 01 c3 48 8b 0d 1b cd 0c 00 f7 d8 64 89 01 48
  RSP: 002b:00007ffcf220b2c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
  RAX: ffffffffffffffda RBX: 000055fdd2916aa0 RCX: 00007feeb5cc20cd
  RDX: 0000000000000000 RSI: 000055fdd29161e0 RDI: 0000000000000035
  RBP: 00007ffcf220b380 R08: 00007feeb5d8fb20 R09: 00007ffcf220b310
  R10: 000055fdd2909dc0 R11: 0000000000000246 R12: 000055fdd29161e0
  R13: 0000000000020000 R14: 000055fdd29203e0 R15: 000055fdd2909d80
   </TASK>

We hit this when trying to initialize firmware of type
NVKM_FIRMWARE_IMG_DMA because we allocate our memory with
dma_alloc_coherent, and DMA allocations can't be turned back into memory
pages - which a scatterlist needs in order to map them.

So, fix this by allocating the memory with vmalloc instead().

V2:
* Fixup explanation as the prior one was bogus

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Dave Airlie <airlied@redhat.com>
Cc: stable@vger.kernel.org
Link: https://patchwork.freedesktop.org/patch/msgid/20240429182318.189668-1-lyude@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nvkm/core/firmware.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
@@ -205,7 +205,9 @@ nvkm_firmware_dtor(struct nvkm_firmware
 		break;
 	case NVKM_FIRMWARE_IMG_DMA:
 		nvkm_memory_unref(&memory);
-		dma_free_coherent(fw->device->dev, sg_dma_len(&fw->mem.sgl), fw->img, fw->phys);
+		dma_unmap_single(fw->device->dev, fw->phys, sg_dma_len(&fw->mem.sgl),
+				 DMA_TO_DEVICE);
+		kfree(fw->img);
 		break;
 	case NVKM_FIRMWARE_IMG_SGT:
 		nvkm_memory_unref(&memory);
@@ -235,14 +237,17 @@ nvkm_firmware_ctor(const struct nvkm_fir
 		fw->img = kmemdup(src, fw->len, GFP_KERNEL);
 		break;
 	case NVKM_FIRMWARE_IMG_DMA: {
-		dma_addr_t addr;
-
 		len = ALIGN(fw->len, PAGE_SIZE);
 
-		fw->img = dma_alloc_coherent(fw->device->dev, len, &addr, GFP_KERNEL);
-		if (fw->img) {
-			memcpy(fw->img, src, fw->len);
-			fw->phys = addr;
+		fw->img = kmalloc(len, GFP_KERNEL);
+		if (!fw->img)
+			return -ENOMEM;
+
+		memcpy(fw->img, src, fw->len);
+		fw->phys = dma_map_single(fw->device->dev, fw->img, len, DMA_TO_DEVICE);
+		if (dma_mapping_error(fw->device->dev, fw->phys)) {
+			kfree(fw->img);
+			return -EFAULT;
 		}
 
 		sg_init_one(&fw->mem.sgl, fw->img, len);



