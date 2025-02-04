Return-Path: <stable+bounces-112216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4013FA2790A
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 18:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D8B1887BF1
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 17:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E134216384;
	Tue,  4 Feb 2025 17:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vawM0pQW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C65C215F74
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691679; cv=none; b=RBAW1zK14q4BuUDJjwm3TMRfXOR2HPniRWaNf1lb/AnokXjxNG3v0XikcijusbXb6iI2n7Pi3l+5pthDQk6BtPYZe7XcJNqmrIh+WI7/0rcLjmeSlUGOxYILuoQGrOz2eomv/9kQrjwfLN+pUfA6F5FsicrU02yiYzLwXZ2msOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691679; c=relaxed/simple;
	bh=Mt4pFcGwwrMYoDa4hQ0JULIpiSIO4EV6OPKWC+dwy0o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h+cyMTZgu2a4ibzaW+e2FmKimRZ9L42Ztt55Evf+NlGABWEBQofzwYn48em/QnEAiTEExbICInoI+sXzIJIikD+YkMDRh1i7FrlR5KNZ7KowLcoFbYHQ/yaw5iE1frdL6bZ3ro7vp1569KhtFUt+ZgTYSSM3T3CwjG+UYoUUxMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vawM0pQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC1AC4CEE2;
	Tue,  4 Feb 2025 17:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738691678;
	bh=Mt4pFcGwwrMYoDa4hQ0JULIpiSIO4EV6OPKWC+dwy0o=;
	h=Subject:To:Cc:From:Date:From;
	b=vawM0pQWpvaTqt3qUDXOFgRTjEapvFENWIoa55V5CCrB/OQg9Fx2X3ofN5eTsCy13
	 dCJ6tCH8BVvrNRmq0Rok0g07Qcnic3LOC0p09W8Tuo9Ti3euhhYA0jEeC+661n9ltw
	 b4SgbbVVfteqeD6nRWg5tNDdvQIPyiyqMyuKm9Iw=
Subject: FAILED: patch "[PATCH] drm/v3d: Assign job pointer to NULL before signaling the" failed to apply to 6.6-stable tree
To: mcanal@igalia.com,itoral@igalia.com,jmcasanova@igalia.com,phil@raspberrypi.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Feb 2025 18:54:31 +0100
Message-ID: <2025020431-radiation-snore-3970@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6e64d6b3a3c39655de56682ec83e894978d23412
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025020431-radiation-snore-3970@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6e64d6b3a3c39655de56682ec83e894978d23412 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Date: Wed, 22 Jan 2025 22:24:03 -0300
Subject: [PATCH] drm/v3d: Assign job pointer to NULL before signaling the
 fence
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In commit e4b5ccd392b9 ("drm/v3d: Ensure job pointer is set to NULL
after job completion"), we introduced a change to assign the job pointer
to NULL after completing a job, indicating job completion.

However, this approach created a race condition between the DRM
scheduler workqueue and the IRQ execution thread. As soon as the fence is
signaled in the IRQ execution thread, a new job starts to be executed.
This results in a race condition where the IRQ execution thread sets the
job pointer to NULL simultaneously as the `run_job()` function assigns
a new job to the pointer.

This race condition can lead to a NULL pointer dereference if the IRQ
execution thread sets the job pointer to NULL after `run_job()` assigns
it to the new job. When the new job completes and the GPU emits an
interrupt, `v3d_irq()` is triggered, potentially causing a crash.

[  466.310099] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000c0
[  466.318928] Mem abort info:
[  466.321723]   ESR = 0x0000000096000005
[  466.325479]   EC = 0x25: DABT (current EL), IL = 32 bits
[  466.330807]   SET = 0, FnV = 0
[  466.333864]   EA = 0, S1PTW = 0
[  466.337010]   FSC = 0x05: level 1 translation fault
[  466.341900] Data abort info:
[  466.344783]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
[  466.350285]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  466.355350]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  466.360677] user pgtable: 4k pages, 39-bit VAs, pgdp=0000000089772000
[  466.367140] [00000000000000c0] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
[  466.375875] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
[  466.382163] Modules linked in: rfcomm snd_seq_dummy snd_hrtimer snd_seq snd_seq_device algif_hash algif_skcipher af_alg bnep binfmt_misc vc4 snd_soc_hdmi_codec drm_display_helper cec brcmfmac_wcc spidev rpivid_hevc(C) drm_client_lib brcmfmac hci_uart drm_dma_helper pisp_be btbcm brcmutil snd_soc_core aes_ce_blk v4l2_mem2mem bluetooth aes_ce_cipher snd_compress videobuf2_dma_contig ghash_ce cfg80211 gf128mul snd_pcm_dmaengine videobuf2_memops ecdh_generic sha2_ce ecc videobuf2_v4l2 snd_pcm v3d sha256_arm64 rfkill videodev snd_timer sha1_ce libaes gpu_sched snd videobuf2_common sha1_generic drm_shmem_helper mc rp1_pio drm_kms_helper raspberrypi_hwmon spi_bcm2835 gpio_keys i2c_brcmstb rp1 raspberrypi_gpiomem rp1_mailbox rp1_adc nvmem_rmem uio_pdrv_genirq uio i2c_dev drm ledtrig_pattern drm_panel_orientation_quirks backlight fuse dm_mod ip_tables x_tables ipv6
[  466.458429] CPU: 0 UID: 1000 PID: 2008 Comm: chromium Tainted: G         C         6.13.0-v8+ #18
[  466.467336] Tainted: [C]=CRAP
[  466.470306] Hardware name: Raspberry Pi 5 Model B Rev 1.0 (DT)
[  466.476157] pstate: 404000c9 (nZcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  466.483143] pc : v3d_irq+0x118/0x2e0 [v3d]
[  466.487258] lr : __handle_irq_event_percpu+0x60/0x228
[  466.492327] sp : ffffffc080003ea0
[  466.495646] x29: ffffffc080003ea0 x28: ffffff80c0c94200 x27: 0000000000000000
[  466.502807] x26: ffffffd08dd81d7b x25: ffffff80c0c94200 x24: ffffff8003bdc200
[  466.509969] x23: 0000000000000001 x22: 00000000000000a7 x21: 0000000000000000
[  466.517130] x20: ffffff8041bb0000 x19: 0000000000000001 x18: 0000000000000000
[  466.524291] x17: ffffffafadfb0000 x16: ffffffc080000000 x15: 0000000000000000
[  466.531452] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[  466.538613] x11: 0000000000000000 x10: 0000000000000000 x9 : ffffffd08c527eb0
[  466.545777] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
[  466.552941] x5 : ffffffd08c4100d0 x4 : ffffffafadfb0000 x3 : ffffffc080003f70
[  466.560102] x2 : ffffffc0829e8058 x1 : 0000000000000001 x0 : 0000000000000000
[  466.567263] Call trace:
[  466.569711]  v3d_irq+0x118/0x2e0 [v3d] (P)
[  466.573826]  __handle_irq_event_percpu+0x60/0x228
[  466.578546]  handle_irq_event+0x54/0xb8
[  466.582391]  handle_fasteoi_irq+0xac/0x240
[  466.586498]  generic_handle_domain_irq+0x34/0x58
[  466.591128]  gic_handle_irq+0x48/0xd8
[  466.594798]  call_on_irq_stack+0x24/0x58
[  466.598730]  do_interrupt_handler+0x88/0x98
[  466.602923]  el0_interrupt+0x44/0xc0
[  466.606508]  __el0_irq_handler_common+0x18/0x28
[  466.611050]  el0t_64_irq_handler+0x10/0x20
[  466.615156]  el0t_64_irq+0x198/0x1a0
[  466.618740] Code: 52800035 3607faf3 f9442e80 52800021 (f9406018)
[  466.624853] ---[ end trace 0000000000000000 ]---
[  466.629483] Kernel panic - not syncing: Oops: Fatal exception in interrupt
[  466.636384] SMP: stopping secondary CPUs
[  466.640320] Kernel Offset: 0x100c400000 from 0xffffffc080000000
[  466.646259] PHYS_OFFSET: 0x0
[  466.649141] CPU features: 0x100,00000170,00901250,0200720b
[  466.654644] Memory Limit: none
[  466.657706] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---

Fix the crash by assigning the job pointer to NULL before signaling the
fence. This ensures that the job pointer is cleared before any new job
starts execution, preventing the race condition and the NULL pointer
dereference crash.

Cc: stable@vger.kernel.org
Fixes: e4b5ccd392b9 ("drm/v3d: Ensure job pointer is set to NULL after job completion")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Tested-by: Phil Elwell <phil@raspberrypi.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250123012403.20447-1-mcanal@igalia.com

diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index da203045df9b..72b6a119412f 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -107,8 +107,10 @@ v3d_irq(int irq, void *arg)
 
 		v3d_job_update_stats(&v3d->bin_job->base, V3D_BIN);
 		trace_v3d_bcl_irq(&v3d->drm, fence->seqno);
-		dma_fence_signal(&fence->base);
+
 		v3d->bin_job = NULL;
+		dma_fence_signal(&fence->base);
+
 		status = IRQ_HANDLED;
 	}
 
@@ -118,8 +120,10 @@ v3d_irq(int irq, void *arg)
 
 		v3d_job_update_stats(&v3d->render_job->base, V3D_RENDER);
 		trace_v3d_rcl_irq(&v3d->drm, fence->seqno);
-		dma_fence_signal(&fence->base);
+
 		v3d->render_job = NULL;
+		dma_fence_signal(&fence->base);
+
 		status = IRQ_HANDLED;
 	}
 
@@ -129,8 +133,10 @@ v3d_irq(int irq, void *arg)
 
 		v3d_job_update_stats(&v3d->csd_job->base, V3D_CSD);
 		trace_v3d_csd_irq(&v3d->drm, fence->seqno);
-		dma_fence_signal(&fence->base);
+
 		v3d->csd_job = NULL;
+		dma_fence_signal(&fence->base);
+
 		status = IRQ_HANDLED;
 	}
 
@@ -167,8 +173,10 @@ v3d_hub_irq(int irq, void *arg)
 
 		v3d_job_update_stats(&v3d->tfu_job->base, V3D_TFU);
 		trace_v3d_tfu_irq(&v3d->drm, fence->seqno);
-		dma_fence_signal(&fence->base);
+
 		v3d->tfu_job = NULL;
+		dma_fence_signal(&fence->base);
+
 		status = IRQ_HANDLED;
 	}
 


