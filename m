Return-Path: <stable+bounces-81790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C992C994969
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722911F21339
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F051DDC06;
	Tue,  8 Oct 2024 12:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="or5J38U0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14ACEEC8;
	Tue,  8 Oct 2024 12:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390140; cv=none; b=ozwERaW7WVIHG7bcb6D2+ninnvrukICRUKTlTYPXcq7Z5wUOkS5iSUz48wwPoBS73mExMmYp8/5oLvq4EtY8bB7YH3PEuVpOvyoJGR/RhFflul7CmB7jauFJEqAZ+0zqsIwpSbEMxhHY9fUenQCWI2j3xdhRWoBhw6j+2UZ8gVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390140; c=relaxed/simple;
	bh=M1YPD1ON+3QL0ZnIgzK0Nq3A3+SlsiGsSbZte0AgPV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s43ywcPZfDjR9P8G7vVHD5AvTlzFpdI8DMZ/8ftrTB3dPNDHBi15zDLg7KEh5nC6z4C5QCWerEmYUbs5aw+qjQccTEdBLMcJO/JL7poHoeddOT9RGmr8kAPQBpVIiv4VaNQaNEN1hyWXjYiklH7aaE6rsC6j6tpkNEoH7e7uBHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=or5J38U0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27758C4CEC7;
	Tue,  8 Oct 2024 12:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728390140;
	bh=M1YPD1ON+3QL0ZnIgzK0Nq3A3+SlsiGsSbZte0AgPV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=or5J38U0gxZZaBlM9yvx9Rxwm2KH7SilxbJsvSERiKzs/azdHohxiBakTjc/L83w7
	 VGCAKrU+TrYnBzxrDXs8UE6mJJWwxCg/KBR9Bz86M5RuyQtaD3cFF3VCwYnHGXuhOk
	 fTlCJMleI66X0o63vsLiOC3as8zhnEpcBZk1Dzlk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peng Liu <liupeng01@kylinos.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 203/482] drm/amdgpu: add raven1 gfxoff quirk
Date: Tue,  8 Oct 2024 14:04:26 +0200
Message-ID: <20241008115656.298933714@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
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

From: Peng Liu <liupeng01@kylinos.cn>

[ Upstream commit 0126c0ae11e8b52ecfde9d1b174ee2f32d6c3a5d ]

Fix screen corruption with openkylin.

Link: https://bbs.openkylin.top/t/topic/171497
Signed-off-by: Peng Liu <liupeng01@kylinos.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 3c8c5abf35abd..c86a6363b2c3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1172,6 +1172,8 @@ static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
 	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc6 },
 	/* Apple MacBook Pro (15-inch, 2019) Radeon Pro Vega 20 4 GB */
 	{ 0x1002, 0x69af, 0x106b, 0x019a, 0xc0 },
+	/* https://bbs.openkylin.top/t/topic/171497 */
+	{ 0x1002, 0x15d8, 0x19e5, 0x3e14, 0xc2 },
 	{ 0, 0, 0, 0, 0 },
 };
 
-- 
2.43.0




