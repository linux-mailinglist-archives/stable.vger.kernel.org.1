Return-Path: <stable+bounces-5441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B45E80CC4A
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 15:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0BF1C209E6
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBF147A7F;
	Mon, 11 Dec 2023 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCOd6P5K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632F647A75
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 14:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AA8C433C7;
	Mon, 11 Dec 2023 13:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702303201;
	bh=Z4zFiJy8nVOqQvwvU48WTvdbUM9MltSNX1w9qcMnUeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DCOd6P5K/KzVXOR7bragkvYZLTfwnsrl7Edz0EQ5dwNG899bMBKbyUOVqJB1UqX2L
	 Y1tdv13kcPS9A4pKc1Z8LoRgF+vERQ9289HcjvoxZUb2qbsiR/dHLSMAEya+sLITck
	 LugL1+sAEGXhtVvcDJFIMxRt3aq+AyQIlLLZBQMyiY6rtFLr0fMqyiSdJR/7v2AdBK
	 LAUegGclr3N2TtcpsSJ8P0WZ3cLGNxNc5XeTakAiWAn3cCdoO5F6vmaBlf2/sXd1q2
	 KQdsr9+gYSkZtUJQWeQ2CN7IwhJgb3vara+WHh9m2vAvTl57hhKfz3NLwwjK/B56CP
	 wxnQdr1KC2AUw==
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
Subject: [PATCH AUTOSEL 5.15 09/19] nouveau/tu102: flush all pdbs on vmm flush
Date: Mon, 11 Dec 2023 08:57:43 -0500
Message-ID: <20231211135908.385694-9-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135908.385694-1-sashal@kernel.org>
References: <20231211135908.385694-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.142
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
index 6cb5eefa45e9a..5a08458fe1b7f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c
@@ -31,7 +31,7 @@ tu102_vmm_flush(struct nvkm_vmm *vmm, int depth)
 
 	type |= 0x00000001; /* PAGE_ALL */
 	if (atomic_read(&vmm->engref[NVKM_SUBDEV_BAR]))
-		type |= 0x00000004; /* HUB_ONLY */
+		type |= 0x00000006; /* HUB_ONLY | ALL PDB (hack) */
 
 	mutex_lock(&vmm->mmu->mutex);
 
-- 
2.42.0


