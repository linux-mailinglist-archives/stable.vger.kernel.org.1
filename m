Return-Path: <stable+bounces-77314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF2A985BB5
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5258B28478C
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A8019F12C;
	Wed, 25 Sep 2024 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4kQvtPI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BEE1C2DC2;
	Wed, 25 Sep 2024 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265144; cv=none; b=FJFVeur+4Ke+9KZsLQyNIQgTyXzIHwEEEeTl4fElEZQSj3k/eWrVLeonPTB3pDS9mg0hnpjh1dXsyXx7Fpu+gB4hsWhU1F8egIN2PySm/mz8vYt9aqfnSvpoR6vC7sKZuMKEjKHyG9ZgV7t9NZ8b6RWcJnPBONOcjwEnecQWM/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265144; c=relaxed/simple;
	bh=T2V3YRkOq7vatkOQ+SUsy0VnQobjXyphXl1/z9YfLd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJJfDLUyb5iGv7vi5KWIw3qkPjraDLMHVR2OTSjWzAUEAuVnUVXpm5kcbl8gqbA78Ajz4ClFeQJ1vhrvBvQrLt+6yIXC38HWeXDVfNkmFW41DpSgZEe2U46+yCM24ivJF2mH94X1P+impqP675LT2BX9CXg4EDaK6OmcP7sel+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4kQvtPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D366C4CECD;
	Wed, 25 Sep 2024 11:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265144;
	bh=T2V3YRkOq7vatkOQ+SUsy0VnQobjXyphXl1/z9YfLd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E4kQvtPIaXW97WIRQRlFuE1xt6p0aSL5oil1WBeuXuz08dzbtv1tjc9UjqZzbIkFz
	 5uqaZjKbDIq3j8OjZMM/y5FGY+22HCIbJ5n9SGQ2YZXPQzG5In4geB82uk9WGEbAQ3
	 UQFG5Ko8DFT0wk976EL4E7jmtYJ9mzGOxU80Vm6U+Krqk9cI7BjFXGLqhqAAuPusFP
	 geweOiherAq5lmVJhTXo18FiNyWGAMIVxCaJPP5zOWzSAQGVYMnfJ/GOT8aZ+gq7jw
	 QbMNFu5nXBD5ZiofKFuS7WKGAvuj+5N5C1fPIEXVsNteKzqzwknXLSWPueElgrKIvK
	 MWmHbUt30ydkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Huang <tim.huang@amd.com>,
	Jesse Zhang <jesse.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	kenneth.feng@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	kevinyang.wang@amd.com,
	Jun.Ma2@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 216/244] drm/amd/pm: ensure the fw_info is not null before using it
Date: Wed, 25 Sep 2024 07:27:17 -0400
Message-ID: <20240925113641.1297102-216-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Tim Huang <tim.huang@amd.com>

[ Upstream commit 186fb12e7a7b038c2710ceb2fb74068f1b5d55a4 ]

This resolves the dereference null return value warning
reported by Coverity.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index ca1c7ae8d146d..f06b29e33ba45 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -1183,6 +1183,8 @@ static int init_overdrive_limits(struct pp_hwmgr *hwmgr,
 	fw_info = smu_atom_get_data_table(hwmgr->adev,
 			 GetIndexIntoMasterTable(DATA, FirmwareInfo),
 			 &size, &frev, &crev);
+	PP_ASSERT_WITH_CODE(fw_info != NULL,
+			    "Missing firmware info!", return -EINVAL);
 
 	if ((fw_info->ucTableFormatRevision == 1)
 	    && (le16_to_cpu(fw_info->usStructureSize) >= sizeof(ATOM_FIRMWARE_INFO_V1_4)))
-- 
2.43.0


