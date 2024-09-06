Return-Path: <stable+bounces-73809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC8C96FA61
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 20:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9BB1C2147C
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 18:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089111D61B7;
	Fri,  6 Sep 2024 18:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GEVHNJJY"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D161D61A9
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725645997; cv=none; b=bdhCDOI9PQ8p9VexP5gW/anJAjGBlObEDqYWsTfoZDmUg2qsZcNScN724mJNwf2RKJM74+nivLUVa/lQVo5saKA+8dvrnw3AgSBqRXIdu8hnz5G44iFKabMdROr99X44SHZGThrId6lDQP4iaX/GJijg1J81eJ/N2Tq10TLXq58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725645997; c=relaxed/simple;
	bh=HUqW5Ib0VXCMvjCX9l1ln3rHLdafg6dkHBJKh8pnIpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h51llC8qG0M6t0zw882MetwKz40eJUU4VCP45+aFCngAV1nwJYEjr8rzCRvf4IKWHlvN+YXR+44UBuUY27UN940xTmYQSRd/YH3cqi4hjDqvj57Fcp0nyDaUuD693bJ00sV5Ql1rN764j+twHjwnKAIRIDXx/QilZUMYxOux7MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GEVHNJJY; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LbRKQC2natDUa9uyMFRK4EkFcMdJKzCTr7qA14B0ZsM=; b=GEVHNJJY0gMk64Jjm2g93r+ABL
	xQW0QLOZUhxkSsVtr7zqVOLz+gUZGJG5K78vSFiC4oFCuXXxST1xDpv5sAtRmekoSHmDPP6PoKyza
	0N8xfv2B/6G+UtgVdWgFt6W7hJL3HMu5FOb+j87l3FWv3rQd/z8leHjd3NWVOXJKb2mAm64LFORjp
	UlAVRoDuiPL63SgXcHoTz75nyNHmkE/OAWfbPAeYlQ8/BP0e467f3KiToYJSI7PnEjSKNwkB9JawR
	i/kgZYoVWUMrGv8/ero7/NIDV3+ski88WrffR6tvCECmZeUoeZYp7+LJ5pydArdVb3JKtVf+daSz1
	dS9kJaPw==;
Received: from [90.241.98.187] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1smdLl-00AW6J-2R; Fri, 06 Sep 2024 20:06:24 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	stable@vger.kernel.org
Subject: [RFC 1/4] drm/sched: Add locking to drm_sched_entity_modify_sched
Date: Fri,  6 Sep 2024 19:06:15 +0100
Message-ID: <20240906180618.12180-2-tursulin@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906180618.12180-1-tursulin@igalia.com>
References: <20240906180618.12180-1-tursulin@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Without the locking amdgpu currently can race
amdgpu_ctx_set_entity_priority() and drm_sched_job_arm(), leading to the
latter accesing potentially inconsitent entity->sched_list and
entity->num_sched_list pair.

The comment on drm_sched_entity_modify_sched() however says:

"""
 * Note that this must be called under the same common lock for @entity as
 * drm_sched_job_arm() and drm_sched_entity_push_job(), or the driver needs to
 * guarantee through some other means that this is never called while new jobs
 * can be pushed to @entity.
"""

It is unclear if that is referring to this race or something else.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: b37aced31eb0 ("drm/scheduler: implement a function to modify sched list")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Luben Tuikov <ltuikov89@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.7+
---
 drivers/gpu/drm/scheduler/sched_entity.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 58c8161289fe..ae8be30472cd 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -133,8 +133,10 @@ void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
 {
 	WARN_ON(!num_sched_list || !sched_list);
 
+	spin_lock(&entity->rq_lock);
 	entity->sched_list = sched_list;
 	entity->num_sched_list = num_sched_list;
+	spin_unlock(&entity->rq_lock);
 }
 EXPORT_SYMBOL(drm_sched_entity_modify_sched);
 
-- 
2.46.0


