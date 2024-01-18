Return-Path: <stable+bounces-11950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BA2831713
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 11:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5944DB240B7
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 10:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162F4241E1;
	Thu, 18 Jan 2024 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xSX4Ongd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADE422F1B;
	Thu, 18 Jan 2024 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575187; cv=none; b=chO9fyNGIQeZVLEh3fEQK5bpaw/HyRXUGB2b5gMpVSPKGznO2/3fJgfuIWYNnTAfUZMN1rOqOG0bZE7IjTW4oATw02LDwfZMCIre7YOJhLgZUDXOGDQzMu+c9iohCszKf8Cpe8Kx2Eo1NG4mDOB+aGOmJl3dNzW5vYcpxu6K2dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575187; c=relaxed/simple;
	bh=Yuu9BfyBz74G1RIIe3gKDXqVokyu4tUSqR6bdcvASrg=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:User-Agent:X-stable:
	 X-Patchwork-Hint:MIME-Version:Content-Transfer-Encoding; b=nRK50iQ8g5THubn8eBq2ZlkruSz7XKq/If8aMhvAbZZBOpAFSAwiLgg2U/tgjOm03M2uuu7SoQtvYGTKMRZzcP+YzUwrHXzxBUnksiUj37JNjYjkouHAsGL0zzkoCKwYt4VGVLQ+K584Ggg/h0dAOdJ0VJ1Of2BX0vY/EhBeJfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xSX4Ongd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB3AC43399;
	Thu, 18 Jan 2024 10:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705575187;
	bh=Yuu9BfyBz74G1RIIe3gKDXqVokyu4tUSqR6bdcvASrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xSX4Ongd75PK3siroeerlIOY3v5DvxpQ4WduUGCAqmaYN6C68wW1VNDaqaMLQ2ady
	 bLnjtYB8ky7h+ZGLpCQe6NGXX2GCopSLyBKDv4ucQYloYfveRU/HriNehWipa9GoMK
	 snJpvl5z36FXaNYWhHDU3WOZpKraUtCqxabaYK8s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Airlie <airlied@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 043/150] nouveau/tu102: flush all pdbs on vmm flush
Date: Thu, 18 Jan 2024 11:47:45 +0100
Message-ID: <20240118104322.039358032@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118104320.029537060@linuxfoundation.org>
References: <20240118104320.029537060@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 6cb5eefa45e9..5a08458fe1b7 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c
@@ -31,7 +31,7 @@ tu102_vmm_flush(struct nvkm_vmm *vmm, int depth)
 
 	type |= 0x00000001; /* PAGE_ALL */
 	if (atomic_read(&vmm->engref[NVKM_SUBDEV_BAR]))
-		type |= 0x00000004; /* HUB_ONLY */
+		type |= 0x00000006; /* HUB_ONLY | ALL PDB (hack) */
 
 	mutex_lock(&vmm->mmu->mutex);
 
-- 
2.43.0




