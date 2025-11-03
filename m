Return-Path: <stable+bounces-192218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE58C2C9AF
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 16:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 76DC0345279
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724CE313E2C;
	Mon,  3 Nov 2025 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INzrl17e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318CB30E842
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181984; cv=none; b=CZUPftASqS7YP5EyCgAmaRYcX1IsvApU3Joh5gAVhZm05/tFQ8Z8pediaXiyjr0ckOoU8FchdBZ8+st+GmVPGw9FOCkHdqqcJBWaBM5z1eFc/hcufAEkLA73Do0BDgEtP1Spo/9xIWXaXYoFh6XKLnFmBYUx++HB/5mAVJg/qDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181984; c=relaxed/simple;
	bh=LzfTBkf5/1O6A9Zgq1hKU0NlNkDBMSRpu8UNmWUX9JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qg0AO8SdAVxcDSCPJWMwCsxLH37A0a+RJTdOJRgLUspM23h+wOEIzyCieZ49Meu4GIAZX5Pn0Pd7PgnurMcNJWd+qlUbbtlI0UZ0rUVW0RLvxq8EyQ5W2QaoU3UEC74ww2Tkdr2Z1/j22bhzSEPtOJZEU2U766rP1clHmYdCivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INzrl17e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC71C4CEE7;
	Mon,  3 Nov 2025 14:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181984;
	bh=LzfTBkf5/1O6A9Zgq1hKU0NlNkDBMSRpu8UNmWUX9JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=INzrl17e4doe7sPkDPL/P/mHbIbr3W4Q+kVelFfAwOsJX1YLFdBXl1koJbVcou27a
	 mIcL1M9wGJCGrmh+I41dyHidHHccCP9iChm1YTb1F3WzhVNlpvGBqQesbnoDxGJbJx
	 bq1qQ04sdLXoHAaxGFM1cOLH6aM2RckRKU0XVLHYjzT9bFcaXVxtQwPu9mvCMQYap7
	 /otZAzmEmvuS9zpfgeCnrDPl2WUCKLVcm/9NowJISoNEuer9zPsIqGtnxFJ49szPx7
	 Um2HPo3QSOHXKNm1cib1Ygikjn9fGSsbs+V+BTl81L+qqWISpwEMFw6O7leg3jngq7
	 utUq8s1yi/2LA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Philipp Stanner <phasta@kernel.org>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/sched: Fix race in drm_sched_entity_select_rq()
Date: Mon,  3 Nov 2025 09:59:40 -0500
Message-ID: <20251103145940.4040983-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110342-pristine-visibly-505b@gregkh>
References: <2025110342-pristine-visibly-505b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Philipp Stanner <phasta@kernel.org>

[ Upstream commit d25e3a610bae03bffc5c14b5d944a5d0cd844678 ]

In a past bug fix it was forgotten that entity access must be protected
by the entity lock. That's a data race and potentially UB.

Move the spin_unlock() to the appropriate position.

Cc: stable@vger.kernel.org # v5.13+
Fixes: ac4eb83ab255 ("drm/sched: select new rq even if there is only one v3")
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Philipp Stanner <phasta@kernel.org>
Link: https://patch.msgid.link/20251022063402.87318-2-phasta@kernel.org
[ adapted lock field name from entity->lock to entity->rq_lock ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 245a1ef5278e8..a13d6186af852 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -531,10 +531,11 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 		drm_sched_rq_remove_entity(entity->rq, entity);
 		entity->rq = rq;
 	}
-	spin_unlock(&entity->rq_lock);
 
 	if (entity->num_sched_list == 1)
 		entity->sched_list = NULL;
+
+	spin_unlock(&entity->rq_lock);
 }
 
 /**
-- 
2.51.0


