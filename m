Return-Path: <stable+bounces-59125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E4A92E9F0
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 15:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED47B21000
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 13:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8679815FD01;
	Thu, 11 Jul 2024 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mivHRjbE"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350F54CE09
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706030; cv=none; b=nmW3t7TwZuU3Tjy3KY/7tG0hlTasDrzJ8hTtUC6T3R+6feMYJFL8qWvGqbVCdEaA3dovFIrO3beJCXPUaS7V3lP7SObRs5CYpzS6UU3PfN44X6rPFrH7SA8sKidRjZSM52PM4UpDcYTBOxklEp8NuYRORdG7/x27NpgUPHv/8cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706030; c=relaxed/simple;
	bh=3e+hzON0xwe3PxPicysjHDdvVFkRZ4LM31wf59xLxOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oeY8xxL9lLcMM+owFSynZTX+pnugmbWceHA7NPiS0IPX03MpdXxKIKS6bo3B6m4mHvYRF58/fgk37VxP3pi+1fvAfO2k6A0zg7Kt1s3YMQkFD/Mu9xE3ZP2HPMM1MqEfIoF/3SwZFNZ88XgdO9CaQEYqf8nz6K6l5U0tZSjuI/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=mivHRjbE; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Q7iLfP5wFpU1dyTQ8u//pl8Ug2inPHMvEM/15Lwrp4U=; b=mivHRjbEEOrr3qEZpIpCULDpG6
	u9D8N5qn8LDoTWbM9041NW4RnBlf9biZuugjY5QWKlu6mVY7OG2k9EpoxRvJMGQbIvLFzR82j7fRc
	RQC2KhyRc9f1FCsp4rPqrRLekKCMWqGyou0IDGxkclDjX8yI5N9xFNt+v6ic9PS9GeObUhYl/R3AP
	UbdPjYweCmzH7O0d46PcAWiAfjmhl088e5qNtBOKKXVVx+B5LLmydtFmdhhDYwmCPhNyJSo0Qz8N+
	YHfdk//KGhiqVOHwqRS5gH8FouA2FtTIVdmWMtjqQn/0SBpLSQf+gACO4FbP2QBgJauhKH7nJvciD
	IUfstTpA==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sRuEx-00Dieq-1R; Thu, 11 Jul 2024 15:53:43 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 01/11] drm/v3d: Prevent out of bounds access in performance query extensions
Date: Thu, 11 Jul 2024 14:53:30 +0100
Message-ID: <20240711135340.84617-2-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240711135340.84617-1-tursulin@igalia.com>
References: <20240711135340.84617-1-tursulin@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Check that the number of perfmons userspace is passing in the copy and
reset extensions is not greater than the internal kernel storage where
the ids will be copied into.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: bae7cb5d6800 ("drm/v3d: Create a CPU job extension for the reset performance query job")
Cc: Maíra Canal <mcanal@igalia.com>
Cc: Iago Toral Quiroga <itoral@igalia.com>
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Reviewed-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 88f63d526b22..263fefc1d04f 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -637,6 +637,9 @@ v3d_get_cpu_reset_performance_params(struct drm_file *file_priv,
 	if (copy_from_user(&reset, ext, sizeof(reset)))
 		return -EFAULT;
 
+	if (reset.nperfmons > V3D_MAX_PERFMONS)
+		return -EINVAL;
+
 	job->job_type = V3D_CPU_JOB_TYPE_RESET_PERFORMANCE_QUERY;
 
 	job->performance_query.queries = kvmalloc_array(reset.count,
@@ -708,6 +711,9 @@ v3d_get_cpu_copy_performance_query_params(struct drm_file *file_priv,
 	if (copy.pad)
 		return -EINVAL;
 
+	if (copy.nperfmons > V3D_MAX_PERFMONS)
+		return -EINVAL;
+
 	job->job_type = V3D_CPU_JOB_TYPE_COPY_PERFORMANCE_QUERY;
 
 	job->performance_query.queries = kvmalloc_array(copy.count,
-- 
2.44.0


