Return-Path: <stable+bounces-5425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 805BB80CC01
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5701C2095B
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EA347A56;
	Mon, 11 Dec 2023 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LA3EcSqm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB0147A4C
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 13:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E470C433C8;
	Mon, 11 Dec 2023 13:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702303010;
	bh=bYKkKLzZA8jGXcnt6bR9g4qRqoJgH/dKArVF5Co8L98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LA3EcSqm3uQl/934YG3mOEgOClGDO+z1TEqfFBe8uBCSTYoRi4W9Or7oVif/hHU6/
	 bDQwf54YnORtQy7nqyu15upP64xFl/eFOld1PUzgDE5lWkq6JRC72uCxvJTkSloZGw
	 +046fblIrCj7ZJuYDXfpvEiTE5MLw/a+fucked6AZRnWnTzCS0YXDL91za0xO7YBWb
	 8zwryIS5faNGkbpeHBbJW7VPRoLbwP84VNzU8TUt8nIH3CjlOjhP/2GUmasnuw3Wat
	 vocJSUrhez3h2t4RzzKUowtKU36ljM9OfxC70tahEuzpPl4xmi5eKW5bMyNQlGmb+H
	 RNK2VIS8MpaSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alvin Lee <alvin.lee2@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Samson Tam <samson.tam@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	felipe.clark@amd.com,
	tony.tascioglu@amd.com,
	ruanjinjie@huawei.com,
	drv@mailo.com,
	sunran001@208suo.com,
	mario.limonciello@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 23/29] drm/amd/display: Use channel_width = 2 for vram table 3.0
Date: Mon, 11 Dec 2023 08:54:07 -0500
Message-ID: <20231211135457.381397-23-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135457.381397-1-sashal@kernel.org>
References: <20231211135457.381397-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.66
Content-Transfer-Encoding: 8bit

From: Alvin Lee <alvin.lee2@amd.com>

[ Upstream commit fec05adc40c25a028c9dfa9d540f800a2d433f80 ]

VBIOS has suggested to use channel_width=2 for any ASIC that uses vram
info 3.0. This is because channel_width in the vram table no longer
represents the memory width

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index e507d2e1410b7..72891d69afb68 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2402,7 +2402,13 @@ static enum bp_result get_vram_info_v30(
 		return BP_RESULT_BADBIOSTABLE;
 
 	info->num_chans = info_v30->channel_num;
-	info->dram_channel_width_bytes = (1 << info_v30->channel_width) / 8;
+	/* As suggested by VBIOS we should always use
+	 * dram_channel_width_bytes = 2 when using VRAM
+	 * table version 3.0. This is because the channel_width
+	 * param in the VRAM info table is changed in 7000 series and
+	 * no longer represents the memory channel width.
+	 */
+	info->dram_channel_width_bytes = 2;
 
 	return result;
 }
-- 
2.42.0


