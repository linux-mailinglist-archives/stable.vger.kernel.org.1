Return-Path: <stable+bounces-83982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC7299CD88
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A740C28131E
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F151AD9EE;
	Mon, 14 Oct 2024 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nmgtbb6E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EDA1AB507;
	Mon, 14 Oct 2024 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916400; cv=none; b=NyK2Yant0Sp2UJK93HSVokBAMY2JG5bbvmscb124dotdiSyfrCwL5lWAfkh/wJBKYpYcFrG/oGg1eI/S/eEZMGX15DN5AqTqF1FHVid8KdbB7JhfrD3iVWcxFBLED5/Rq+1Qkw9aCk9G7E9yBkt7Eh++nyLfvZDTdflgeUeLKgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916400; c=relaxed/simple;
	bh=VRrvZUMwa5+yLZKzI40niW7L/JC11Wz2Xselvr4ZMxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IU0KCB5DdpN41nOb0NxEpX4rCvNjQ8WrAsUYkU9qJS9HjCTTBIVdPuITuR5j0gMzUhgaPx+/x0MN9v0vLZin5O9UIYUVV3pWbX75ndqIsoW4Ai3ziXhI7jB7kRcFd2AExRh5E612FLZKnXzATCnMoSq5i17FOf3TxOt44Yb6rOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nmgtbb6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61260C4CECF;
	Mon, 14 Oct 2024 14:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728916399;
	bh=VRrvZUMwa5+yLZKzI40niW7L/JC11Wz2Xselvr4ZMxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nmgtbb6EzBWyVyN5PdsU8lUIp5vjob2cc8IRkuBjfXUV9x8gs1TXobhd8tdqEVQjv
	 qHGOZ5rq8mEI3R80lVp/tU0u8oUHI/lBqOsjZdI9o+sVAtWkqIFMaSsLW4yhAXq99Y
	 PsJ+GU9Ha0iXptBuak3Z6Z3flJvX12bLFfYK+8Tc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	"Juan A. Suarez" <jasuarez@igalia.com>
Subject: [PATCH 6.11 173/214] drm/v3d: Stop the active perfmon before being destroyed
Date: Mon, 14 Oct 2024 16:20:36 +0200
Message-ID: <20241014141051.730850747@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141044.974962104@linuxfoundation.org>
References: <20241014141044.974962104@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maíra Canal <mcanal@igalia.com>

commit 7d1fd3638ee3a9f9bca4785fffb638ca19120718 upstream.

When running `kmscube` with one or more performance monitors enabled
via `GALLIUM_HUD`, the following kernel panic can occur:

[   55.008324] Unable to handle kernel paging request at virtual address 00000000052004a4
[   55.008368] Mem abort info:
[   55.008377]   ESR = 0x0000000096000005
[   55.008387]   EC = 0x25: DABT (current EL), IL = 32 bits
[   55.008402]   SET = 0, FnV = 0
[   55.008412]   EA = 0, S1PTW = 0
[   55.008421]   FSC = 0x05: level 1 translation fault
[   55.008434] Data abort info:
[   55.008442]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
[   55.008455]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   55.008467]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   55.008481] user pgtable: 4k pages, 39-bit VAs, pgdp=00000001046c6000
[   55.008497] [00000000052004a4] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
[   55.008525] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
[   55.008542] Modules linked in: rfcomm [...] vc4 v3d snd_soc_hdmi_codec drm_display_helper
gpu_sched drm_shmem_helper cec drm_dma_helper drm_kms_helper i2c_brcmstb
drm drm_panel_orientation_quirks snd_soc_core snd_compress snd_pcm_dmaengine snd_pcm snd_timer snd backlight
[   55.008799] CPU: 2 PID: 166 Comm: v3d_bin Tainted: G         C         6.6.47+rpt-rpi-v8 #1  Debian 1:6.6.47-1+rpt1
[   55.008824] Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
[   55.008838] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   55.008855] pc : __mutex_lock.constprop.0+0x90/0x608
[   55.008879] lr : __mutex_lock.constprop.0+0x58/0x608
[   55.008895] sp : ffffffc080673cf0
[   55.008904] x29: ffffffc080673cf0 x28: 0000000000000000 x27: ffffff8106188a28
[   55.008926] x26: ffffff8101e78040 x25: ffffff8101baa6c0 x24: ffffffd9d989f148
[   55.008947] x23: ffffffda1c2a4008 x22: 0000000000000002 x21: ffffffc080673d38
[   55.008968] x20: ffffff8101238000 x19: ffffff8104f83188 x18: 0000000000000000
[   55.008988] x17: 0000000000000000 x16: ffffffda1bd04d18 x15: 00000055bb08bc90
[   55.009715] x14: 0000000000000000 x13: 0000000000000000 x12: ffffffda1bd4cbb0
[   55.010433] x11: 00000000fa83b2da x10: 0000000000001a40 x9 : ffffffda1bd04d04
[   55.011162] x8 : ffffff8102097b80 x7 : 0000000000000000 x6 : 00000000030a5857
[   55.011880] x5 : 00ffffffffffffff x4 : 0300000005200470 x3 : 0300000005200470
[   55.012598] x2 : ffffff8101238000 x1 : 0000000000000021 x0 : 0300000005200470
[   55.013292] Call trace:
[   55.013959]  __mutex_lock.constprop.0+0x90/0x608
[   55.014646]  __mutex_lock_slowpath+0x1c/0x30
[   55.015317]  mutex_lock+0x50/0x68
[   55.015961]  v3d_perfmon_stop+0x40/0xe0 [v3d]
[   55.016627]  v3d_bin_job_run+0x10c/0x2d8 [v3d]
[   55.017282]  drm_sched_main+0x178/0x3f8 [gpu_sched]
[   55.017921]  kthread+0x11c/0x128
[   55.018554]  ret_from_fork+0x10/0x20
[   55.019168] Code: f9400260 f1001c1f 54001ea9 927df000 (b9403401)
[   55.019776] ---[ end trace 0000000000000000 ]---
[   55.020411] note: v3d_bin[166] exited with preempt_count 1

This issue arises because, upon closing the file descriptor (which happens
when we interrupt `kmscube`), the active performance monitor is not
stopped. Although all perfmons are destroyed in `v3d_perfmon_close_file()`,
the active performance monitor's pointer (`v3d->active_perfmon`) is still
retained.

If `kmscube` is run again, the driver will attempt to stop the active
performance monitor using the stale pointer in `v3d->active_perfmon`.
However, this pointer is no longer valid because the previous process has
already terminated, and all performance monitors associated with it have
been destroyed and freed.

To fix this, when the active performance monitor belongs to a given
process, explicitly stop it before destroying and freeing it.

Cc: stable@vger.kernel.org # v5.15+
Closes: https://github.com/raspberrypi/linux/issues/6389
Fixes: 26a4dc29b74a ("drm/v3d: Expose performance counters to userspace")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Juan A. Suarez <jasuarez@igalia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241004130625.918580-2-mcanal@igalia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/v3d/v3d_perfmon.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -289,6 +289,11 @@ void v3d_perfmon_open_file(struct v3d_fi
 static int v3d_perfmon_idr_del(int id, void *elem, void *data)
 {
 	struct v3d_perfmon *perfmon = elem;
+	struct v3d_dev *v3d = (struct v3d_dev *)data;
+
+	/* If the active perfmon is being destroyed, stop it first */
+	if (perfmon == v3d->active_perfmon)
+		v3d_perfmon_stop(v3d, perfmon, false);
 
 	v3d_perfmon_put(perfmon);
 
@@ -297,8 +302,10 @@ static int v3d_perfmon_idr_del(int id, v
 
 void v3d_perfmon_close_file(struct v3d_file_priv *v3d_priv)
 {
+	struct v3d_dev *v3d = v3d_priv->v3d;
+
 	mutex_lock(&v3d_priv->perfmon.lock);
-	idr_for_each(&v3d_priv->perfmon.idr, v3d_perfmon_idr_del, NULL);
+	idr_for_each(&v3d_priv->perfmon.idr, v3d_perfmon_idr_del, v3d);
 	idr_destroy(&v3d_priv->perfmon.idr);
 	mutex_unlock(&v3d_priv->perfmon.lock);
 	mutex_destroy(&v3d_priv->perfmon.lock);



