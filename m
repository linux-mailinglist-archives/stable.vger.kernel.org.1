Return-Path: <stable+bounces-146174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEB6AC1E15
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 09:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C1227BA6E5
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 07:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76706289360;
	Fri, 23 May 2025 07:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="RWOC6MXW"
X-Original-To: stable@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505A72882DD
	for <stable@vger.kernel.org>; Fri, 23 May 2025 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747987027; cv=none; b=SFpFYKHK7eXAl7U1vho2YjZJMDScEycnZYPOwKR4hUp48NmT5NO+lJtlOFWrwI1p/PWzIiOgRi+oeKxSLXhN/cADLvv0raxRIjNEvr4OlbN3Winsn2srxEQALQ8nmkcFRN2oodYLq/eP3Fb1IxKm9fzCp9DlR72NU2gQzM/3Rps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747987027; c=relaxed/simple;
	bh=rR3vPAPlUJEfRssL5GiwmgHjwvovtafRJtml2i1CacQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ml9eVSjga/N9J8nZ9vEDZL5pNcLS7YOwinYJQTfba7We9dqkhBeI4m4+c3ghBj6cILkEBc2BxijNnm/JGrVkZ/G7+Bf+cTapk7sCH7AzU7ezLjI32bks5LNkKzWCMrgrr2QQSE6N05Lkd6ayfI6QiOVRtLAkDrWV444p2yAIdBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=RWOC6MXW; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id A22B61C118D
	for <stable@vger.kernel.org>; Fri, 23 May 2025 10:50:24 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1747986624; x=
	1748850625; bh=rR3vPAPlUJEfRssL5GiwmgHjwvovtafRJtml2i1CacQ=; b=R
	WOC6MXWGK/aGAD99+5hQcItRKFJ9kimi5SIaD3qRP6w7Q1M7w55Fe2UdlkZYbWQV
	AzGq5aOtJPyk9WZPAkg0dw3cEbUMBsM5nIN/h7PTGiEUyVNeXJb4kO8ozZZCC2+4
	FKB8yUNWiQKmfA2rTi0xClR/weL/40x5qb8buzw8Gs=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Or81gyhgdHhQ for <stable@vger.kernel.org>;
	Fri, 23 May 2025 10:50:24 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 91B471C0DAB;
	Fri, 23 May 2025 10:50:22 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: Lyude Paul <lyude@redhat.com>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/nouveau/mmu: fix potential overflow in PFN size calculation
Date: Fri, 23 May 2025 07:50:14 +0000
Message-ID: <20250523075015.884716-1-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On most Linux-supported platforms, `int` is 32-bit, making (1 << 47)
undefined and potentially dangerous. To ensure defined behavior and
correct 64-bit arithmetic, replace `1` with `1ULL`.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: stable@vger.kernel.org # v5.1+
Fixes: a5ff307fe1f2 ("drm/nouveau/mmu: add a privileged method to directly manage PTEs")
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
index 9c97800fe037..29da1acbe3a8 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
@@ -1383,7 +1383,7 @@ nvkm_vmm_pfn_map(struct nvkm_vmm *vmm, u8 shift, u64 addr, u64 size, u64 *pfn)
 			 */
 			while (size) {
 				pfn[pi++] = NVKM_VMM_PFN_NONE;
-				size -= 1 << page->shift;
+				size -= 1ULL << page->shift;
 			}
 		} else {
 			pi += size >> page->shift;
-- 
2.43.0


