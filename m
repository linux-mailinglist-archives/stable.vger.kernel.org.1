Return-Path: <stable+bounces-43362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC6B8BF213
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5EE5287079
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519FE16F84F;
	Tue,  7 May 2024 23:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIh1xjhF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB9913791F;
	Tue,  7 May 2024 23:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123496; cv=none; b=WqHUFoIrC8wV9o3jRP5AaKhbhKyVf+Xfxe6VVmQuCMtTbs6bd/EbCCfHFEN/s205d7mzx12g+fM6R8C8gLgKL7q7DZmkeylVkfhhxB/JPQ+zCtHKl4Vzm0YhVFZvsbPGdVIf6MIznKWg5xmK0Wz5FObD8w5Kf5unI/clJWlT/48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123496; c=relaxed/simple;
	bh=3mbKwu6yhW+loSsWzZ+Y9ZwzY22b25iDBTwGIjMHOlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSKZLnedLnQh6Tt4Deyv/eRcsl4BecqjBEAsoBWwPr8FpRk7xiLU5LJ2v2AU55ypKvqJxnUHOXNzPVcpiPYhF6PDXGXFnahml15SZSrCwbrfgBThp8VeJqtB4S0g6RmIp/frun4EA2vIe4Z740w2zCsjNrhcgCcKFOuzMOV0uYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIh1xjhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40C1C2BBFC;
	Tue,  7 May 2024 23:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123495;
	bh=3mbKwu6yhW+loSsWzZ+Y9ZwzY22b25iDBTwGIjMHOlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fIh1xjhF21ZTrJvIZcfG1sYyxo+rCCB7qo5qSU6+ai8o6G/Ob0WNiTZhAf/Dl44id
	 EdBG2IAkig9jNZ7s7h0E6TCDI0j7wqtzouh3PQPjCWwU/30JhCXklD+mUAJXhxvrRX
	 nph7819jwqBZ/zUb8UMTXuKcNl2WjK3/2u1un8FKQuMMrtPXJTTjGWq5EdaQ7KvAuI
	 4k4nQJ/vCZnx55RUDrZt3RMQYBCH4pwzHxkxEB7DD+7wy9Av/ZL0Nz6ltFGrzQgzud
	 Y3IifJ+tra6RsuIf8YcLybmmYENEsk56HQC1kMjfeP/hQ1awdcwSkMagrQ81FMqMzj
	 Yzt4DPsNnBuPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabe Teeger <gabe.teeger@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	wayne.lin@amd.com,
	alvin.lee2@amd.com,
	sohaib.nadeem@amd.com,
	charlene.liu@amd.com,
	sunran001@208suo.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 30/43] drm/amd/display: Atom Integrated System Info v2_2 for DCN35
Date: Tue,  7 May 2024 19:09:51 -0400
Message-ID: <20240507231033.393285-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Gabe Teeger <gabe.teeger@amd.com>

[ Upstream commit 9a35d205f466501dcfe5625ca313d944d0ac2d60 ]

New request from KMD/VBIOS in order to support new UMA carveout
model. This fixes a null dereference from accessing
Ctx->dc_bios->integrated_info while it was NULL.

DAL parses through the BIOS and extracts the necessary
integrated_info but was missing a case for the new BIOS
version 2.3.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 4c3c4c8de1cfc..93720cf069d7c 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2961,6 +2961,7 @@ static enum bp_result construct_integrated_info(
 				result = get_integrated_info_v2_1(bp, info);
 				break;
 			case 2:
+			case 3:
 				result = get_integrated_info_v2_2(bp, info);
 				break;
 			default:
-- 
2.43.0


