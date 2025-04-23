Return-Path: <stable+bounces-136052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E5DA991B6
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE23516D9B3
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ACD27F751;
	Wed, 23 Apr 2025 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y/smgXlN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FA62798E3;
	Wed, 23 Apr 2025 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421529; cv=none; b=ihWv0YSXFqPmjIEJYMjGUoh6Ag23JQRgOIyz3cHpjJXLxOF7DOuQtBMX45dTpVE4DjL4KIjkBd2J/pnlbuaeSKju1BGEKpxBtXw7omjFPMxsDa6vdu181DzELQczIbWLbGGxZTOkUaumprLTK6ZBcV00MZ7UBQwTHEkhSG61Bu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421529; c=relaxed/simple;
	bh=+oagyEdmEdE/sbORug3/124JFuFSFKRxir0J/zqTtH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddO6J2fIoi/BZ+8aMS0EIUngiYYjfUla4L05wUFxksNUAiMSHXW2W28TTCEzqPEkFTufLyTQjrwadYBV++qaJF1ZN+gFbevhfopjxOD3E6z5Aa/am4C/RsRN71XZ35niF7dpFOWknUnIojRlkH+ptHvuf9qeAh/fL0isxBI9WEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y/smgXlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB594C4CEE2;
	Wed, 23 Apr 2025 15:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421529;
	bh=+oagyEdmEdE/sbORug3/124JFuFSFKRxir0J/zqTtH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/smgXlNeEdy7IjnOy93ePb2e3Z5u8w6pbX7GD2Oy3OQLrgrzFKHqz1qOiNPj07AG
	 ABiO4WWWzO5OjTCo2XbDk0u/fHk4b6QTTfJS552CXdij5/2c/4Z2NdVaievqeLD6lR
	 jVvE5LQw94xWkbV8lq7ks40ZQSIT9yuPeh8goGgE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brendan King <brendan.king@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>
Subject: [PATCH 6.14 199/241] drm/imagination: take paired job reference
Date: Wed, 23 Apr 2025 16:44:23 +0200
Message-ID: <20250423142628.638536944@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
References: <20250423142620.525425242@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brendan King <Brendan.King@imgtec.com>

commit 4ba2abe154ef68f9612eee9d6fbfe53a1736b064 upstream.

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
Reviewed-by: Matt Coster <matt.coster@imgtec.com>
Link: https://lore.kernel.org/r/20250318-ddkopsrc-1337-use-after-free-in-pvr_queue_prepare_job-v1-1-80fb30d044a6@imgtec.com
Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/imagination/pvr_job.c   |    7 +++++++
 drivers/gpu/drm/imagination/pvr_queue.c |    4 ++++
 2 files changed, 11 insertions(+)

--- a/drivers/gpu/drm/imagination/pvr_job.c
+++ b/drivers/gpu/drm/imagination/pvr_job.c
@@ -677,6 +677,13 @@ pvr_jobs_link_geom_frag(struct pvr_job_d
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
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -866,6 +866,10 @@ static void pvr_queue_free_job(struct dr
 	struct pvr_job *job = container_of(sched_job, struct pvr_job, base);
 
 	drm_sched_job_cleanup(sched_job);
+
+	if (job->type == DRM_PVR_JOB_TYPE_FRAGMENT && job->paired_job)
+		pvr_job_put(job->paired_job);
+
 	job->paired_job = NULL;
 	pvr_job_put(job);
 }



