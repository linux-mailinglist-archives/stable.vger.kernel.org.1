Return-Path: <stable+bounces-77488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE0C985DDD
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9259EB283A5
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC983DABE2;
	Wed, 25 Sep 2024 12:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLJzp1aw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0741B3F31;
	Wed, 25 Sep 2024 12:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265999; cv=none; b=mDrvACeEZOGDRZSDCtrqaWUrHMX/mggR2D9LMgEp6u9lWGQ1niyD7haV8/FmgzdL1gR5Zl2XG9OoSJHOjC9SQcMyvwsQa8PQYvMP3rFeMukqWz0iHMhwGADLoFtklb7a2PTWTOJx+/qontTJRF0q+srhS84rxXYdLM3URfYdmw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265999; c=relaxed/simple;
	bh=BzV+rqHtyok1zlVJlyPbJzBVp6uUgf+GhTrD/hr4PH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqBmNb+7/PKTFJF59A4XsZn28hs9UNvCrkqC+etR716YDAx7t9ia5gV6y1df8pF6zylS53YjxVzfwjraH25OfVaTfboMTEHdOsN/YP67V64tqWyHSRzt128UHboPsx1uv+leBe2A6Z50ITrZSicyFacZhccMMlOI25i1YeYXClQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLJzp1aw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E91EC4CEC7;
	Wed, 25 Sep 2024 12:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265999;
	bh=BzV+rqHtyok1zlVJlyPbJzBVp6uUgf+GhTrD/hr4PH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lLJzp1awFCgZ1H+tKKGSYi0G5YW80J/NsnfFi8k0GiAwkGGx94v7NCAjUjvHPyIpq
	 7Zu/lnyrTLQnneNX6uNn5c006V/NJG1cs9o0E9eb1eMMyrivxh5NPb6BYjzIo0dE4J
	 4BKF/ku77VqwTUSx6PIFQQdOoXuB/7ZOm0P+SrH/lN9ZOUZdYIiWiLMv9DLDY5SmCX
	 kWztsg5gv82xKtE432V47FUjDqDHCzwcvAJJaX9qdkJadIyXHj2v5i28PYAo7zE1nY
	 QVDBKc9YF1c3xmxwXlUoS/f9VbUAyn2kxEHNuXKpVV4PFuH5gwB/Wop6OdMkYx5Obv
	 UzxH11HQacQxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Liu <liupeng01@kylinos.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	sunil.khatri@amd.com,
	Prike.Liang@amd.com,
	Tim.Huang@amd.com,
	kevinyang.wang@amd.com,
	pierre-eric.pelloux-prayer@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 143/197] drm/amdgpu: enable gfxoff quirk on HP 705G4
Date: Wed, 25 Sep 2024 07:52:42 -0400
Message-ID: <20240925115823.1303019-143-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Peng Liu <liupeng01@kylinos.cn>

[ Upstream commit 2c7795e245d993bcba2f716a8c93a5891ef910c9 ]

Enabling gfxoff quirk results in perfectly usable
graphical user interface on HP 705G4 DM with R5 2400G.

Without the quirk, X server is completely unusable as
every few seconds there is gpu reset due to ring gfx timeout.

Signed-off-by: Peng Liu <liupeng01@kylinos.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c86a6363b2c3d..0594eab666a9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1174,6 +1174,8 @@ static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
 	{ 0x1002, 0x69af, 0x106b, 0x019a, 0xc0 },
 	/* https://bbs.openkylin.top/t/topic/171497 */
 	{ 0x1002, 0x15d8, 0x19e5, 0x3e14, 0xc2 },
+	/* HP 705G4 DM with R5 2400G */
+	{ 0x1002, 0x15dd, 0x103c, 0x8464, 0xd6 },
 	{ 0, 0, 0, 0, 0 },
 };
 
-- 
2.43.0


