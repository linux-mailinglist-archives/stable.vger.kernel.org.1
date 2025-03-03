Return-Path: <stable+bounces-120167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91186A4C884
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 18:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20023B0CB3
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70367276D3F;
	Mon,  3 Mar 2025 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEB1pCSK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D347276D2A;
	Mon,  3 Mar 2025 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019546; cv=none; b=oeyVK51QWchjH7Zi6Fh4z0mFqLpm+rRSj4NQlFjTc17VVBRBCAaeCwpyQaPp/DvnnPyBJiSxbwqYk/A5868K1DiWtXHIPYtTFQ/eRdnGjUbCava/DjDvO00Ja1U1pFLqlTaVoU8w+/lqYisSyTpBM3mE82SPXUOlvQy53QuOWcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019546; c=relaxed/simple;
	bh=dJTFCGdofHJjU0lr1G1iDu2+pobHXDAxaKuOH8UYRFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SLo/1HNeG8pyyN0mhq59m7hoe/utlVyUXPxppGpwFJlE2PzWrsHpn/2tccTG5sL2lZSvW8eOEkgjtrwOImGccxcOO+Y8o8/sbEzonGFFSQ0K+ohKUYpgBNuRsYivsdqjR3NawnF2IAs/tpeXOUX9sikcKQEkK0diO71aTvtJFkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEB1pCSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E140BC4CEE9;
	Mon,  3 Mar 2025 16:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019546;
	bh=dJTFCGdofHJjU0lr1G1iDu2+pobHXDAxaKuOH8UYRFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nEB1pCSKosQbgOatZ+6Azd13WGaluXPjjYK14navxEahCd8RF/3MPEfDPKTzuYQEL
	 Fq7rbTgg84/J+6iQh0ABMwGPeLM3250danMGoWW2q8VBS9qgppPzQ6iEBjKSTUGBRi
	 k0Xc75QbktuR74WkMbLjK2kJOldzqU35EhkzwDnfQHtnd+sZ6BlM59c/D0jLdEO66U
	 uveWqsNqhVAkf/oVfpCSRKUwa1hR+4ZvCLs6YzGY9QzizyegxJUJZjWm89rKhPthYX
	 RkKEQJ2ur1MS40Xz1mkDIi35S97DhU2ezRf+pGy2OuBhcDerx3zJsaY+4OpAIkcyti
	 j7TLK9nSaJrvA==
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
Subject: [PATCH AUTOSEL 5.10 7/8] drm/nouveau: Do not override forced connector status
Date: Mon,  3 Mar 2025 11:32:10 -0500
Message-Id: <20250303163211.3764282-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163211.3764282-1-sashal@kernel.org>
References: <20250303163211.3764282-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
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
index 6b8ad830c0348..aa8e4a732b7ce 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -751,7 +751,6 @@ nouveau_connector_force(struct drm_connector *connector)
 	if (!nv_encoder) {
 		NV_ERROR(drm, "can't find encoder to force %s on!\n",
 			 connector->name);
-		connector->status = connector_status_disconnected;
 		return;
 	}
 
-- 
2.39.5


