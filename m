Return-Path: <stable+bounces-59075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E47192E33D
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 11:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9408EB24140
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 09:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694551527AA;
	Thu, 11 Jul 2024 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="He6IfgLi"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B9EDDDF
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720689351; cv=none; b=f51V+AwCt9iBS8rKbuvidCNLGNyHwrKkI/fO/NzQ2q5HQwSIlD/watG4xkz8iTILVaQWBXu5GSBP00MKzKYMkM6JRNkjxLwTPeNxX5lQhpwqVj9aPXqycfhKcJYLPkf2ycL3uNDxKsfl0F8/9BuqrHowgv0zOSaq0569X+nr48Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720689351; c=relaxed/simple;
	bh=MSkyHrqHW+IQiTY1paw47/f9/irmfPW6+wSHxMrJ8Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnkhrIPF8Dmf2kgHYM4YsffL1oSSPZTDIS8bmkm0qUIkvExmzNr/NDSWP4/BQwV8Q6MBoggxKgUHH+w556NizvKfHVFv66tN9aUweVRSRDEbfTMXnCleZYRO6Fm21AXu61JbFBGby1XdtxEKAnc3C11M1oosnJcW6vgmFnXbp1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=He6IfgLi; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FIGyg6oNOF6x6modz3D+rHkGGJr55WEsrfdHTkFerYQ=; b=He6IfgLiXmyQ13eQHDbL4rAkqj
	EVV2WnlHC3Ca7lN8atl9RQ+moSSJcKzr8WM//u/lMLKYZzOGKCgVe9qdjVkmqJ/JRY0DCjnHZRMB3
	tEmE5dlX9kxoQB1VZp3vPlIyWPjfar7zJkl3A9U3qAuliyhwiRZ8PM2295+aUDGEbXJIoHacdi72e
	vYLDiOTo4hDuhTpFLoVxe6ukEy7nwkTyol4ebJ+7OIkPTRUi33IZg9iukT8RBxr1NbYGMi06i8YM2
	UQN8y+gMmE6fzGcrEwVDN+7YDytHOVJZsplaDyB62cq0tIl9OU01XzkgBfCy3OzXTLqO2kMe52kQH
	JXNwP4og==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sRptw-00DcKK-DB; Thu, 11 Jul 2024 11:15:44 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 01/11] drm/v3d: Prevent out of bounds access in performance query extensions
Date: Thu, 11 Jul 2024 10:15:32 +0100
Message-ID: <20240711091542.82083-2-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240711091542.82083-1-tursulin@igalia.com>
References: <20240711091542.82083-1-tursulin@igalia.com>
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


