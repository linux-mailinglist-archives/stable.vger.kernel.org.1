Return-Path: <stable+bounces-192220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9D0C2CAD7
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 16:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE45189C2A7
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 15:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7048D314B90;
	Mon,  3 Nov 2025 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKNKVwNb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9EA314B71
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182392; cv=none; b=JDVi4FsXrzo6Bo9q03Vkrd5eds3Fq/zxRDjHf3KK3RERM9BsdLaXQp6YX/oyAHNqkUEDEnMw+PGDB1r/cy4McljKajnCs4k1b06SgQl8pD1ElR6KGdEPEkM6niUw5IVLm/zl06XF26WW/qtjAA2L6xvBEKtfTOSZyu9mqFblbnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182392; c=relaxed/simple;
	bh=Xe8cPSqrgDHXwOZig0tkU1vtczIZ1flq2cHyMveTtuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pE24UgEIc2N00Z8ksiMNoerZriCynIzeBcT+WgWU2et6WWasMqyQto+g0sKAtdYZ5SQ3KO6kpPJdZdJdToV80I4TyBHCVbux0ONF+jrC6dxRRBDwe2CSuQMrQrIRiIbElz2/qWucb9ycVcWMH9Aa92p58GjdhCtzHPMkA+0/4zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKNKVwNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B281C4CEE7;
	Mon,  3 Nov 2025 15:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762182391;
	bh=Xe8cPSqrgDHXwOZig0tkU1vtczIZ1flq2cHyMveTtuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKNKVwNbPwgpNLgv7gk6m3h9qKG6SEszGzI5JFOR2AEFCOFhSDlZMDfWj4Z8HvKcp
	 JftflzJUN5cJTKnKBDLaRwhZCue3gNoN0a32av14aS6jFFjt9wWUuXQ/xDu7Sc8IxA
	 7bUU23VUmeJDiOGYSpamJp3hvS79tBzuaCeHby39OnodSlAxWj+t76B0ldU3c7CR+/
	 0xCYQjs6vFm+VZsq3o+FTjxvFrMB+RhjfF1uBBVpLvDpQx4DuEUgLKMsbXi6uhu40o
	 Da/U1j2/hj+MGKLgU6T8aqvJd39VGLhqGVPYGx73klq3vmv1Zei8zIIJEgse5462vD
	 q3rbJWuAsvMqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Philipp Stanner <phasta@kernel.org>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/sched: Fix race in drm_sched_entity_select_rq()
Date: Mon,  3 Nov 2025 10:06:29 -0500
Message-ID: <20251103150629.4044990-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110343-daffodil-target-5d2b@gregkh>
References: <2025110343-daffodil-target-5d2b@gregkh>
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
index 2634a555d2758..3f68a47e34062 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -471,10 +471,11 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
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


