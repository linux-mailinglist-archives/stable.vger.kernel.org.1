Return-Path: <stable+bounces-59013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDC892D30B
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 15:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4392838A9
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 13:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F9E192B93;
	Wed, 10 Jul 2024 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Pq/YCBtz"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7DE192B71
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618902; cv=none; b=sPQdSxRF1gKyMJd6Ra30N6k/I3hXLCjuNeCoQ/maPN0Zy7E0ULoVRzWu+jO/cUiNa28wsUoVVNd9oVm2OD8TZqlUaESVfr1AVKNuAeXb1I8WebR6s+INphNPuYNt9346YXw7pvOOq+c6IHM3UCrCq7ayW5JcXMGCt9hR1mTIhC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618902; c=relaxed/simple;
	bh=cCLPFUmvKcpxFkThPVI5ji0IKus8GrWuWtXACVn/bxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gAXD0aoJMfiKSddFkurVVJpVZYfAT048U+Xx2rfGM9YbWB1i9e9AbWZOhlEXDx3ooLfDdaFwzqeD2tR7VgMNSNbBZeBqDDOuL5Wb4dkSIS71uUrDfPTsaKc/AvXS9bDnJ95cAuqXfpnn4iRS4hsx5fgCl/JA7Tb48QzYwrx05Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Pq/YCBtz; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2b1k5yU+YmJ6Limrt534OhRCK30OkGrtORCAhUx2zYU=; b=Pq/YCBtzWEy4gubTxKx2s/AQjh
	uvwZuap9mEfMHY4Tlq1iJokoA6Nr+NcFsOl87t4bhVXfPauuSQ+VyWmCpKNPRkD1pnoDaF7qAmOaU
	qvfWxyk0cEJPAvch9cPp8uxNvTU10aePJLWk/3dkni6p1LiOK/Oed/HBGHgCDZPx1soNhx1/uEY6w
	kyvw3NV6Y1SbmmQ/xfoKYJaJB+KE3nXbS1dw0xIvu0QBpVOaCbykxYUPzUQ7YHUO+YULdDMR0aXsL
	YjtFKUQbM2nBHiQjxj/0+CgLwYw1K+EJObVqCICVlXounUwh3DS1k1fAiY8xst8x7LE36i+V41wVB
	O/l1BXEA==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sRXZe-00DH0n-AP; Wed, 10 Jul 2024 15:41:34 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 01/12] drm/v3d: Prevent out of bounds access in performance query extensions
Date: Wed, 10 Jul 2024 14:41:19 +0100
Message-ID: <20240710134130.17292-2-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240710134130.17292-1-tursulin@igalia.com>
References: <20240710134130.17292-1-tursulin@igalia.com>
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
Fixes: bae7cb5d6800 ("drm/v3d: Create a CPU job extension for the reset performance query job"
Cc: Maíra Canal <mcanal@igalia.com>
Cc: Iago Toral Quiroga <itoral@igalia.com>
Cc: <stable@vger.kernel.org> # v6.8+
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


