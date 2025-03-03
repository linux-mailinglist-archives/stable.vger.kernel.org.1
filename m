Return-Path: <stable+bounces-120111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2B0A4C788
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A81E7A4C6E
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1148E2356AF;
	Mon,  3 Mar 2025 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmHVfOoF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF07C2356A3;
	Mon,  3 Mar 2025 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019421; cv=none; b=hd5tDNwpEfUuN9MjBFdtS8+zrfM6bWlalHDnUFhRV7KfPXKqJkWjCpoCEKdWGze+Y0AM6zTTiyU3OqstvR5X/4YcjDe0jFH03eBRYesFWClacNauCdL3p5Rz66DRy29+7qmrjxuwQoMy/YxXacemZXxAQX1p1BbE/680aTNlGaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019421; c=relaxed/simple;
	bh=Y/pgDj31jv6H8diWaExyFSQ5b4ghy9KqWG+41n3cLUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y+aCG88mkl4SfS56C3HRpWcElgcEwdo8DhZW0C6/fa4qtKxbDngAhrFuCIFREnoLzmreNRDlV/8bcZT7wKeAU7vz6faVyl4o5oW8mnDlmwASWQte1l2CO1e6mh42Ql7+TuoQFDdJ8advH6ux+LtjBE456Xf8FyEYQxWVmQotuDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmHVfOoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AE3C4CEEA;
	Mon,  3 Mar 2025 16:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019421;
	bh=Y/pgDj31jv6H8diWaExyFSQ5b4ghy9KqWG+41n3cLUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FmHVfOoFLZUnrtiRfOPjboRoLL7Phtb0bcNJvNRe6yUAl25aX9O/gFRUjJtJoBYfy
	 ELcQhmkuAXDj+tMYwFozjShuhlAFyAyGku3AAwyycHMiYaBPP1xDOpz+cd1rvZupGW
	 chOaehNPrnvkt91Og+f19KK3trkoNK6EqwwUFGVCMvhddWbHdnjJ8gIktv1hAiz7ev
	 d+5JzsECMYFcE21G+OGbqqI6WFPVpnDFmb+qlcF/+tiVCb58eYlQ+XbyhQGlCny+/Z
	 MH8euOAyuT29CtdTvRvVn9cmpLLl0HiBUJdxVrnKWVvZS3FhSEpXCWJhe9wBm/6T8r
	 n+b17zNEVu3ow==
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
Subject: [PATCH AUTOSEL 6.13 14/17] drm/nouveau: Do not override forced connector status
Date: Mon,  3 Mar 2025 11:29:46 -0500
Message-Id: <20250303162951.3763346-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303162951.3763346-1-sashal@kernel.org>
References: <20250303162951.3763346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.5
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
index 8d5c9c74cbb90..eac0d1d2dbda2 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -775,7 +775,6 @@ nouveau_connector_force(struct drm_connector *connector)
 	if (!nv_encoder) {
 		NV_ERROR(drm, "can't find encoder to force %s on!\n",
 			 connector->name);
-		connector->status = connector_status_disconnected;
 		return;
 	}
 
-- 
2.39.5


