Return-Path: <stable+bounces-80736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6A7990329
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 14:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8486D1F21887
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 12:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597A41D2B1C;
	Fri,  4 Oct 2024 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YZhcQY68"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3C31D3589
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 12:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045544; cv=none; b=ngdj7kT4QipqtcPM1dlYxNjt2+p7pVZIYO90wBSZU4f/GWUPjnSwEC7L00x9uNoI6zQvhQaD5yl40Oh7mqYdgd6JDsw4NJsOVHBWLmMEpH524blA9EMYRVj5+Nx3J1GhuGmYqeC+enpXoP9Q/DULlwARDlQsShKf/P92Yf/XUa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045544; c=relaxed/simple;
	bh=YpbT9xdIR757GlbFl+vsG+cITjXVv8x0R7EGC1ILN+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdrovz3JVleA56DdO8Az0MiSfkrbPOB+ajJKTyVWPt7Z/W/fct4djHWgDmVozIqWVsaGPyuEpQ/WO3x1BOyRTibhzF/75654dxOmM9TmavjJg3apKDDsPp54c8tgNC3LiC4VyN5j0dRJ3gB8+cnPqUC5eBAW5v8XZS51eCAIAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YZhcQY68; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=d2iMVdiX4Q7fHdp7dKgJJFBNw8ERc0WaBdqcXcFR1H8=; b=YZhcQY68RgKTBunsJ8HeLznITf
	OAvY4JOG/XZgQn+Cf6YBkPRdrnax+B1uamx2b6iD6Xr3kozirc6Au0mARMuCST+XKELZ8L2vjFMeA
	N7qSWFdcFvoEcW/yvYUrRziqEQRLGq3Jh47+JxBi0WVMDQLUxwwMheox1UVk9lXBr8Dz3Ko6qBOiE
	2Ub9E3RHKYT6jHms02LPayimFfVaXAoHz6XHhVgRkthT53rr58sBnwCPlZRn0Dx0lMOcDPoT8O8Vq
	5ASrGOe6nc49EL5TxDJNOXluc+C2CYC0CYKZ2MjRe8U8oBA1gqmcXgs40Dw4BbdtQRi4QXKelpJoK
	/S94RAww==;
Received: from [187.36.213.55] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1swha7-004phG-4C; Fri, 04 Oct 2024 14:38:51 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	"Juan A . Suarez Romero" <jasuarez@igalia.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	stable@vger.kernel.org,
	Boris Brezillon <bbrezillon@kernel.org>
Subject: [PATCH 2/2] drm/vc4: Stop the active perfmon before being destroyed
Date: Fri,  4 Oct 2024 09:36:00 -0300
Message-ID: <20241004123817.890016-2-mcanal@igalia.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241004123817.890016-1-mcanal@igalia.com>
References: <20241004123817.890016-1-mcanal@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Upon closing the file descriptor, the active performance monitor is not
stopped. Although all perfmons are destroyed in `vc4_perfmon_close_file()`,
the active performance monitor's pointer (`vc4->active_perfmon`) is still
retained.

If we open a new file descriptor and submit a few jobs with performance
monitors, the driver will attempt to stop the active performance monitor
using the stale pointer in `vc4->active_perfmon`. However, this pointer
is no longer valid because the previous process has already terminated,
and all performance monitors associated with it have been destroyed and
freed.

To fix this, when the active performance monitor belongs to a given
process, explicitly stop it before destroying and freeing it.

Cc: <stable@vger.kernel.org> # v4.17+
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Juan A. Suarez Romero <jasuarez@igalia.com>
Fixes: 65101d8c9108 ("drm/vc4: Expose performance counters to userspace")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_perfmon.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_perfmon.c b/drivers/gpu/drm/vc4/vc4_perfmon.c
index f2e56d0f6298..f1342f917cf7 100644
--- a/drivers/gpu/drm/vc4/vc4_perfmon.c
+++ b/drivers/gpu/drm/vc4/vc4_perfmon.c
@@ -116,6 +116,11 @@ void vc4_perfmon_open_file(struct vc4_file *vc4file)
 static int vc4_perfmon_idr_del(int id, void *elem, void *data)
 {
 	struct vc4_perfmon *perfmon = elem;
+	struct vc4_dev *vc4 = (struct vc4_dev *)data;
+
+	/* If the active perfmon is being destroyed, stop it first */
+	if (perfmon == vc4->active_perfmon)
+		vc4_perfmon_stop(vc4, perfmon, false);
 
 	vc4_perfmon_put(perfmon);
 
@@ -130,7 +135,7 @@ void vc4_perfmon_close_file(struct vc4_file *vc4file)
 		return;
 
 	mutex_lock(&vc4file->perfmon.lock);
-	idr_for_each(&vc4file->perfmon.idr, vc4_perfmon_idr_del, NULL);
+	idr_for_each(&vc4file->perfmon.idr, vc4_perfmon_idr_del, vc4);
 	idr_destroy(&vc4file->perfmon.idr);
 	mutex_unlock(&vc4file->perfmon.lock);
 	mutex_destroy(&vc4file->perfmon.lock);
-- 
2.46.2


