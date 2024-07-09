Return-Path: <stable+bounces-58915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A5492C210
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 19:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91605B2EFE5
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 17:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869691B29C4;
	Tue,  9 Jul 2024 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PF+MYIye"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578571B29B6
	for <stable@vger.kernel.org>; Tue,  9 Jul 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542887; cv=none; b=CtKlLFGNuK2+LpKB6d3nGOHltl9HW3QRwE4eOmDFJ8guRRkMI8blJu+w5AYVMMzxL9SyGPrALyA8Egz2jGDQ4J/IJ5LkNndG2lCwvBC0NNacu+lyxTRDxMiOvtrJtBikbPtBqzHQSf93sx6i0kp5oyYjNDezC4XWJiH5UA53/v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542887; c=relaxed/simple;
	bh=JLDo40a7C0QPR3ewnmlKOXS6CfkWx3t5admGcKsS/5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OC54iqnKJHtXZl0TomjDyFKbJSYGoTti/2S4Mdw2eQBNT9TcvB4jbhcr1Gf1uzadv6O2wTCP7pfM5hI+Xq8x3xgBVSGCklXAMP/UlVsgoWdZ0yDkKsmZCIuMlNlUlJupcxOKpvQXJKGPeZM8KG9gP2fT9H5ihbLZJhya66+m1m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PF+MYIye; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=koLDN1PR3znJTaiuCGWTae1dfYUoXjyFBExlwnb98oc=; b=PF+MYIye1SgGQP2nPpvf6ldq7D
	Y0Tlc5gIqFpWZW/W8+vrMDzEigYAIApGmronRc5RgFKlSHntv6ObK4a3tHnF2IKYeV4cAqfQI5J8Z
	O6d9X/vEjkDhEEw7TgB3h5skFL89GyGoj7gKgu5P4sg/czH//xyE8nl/7RBRo5mpCI4RO1Hlw+BIF
	4lmS8EzgezvhdK5HXzH8RZsIuj1GEyFsm4m3QP5ddmHfhal0apoD7MTYr987djnrRLkjVbvzBOIcU
	UzG/xRhESqzi8L+b9oMvVIeHFEg+5JDnEGSr2bNQU1/pQ84xOSnwbYxAtMtv6SfgNp94MluSQ/wCf
	xqu022cQ==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sRDnX-00CsoV-WC; Tue, 09 Jul 2024 18:34:36 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 07/12] drm/v3d: Validate passed in drm syncobj handles in the timestamp extension
Date: Tue,  9 Jul 2024 17:34:20 +0100
Message-ID: <20240709163425.58276-8-tursulin@igalia.com>
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
Fixes: 9ba0ff3e083f ("drm/v3d: Create a CPU job extension for the timestamp query job")
Cc: Maíra Canal <mcanal@igalia.com>
Cc: Iago Toral Quiroga <itoral@igalia.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/v3d/v3d_submit.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 81afcfccc6bb..a408db3d3e32 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -499,6 +499,10 @@ v3d_get_cpu_timestamp_query_params(struct drm_file *file_priv,
 		}
 
 		qinfo->queries[i].syncobj = drm_syncobj_find(file_priv, sync);
+		if (!qinfo->queries[i].syncobj) {
+			err = -ENOENT;
+			goto error;
+		}
 	}
 	qinfo->count = timestamp.count;
 
@@ -554,6 +558,10 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
 		}
 
 		qinfo->queries[i].syncobj = drm_syncobj_find(file_priv, sync);
+		if (!qinfo->queries[i].syncobj) {
+			err = -ENOENT;
+			goto error;
+		}
 	}
 	qinfo->count = reset.count;
 
@@ -619,6 +627,10 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
 		}
 
 		qinfo->queries[i].syncobj = drm_syncobj_find(file_priv, sync);
+		if (!qinfo->queries[i].syncobj) {
+			err = -ENOENT;
+			goto error;
+		}
 	}
 	qinfo->count = copy.count;
 
-- 
2.44.0


