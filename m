Return-Path: <stable+bounces-43391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 912188BF25C
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B066283114
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EEA1C6882;
	Tue,  7 May 2024 23:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cymLLJ2K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEA98626F;
	Tue,  7 May 2024 23:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123585; cv=none; b=fwYp5xqyAv7yQdYkhUk3/n6KZP4+WDuqx0E+U2MBN7SjuZxnV8nPCEAjSj9GldwazcMuS4rcZ1NRwJc3qUC32oYQhdHav/KwMdem6XRroLvTf1Zln8Glhkx7ryWHkLw9VM/9D7XegDZRYv/SMgdCyAuvPYtG+isRRrHhoQ5no4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123585; c=relaxed/simple;
	bh=t6bt3vIQSinGED0xz1wUZT7hlpMQ0X5JsMS8V3TwfnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqO0BsRMrmhenZNL4Im4c2fRiPHTAyww7uOPRUHHtoXYmbx23/0B35BWQEiEsNAuTGd5cfCohhJ5CiFfVNVYqebDfPVZy7ZHesd0ZpIGJ2/WFmpUlFMiv4DH7suRZ2EQrDw76seNOOpAlQow14nLsbq+J5uPn9Kca5rDBXTpDWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cymLLJ2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDD1C2BBFC;
	Tue,  7 May 2024 23:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123585;
	bh=t6bt3vIQSinGED0xz1wUZT7hlpMQ0X5JsMS8V3TwfnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cymLLJ2KlhWMOCa7nMxUuNoB2WMBEfYT8wUBCrvDzs2tX1UuTNihtgt2gxp8Qlkd8
	 k3ggNcL+J1EcnxZLPse9fTm95CZA5X9MwRrn3RWJuWo1d8fFaApswGw+ae44vKeXZ8
	 P1k44UjjquDXvSGnL9F17v9fAemNlp6quHNJ1w7mi3XF8KasrFpYyroebxL9Lr2C3n
	 YyJFbAtMW0nJzIwQcTnLTqqlbS+cr456h7Dgh1zLMhsoZTUsePmHEQ2elxsPnS8oNq
	 OwrOUO05n91jKt2rVpDieHHl7oW6/299MFb1MOVrCkiwZJROp0EfRULt2CwMCRzbOE
	 0NbDz7Y5Ha02Q==
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
	samson.tam@amd.com,
	alvin.lee2@amd.com,
	charlene.liu@amd.com,
	sohaib.nadeem@amd.com,
	sunran001@208suo.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 16/25] drm/amd/display: Atom Integrated System Info v2_2 for DCN35
Date: Tue,  7 May 2024 19:12:03 -0400
Message-ID: <20240507231231.394219-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231231.394219-1-sashal@kernel.org>
References: <20240507231231.394219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
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
index 93e40e0a15087..4d2590964a204 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2962,6 +2962,7 @@ static enum bp_result construct_integrated_info(
 				result = get_integrated_info_v2_1(bp, info);
 				break;
 			case 2:
+			case 3:
 				result = get_integrated_info_v2_2(bp, info);
 				break;
 			default:
-- 
2.43.0


