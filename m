Return-Path: <stable+bounces-120171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3712DA4C86B
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972F41783AB
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AB727C149;
	Mon,  3 Mar 2025 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lM3q5LNQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EE227C144;
	Mon,  3 Mar 2025 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019555; cv=none; b=TLIa5h/LRJMeolTYi6tS3sCRXIDlUdbcR1NsGnW2Q6N8XzbiCxvpR81YbqQ2h9l4WRHI4WcERED+loQK1ecUaQmOD7iV7IkmXF1kgQyYMEr56Bg5URKSU6x1PA/07313/NJ3XnjaMTjWG2KhcTLDxOu2TjjjLdap5flvkkLQhuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019555; c=relaxed/simple;
	bh=60POIUAE8MUOThoRKFxbWyRNp22VrKkaS17XYtsLJUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ObZDjyEu09C02IhrRZaB9Qn4AbN0aUPg1VUhwB1OqVoy+qbu941RGOW1mH2S1X3VvTD2k5kucxVa+wC2w0cS0gpoDxiMAH+78z+sfNBsazcbVNRjvYmQyHEwhVnfynz3uwGnWqowtQzgFSfCF4VYdooDBeFsEKOsWcGF+/KQNrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lM3q5LNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26534C4CED6;
	Mon,  3 Mar 2025 16:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019555;
	bh=60POIUAE8MUOThoRKFxbWyRNp22VrKkaS17XYtsLJUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lM3q5LNQJojRUIMgQmyx64WSwbW1+FvMj87DUbmeQ3TESqPFHTFYZ5jaklV1aKfQk
	 6QJl3AkTLmjtkd+LT0pCMDY55JqTN4K9Iu0tnbqfev9WlDNaEbuEDIiWtlBmZ54wYU
	 vEcYJMm/8GPabQ7XK3dNs8PL5wnGdFOw14DGQZq7RBv4HBlhGWciyL0JtbT+sX4Pva
	 zuDZEXuQTSWzJuWoGsKONyPNqhsZebJanFoAxpe6zCTXe0lkY8BxfBuVmLuRnfrxPA
	 aXzdqJlIGmGEI4vSiBIeEY+VBaptaEAV2+ovUYxV4p8TOhDG/e5+XB8js0OwTZ6EYf
	 LBrr7aAwD8qTQ==
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
Subject: [PATCH AUTOSEL 5.4 3/4] drm/nouveau: Do not override forced connector status
Date: Mon,  3 Mar 2025 11:32:26 -0500
Message-Id: <20250303163228.3764394-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163228.3764394-1-sashal@kernel.org>
References: <20250303163228.3764394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.290
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
index c49303ba30c80..6f2bf5e9992f8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -759,7 +759,6 @@ nouveau_connector_force(struct drm_connector *connector)
 	if (!nv_encoder) {
 		NV_ERROR(drm, "can't find encoder to force %s on!\n",
 			 connector->name);
-		connector->status = connector_status_disconnected;
 		return;
 	}
 
-- 
2.39.5


