Return-Path: <stable+bounces-77475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E44985D9B
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46E81C250D9
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8421B3759;
	Wed, 25 Sep 2024 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccgACGVW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE721B374F;
	Wed, 25 Sep 2024 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265952; cv=none; b=ou8KerivoIqIr1B5oqLRCkpFXKefD3itaICRKgzNMWa3kzPdbz2k9O4Of4Bw+EjlsDu6UI4MaKqfa1GM4jiTHAYh8B6xG3m4J4fpFIpVbKp2Ij61wNpR2m/cuwizvVzqqOnOIsW+0/nd2ABT9Nj/XG4w2VX4GnHOkLBvD/Cgnq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265952; c=relaxed/simple;
	bh=orZkGjiJeSCB5IXisKsyRURuAMOIPrksN06pQ34+i3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWPyEUSPeq0mfnBUmHGCvLqrymbtGKO9W07wOcETlDCu4VpGAvYRam5sKHaWwNJEyln/TtMUyFa7oXBUWEeyYSXvm5FcAbR++uE/ndk7XVbCC/squuKre2sEICUGvF5y9JXf90C+iSbn33TEjsTsy5cp9WdlvuLEfj+pCL0N3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccgACGVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28023C4CEC3;
	Wed, 25 Sep 2024 12:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265951;
	bh=orZkGjiJeSCB5IXisKsyRURuAMOIPrksN06pQ34+i3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ccgACGVWDQbS4/di/IyjplwOSpHzRQrhPPsNwjlHig2wmlcq3DpWqlczRieqbaAJD
	 EpopfNmO32CQqzVE+iXaOvitsNf0zwR+bEoD0xJ42foHlSwZVnLCDpnRWXTtGGC7b4
	 XwPhq+Zkrt5s7vY3s24eBa12a7PiLB3J0Uv7/ZjrnPrcHCZt05ELLx5K0KIs9YXzsH
	 pwOv0x8nAoble3YSDHyCPLSsEZ0MqaFJC8QQPOa2IeYMY4fjFavNKsApnngYoURmIs
	 59G4XRJEUXECHCvEmKSSMs93ZpdGQj8PTUPaxbbaP+QMhbPW5SNQSItcJvTCCHXMat
	 CbkhJH0bASdow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alvin.lee2@amd.com,
	samson.tam@amd.com,
	wenjing.liu@amd.com,
	dillon.varone@amd.com,
	yi-lchen@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 130/197] drm/amd/display: Add NULL check for function pointer in dcn32_set_output_transfer_func
Date: Wed, 25 Sep 2024 07:52:29 -0400
Message-ID: <20240925115823.1303019-130-sashal@kernel.org>
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 28574b08c70e56d34d6f6379326a860b96749051 ]

This commit adds a null check for the set_output_gamma function pointer
in the dcn32_set_output_transfer_func function. Previously,
set_output_gamma was being checked for null, but then it was being
dereferenced without any null check. This could lead to a null pointer
dereference if set_output_gamma is null.

To fix this, we now ensure that set_output_gamma is not null before
dereferencing it. We do this by adding a null check for set_output_gamma
before the call to set_output_gamma.

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 8759c14a63226..de272a1ab2630 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -581,7 +581,9 @@ bool dcn32_set_output_transfer_func(struct dc *dc,
 		}
 	}
 
-	mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
+	if (mpc->funcs->set_output_gamma)
+		mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
+
 	return ret;
 }
 
-- 
2.43.0


