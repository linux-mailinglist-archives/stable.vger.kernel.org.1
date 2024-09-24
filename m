Return-Path: <stable+bounces-76981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9D99843FC
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 12:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1CC1C22CE8
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 10:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F111A3A98;
	Tue, 24 Sep 2024 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TjFjQwTV"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBC71A3A92
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174902; cv=none; b=gRo/xqz/m5O/mwgzOc0sHdCLWI1MPhExVKxEPSYXXdIubFsXseMf4u/+JZY/8bev/sZwk6tybUpp9cYq4VZNgLnbXOJXOIKkAcob9+lhZXn65/TCUPpYlg0kDYa1aA//++CBfjb/vPd8geUWwPXh7w+xKeD/B4dzQED8p2GIEJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174902; c=relaxed/simple;
	bh=5pHKYiUAz3OE3jd+TKhmpw9WD2/cESLNOJycxiIS31c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBqrpSr5uRh66fOtYQDkrMwKR5dpCoDhqBoN3HNu3h6fsaE4LH6/6Q6RhBsDIgi18Q+6sHhAVWEbmFsE96x7GCzIjIq6k2OvO2xru/Pmeha/QbqmpaXyorSfuwEq8S7mdB+deddz53FDfLxxc2c7Ny243+25+VL7+yg4HbWwtfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TjFjQwTV; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PL0EryNJHMxg8jGdJLmugrzcjMPFfBHMILcdQ7bYj1o=; b=TjFjQwTVxm+1TbSJLm3zbXlkm7
	Khvim/+/HChyBFXPkl11DGdEAUH4xmsFCVmk/ciZQH94H3+xejqwoKcUE1bMFdYMvJHtGeVWqjNw+
	do40oPNPSTdD+nWU/Y828iEylEyG1ooxwTsT4T0r3cWtMkRv6OjV/F6/rLYJNvjmF2N2C3b1JiFFU
	S2RKirMGSvZz2XlNRRZ4NrzJzp4XgDCp7SvAdtrhBgTqH5VdQPG/J4ZnUdvVDqGSlRdZ/10/NJQfR
	zDsOBiGzqXXcTqf9SIHVKcr/3ryLF2OBn3ltro4Hzr9ejm+KOOWMvCwIEV6JmBmdog/IU0o4dbbMf
	hAvVpQRg==;
Received: from [90.241.98.187] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1st2db-000L2K-RZ; Tue, 24 Sep 2024 12:19:19 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Philipp Stanner <pstanner@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/8] drm/sched: Add locking to drm_sched_entity_modify_sched
Date: Tue, 24 Sep 2024 11:19:07 +0100
Message-ID: <20240924101914.2713-2-tursulin@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240924101914.2713-1-tursulin@igalia.com>
References: <20240924101914.2713-1-tursulin@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Without the locking amdgpu currently can race between
amdgpu_ctx_set_entity_priority() (via drm_sched_entity_modify_sched()) and
drm_sched_job_arm(), leading to the latter accesing potentially
inconsitent entity->sched_list and entity->num_sched_list pair.

v2:
 * Improve commit message. (Philipp)

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: b37aced31eb0 ("drm/scheduler: implement a function to modify sched list")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Luben Tuikov <ltuikov89@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: Philipp Stanner <pstanner@redhat.com>
Cc: <stable@vger.kernel.org> # v5.7+
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 567e5ace6d0c..0e002c17fcb6 100644
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


