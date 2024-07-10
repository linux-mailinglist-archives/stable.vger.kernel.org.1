Return-Path: <stable+bounces-59014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAE692D30C
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 15:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B23D2841FD
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 13:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9808A192B94;
	Wed, 10 Jul 2024 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ooiw/xXI"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4ED192B87
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618902; cv=none; b=ZL97GLLK5gSWF9NI9WXibz6mXINCBscldatp89dGYs6gfXr2jswol1C1uEbxl11dDHispMXErazsueta9CqepEgWKbnnq+oVJw4AARibNijab4q9Zf3UJnksfQUUUenwFDZQlvWPNcFI3j9/RHaRp2LZ8pimwwZNRtrUDzvxdlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618902; c=relaxed/simple;
	bh=3joLMjrbPKgStlxHwruUhSO3ZGRX2GNfzE9H4Pu1/dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOCRuHPtTAuhRCfoNcyuWwTEltWP48Ey8g2AR9Cdg6m11vlCZbCmK2M/DBibi4u3ewhmBvbmlziIUUQU1A3u7CM3YktaZK6aMF9SlpXdBYff+blGNFr8bE81paBrNZH/4vbgZYvcJsKgDQWqiOHrIPHSTJNN29gg4ae+Ih+Pqhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ooiw/xXI; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hcSzWaZaN7c2W1SaCkZxLgmhtR3XmsGLfSerFygdOug=; b=ooiw/xXIbWGZr9s8f3U1C9tt0U
	siVo1AZU0WdXJpHEvMpoQKgljsNmbP75M7Y+wEb3DhbR+evHiEmMoUTmf5kjZtRgzDQ02r4V0MIPX
	jLDZuipEaQev3F1IjiXdQlMGyB5JDWhz0TYNKzIPASrurliPOBIQHlZ0WK0xXeCFFjmGMqd8m/Wm2
	dOfvakE7LTN3yAsam5ik+i3FnCXj3GQUgqfdUzg9seeFYqCTN/0J4otFfLmSTeJ5t5SIKrgYW+FMc
	YpRNdi/ONokD5b36SmLCrQVuOQcTfhEeDYmgcuj8a7cqEgEVs9bD0VZUCC8zj2pGz0I7wCYRcor10
	KDNaFp0A==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sRXZg-00DH19-W4; Wed, 10 Jul 2024 15:41:37 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 05/12] drm/v3d: Validate passed in drm syncobj handles in the performance extension
Date: Wed, 10 Jul 2024 14:41:23 +0100
Message-ID: <20240710134130.17292-6-tursulin@igalia.com>
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

If userspace provides an unknown or invalid handle anywhere in the handle
array the rest of the driver will not handle that well.

Fix it by checking handle was looked up successfuly or otherwise fail the
extension by jumping into the existing unwind.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: bae7cb5d6800 ("drm/v3d: Create a CPU job extension for the reset performance query job"
Cc: Maíra Canal <mcanal@igalia.com>
Cc: Iago Toral Quiroga <itoral@igalia.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/v3d/v3d_submit.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 3313423080e7..b51600e236c8 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -706,6 +706,10 @@ v3d_get_cpu_reset_performance_params(struct drm_file *file_priv,
 		}
 
 		job->performance_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
+		if (!job->performance_query.queries[i].syncobj) {
+			err = -ENOENT;
+			goto error;
+		}
 	}
 	job->performance_query.count = reset.count;
 	job->performance_query.nperfmons = reset.nperfmons;
@@ -787,6 +791,10 @@ v3d_get_cpu_copy_performance_query_params(struct drm_file *file_priv,
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


