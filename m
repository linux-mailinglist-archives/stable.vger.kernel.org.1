Return-Path: <stable+bounces-120128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1644A4C7CF
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A10188300A
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934EB25335E;
	Mon,  3 Mar 2025 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSBPB8JV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D97E253343;
	Mon,  3 Mar 2025 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019462; cv=none; b=thuWI0zHTkRDeV2OYGf1Q4IMEPMZTRzU2bYV6wcShVXpVZAu2bLpN2dMKMMmB6bHjyj5Ge8ZoCbwtq7uvxl47z7o7tGNJCRHStI2sW/lUEaryz/T1ON629C//EHvW0csEIJm5yWFmhEXtUShWuuYm+/am1PT7T6OtOmNebx2JxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019462; c=relaxed/simple;
	bh=EllXonpnbCxLKoJMd/6o0eawtGiQ9nXqLC2Yfn3eRwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ix5dhsstsE28qOBTIsUa6F61O30qHl5+RzmlVl0OMmQ02EVi8u0X0XeEYMMAlb+OR1l9RjQ6Bsvwp7ui5uybAfngxa295ZYtp0qGC8e9QXy9Qx6HaCDhI2w5OYFUWGdrvAPZhcCA85Xvsk1tYzIpZiwKwjLvEC8YtWNuUJYAWPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSBPB8JV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADE9C4CEEB;
	Mon,  3 Mar 2025 16:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019461;
	bh=EllXonpnbCxLKoJMd/6o0eawtGiQ9nXqLC2Yfn3eRwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OSBPB8JVOW4XAD8Sx5dNu66FhKGNB+Qi6kP0bWKRrP0e164DV7rREMtcg9PrCqf/q
	 mPuKN3PsB5DPxvwi/iKvmYhnlT/bHF0EZ06QN0NSIqv+RYYy2G36HSD39rSdItGh+H
	 i6D8NPFiDBi2340plT+2w34jMpl7Y3FhtImpb0YFBYK3Y0JRidRnqNGfA3p2EYnL0T
	 4Y+aUaSJwIyakoVj+UJuy9KARrI7YcaBz6MT2Z9EAohpmOZ6k9WEiFCmk5sMqUG14J
	 yNnHp8R3ZvPnHczyqxe+OJaJkQzzr9qd5zBio8ZFQj2gFrsHgzoVHx9CoYoPtA4oGc
	 ZF4HzMbSrIkOw==
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
Subject: [PATCH AUTOSEL 6.12 14/17] drm/nouveau: Do not override forced connector status
Date: Mon,  3 Mar 2025 11:30:26 -0500
Message-Id: <20250303163031.3763651-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163031.3763651-1-sashal@kernel.org>
References: <20250303163031.3763651-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.17
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
index b06aa473102b3..5ab4201c981e4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -776,7 +776,6 @@ nouveau_connector_force(struct drm_connector *connector)
 	if (!nv_encoder) {
 		NV_ERROR(drm, "can't find encoder to force %s on!\n",
 			 connector->name);
-		connector->status = connector_status_disconnected;
 		return;
 	}
 
-- 
2.39.5


