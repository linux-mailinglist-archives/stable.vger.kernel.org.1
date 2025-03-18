Return-Path: <stable+bounces-124809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF34A67711
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 15:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87081890A35
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED09420E01F;
	Tue, 18 Mar 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPEaa/wL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A32820C47B;
	Tue, 18 Mar 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309604; cv=none; b=oTMbs5eDcxCwU8U/i5/JdLQ/jv4aHRFnsDP/WmtrZGLHOx2eDRxjGzbkz0eiCsqdiS8BNcgoqb6RiMZpXLM9/akjFSISUQ6nN4A6aFH+KUbpWy6ZGn4+YIrQ2inVEosmsnSKU3i4bjwa2jOM9F+xkEjYOME2+z3fNzFH3GowP9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309604; c=relaxed/simple;
	bh=XbWyEc8aFSTdcfHVMp23HWE4gemGI9Wz95sUOB11emE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rfnVqlyW8CsXvv1eEWSmtTCbzhXnlxb6urIUBja4Wy5ylDoK1LaQTjNdbtto7k8h8JjRJN9QOIAXPFUe5204Mmeuwa+WJsodkX8DW3bAKBF0xsC2CSZuyAGaIq6PNxbA7ASM00G+pxyNPzWtPF4SODvhD2EhSHvSJC8iAnigNS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPEaa/wL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0437BC4CEDD;
	Tue, 18 Mar 2025 14:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742309604;
	bh=XbWyEc8aFSTdcfHVMp23HWE4gemGI9Wz95sUOB11emE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=CPEaa/wLD8sXr2iETAc/pFi3cn7npRmvZI+2za3hWuahLgpUfzNEFoqyJ2LZsuYBK
	 p7WA5JRikarv2iBN7YcfRlOMUuW+3VtwmCIeT50Soa6zYSk7r7PJ7tTnfdzIJrL617
	 z8SG4IolFx3+KN9LQyEE1RD7RWk/2gFoVyLX2myy1Y/PU6SDNbxea4Q39eqtGW7X4E
	 uVkkPfOE1kgXYovUqUyniYLm6Q81V4rA37CFE9Z8MCyoI5Sh9uxg/yGKnncpY1zXNu
	 RY/pDxHZGIRTb/eT2t3r7FzOeuoMxYQiRAfCqfaWtWJ3cBEqkocgJ2MBHbINB/axf5
	 C4ENi2mF5fPqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB599C282EC;
	Tue, 18 Mar 2025 14:53:23 +0000 (UTC)
From: Brendan King via B4 Relay <devnull+Brendan.King.imgtec.com@kernel.org>
Date: Tue, 18 Mar 2025 14:53:13 +0000
Subject: [PATCH] drm/imagination: take paired job reference
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-ddkopsrc-1337-use-after-free-in-pvr_queue_prepare_job-v1-1-80fb30d044a6@imgtec.com>
X-B4-Tracking: v=1; b=H4sIANiI2WcC/x2N2wrCMBAFf6Xsswu5qBV/RSTkstEoJOnGFKH03
 w0+Dmc4s0EjTtTgOm3AtKaWSh4gDxP4p80PwhQGgxLqJLS8YAjvUht7lFrP2BuhjR9ijEzDzVh
 XNkunTqYyVctkXsWhPEfn56MTXgkY32OL6fvv3u77/gOewIWDhwAAAA==
X-Change-ID: 20250318-ddkopsrc-1337-use-after-free-in-pvr_queue_prepare_job-16fbc74b0c20
To: Frank Binns <frank.binns@imgtec.com>, 
 Matt Coster <matt.coster@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Brendan King <brendan.king@imgtec.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742309603; l=2606;
 i=Brendan.King@imgtec.com; s=20250203; h=from:subject:message-id;
 bh=iRO8TwqpOWn8X5jFM/tEN7yZ9E4/c1t772uWrRZbV/s=;
 b=6U0jpX6Ay9Wdn4uPme1Lovgv3I7RKQNnlFylAxRR64RsGqneC6U92TnG6vnE11fCuimMPMq/2
 lGiXF8TO8xmAGhsqXIJIL204XFaee2fLAqQRPg5/R2StCJjyjKGC7v3
X-Developer-Key: i=Brendan.King@imgtec.com; a=ed25519;
 pk=i3JvC3unEBLW+4r5s/aEWQZFsRCWaCBrWdFbMXIXCqg=
X-Endpoint-Received: by B4 Relay for Brendan.King@imgtec.com/20250203 with
 auth_id=335
X-Original-From: Brendan King <Brendan.King@imgtec.com>
Reply-To: Brendan.King@imgtec.com

From: Brendan King <Brendan.King@imgtec.com>

For paired jobs, have the fragment job take a reference on the
geometry job, so that the geometry job cannot be freed until
the fragment job has finished with it.

The geometry job structure is accessed when the fragment job is being
prepared by the GPU scheduler. Taking the reference prevents the
geometry job being freed until the fragment job no longer requires it.

Fixes a use after free bug detected by KASAN:

[  124.256386] BUG: KASAN: slab-use-after-free in pvr_queue_prepare_job+0x108/0x868 [powervr]
[  124.264893] Read of size 1 at addr ffff0000084cb960 by task kworker/u16:4/63

Cc: stable@vger.kernel.org
Fixes: eaf01ee5ba28 ("drm/imagination: Implement job submission and scheduling")
Signed-off-by: Brendan King <brendan.king@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_job.c   | 7 +++++++
 drivers/gpu/drm/imagination/pvr_queue.c | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/imagination/pvr_job.c b/drivers/gpu/drm/imagination/pvr_job.c
index 1cdb3cfd058d7db573337a2b4f6895ee4922f9a9..59b334d094fa826f26668d98561e956ec9c51428 100644
--- a/drivers/gpu/drm/imagination/pvr_job.c
+++ b/drivers/gpu/drm/imagination/pvr_job.c
@@ -671,6 +671,13 @@ pvr_jobs_link_geom_frag(struct pvr_job_data *job_data, u32 *job_count)
 		geom_job->paired_job = frag_job;
 		frag_job->paired_job = geom_job;
 
+		/* The geometry job pvr_job structure is used when the fragment
+		 * job is being prepared by the GPU scheduler. Have the fragment
+		 * job hold a reference on the geometry job to prevent it being
+		 * freed until the fragment job has finished with it.
+		 */
+		pvr_job_get(geom_job);
+
 		/* Skip the fragment job we just paired to the geometry job. */
 		i++;
 	}
diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index 21c185d18bb2e0569bd6e12832a74e38137bd48a..6431f6b654a2e60b86a46bd8571eb9f8133c4b53 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -856,6 +856,10 @@ static void pvr_queue_free_job(struct drm_sched_job *sched_job)
 	struct pvr_job *job = container_of(sched_job, struct pvr_job, base);
 
 	drm_sched_job_cleanup(sched_job);
+
+	if (job->type == DRM_PVR_JOB_TYPE_FRAGMENT && job->paired_job)
+		pvr_job_put(job->paired_job);
+
 	job->paired_job = NULL;
 	pvr_job_put(job);
 }

---
base-commit: 96c85e428ebaeacd2c640eba075479ab92072ccd
change-id: 20250318-ddkopsrc-1337-use-after-free-in-pvr_queue_prepare_job-16fbc74b0c20

Best regards,
-- 
Brendan King <Brendan.King@imgtec.com>



