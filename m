Return-Path: <stable+bounces-59127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAB892E9EF
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 15:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB721C23090
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 13:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6168C1607A1;
	Thu, 11 Jul 2024 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Ve7+wKxi"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE3015FA9E
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706031; cv=none; b=ldkjpnxcx4s4fTT0rIb0asY7t+LdGoD13adolDufSxJukwcpfU9QIhR9KsL8vqNnbr1x3ZkpHJ1D6+Lec3owOkQfeqZ1FiBGVDkMi0lV5pk5snbFzhOOUBFA4ND74F1Cf9I88R2RR4zSsxQvARZgjTB0wbww5StIum4IM1edeQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706031; c=relaxed/simple;
	bh=UFOJm2kZG+MP6iK7WxQgilklthhHM+Cc1CakeqnrS4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntHuq9cj/t++iqfDhcOQJ4c31LFWRFU13V30ed4RtHJVmUk2p87iPW0lye6jKUzdSK5CDVwV5Fy/NDi2BL/zZzsgsIe4Srg3VseK6QhRsJIN8H29jwv67sB4oJ8lmzpxmrQNGpYSCS7UK+ueIQtMSiF9sa3JwJ38MeNo2MKrK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Ve7+wKxi; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mDmaElbIe6i75roQg6iinEJsMlogtcLjpouaERM3uek=; b=Ve7+wKxi5EX8vjwkcqs9Ln9dqa
	0UV+oAEyPyXZTOr9zIL+A4xEbZhNgUQ3WlZyamEDMckE0nGL4FQ86ws6Jl45B9r11X+MTxDbvh1P0
	Kq4PFcenZk9+5KMCOXOiR60pnOWAHJI6zKzp/NuxvNO/BzwzSVtKx2zb0d/hRqGONOLmhgzYNaxv2
	0hGaZnBpNFD/WF7rUlEG0CMUBTiOHJzMGaCK8OxD6jzsEkb6VH4HY8XT/qpMA52KA8wmc+nTUsO1+
	G6ptqYcK8yGHJFMs+Z3u4roE9vNZ+vTrKqnZmugBRIVF+KgOYRki1gXCd+bXRGhU0drUnzIqGe2Kj
	qdsB8UYg==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sRuEz-00Dif5-1e; Thu, 11 Jul 2024 15:53:45 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 04/11] drm/v3d: Validate passed in drm syncobj handles in the timestamp extension
Date: Thu, 11 Jul 2024 14:53:33 +0100
Message-ID: <20240711135340.84617-5-tursulin@igalia.com>
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
Fixes: 9ba0ff3e083f ("drm/v3d: Create a CPU job extension for the timestamp query job")
Cc: Maíra Canal <mcanal@igalia.com>
Cc: Iago Toral Quiroga <itoral@igalia.com>
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 50be4e8a7512..9a3e32075ebe 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -498,6 +498,10 @@ v3d_get_cpu_timestamp_query_params(struct drm_file *file_priv,
 		}
 
 		job->timestamp_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
+		if (!job->timestamp_query.queries[i].syncobj) {
+			err = -ENOENT;
+			goto error;
+		}
 	}
 	job->timestamp_query.count = timestamp.count;
 
@@ -552,6 +556,10 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
 		}
 
 		job->timestamp_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
+		if (!job->timestamp_query.queries[i].syncobj) {
+			err = -ENOENT;
+			goto error;
+		}
 	}
 	job->timestamp_query.count = reset.count;
 
@@ -616,6 +624,10 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
 		}
 
 		job->timestamp_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
+		if (!job->timestamp_query.queries[i].syncobj) {
+			err = -ENOENT;
+			goto error;
+		}
 	}
 	job->timestamp_query.count = copy.count;
 
-- 
2.44.0


