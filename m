Return-Path: <stable+bounces-121543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9B6A57B0D
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 15:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271AE16E768
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 14:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2FD1DD539;
	Sat,  8 Mar 2025 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TmxDxOQ0"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631FD1624F7
	for <stable@vger.kernel.org>; Sat,  8 Mar 2025 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741444463; cv=none; b=Gj5gc9FdPazwolFT6G9h/zis0HvLvSgEL0SuiVKfvDg9tevYHHPBL6UCknvca7YVNlzmn854js2TdYYD6Xwa2wnWxxPF3boBdLBMJh5oqAqVIar9RcXvmEP6FDg7GtT5tT0SO3QJgaDZ/v8DMJf+TXHxk35HvXIaIV4y4BGJ3C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741444463; c=relaxed/simple;
	bh=pUXjA+I7tCLIoH3bNrkO4IB28zYBbl1H9vaCVIpHHNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DgO85VQXIsKeUhjSfaSR3OwPZkbeWI+URb3BIekxcim/36lGgQh64ANiCOkTUqY4yJTMfZccM9tlCD5z96TpygLtMkSIIez2LUqSmodNo1NWHT4lm3GuqDVAyYi+Ezd31mdWxwOPKc36HGfLfx5099byhx3GHlZNRcFpPwddhIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TmxDxOQ0; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FcMGhykXB4u4YxIGnBy/HoDy7WeSl1BAMrtIHGKlZ4g=; b=TmxDxOQ0rvne4pTPdPJqhGNxCT
	Rz/KgNkrPUjkF4mYIfWlUW3NPnUsTognzx70+pqBlENc66DlIwxjZ3XHbxhrtL/lIBeJs/ETtXeyz
	mBCKyRgV+NCJn3CiZh8g+oWtvOAcWrVBEwc4EAZ+ykNW2j+CKX9b31ZDeEyx1SbfpcLNyjCFjjZAV
	MHv9h/zQklPXSJvJ/RQlScJ0yTlgltXq4/6/7sYgfzS0WK3RtUnityXk49mlUI0LGOndjFz7oIJQB
	wF5CpJUWTym20VwLs88rN1s4Bol/4lvlCaa07nlIl1tAKfrShn4wszOHTtIXzKAca5adRoRXlDx4N
	+QDAhlJg==;
Received: from [189.7.87.170] (helo=1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tqvFl-005pPS-1P; Sat, 08 Mar 2025 15:34:19 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sat, 08 Mar 2025 11:33:40 -0300
Subject: [PATCH v2 1/6] drm/v3d: Don't run jobs that have errors flagged in
 its fence
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250308-v3d-gpu-reset-fixes-v2-1-2939c30f0cc4@igalia.com>
References: <20250308-v3d-gpu-reset-fixes-v2-0-2939c30f0cc4@igalia.com>
In-Reply-To: <20250308-v3d-gpu-reset-fixes-v2-0-2939c30f0cc4@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: Phil Elwell <phil@raspberrypi.com>, dri-devel@lists.freedesktop.org, 
 kernel-dev@igalia.com, stable@vger.kernel.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2200; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=pUXjA+I7tCLIoH3bNrkO4IB28zYBbl1H9vaCVIpHHNI=;
 b=owEBbQGS/pANAwAIAT/zDop2iPqqAcsmYgBnzFVi++EmDNEIABjpW1dFJsVTM9TUkcaJMjH1H
 Mn24WxE5VaJATMEAAEIAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCZ8xVYgAKCRA/8w6Kdoj6
 qncxCAC1BsVE/+rd/5CBk99dP6q258eaIklztgwalzAbiAUwshdzyLG9cyZ6u2ytuxTBrqTbrWp
 smHnDQZacnljblWiy6NJr/ly5cUEKsAfJn1TU8gKt5WCtLS/FE7qUUuBGx22R5YilueAXP65oYh
 RfDNjYPv8QaMiWVHvIip5w04wGOsdxc1Wnw8RDFIyOrtsjTEVIKQt8iEZhtYI6syqq3M5XQTwFw
 iK9ucM8EPbKJzSCtY44v0ncyQPcEy1dqrpAh6dvoPuSSEZkKRHePNcBV5M73S2CnibZr1MoAdCj
 XSENA1clkVLEyxpKXMfBOPI796KoB9ZbMz87CHJy64vqe6e+
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

The V3D driver still relies on `drm_sched_increase_karma()` and
`drm_sched_resubmit_jobs()` for resubmissions when a timeout occurs.
The function `drm_sched_increase_karma()` marks the job as guilty, while
`drm_sched_resubmit_jobs()` sets an error (-ECANCELED) in the DMA fence of
that guilty job.

Because of this, we must check whether the job’s DMA fence has been
flagged with an error before executing the job. Otherwise, the same guilty
job may be resubmitted indefinitely, causing repeated GPU resets.

This patch adds a check for an error on the job's fence to prevent running
a guilty job that was previously flagged when the GPU timed out.

Note that the CPU and CACHE_CLEAN queues do not require this check, as
their jobs are executed synchronously once the DRM scheduler starts them.

Cc: stable@vger.kernel.org
Fixes: d223f98f0209 ("drm/v3d: Add support for compute shader dispatch.")
Fixes: 1584f16ca96e ("drm/v3d: Add support for submitting jobs to the TFU.")
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 80466ce8c7df669280e556c0793490b79e75d2c7..c2010ecdb08f4ba3b54f7783ed33901552d0eba1 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -327,11 +327,15 @@ v3d_tfu_job_run(struct drm_sched_job *sched_job)
 	struct drm_device *dev = &v3d->drm;
 	struct dma_fence *fence;
 
+	if (unlikely(job->base.base.s_fence->finished.error))
+		return NULL;
+
+	v3d->tfu_job = job;
+
 	fence = v3d_fence_create(v3d, V3D_TFU);
 	if (IS_ERR(fence))
 		return NULL;
 
-	v3d->tfu_job = job;
 	if (job->base.irq_fence)
 		dma_fence_put(job->base.irq_fence);
 	job->base.irq_fence = dma_fence_get(fence);
@@ -369,6 +373,9 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
 	struct dma_fence *fence;
 	int i, csd_cfg0_reg;
 
+	if (unlikely(job->base.base.s_fence->finished.error))
+		return NULL;
+
 	v3d->csd_job = job;
 
 	v3d_invalidate_caches(v3d);

-- 
Git-154)


