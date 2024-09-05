Return-Path: <stable+bounces-73235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7104796D3E7
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFBD284FD0
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C061195F3A;
	Thu,  5 Sep 2024 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F2aGvH8R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A744635;
	Thu,  5 Sep 2024 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529574; cv=none; b=aXWxW3E0/T1tYpy942vMbx0PkEji8gxg7mRLUNSh1NedxNzr6PfK6e3uTdVoNqT4xbCyxrNKlPUaCwd4TQM9h101/FikHJZrnHnQmxKNnjHzKmjK84nRRZP0OtCCR+hhonCTIg8WDI0DXat6+WEhxnWKg4xD2yn+U9kpeSdH8ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529574; c=relaxed/simple;
	bh=LslQqBNJKW4vFYqLqUYYkMfcO6n5e8RXGZrnY0kTKFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdjquFQ9Acenk2M9eKkxOr1tEx6T0Smok2mDcY7FqB+ptRq2PfCmerBtQdYBHhIOlXap0gypdUEPwUEkMDu2xJJh+edQX0/HUPZMAJ+n8EiLTulaKAaEXVzDOG5uu5aH3Wix1H9+b3ZWiomLW1T+4V1tFB4N1XVrp+b50tQrSU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F2aGvH8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4547C4CEC3;
	Thu,  5 Sep 2024 09:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725529574;
	bh=LslQqBNJKW4vFYqLqUYYkMfcO6n5e8RXGZrnY0kTKFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2aGvH8R/De6lyutB92n5niv3xmJSQ/TqCpulOIyPUIRQvjQziM6BhmEWaazlJquR
	 nD4ULQXbSWxVBTj9GOu5xPBnX/KJlmnynxB5AdIB6iRUTiIA9/C+npEEhq3A1QRFVm
	 qFCUr8h5bv6HYVcD4/wY2zvG4wW6ik21gM6tKTM4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Hung <alex.hung@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Hersen Wu <hersenxs.wu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 076/184] drm/amd/display: Skip inactive planes within ModeSupportAndSystemConfiguration
Date: Thu,  5 Sep 2024 11:39:49 +0200
Message-ID: <20240905093735.208751696@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093732.239411633@linuxfoundation.org>
References: <20240905093732.239411633@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hersen Wu <hersenxs.wu@amd.com>

[ Upstream commit a54f7e866cc73a4cb71b8b24bb568ba35c8969df ]

[Why]
Coverity reports Memory - illegal accesses.

[How]
Skip inactive planes.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 9a3ded311195..85453bbb4f9b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -1099,8 +1099,13 @@ void ModeSupportAndSystemConfiguration(struct display_mode_lib *mode_lib)
 
 	// Total Available Pipes Support Check
 	for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
-		total_pipes += mode_lib->vba.DPPPerPlane[k];
 		pipe_idx = get_pipe_idx(mode_lib, k);
+		if (pipe_idx == -1) {
+			ASSERT(0);
+			continue; // skip inactive planes
+		}
+		total_pipes += mode_lib->vba.DPPPerPlane[k];
+
 		if (mode_lib->vba.cache_pipes[pipe_idx].clks_cfg.dppclk_mhz > 0.0)
 			mode_lib->vba.DPPCLK[k] = mode_lib->vba.cache_pipes[pipe_idx].clks_cfg.dppclk_mhz;
 		else
-- 
2.43.0




