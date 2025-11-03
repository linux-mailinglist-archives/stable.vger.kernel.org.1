Return-Path: <stable+bounces-192197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C45F0C2BD6C
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 13:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1C064F529C
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 12:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631C330CDB7;
	Mon,  3 Nov 2025 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXVj6R0A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2307D41C72
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173896; cv=none; b=ZXLtFC7QWz5C2A0EMQzrvS/gc7MGnih/DUHo6hAM1HIy7DTjYErdpksV8UotORVan+wpOPLtmbjOwiY4omZLIYx4AQMeA2xRC8DyPqftl7Cmmb6bmxNY5ZZj7+9Nd5+bWT9kB8zlus/MikyQN7+5vLvXqO1vFBq3rntcv/v1y/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173896; c=relaxed/simple;
	bh=n77TQYVTX6kaVPbYK6QUg+dmPAHNZfPVi2fidSFY7/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLxILQiJWZoM8ZXdu/e/8XfloaZvz28fX3qppJ0odTrSXTkGEJgCQNwSZsO4olsRG7ZBnnqD0qvAX7F5m2oqGV5ADUnVLJk3kSoMLtxntYkuZyiX8KKBncFdGr9TsGITSSFJr71LPyX98l5ZeKwy6GU3xn8Jn0FFMySUPUONK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXVj6R0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5C0C4CEFD;
	Mon,  3 Nov 2025 12:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762173895;
	bh=n77TQYVTX6kaVPbYK6QUg+dmPAHNZfPVi2fidSFY7/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bXVj6R0At7nl27eafmUtN6l1eLkBUx5M6S5j7OgWGzq4OqKc+t8ImO20tgF1ARNUG
	 fY/1WDSSy+oGUR/Go5Qnsmvai2uWuH+0kv/7fqiclmzt0XNYmePY5Y190o4qBsIU+3
	 1njhJinf4utqdYSLHq5jMvkqGhFRi+MYmGbJL7yh9qGeXQ/yS/A2ygaLBatQHlTVW1
	 rHa4MRU86snT/RXElbKLPgJLw3bw8kKxkHvs+QCH7OItumN76DO3H6mRIepQyYY37x
	 Vx2PMJ7Kt18tCuAbgZSB4+AupoTOaHtm+OHSACByMib0dyJrbyw668wmJt0JA+9oBX
	 EtFreJxsS1GHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Philipp Stanner <phasta@kernel.org>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] drm/sched: Fix race in drm_sched_entity_select_rq()
Date: Mon,  3 Nov 2025 07:44:50 -0500
Message-ID: <20251103124450.4002293-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103124450.4002293-1-sashal@kernel.org>
References: <2025110342-exhume-mankind-5952@gregkh>
 <20251103124450.4002293-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 089e8ba0435b8..f5b5729433cbb 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -557,10 +557,11 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 		drm_sched_rq_remove_entity(entity->rq, entity);
 		entity->rq = rq;
 	}
-	spin_unlock(&entity->lock);
 
 	if (entity->num_sched_list == 1)
 		entity->sched_list = NULL;
+
+	spin_unlock(&entity->lock);
 }
 
 /**
-- 
2.51.0


