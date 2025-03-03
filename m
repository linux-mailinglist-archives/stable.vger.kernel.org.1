Return-Path: <stable+bounces-120105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F234A4C75D
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC037AA435
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEEC22D7BA;
	Mon,  3 Mar 2025 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNcPIUTk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0857622D7A3;
	Mon,  3 Mar 2025 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019409; cv=none; b=dnZTpaGjIgjD902mlpjAi3nzKYJ+aFSchjxHO7G3EQy11HXWTJ0sFKmEYt2rQewodmkxynbKMzQuj+EVCIQkHg5SPDVbr1OvWdAb0YQl7vB3ikOyd92851tKZy79p5VheJDVFBWcj2qNSvZm6OcuaS3lECn3YCAcf71PkuxEzvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019409; c=relaxed/simple;
	bh=Gbp33Zg0auw4J+qVFDCsrw5W/bYPrkw5XHuHErAJtxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jp0RIRen85NfcPoOxwHkqjmzMfuTCsPHoj8rjf7r4Y6z4pxNqhjojXYiHHXKDRXGFs4FhpHoImmTW1yLRiQf6wPqKJmZVe6hp6U/PQYkkOOKQ6EHyd5B5J6loLMN2zBTLcw4EQoI5zaOC9qBFEV5X78QjVWReLJvOOgZ1Q3tJac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNcPIUTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D27C4CEE6;
	Mon,  3 Mar 2025 16:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019408;
	bh=Gbp33Zg0auw4J+qVFDCsrw5W/bYPrkw5XHuHErAJtxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hNcPIUTkF/8IVVXD7zSPa4wJEth5XP7YJBy7UD4R5iXvnEGHvFtjzg5+bC19QV4Zy
	 YFiDMMHcjNg0mAQiTdKR7uPrzTKP8qsPmZA52ykG9B/X/j4RTrrxP1+ey1p+CouAdL
	 vDA2BiSbP+lkL1/A8A107e7vKNBcfZ6MPNd+2vWvHG2yvYQ6O6K5seTh4p2mHRqGhn
	 xNFSc/Fv9G57lW+JaEJgH31eM1ZMwPMFAVsbh50pRjCge4WiLz4RHqqxaJvQRfdMH3
	 zC+THN6IpeHa2YuDMzuESDbWloGxsAvCVqi3kFbqzkz5CdzRQVmxJeCBmBQAZogufh
	 wOuTk0WsMCdvw==
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
Subject: [PATCH AUTOSEL 6.13 08/17] drm/vkms: Round fixp2int conversion in lerp_u16
Date: Mon,  3 Mar 2025 11:29:40 -0500
Message-Id: <20250303162951.3763346-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303162951.3763346-1-sashal@kernel.org>
References: <20250303162951.3763346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.5
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
index 3f0977d746bee..87dfb9f69ee5b 100644
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


