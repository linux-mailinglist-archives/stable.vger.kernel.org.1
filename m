Return-Path: <stable+bounces-192225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D82C2CD80
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 16:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4385F341E72
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B0F26C3BE;
	Mon,  3 Nov 2025 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M16VKZgm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12A983A14
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184689; cv=none; b=fJfoi92tS5/VMh6gs1K7oZx2QOkWM+ZRMsDyUIWA/t0K0KtX0ylosez0sc/Wq3YJgDXqr+zqrrk0d+k5aX1p9vtT7ddkRGOy67GCev4Id6NBmj8oQuTAwEK1RpocVA6x9cKpUOuDY1m7cuLCugoBU85JNUIk76U4iSOdaPX+wI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184689; c=relaxed/simple;
	bh=frns27hdPqkhuJ92qTvyyZFxlcYDJXaCUIlalP/lfuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBLrUJbKVJtS3zurUUsDufAyG8nonEYmaXpPuwxZdPTYqMoJf+I6uHCgZh3t3uAJGP1jntjYNna8jngEAUoakkMIa1256MiU/v0M7/aRk32Vml8NkQp2xs6rJAxZGySa0brZVJSG23UAnrJZLqWh+s1wlOCQr/CTEZNOv/5WaxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M16VKZgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93CBC4CEFD;
	Mon,  3 Nov 2025 15:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762184689;
	bh=frns27hdPqkhuJ92qTvyyZFxlcYDJXaCUIlalP/lfuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M16VKZgmeF6o/CYD3NWpvUPyfFWj8ADPcrUC1z1cEyyuBKQ+X6KyL+uxCxaAydsWz
	 Cu3AofT9fVfo2drKMyRodtnotnVIXiLzCAAWjuSgWiO+Gg8N7WJwHcuh4XLi7NnCZC
	 nHOkb9mD6ynFilqybLDtoRgo8a8h4veI9eVzWcEhWqUbCIkZraWGfH0eh9rzawNZ0G
	 7nawhPM/vsnOCmsV0s5oparavqqTYoweBcR02s84IIvMKW2Hy8AXpkJ2Q91WCJBFB0
	 hbZaXnBSZqqJRoLD5yPgHOomuFdDxeTqs0Ter8DblIaAh9BvwhyYfCzH9oCjRejhlG
	 QBrI93g1X/zsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Philipp Stanner <phasta@kernel.org>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/sched: Fix race in drm_sched_entity_select_rq()
Date: Mon,  3 Nov 2025 10:44:46 -0500
Message-ID: <20251103154446.4056428-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110344-huntress-jittery-3aee@gregkh>
References: <2025110344-huntress-jittery-3aee@gregkh>
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
index 9343b5a74c71a..38951c4a62faf 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -456,10 +456,11 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
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


