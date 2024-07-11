Return-Path: <stable+bounces-59128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E098192E9F6
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 15:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54D99B213C0
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 13:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4DA1607A7;
	Thu, 11 Jul 2024 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KDsLyApK"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0E515FCEB
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706031; cv=none; b=FqtQ4euFr5xxRcka0lcL4URsJ+u6mjRKI0qpEYWmCsBIHJ09mXsHBciLgOSK2juZt9O+LeRm73GP8GcmfwU6E/Zqnl3u5KY9yYbUgV9uno49+v3Dh8uiTvNtr7R9Bo+cjL6jEh19XjgBvuNxivxA1s1pTGBvqaH5zmp8HtaL4jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706031; c=relaxed/simple;
	bh=AXitqBAmsnymxE9JIF6hQTX/sICBAD1fwliLjhE6Z7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxJ9fpCXE6nLIIMHRLSfHdS3dC0ZAIwgTWfy4VXcey7pvzbRSfS5YAsB5nfoOlXIv+wRzXVB6pmLG0QHxciALIdRSxU4A8+DL1hgLwAd9Q5ypXFH952xoJi5yWb+gKPMDnynOAEiO/BCaSgxpnmhJorhiDB2PXb3a4d5qIyPxoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KDsLyApK; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UWRR8NcVl471Zj1Z+bvpeF3g2ixP4/oX5ENOHO5aO7s=; b=KDsLyApKuJat/UpIwfOCtFCg3K
	5SO9xMH4D789J1zvVk1XgpcZQ74X/xLFsMhrgg/V4Qi11gXw4aQ/xxvPhY9DuML+NMq6X8/9iyYmq
	V3RUGj7iKZizXxA2FpJrz2/CKoJIb6yNKj/JnmwzY4lYtoo7Ce/jniJUCXWVtu2XE7CNdnBq5EVE0
	N5c0GH7bmgl3aHl47VjGtEOrMhm8YMWjc0GxkpiKFNx0ruBTCuGLpx8zTRNseSB9V45JkKq68Junz
	qoIrhP5y13aaYewAuz6T276mMO4qrT43iLDJ6fmaXzf6K5VfP3/tUqfboFqNUSp4NuSu/+flJxcxl
	G+aEt60Q==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sRuEz-00DifC-N5; Thu, 11 Jul 2024 15:53:45 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 05/11] drm/v3d: Validate passed in drm syncobj handles in the performance extension
Date: Thu, 11 Jul 2024 14:53:34 +0100
Message-ID: <20240711135340.84617-6-tursulin@igalia.com>
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

If userspace provides an unknown or invalid handle anywhere in the handle
array the rest of the driver will not handle that well.

Fix it by checking handle was looked up successfully or otherwise fail the
extension by jumping into the existing unwind.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: bae7cb5d6800 ("drm/v3d: Create a CPU job extension for the reset performance query job")
Cc: Maíra Canal <mcanal@igalia.com>
Cc: Iago Toral Quiroga <itoral@igalia.com>
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 9a3e32075ebe..4cdfabbf4964 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -710,6 +710,10 @@ v3d_get_cpu_reset_performance_params(struct drm_file *file_priv,
 		}
 
 		job->performance_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
+		if (!job->performance_query.queries[i].syncobj) {
+			err = -ENOENT;
+			goto error;
+		}
 	}
 	job->performance_query.count = reset.count;
 	job->performance_query.nperfmons = reset.nperfmons;
@@ -790,6 +794,10 @@ v3d_get_cpu_copy_performance_query_params(struct drm_file *file_priv,
 		}
 
 		job->performance_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
+		if (!job->performance_query.queries[i].syncobj) {
+			err = -ENOENT;
+			goto error;
+		}
 	}
 	job->performance_query.count = copy.count;
 	job->performance_query.nperfmons = copy.nperfmons;
-- 
2.44.0


