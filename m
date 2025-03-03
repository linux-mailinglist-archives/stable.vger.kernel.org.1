Return-Path: <stable+bounces-120135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C78A4C803
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009681885AE3
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7079E25E838;
	Mon,  3 Mar 2025 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhp1lLru"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F11822A81E;
	Mon,  3 Mar 2025 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019480; cv=none; b=SNHM1XDSq2k7LzIhR+pc+cbw/BNWz1vZa1xVu4s4ugfXy16pAx4RxpUPfc84BKbjPv85Lhf9jlmXFF66Nxq8N2sAL0b+KzJRaTog0vdUSgdp9Ctom83Ej7pnXTpHnyalfrP9zHc0kWZxBnVoA1REX0mThGugmD2eZP15C/a+pt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019480; c=relaxed/simple;
	bh=kWMnwqFbpjLz79Bq1d2W52AJjEPoXPjTiAxNA0FiBOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FYvURacq+TsHJGVkrgHEOPJjGbDKgBl52mdWN1D9DokRgNzA+4SEGGoW9D8PqUre9NQunLPTvGSEeuV9EH5Cx0ISFaJi99MVwSe9AxOeK4OLXMiCMZhF1iH+I9NJa8nR1jVO+JyJIgNsaiAIXhUKlnN7hfWE2/i53SrpNYWWelw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhp1lLru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B916CC4CEEB;
	Mon,  3 Mar 2025 16:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019480;
	bh=kWMnwqFbpjLz79Bq1d2W52AJjEPoXPjTiAxNA0FiBOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhp1lLruMVfR/btPCM3zIEPxwrVWQUVP2QcCfO7uKBM8tgqU4GepoLALrA2G17eg6
	 acvFIAMjWanarh7WrcsRprm/TpSTDC+szPlsouxVEG0ypZ/e2PnMyTPyS08F3ugSMk
	 gkmCD/GYe7al6sXoUIxHLL4xIB8S5Q7B0UZDIplmldiLEwtk7C2iZYMaOGFTeGgQM4
	 mzdmABlHnykAUSyCf5bLlNVpjbWctvgF7fTTjLxPuSg5EmcpPux8kqrI36D8yBMKSx
	 NoHFxredZxAqalKvJqRUyr5wqIGvEZgc2SZqRPB/xa+IOoVFcCgnoLNBoEnkGpa0b2
	 9+ALBM7aV7lgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Louis Chauvet <louis.chauvet@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 05/11] drm/vkms: Round fixp2int conversion in lerp_u16
Date: Mon,  3 Mar 2025 11:31:03 -0500
Message-Id: <20250303163109.3763880-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163109.3763880-1-sashal@kernel.org>
References: <20250303163109.3763880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.80
Content-Transfer-Encoding: 8bit

From: Harry Wentland <harry.wentland@amd.com>

[ Upstream commit 8ec43c58d3be615a71548bc09148212013fb7e5f ]

fixp2int always rounds down, fixp2int_ceil rounds up. We need
the new fixp2int_round.

Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241220043410.416867-3-alex.hung@amd.com
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index e7441b227b3ce..3d6785d081f2c 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -98,7 +98,7 @@ static u16 lerp_u16(u16 a, u16 b, s64 t)
 
 	s64 delta = drm_fixp_mul(b_fp - a_fp,  t);
 
-	return drm_fixp2int(a_fp + delta);
+	return drm_fixp2int_round(a_fp + delta);
 }
 
 static s64 get_lut_index(const struct vkms_color_lut *lut, u16 channel_value)
-- 
2.39.5


