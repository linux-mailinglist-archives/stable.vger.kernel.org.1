Return-Path: <stable+bounces-120140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E48BAA4C817
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5BF16B6A2
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1718260378;
	Mon,  3 Mar 2025 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZQlcKBk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00C4260371;
	Mon,  3 Mar 2025 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019488; cv=none; b=WM8ypqv+ivPWyciTn+SGp23Csi2AcVy/1Q1f1nlEyzxMRyOVmMc50+9+G0JQS+8w6n2umJLjwtZPIBdw83PZXgWkQpvhTiuTu45VMW7qBzNSlQt80WPK0vpu4DB5z4abhcoheCio98LqvYu0fAC6COFvhnQZQocO2mtIdai6EjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019488; c=relaxed/simple;
	bh=g9CIBY9Nmr7cS8ndBcPH61ca5n6zQszj26hUAnVfUAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cjp6IuePczfk0iMFJxfVAkLt+QnJLr6QMhB8hkmWWzg5nAHMKDQj0JM/1nhrCi90MTPbRtxLnou7DtoCgkpp84Q7k3Rw+fTSs2p3XXgEzVbUgxWqxnKmFSti7KlOif/bnBvkS3qmR8rqGHxYpYTpeJdepG8WZ+AmLwpJ/p7jNyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZQlcKBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CD4C4CEE4;
	Mon,  3 Mar 2025 16:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019488;
	bh=g9CIBY9Nmr7cS8ndBcPH61ca5n6zQszj26hUAnVfUAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SZQlcKBkiomU+ydGFHvdIcbgEIrIf0WNU3dyv0tyFDneAZAQsuoT1h/Z1tYZl7OZl
	 fSVeGNal5NX4DIYlKcyhgFIOy3UR5B177U1ryVhS8CPhp2uE+zz1lShT0IxicMbqri
	 4/UVrCnl1zZRr8/VUjTlD/lW14RvAsb5ZrHcZn1AVxZgqS9UpzIqtlAQmJts12xqYn
	 q+aGcHXDkOT8sO5NDY7jMZ+j+oxHuCHLU2/TZCoqSQCG5LVUnZjKrXyMLL8h8CdhvM
	 ipQQZQcA6b4lwP5M+IjWJZ1XSjOb42hfZK6+w6jcCkduI7Z3kNdCGsp//RcHJjCWuj
	 yDgvsbDFngKnw==
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
Subject: [PATCH AUTOSEL 6.6 09/11] drm/nouveau: Do not override forced connector status
Date: Mon,  3 Mar 2025 11:31:07 -0500
Message-Id: <20250303163109.3763880-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163109.3763880-1-sashal@kernel.org>
References: <20250303163109.3763880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.80
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
index 22a125243d81f..c1985448d9b38 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -758,7 +758,6 @@ nouveau_connector_force(struct drm_connector *connector)
 	if (!nv_encoder) {
 		NV_ERROR(drm, "can't find encoder to force %s on!\n",
 			 connector->name);
-		connector->status = connector_status_disconnected;
 		return;
 	}
 
-- 
2.39.5


