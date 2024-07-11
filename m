Return-Path: <stable+bounces-59079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045E492E343
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 11:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CA07B25946
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 09:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E3B15572D;
	Thu, 11 Jul 2024 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cErZLg6F"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E649112C559
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 09:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720689352; cv=none; b=fyc7W0zR6RU7idTeXlcQW1I0HpSlbk23Ef6owk0y+tJNssBqE6qvl7KgdRXtAR/pbgwhFd5d9/9pNZ+EJx682h9hJ+Am5nJeIOnWc8PgH+Kk0nEYoNF7fk13+0HZUgjXzcLdf3d9WRJGRuP/M/BVEZ1H4AgtUdWeATapMhC2b4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720689352; c=relaxed/simple;
	bh=IhKr3fK6i4RUFxlIV3q0lN7n/EJwZmeT/fP+9PIftR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6qaGIn7/JnBVPr3WH8tSTtjHDSv11exDY7WmsGNJrsbbJ+gYZuLvVipybtwISM8RW7ZZsU0As0JMyXrIIQQcKMo19JuBCVWUEcikUWxD4h2FxBEatkw3hXWEl0ozW1d3hwXXRoN2rSJS1OtAsRAzaV77zhSPTnLAlYbitURqZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cErZLg6F; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YPNiIz3stEkLohQYb4JLVFQLWPs2wC9BvTR5uzKIUTI=; b=cErZLg6FViMKXrjiAF2rv89ZDn
	lPviyuHKQ8BqgQUkECCaYahJES4KeOKP3p+fU2/I41m06NqQ3rUk1EkqyPemIrWX4nm3YcUigJh82
	UaPiOPYIN25Xgj6h4arAaAuabv1RtK2inxfRLch4xm6iLkh/aTdGd9wlFCI5c0lsF6RHEZ0RHgiWI
	ROyw/3j6WDVqPbLGTfTLT5vZobWGem6hihHwVkelfmHKIMxe+Zsv2wfL6jac5xT/QZvYhF1PVi8pw
	mmdkt7c7gB+e03KO/ehab1Ir9+HGAOCrz3QrOENqSchvwxPRRUYoer/ip6uUxEPh0FzwYTaCBu/QA
	wnCfx0Vg==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sRptz-00DcKd-1N; Thu, 11 Jul 2024 11:15:47 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 05/11] drm/v3d: Validate passed in drm syncobj handles in the performance extension
Date: Thu, 11 Jul 2024 10:15:36 +0100
Message-ID: <20240711091542.82083-6-tursulin@igalia.com>
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
index e3a00c8394a5..3838ebade45d 100644
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


