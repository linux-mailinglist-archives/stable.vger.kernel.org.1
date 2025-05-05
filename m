Return-Path: <stable+bounces-140130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15247AAA564
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CDB188EF2D
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6F430FD08;
	Mon,  5 May 2025 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4VXfLA4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A09A30FD02;
	Mon,  5 May 2025 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484163; cv=none; b=hUccUTSjjwai2BLfWenzWkDn1UafdJsbgw0IDIhtcTrVxVfaYyTgcJtTpYmNCgRb+++LHluECncCxRyRyiI/5STRv7gQjZZDpj9gW80ANQpGdcMh6qVfArqxbILsvUtYPq7aGRF3rW4gyAIwPRS/BA1x92uClDzG/ThzQ4klJ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484163; c=relaxed/simple;
	bh=9MDdimvpyVuizF6v+LsY4x+G/eT4yF+NtSq6Tll17AQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NQQDWKBK2qSBVwwTPddfPLd1kR85La//InEMYOPvYdkg8QYlCjE662SQYydjDaGvlWY+PXJ5dzcorQ3AZPAE5pcQdJjw8VIwIkjYTQb7i5KoUS87S2QH7qj95GBWp31k2iNv7o2iEpnKuzxZaFoU+m0gtfSBy8qZ7S8gU7HmZhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4VXfLA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD17C4CEED;
	Mon,  5 May 2025 22:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484162;
	bh=9MDdimvpyVuizF6v+LsY4x+G/eT4yF+NtSq6Tll17AQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4VXfLA4/2wM53s44F9ev9TJXcCnG3KlRF7VHApDOn8+cNxZqZgZHIyfgh47g17ha
	 yJEGJ8I1k3mpT4uDkSFUUCSvB0f0c95etIKGjRhO0Z5MGISScm67C26oWn0dT1Xg5E
	 spmRdzZZhXapBPYpLvMIvy+D3iq5NTiAQ0k0egg7OCR34Wyt010I9eariZ7kaQiAKI
	 oOx0ukCwshlNTXhbu/wD6AKbaVtfAFVe379C+K+XnxD0OoObHjpPYSRcNrsKKSXUpK
	 exjkYMuj7NiDsJ9wPPCwgjPEGmgDvEzeiL8Rg8NoWjaTKua22YkbpiPVRvtf0pTbxl
	 +P9jL0Ekc2qbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lijo Lazar <lijo.lazar@amd.com>,
	Asad Kamal <asad.kamal@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	kenneth.feng@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	boyuan.zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 383/642] drm/amd/pm: Fetch current power limit from PMFW
Date: Mon,  5 May 2025 18:09:59 -0400
Message-Id: <20250505221419.2672473-383-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit b2a9e562dfa156bd53e62ce571f3f8f65d243f14 ]

On SMU v13.0.12, always query the firmware to get the current power
limit as it could be updated through other means also.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ed9dac00ebfb1..f3f5b7dd15ccc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2802,6 +2802,7 @@ int smu_get_power_limit(void *handle,
 			switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 			case IP_VERSION(13, 0, 2):
 			case IP_VERSION(13, 0, 6):
+			case IP_VERSION(13, 0, 12):
 			case IP_VERSION(13, 0, 14):
 			case IP_VERSION(11, 0, 7):
 			case IP_VERSION(11, 0, 11):
-- 
2.39.5


