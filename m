Return-Path: <stable+bounces-158006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0ADAE56D2
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4403A5270
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D25199FBA;
	Mon, 23 Jun 2025 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eIwG1oXj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D631B15ADB4;
	Mon, 23 Jun 2025 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717255; cv=none; b=hazwrDwoJ69oUzE9VqtBvNTcsrta9p44caeOTf8fexFetoWdgQiJfTo2ciFnMkXJzy6KubqOI9Q3QqN56ZxtKUYFiT0M5xHefWvuufIYjvJpMCPWGymRl9FotRhmOx4qP5cGo3oygUmtQapfHngk+x1D3NgK6f/yBNjng3fCnfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717255; c=relaxed/simple;
	bh=7yfQAR97QfV1pjZxeRPhC/KkN4Ob5VhBG1GmFeZZOAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUGHYvsoM8BqMJnIeqdB0QTiNrBHQphRIF0LCCp8RP45N1ETY8cjeGQvPqvx6wF3Yb2YgVA3w3mY/+aTO6sfWGBfjA2I514WBnMJxScDGQROKtLb3qlJvpm/K3B02edq3sh0veEWOqoCnMyDRbZ9ZJ3GugFHNp0lymV847q+uQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eIwG1oXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31519C4CEEA;
	Mon, 23 Jun 2025 22:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717253;
	bh=7yfQAR97QfV1pjZxeRPhC/KkN4Ob5VhBG1GmFeZZOAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eIwG1oXjrinCB0cGsFTTrOy49QMvMPmp0RVb7y0K/CzstnFq/+dKH8sojaZR2ktLJ
	 T2nX3IoDVhGO5C+urEUEYGqJX8LEpajOvJSH06zBha/fEyTQ2nASGP4svngjkQgxFd
	 Ud5ZRmgMkpA48E1AjsAyYsiGdNHu7sWeyOuuSLGE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 6.12 347/414] drm/v3d: Avoid NULL pointer dereference in `v3d_job_update_stats()`
Date: Mon, 23 Jun 2025 15:08:04 +0200
Message-ID: <20250623130650.651063837@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maíra Canal <mcanal@igalia.com>

commit e1bc3a13bd775791cca0bb144d977b00f3598042 upstream.

The following kernel Oops was recently reported by Mesa CI:

[  800.139824] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000588
[  800.148619] Mem abort info:
[  800.151402]   ESR = 0x0000000096000005
[  800.155141]   EC = 0x25: DABT (current EL), IL = 32 bits
[  800.160444]   SET = 0, FnV = 0
[  800.163488]   EA = 0, S1PTW = 0
[  800.166619]   FSC = 0x05: level 1 translation fault
[  800.171487] Data abort info:
[  800.174357]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
[  800.179832]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  800.184873]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  800.190176] user pgtable: 4k pages, 39-bit VAs, pgdp=00000001014c2000
[  800.196607] [0000000000000588] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
[  800.205305] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
[  800.211564] Modules linked in: vc4 snd_soc_hdmi_codec drm_display_helper v3d cec gpu_sched drm_dma_helper drm_shmem_helper drm_kms_helper drm drm_panel_orientation_quirks snd_soc_core snd_compress snd_pcm_dmaengine snd_pcm i2c_brcmstb snd_timer snd backlight
[  800.234448] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.25+rpt-rpi-v8 #1  Debian 1:6.12.25-1+rpt1
[  800.244182] Hardware name: Raspberry Pi 4 Model B Rev 1.4 (DT)
[  800.250005] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  800.256959] pc : v3d_job_update_stats+0x60/0x130 [v3d]
[  800.262112] lr : v3d_job_update_stats+0x48/0x130 [v3d]
[  800.267251] sp : ffffffc080003e60
[  800.270555] x29: ffffffc080003e60 x28: ffffffd842784980 x27: 0224012000000000
[  800.277687] x26: ffffffd84277f630 x25: ffffff81012fd800 x24: 0000000000000020
[  800.284818] x23: ffffff8040238b08 x22: 0000000000000570 x21: 0000000000000158
[  800.291948] x20: 0000000000000000 x19: ffffff8040238000 x18: 0000000000000000
[  800.299078] x17: ffffffa8c1bd2000 x16: ffffffc080000000 x15: 0000000000000000
[  800.306208] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[  800.313338] x11: 0000000000000040 x10: 0000000000001a40 x9 : ffffffd83b39757c
[  800.320468] x8 : ffffffd842786420 x7 : 7fffffffffffffff x6 : 0000000000ef32b0
[  800.327598] x5 : 00ffffffffffffff x4 : 0000000000000015 x3 : ffffffd842784980
[  800.334728] x2 : 0000000000000004 x1 : 0000000000010002 x0 : 000000ba4c0ca382
[  800.341859] Call trace:
[  800.344294]  v3d_job_update_stats+0x60/0x130 [v3d]
[  800.349086]  v3d_irq+0x124/0x2e0 [v3d]
[  800.352835]  __handle_irq_event_percpu+0x58/0x218
[  800.357539]  handle_irq_event+0x54/0xb8
[  800.361369]  handle_fasteoi_irq+0xac/0x240
[  800.365458]  handle_irq_desc+0x48/0x68
[  800.369200]  generic_handle_domain_irq+0x24/0x38
[  800.373810]  gic_handle_irq+0x48/0xd8
[  800.377464]  call_on_irq_stack+0x24/0x58
[  800.381379]  do_interrupt_handler+0x88/0x98
[  800.385554]  el1_interrupt+0x34/0x68
[  800.389123]  el1h_64_irq_handler+0x18/0x28
[  800.393211]  el1h_64_irq+0x64/0x68
[  800.396603]  default_idle_call+0x3c/0x168
[  800.400606]  do_idle+0x1fc/0x230
[  800.403827]  cpu_startup_entry+0x40/0x50
[  800.407742]  rest_init+0xe4/0xf0
[  800.410962]  start_kernel+0x5e8/0x790
[  800.414616]  __primary_switched+0x80/0x90
[  800.418622] Code: 8b170277 8b160296 11000421 b9000861 (b9401ac1)
[  800.424707] ---[ end trace 0000000000000000 ]---
[  800.457313] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---

This issue happens when the file descriptor is closed before the jobs
submitted by it are completed. When the job completes, we update the
global GPU stats and the per-fd GPU stats, which are exposed through
fdinfo. If the file descriptor was closed, then the struct `v3d_file_priv`
and its stats were already freed and we can't update the per-fd stats.

Therefore, if the file descriptor was already closed, don't update the
per-fd GPU stats, only update the global ones.

Cc: stable@vger.kernel.org # v6.12+
Reviewed-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Link: https://lore.kernel.org/r/20250602151451.10161-1-mcanal@igalia.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/v3d/v3d_sched.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -191,7 +191,6 @@ v3d_job_update_stats(struct v3d_job *job
 	struct v3d_dev *v3d = job->v3d;
 	struct v3d_file_priv *file = job->file->driver_priv;
 	struct v3d_stats *global_stats = &v3d->queue[queue].stats;
-	struct v3d_stats *local_stats = &file->stats[queue];
 	u64 now = local_clock();
 	unsigned long flags;
 
@@ -201,7 +200,12 @@ v3d_job_update_stats(struct v3d_job *job
 	else
 		preempt_disable();
 
-	v3d_stats_update(local_stats, now);
+	/* Don't update the local stats if the file context has already closed */
+	if (file)
+		v3d_stats_update(&file->stats[queue], now);
+	else
+		drm_dbg(&v3d->drm, "The file descriptor was closed before job completion\n");
+
 	v3d_stats_update(global_stats, now);
 
 	if (IS_ENABLED(CONFIG_LOCKDEP))



