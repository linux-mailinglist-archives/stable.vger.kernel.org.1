Return-Path: <stable+bounces-43411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E5F8BF28A
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7CFC1F23094
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56051182A8C;
	Tue,  7 May 2024 23:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3f7bK/+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1361A182A87;
	Tue,  7 May 2024 23:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123635; cv=none; b=cJX1oYFivZrg8icIoGJYiv2CSTxtp3Otja3Ro3zGNWVgFdfgJ7cgNE21agtjELjeRyKogeS9aOnwHkCozrez/jFEJwu+EGynBM+ijmC4eW/nKM4/nVwpaDQpOmrK99M/5+E2AJcawSnSsXbriEK11Z4QfgYmbAihSj6quJwFIns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123635; c=relaxed/simple;
	bh=7XUdhYBuP3PUPxg1+fCt2aEcoCZ3e46AEM3flJ/HOJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxbK+bKR2QcVnHzXszc1XwnC4n2baLfplI5AK5kTuV88mA113Tzk7+qtXlH+pthkC+I3X9nI/UOsF+3mvpabxaaVLgnNZa4c8NeWid61PT8bH0QCm2cZTKobVwtRglQZPbIyUS369i0/xZ086cxEAllgHDPaTFwWS9a7p8PFC90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3f7bK/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628E4C3277B;
	Tue,  7 May 2024 23:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123634;
	bh=7XUdhYBuP3PUPxg1+fCt2aEcoCZ3e46AEM3flJ/HOJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q3f7bK/+YcEhTQauWzSdJhpq5cBRLZAiQEFZZ7XOV8lbU65UdJjklVq2wf63GgJwY
	 HT5VhmwKeR6Ho0+wBDXSvYxoY4+SVKaoE4WZR3T1FHHThSVNb6rL+RLshy7Gw6gJHI
	 1KtVplMExwx4X7BRaERCDnfQH1npB4WcQBf85Mj61AsX8UxVF9Bh0PZTujxzYMHyJD
	 bBgWfbVkzOWnLxsWRvEWqQmPtjkIzDY04wGxEpw07SEbFwMRwflk397reKa+d9wkFt
	 CJyDHnBxJqUHYmgTnRBej5zorE6xHrE06fWp2ptmwV+yoSILKFtIAGg+3zNtO7DhsI
	 b3DBA6HDab7ZA==
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
Subject: [PATCH AUTOSEL 5.15 11/15] drm/amd/display: Atom Integrated System Info v2_2 for DCN35
Date: Tue,  7 May 2024 19:13:20 -0400
Message-ID: <20240507231333.394765-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231333.394765-1-sashal@kernel.org>
References: <20240507231333.394765-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.158
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
index 228f098e5d88f..6bc8c6bee411e 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2303,6 +2303,7 @@ static enum bp_result construct_integrated_info(
 				result = get_integrated_info_v2_1(bp, info);
 				break;
 			case 2:
+			case 3:
 				result = get_integrated_info_v2_2(bp, info);
 				break;
 			default:
-- 
2.43.0


