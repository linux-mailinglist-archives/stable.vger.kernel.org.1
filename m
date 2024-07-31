Return-Path: <stable+bounces-64858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E37943AF0
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BF4FB21E62
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690E1154BE7;
	Thu,  1 Aug 2024 00:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5/vsuRu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F2A15445B;
	Thu,  1 Aug 2024 00:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471150; cv=none; b=Yar+dTtNlLCY5XpTTD/Th6nGe6cctLX2kjiNBPrJbbdDt/fNU1SM8qBuDfqz+1pc4+DI49hHPfGxEj1Bxn55QsicLf9vOZfmWDs5pzwN4lFn7n+4RK4wQ4qRXDndVWBO0aJmaYJaypkbIk7+lZ91h+W2JKBT2R+qw9hmrS344us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471150; c=relaxed/simple;
	bh=g9ItIRqLvF1nnPxK1LAetPz07OAallDiEh7T4HVBHWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R91C/8VJuGNckUjndVvsd3AwWHujFBGeo/lCHEC9itpEu9EnxC39ua4OPSsDYqMVnBH9ZZC2ar+KYfcnPFgS1t7hoWRBp/wkzW2mdLc2f5jNILMaslb5EH+MAOe8qIS2/wceTpmznEYDo69P4BP9dxx6u390hauW9wvN5vtfwTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5/vsuRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10C9C4AF10;
	Thu,  1 Aug 2024 00:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471149;
	bh=g9ItIRqLvF1nnPxK1LAetPz07OAallDiEh7T4HVBHWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R5/vsuRuDqpd5Q6hX0XGzhC1FtKTHJQ4FNunLW4GKdhaP1dXg+q+gJlSbzrsqW8il
	 AhdIKm9NF55wNEVgImZ58VecPJqsXIA1N9u1r19zvaUYoIiC38k4JXPWhutFoeMA7L
	 U4OSVXceKPC1ARqfsoKt0Q5YcBj/NkybMRrabjrsQiKGVb6PyXhgJ9Lm9iCFMbUW8K
	 uqr7Bi0PE0CmYDBO/1kAZ2MYPgIuWIw572BEDCygyJAjkvrR3lICfLsJaED/0+U+c4
	 E3ls8pdSUxnjSulCgzUouTaAMu2YQXhaCjVtJ/eAtX8n8ng/sqXd8b4n8dvJnR4kj8
	 cXsH2uSOVt4HA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Lin.Cao" <lincao12@amd.com>,
	Jonathan Kim <jonathan.kim@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 033/121] drm/amdkfd: Check debug trap enable before write dbg_ev_file
Date: Wed, 31 Jul 2024 19:59:31 -0400
Message-ID: <20240801000834.3930818-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: "Lin.Cao" <lincao12@amd.com>

[ Upstream commit 547033b593063eb85bfdf9b25a5f1b8fd1911be2 ]

In interrupt context, write dbg_ev_file will be run by work queue. It
will cause write dbg_ev_file execution after debug_trap_disable, which
will cause NULL pointer access.
v2: cancel work "debug_event_workarea" before set dbg_ev_file as NULL.

Signed-off-by: Lin.Cao <lincao12@amd.com>
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index d889e3545120a..6c2f6a26c479c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -103,7 +103,8 @@ void debug_event_write_work_handler(struct work_struct *work)
 			struct kfd_process,
 			debug_event_workarea);
 
-	kernel_write(process->dbg_ev_file, &write_data, 1, &pos);
+	if (process->debug_trap_enabled && process->dbg_ev_file)
+		kernel_write(process->dbg_ev_file, &write_data, 1, &pos);
 }
 
 /* update process/device/queue exception status, write to descriptor
@@ -645,6 +646,7 @@ int kfd_dbg_trap_disable(struct kfd_process *target)
 	else if (target->runtime_info.runtime_state != DEBUG_RUNTIME_STATE_DISABLED)
 		target->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;
 
+	cancel_work_sync(&target->debug_event_workarea);
 	fput(target->dbg_ev_file);
 	target->dbg_ev_file = NULL;
 
-- 
2.43.0


