Return-Path: <stable+bounces-5474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D7080CC9E
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 15:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA485B20DD0
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D80482D9;
	Mon, 11 Dec 2023 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ou+HrEbR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992EE482CB
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 14:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86A6C433C8;
	Mon, 11 Dec 2023 14:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702303361;
	bh=dwADcyDW2WetwqIR+D9TN1Bko6rQzL3C8eVoG+twuIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ou+HrEbRml9VFOMv2ULe/9Mmm7HNDGvmaEz2TAX/ujlWUf2PpL1sjJkgjXLX5g8kc
	 z6ZozXwFsDoJrwRVEAyVIZXri0iVgJRcyq89BIIPGsiok3exLmcplzWWE58fPSNvJO
	 NHgGQNYFQ1nE+vWMOrtFZ19TA98lYnA9tcCgCHHCYB6ZsUOZLpk6DKJvmm2vEfZvpz
	 n43QPgJln4hOoi5G2XIdyYsLJ3FQYwURe7N3gRVffyVngSJGIkNykYd5b9e1InGjfs
	 PXZ2uqih42ykbu7MTWC9fzh1iYoEJEji+CsczFQfUPtg7hOSYs8pZQjx1Pt+cDRbQ1
	 xZSd7fKrC7Jxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dave Airlie <airlied@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	kherbst@redhat.com,
	lyude@redhat.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	bskeggs@redhat.com,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 07/12] nouveau/tu102: flush all pdbs on vmm flush
Date: Mon, 11 Dec 2023 09:02:00 -0500
Message-ID: <20231211140219.392379-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211140219.392379-1-sashal@kernel.org>
References: <20231211140219.392379-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.263
Content-Transfer-Encoding: 8bit

From: Dave Airlie <airlied@redhat.com>

[ Upstream commit cb9c919364653eeafb49e7ff5cd32f1ad64063ac ]

This is a hack around a bug exposed with the GSP code, I'm not sure
what is happening exactly, but it appears some of our flushes don't
result in proper tlb invalidation for out BAR2 and we get a BAR2
fault from GSP and it all dies.

Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231130010852.4034774-1-airlied@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c
index be91cffc3b52a..315000b2f8e3e 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c
@@ -32,7 +32,7 @@ tu102_vmm_flush(struct nvkm_vmm *vmm, int depth)
 
 	type = 0x00000001; /* PAGE_ALL */
 	if (atomic_read(&vmm->engref[NVKM_SUBDEV_BAR]))
-		type |= 0x00000004; /* HUB_ONLY */
+		type |= 0x00000006; /* HUB_ONLY | ALL PDB (hack) */
 
 	mutex_lock(&subdev->mutex);
 
-- 
2.42.0


