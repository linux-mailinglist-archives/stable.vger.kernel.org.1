Return-Path: <stable+bounces-48165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB478FCD33
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C031C20B58
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3587A1C53A4;
	Wed,  5 Jun 2024 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cK5zq9lf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A921C5380;
	Wed,  5 Jun 2024 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589028; cv=none; b=NOI4cEiWvTn0qND55qdQH4JGwbn33VQfxCI6MeGBnh1NHKWsLBKSEGK6ZqPNRjjx6z5G1b/6HI2bsXoBvc7N3guYJhACnFtmQXv0GJHv43EGcf1MId87hBi3Rqy3gxssy6p2qgTzrWp+ddwy1mYUWNbvy5ISnjMiFl/lHbdbyx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589028; c=relaxed/simple;
	bh=mhF2FMNKnJzLhKnTFHQyPQ5Vg1uXY8LbYLMJ+EGQuNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/ldPYOWx8o6xUzJIkNN5IR6gPAto2zMEogEtV1lyIj3cVT7mohGfXZnnmQ8TNwtJitfKAZLsP8Fg5amngFpdNmB8eKiHX6CUmKrnr+I6ugRdOEY38MmEaYODdM5oC51Sxfm+CL1imaBo2fMgBBOPlOvSlEOeVT9gvun2TUfXhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cK5zq9lf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD869C4AF09;
	Wed,  5 Jun 2024 12:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589027;
	bh=mhF2FMNKnJzLhKnTFHQyPQ5Vg1uXY8LbYLMJ+EGQuNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cK5zq9lf4DIUHy1FPxwUwMHWtD8lBAGBP2rahqF4iEJlq4q66lDm9q/kjtku2T/n7
	 m/P9WXd3pfY2UJQCo1Y4/ihP270odcT60WieTl3bkfBZSEpeqT86An5eKfBuphH6WB
	 GtW1dCFz+IfjhJCwjpxPOJJOUQOMVgZ3B/j5Rc7uT1io65j3VxE+eCWm39SP1t+if/
	 9k9SpT3u8ZUL1cBZq2aJq5rB448FNN0bxuUS3bKQu14nl6j4EB2CGaByzOu5aSkaqF
	 rk4Qo/QvTF1BS+/fXSOm9UawZoXnMeqdDEtlt9y4eiAYu90HLEbuQfAMn5Ea1MF8gu
	 rFJa0wLsVpL1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	candice.li@amd.com,
	Le.Ma@amd.com,
	lijo.lazar@amd.com,
	aurabindo.pillai@amd.com,
	li.ma@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 15/18] drm/amdgpu: silence UBSAN warning
Date: Wed,  5 Jun 2024 08:03:05 -0400
Message-ID: <20240605120319.2966627-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120319.2966627-1-sashal@kernel.org>
References: <20240605120319.2966627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 05d9e24ddb15160164ba6e917a88c00907dc2434 ]

Convert a variable sized array from [1] to [].

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index fa7d6ced786f1..06be085515200 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -3508,7 +3508,7 @@ struct atom_gpio_voltage_object_v4
    uint8_t  phase_delay_us;                      // phase delay in unit of micro second
    uint8_t  reserved;   
    uint32_t gpio_mask_val;                         // GPIO Mask value
-   struct atom_voltage_gpio_map_lut voltage_gpio_lut[1];
+   struct atom_voltage_gpio_map_lut voltage_gpio_lut[] __counted_by(gpio_entry_num);
 };
 
 struct  atom_svid2_voltage_object_v4
-- 
2.43.0


