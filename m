Return-Path: <stable+bounces-58917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5729E92C19F
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 19:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFD31F21841
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 17:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B2B1A00D3;
	Tue,  9 Jul 2024 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OMHkSiwN"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578051B29B5
	for <stable@vger.kernel.org>; Tue,  9 Jul 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542888; cv=none; b=PslA+KfOzUyACj3wpCuKDBq4QsvYXFU5Xl1Bq9atHPx3FvG2XwrBTwnY7oc7sMWDOXIIPQoREZ2aIGDSSC1pOKsklUr6ryKKgd4q36rmmRSInZhdhLcvSScGomqKhdy8qc7cdFe3HwSXyZ93UofEusPHb0G4iLxdkgBp5LJ4ehE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542888; c=relaxed/simple;
	bh=bvJx/TrdXBmW1Ftw5YSby4sRHHtot4RROW960/5RAHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+rvV+UKq2K6fgmQi2mTMvUjhz6Daw/9iOov7NJgkdnTdqxohCm1+GalNeSJqmIW2ZlWzw0a3zEJoe8ZnB6JhqkLXTGAttZN5xMWzXs/S1iaS6HwCuthSPKi+XK1VBHQ0AWfJZFdTxw4BMgmYBhd0UKb+yCbO45HWhvItoRT1tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OMHkSiwN; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lUWT7OEVdaa9leDIsW4NotJCuqqFsJk3YdxE80TeHrY=; b=OMHkSiwN/08TIkr0ssspvKC10j
	F132sjirtOFQcAK/2B6eKancnRT2mDA+alvN/+bqRNAXGIwksiuhY62jLSmD5EQt41TwYdOx3AMLu
	Oek4P/nf1PMiCKOGwc8Kiq7hu1v65HeFuZVXhaNYDG87dpwq0ZXuutay9YXDhOXy+PeTVZa7HO//s
	I3T7qP4BMSk9vQsvbs2yD+PUqHIynDRJzJjhYa0tFgaAOtee6pZpsiO/1t/F9jG7r7wv29sMIz9cG
	UgfnAumAzaV2A2TT3BXdTnVk6n+3zhf4Xws3Y9Bxmhl+j+JB185IfbbsKwLcsL/G9euYHBq+oRYt2
	Sy2IOLpQ==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sRDnY-00Csoa-L8; Tue, 09 Jul 2024 18:34:36 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 08/12] drm/v3d: Validate passed in drm syncobj handles in the performance extension
Date: Tue,  9 Jul 2024 17:34:21 +0100
Message-ID: <20240709163425.58276-9-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240709163425.58276-1-tursulin@igalia.com>
References: <20240709163425.58276-1-tursulin@igalia.com>
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
index a408db3d3e32..2c4bb39c9ac6 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -714,6 +714,10 @@ v3d_get_cpu_reset_performance_params(struct drm_file *file_priv,
 		}
 
 		qinfo->queries[i].syncobj = drm_syncobj_find(file_priv, sync);
+		if (!qinfo->queries[i].syncobj) {
+			err = -ENOENT;
+			goto error;
+		}
 	}
 	qinfo->count = reset.count;
 	qinfo->nperfmons = reset.nperfmons;
@@ -795,6 +799,10 @@ v3d_get_cpu_copy_performance_query_params(struct drm_file *file_priv,
 		}
 
 		qinfo->queries[i].syncobj = drm_syncobj_find(file_priv, sync);
+		if (!qinfo->queries[i].syncobj) {
+			err = -ENOENT;
+			goto error;
+		}
 	}
 	qinfo->count = copy.count;
 	qinfo->nperfmons = copy.nperfmons;
-- 
2.44.0


