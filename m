Return-Path: <stable+bounces-77318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0D5985BBE
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748B0281FBE
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFC819F41E;
	Wed, 25 Sep 2024 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYKTZhpx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D60C19F405;
	Wed, 25 Sep 2024 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265155; cv=none; b=iOFqBqGu618pIWRPSWeU8Wip1ciRXW3h51f6xvIVAkKysxTO1og1HqIDzs8KlBB6xG43HB/YvaRHFh0kTdxpwMH6y0AqFuYSV0JHrUtsb3u7XROcrhDf7M2dwtkA5nyP3yQ2cI0Q+EcU8sgFYIquOlU5Ixw8sxBI9zBqDoUPJhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265155; c=relaxed/simple;
	bh=nkBzYac0mtkWjR1R5qQ4U2a+voJyzBdEXgbdpDg+cEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=is+S54BLC6sEnM8aPu0wqudK0ZT8gz9YqJL8MfIsKD0mnM9ckkFn/QRr8+Uf//aAOYvj1x5UmNpSrbaqU9uZT9F9h/4kPCXqwGeSvapVCTbCnbAxechPnqrQc2X9iuKdVnABVOgU+YQELQ9oB4bn4UkuFfci54JCz9ZrVBaceLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYKTZhpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193D1C4CECE;
	Wed, 25 Sep 2024 11:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265154;
	bh=nkBzYac0mtkWjR1R5qQ4U2a+voJyzBdEXgbdpDg+cEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lYKTZhpxhmBm56ObhOz67uvUv0cdKp/u2X6cvApjT/8Ox9hn3LqVKpbzRAcpZ12pF
	 gc7PcCvHq6ukqtY9R8dky10B8lSSlrQCXetPcml1aObdFOJRnb7RCfGK8T/rpJ5cjD
	 kAwre2FBdK6//nGFw0fO+rmgbxVpbFQSDpm+xuofsMgOFPiVaUNPNTeHCBftVS7VxK
	 6LmEij3+t0xveq7DSs/RGo8oxTKwp+2y61grCu4f4VAe8eGiCdO/Iuqdf7wKbG433W
	 sfu0qbuYK3L6KEdcKJfjmIbxQj5JqDw66nHtuK6+2Nu2MCy1UbSMJrxPZqALk1nNMP
	 zPoKCHBBs7eEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Ahmed, Muhammad" <Ahmed.Ahmed@amd.com>,
	Charlene Liu <charlene.liu@amd.com>, Ahmed@web.codeaurora.org,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
	sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
	daniel@ffwll.ch, daniel.miess@amd.com, wayne.lin@amd.com,
	nicholas.kazlauskas@amd.com, yi-lchen@amd.com, alex.hung@amd.com,
	ilya.bakoulin@amd.com, harikrishna.revalla@amd.com,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 220/244] drm/amd/display: guard write a 0 post_divider value to HW
Date: Wed, 25 Sep 2024 07:27:21 -0400
Message-ID: <20240925113641.1297102-220-sashal@kernel.org>
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

From: "Ahmed, Muhammad" <Ahmed.Ahmed@amd.com>

[ Upstream commit 5d666496c24129edeb2bcb500498b87cc64e7f07 ]

[why]
post_divider_value should not be 0.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ahmed, Muhammad <Ahmed.Ahmed@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 68cd3258f4a97..a64d8f3ec93a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -47,7 +47,8 @@ static void dccg35_trigger_dio_fifo_resync(struct dccg *dccg)
 	uint32_t dispclk_rdivider_value = 0;
 
 	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_RDIVIDER, &dispclk_rdivider_value);
-	REG_UPDATE(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, dispclk_rdivider_value);
+	if (dispclk_rdivider_value != 0)
+		REG_UPDATE(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, dispclk_rdivider_value);
 }
 
 static void dcn35_set_dppclk_enable(struct dccg *dccg,
-- 
2.43.0


