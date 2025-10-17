Return-Path: <stable+bounces-187690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9BFBEB282
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 20:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 329E24E951C
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8821306B2D;
	Fri, 17 Oct 2025 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="IZQylD0q"
X-Original-To: stable@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E157229D28A
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760724576; cv=none; b=LycDXz5I3q1Vz+829X+EjTexWXV00SR0wLOF2EaKVhtgif71o/UR45Ty85YS5FHPLSTTkQY7a8duIjuBgA2bnYf1kClg1oNrqLY/VcTextdhz0BF2XUOVHLTxsKTxy0grJwKp0BdLwk6PIyTkVUlcOKkOKu5+GydQAhn9IFLmqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760724576; c=relaxed/simple;
	bh=nb+5bT25d1M9YxzxnP1Qd1sMOEccv9bzgw8JCRyZ0Ro=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=R0sIOA2/ZaWgLfNzQWlhhhmQIGqykwJvt4WgCl1ig2Oho8XYJVMHngcP9n/C0to3hIn5juzpNNfL8hQaGmMbC0LRRZBGB8op1oHvgovv1CrBkgBOOgWN00cyeRWr44biwF3k3cmi0FC/dbrcvfsrS+0QkyT1R108KcgkID3sbbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=IZQylD0q; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 9E12B8286998
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 13:01:17 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id njEdSF89wSn9 for <stable@vger.kernel.org>;
	Fri, 17 Oct 2025 13:01:12 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 6FB208286BDC
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 13:01:12 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 6FB208286BDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1760724072; bh=DWT98stRyE0j6pKGK0uEgmxY8foVUYb5iTU+NrF8sxA=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=IZQylD0qJB0EQIgt3nKs7HL/h4ksiJt6TZeo1X+DRKoHJz8uZCWTCaOAGY9hPSfof
	 c+ZQmFKk47hoYFM/cqaOpbtUf+MXVEGplpk6ok6EM3BQX6LNf4vRVBd3P7JmxAMgLK
	 8HN0lCrm75wVUKs7r+vwlu8U67J5EMmWTETg03c8=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9aZfqIyhPt-h for <stable@vger.kernel.org>;
	Fri, 17 Oct 2025 13:01:12 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 386CA8286998
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 13:01:12 -0500 (CDT)
Date: Fri, 17 Oct 2025 13:01:12 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: stable <stable@vger.kernel.org>
Message-ID: <389171823.1798956.1760724071998.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH 6.12.y] drm/amd/display: fix dmub access race condition
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC141 (Linux)/8.5.0_GA_3042)
Thread-Index: MpjRvMaKmQgq+hPtkdVc5Jvx6rcWug==
Thread-Topic: drm/amd/display: fix dmub access race condition

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Justificiation:
This fixes DisplayPort lockups on Polaris GPUs during DPMS transitions,
which have been a major headache on our POWER9 platforms.  Backport to
Debian stable kernel version.

[ Upstream commit c210b757b400959577a5a17b783b5959b82baed8 ]

Accessing DC from amdgpu_dm is usually preceded by acquisition of
dc_lock mutex. Most of the DC API that DM calls are under a DC lock.
However, there are a few that are not. Some DC API called from interrupt
context end up sending DMUB commands via a DC API, while other threads were
using DMUB. This was apparent from a race between calls for setting idle
optimization enable/disable and the DC API to set vmin/vmax.

Offload the call to dc_stream_adjust_vmin_vmax() to a thread instead
of directly calling them from the interrupt handler such that it waits
for dc_lock.

[Timothy Pearson]

Modified header file patch to apply to 6.12

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 55 +++++++++++++++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 14 +++++
 2 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b02ff92bae0b..fd6d66832ccf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -533,6 +533,50 @@ static void dm_pflip_high_irq(void *interrupt_params)
 		      amdgpu_crtc->crtc_id, amdgpu_crtc, vrr_active, (int)!e);
 }
 
+static void dm_handle_vmin_vmax_update(struct work_struct *offload_work)
+{
+	struct vupdate_offload_work *work = container_of(offload_work, struct vupdate_offload_work, work);
+	struct amdgpu_device *adev = work->adev;
+	struct dc_stream_state *stream = work->stream;
+	struct dc_crtc_timing_adjust *adjust = work->adjust;
+
+	mutex_lock(&adev->dm.dc_lock);
+	dc_stream_adjust_vmin_vmax(adev->dm.dc, stream, adjust);
+	mutex_unlock(&adev->dm.dc_lock);
+
+	dc_stream_release(stream);
+	kfree(work->adjust);
+	kfree(work);
+}
+
+static void schedule_dc_vmin_vmax(struct amdgpu_device *adev,
+	struct dc_stream_state *stream,
+	struct dc_crtc_timing_adjust *adjust)
+{
+	struct vupdate_offload_work *offload_work = kzalloc(sizeof(*offload_work), GFP_KERNEL);
+	if (!offload_work) {
+		drm_dbg_driver(adev_to_drm(adev), "Failed to allocate vupdate_offload_work\n");
+		return;
+	}
+
+	struct dc_crtc_timing_adjust *adjust_copy = kzalloc(sizeof(*adjust_copy), GFP_KERNEL);
+	if (!adjust_copy) {
+		drm_dbg_driver(adev_to_drm(adev), "Failed to allocate adjust_copy\n");
+		kfree(offload_work);
+		return;
+	}
+
+	dc_stream_retain(stream);
+	memcpy(adjust_copy, adjust, sizeof(*adjust_copy));
+
+	INIT_WORK(&offload_work->work, dm_handle_vmin_vmax_update);
+	offload_work->adev = adev;
+	offload_work->stream = stream;
+	offload_work->adjust = adjust_copy;
+
+	queue_work(system_wq, &offload_work->work);
+}
+
 static void dm_vupdate_high_irq(void *interrupt_params)
 {
 	struct common_irq_params *irq_params = interrupt_params;
@@ -582,10 +626,9 @@ static void dm_vupdate_high_irq(void *interrupt_params)
 				    acrtc->dm_irq_params.stream,
 				    &acrtc->dm_irq_params.vrr_params);
 
-				dc_stream_adjust_vmin_vmax(
-				    adev->dm.dc,
-				    acrtc->dm_irq_params.stream,
-				    &acrtc->dm_irq_params.vrr_params.adjust);
+				schedule_dc_vmin_vmax(adev,
+					acrtc->dm_irq_params.stream,
+					&acrtc->dm_irq_params.vrr_params.adjust);
 				spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 			}
 		}
@@ -675,8 +718,8 @@ static void dm_crtc_high_irq(void *interrupt_params)
 					     acrtc->dm_irq_params.stream,
 					     &acrtc->dm_irq_params.vrr_params);
 
-		dc_stream_adjust_vmin_vmax(adev->dm.dc, acrtc->dm_irq_params.stream,
-					   &acrtc->dm_irq_params.vrr_params.adjust);
+		schedule_dc_vmin_vmax(adev, acrtc->dm_irq_params.stream,
+				&acrtc->dm_irq_params.vrr_params.adjust);
 	}
 
 	/*
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 9603352ee094..aa99e226a381 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1012,4 +1012,18 @@ void dm_free_gpu_mem(struct amdgpu_device *adev,
 
 bool amdgpu_dm_is_headless(struct amdgpu_device *adev);
 
+/**
+ * struct dm_vupdate_work - Work data for periodic action in idle
+ * @work: Kernel work data for the work event
+ * @adev: amdgpu_device back pointer
+ * @stream: DC stream associated with the crtc
+ * @adjust: DC CRTC timing adjust to be applied to the crtc
+ */
+struct vupdate_offload_work {
+       struct work_struct work;
+       struct amdgpu_device *adev;
+       struct dc_stream_state *stream;
+       struct dc_crtc_timing_adjust *adjust;
+};
+
 #endif /* __AMDGPU_DM_H__ */
-- 
2.47.2


