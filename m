Return-Path: <stable+bounces-64878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DA2943B65
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86C11F21355
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACE8183CD2;
	Thu,  1 Aug 2024 00:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJX/Cxz6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86110183CA6;
	Thu,  1 Aug 2024 00:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471274; cv=none; b=OpMPZKJ7FxPPlLTB9HXvbWFTpR6oxchdVIOIhsCbxRAeCjxPRGgqKPLS2i2yB6C+WZbe35j+IoFyLHjSGXuNQNWrP+68tNiBo4OoFQW+1Etp8MMTQOj4uEHDeTGTgEEGhMRhh/naWWrHs1FX2o6lsH1GVnnfgZwuFF8z/DwXblI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471274; c=relaxed/simple;
	bh=z0kPG+8i0YtyeC1UePHtGH+PiVUeD566BDbFxMMRRcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tflhQEwxRsVOiSVDxqg5dedlVDOEGIdMjqphhuF8oHoMh9e10mDGU1NpWjCw+Q4H/169pGlZd2geVXd4Ii51U7BAYKZi7SULJOkmJe6O2gI58BgUDpJKZdf8RTErYgnKKrpKnYQcKALsNHEr/ema9f4ZvvzpUpv9hoYst4G1+lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJX/Cxz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CCCC4AF0E;
	Thu,  1 Aug 2024 00:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471274;
	bh=z0kPG+8i0YtyeC1UePHtGH+PiVUeD566BDbFxMMRRcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vJX/Cxz6M0ja4iXAdihsP5IkWH4Lmhsrd06Uy89mDNxeh5RQc6OmL0ZRdMmH6Feqy
	 SVlbNgKm6hbYRqJQGBJNzEGpAqDYdsl7nOZj361GidY87aK89OPhVdzZECsgNQHTJe
	 KSMR8Aj60btiluJ9GTv92B6pHMTtgYNDeGF3piig2zgKDqWue/DvAEvE4WnZATXNxN
	 h2Wd4wV0kJCHZkrOTvL0xXD1/6dq3sQWhNwoQInoSW+CT+n+VK3TGZ/5XXuod98JJo
	 p65mdCjHN5xo0Yo+WTFESPTzVPwXzYiGPa26CFd/5rrxGtHmVCaSB8R6zYkoD+HhEA
	 0NRfNMn4ILBCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Francois Dugast <francois.dugast@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 053/121] drm/xe: Fix xe_pm_runtime_get_if_active return
Date: Wed, 31 Jul 2024 19:59:51 -0400
Message-ID: <20240801000834.3930818-53-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Rodrigo Vivi <rodrigo.vivi@intel.com>

[ Upstream commit 46edb0a3eb16cebc2db6f9b6f7c19813d52bfcc9 ]

Current callers of this function are already taking the result
to a boolean and using in an if. It might be a problem because
current function might return negative error codes on failure,
without increasing the reference counter.

In this scenario we could end up with extra 'put' call ending
in unbalanced scenarios.

Let's fix it, while aligning with the current xe_pm_get_if_in_use
style.

Tested-by: Francois Dugast <francois.dugast@intel.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240522170105.327472-1-rodrigo.vivi@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_pm.c | 8 ++++----
 drivers/gpu/drm/xe/xe_pm.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 37fbeda12d3bd..19eb12a91cf56 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -505,12 +505,12 @@ int xe_pm_runtime_get_ioctl(struct xe_device *xe)
  * xe_pm_runtime_get_if_active - Get a runtime_pm reference if device active
  * @xe: xe device instance
  *
- * Returns: Any number greater than or equal to 0 for success, negative error
- * code otherwise.
+ * Return: True if device is awake (regardless the previous number of references)
+ * and a new reference was taken, false otherwise.
  */
-int xe_pm_runtime_get_if_active(struct xe_device *xe)
+bool xe_pm_runtime_get_if_active(struct xe_device *xe)
 {
-	return pm_runtime_get_if_active(xe->drm.dev);
+	return pm_runtime_get_if_active(xe->drm.dev) > 0;
 }
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_pm.h b/drivers/gpu/drm/xe/xe_pm.h
index 18b0613fe57b9..f694005db2782 100644
--- a/drivers/gpu/drm/xe/xe_pm.h
+++ b/drivers/gpu/drm/xe/xe_pm.h
@@ -29,7 +29,7 @@ int xe_pm_runtime_resume(struct xe_device *xe);
 void xe_pm_runtime_get(struct xe_device *xe);
 int xe_pm_runtime_get_ioctl(struct xe_device *xe);
 void xe_pm_runtime_put(struct xe_device *xe);
-int xe_pm_runtime_get_if_active(struct xe_device *xe);
+bool xe_pm_runtime_get_if_active(struct xe_device *xe);
 bool xe_pm_runtime_get_if_in_use(struct xe_device *xe);
 void xe_pm_runtime_get_noresume(struct xe_device *xe);
 bool xe_pm_runtime_resume_and_get(struct xe_device *xe);
-- 
2.43.0


