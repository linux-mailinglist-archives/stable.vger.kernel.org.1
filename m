Return-Path: <stable+bounces-120159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEC8A4C869
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3613A4A02
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2685269D1C;
	Mon,  3 Mar 2025 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIw2LPp4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683BC22F150;
	Mon,  3 Mar 2025 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019529; cv=none; b=gLhIp8x4EDzCsK44SN2+bQwQtSnLILvztsIOcONl6GKrmvvSh+20p8WdgbN/E4CV2jwjwQsXZ1Ej2+KCItGECV1x3C3KVa3iW9Vm59Z3nDIjnVBWPzzw0swl7cgTIeMnNgXqoebnGcC76zZMhyaZv0WUBJmg7Y7TUK+VXIx0DUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019529; c=relaxed/simple;
	bh=h4c9tkgdukwsn5DyCfCMTKlFsyQOeHry+5nbscAY4LY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t2EVRu575yU5Z2lxeVFQ7JviuLasghrlpr/uw3Vtk4LP3YRSJGYUifVI/JqCCADXC6jLYgjMOJjK4fe0HwyqgOj5c2kO6BgAxIZwA4L1/rUr9eLqi5kcGxXtcJfu1cF7lHWbzlXJ3IJXR8/l+gu6YdVKrHvm4PSN9KTgQNilNkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIw2LPp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27491C4AF0B;
	Mon,  3 Mar 2025 16:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019529;
	bh=h4c9tkgdukwsn5DyCfCMTKlFsyQOeHry+5nbscAY4LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EIw2LPp4iK+hOSpM3ghh2U2rRCEPhWTbbMbTuuyy7n6C3Id5CL4HWTg30Kg/iL9hS
	 Q7zLqdFB6OjlgxwMIs4w9rtCUJEUoFfcgjqEKjMLr9io1lWGaUvs26fiqdb4a0PFji
	 v1bsP2G6qNIT+Vu4bG4Gs2cmkBw6XEQmOMjaLCsgGKeGFlsBh3USOiR0nwa89eFH3+
	 Z47jD4Y9wT3ZgIR0ayjfAy5uw1QP+VvUKuIhIVV2Y40zL93VOq/kGo7aeL7cqZspDs
	 5sno40k1zhdkKuTLbs4RiwsUm50e8HchJr5nDQWqtagCFqwQI7CS7xagKHcXhezinJ
	 1HSeglPBPRiJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Lyude Paul <lyude@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	dakr@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 8/9] drm/nouveau: Do not override forced connector status
Date: Mon,  3 Mar 2025 11:31:51 -0500
Message-Id: <20250303163152.3764156-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163152.3764156-1-sashal@kernel.org>
References: <20250303163152.3764156-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 01f1d77a2630e774ce33233c4e6723bca3ae9daa ]

Keep user-forced connector status even if it cannot be programmed. Same
behavior as for the rest of the drivers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250114100214.195386-1-tzimmermann@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index ac9eb92059bc3..30f871be52cb3 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -754,7 +754,6 @@ nouveau_connector_force(struct drm_connector *connector)
 	if (!nv_encoder) {
 		NV_ERROR(drm, "can't find encoder to force %s on!\n",
 			 connector->name);
-		connector->status = connector_status_disconnected;
 		return;
 	}
 
-- 
2.39.5


