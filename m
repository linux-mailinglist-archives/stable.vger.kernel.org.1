Return-Path: <stable+bounces-48146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F00D8FCCF3
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424A328A77B
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F3619938F;
	Wed,  5 Jun 2024 12:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqmUp035"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFC119938C;
	Wed,  5 Jun 2024 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588977; cv=none; b=uaQtarYt//Gom6YWzb8ayKEZ5UoY98AXyn4B20SJTPyX0RZGTT39nlB0Of5A9D+DPV+sLOz5Og1FVtQV2KJ5U1YEE52lRjHZU82TFRn1bcvryh2s99F/bTIX2p/j4OXku5jogRhU8BqDJ84wU1O1Km0xhJ8PAcyfp61pwVwMRWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588977; c=relaxed/simple;
	bh=cpLQBDYTpOjTj5+0cqgMMLMfiWdRzQ2aqkxE/qjxEpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hhgv1KkvPchuJ4aZUepcdrqIWsn1zoXHcVRax7/8F84EHLBl7UbNicdpSFwbI+WtmvUWOCb5JMLUeiPumIaP8sl5Ue1XP5BDbHz/g1FxlM/6TGLWDCWFNeLOg+brPAxPgVfTMs/mLH2pbXubjZ9LHNBeNJ2oIkeGQGt72sFkY10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqmUp035; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296CDC3277B;
	Wed,  5 Jun 2024 12:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588976;
	bh=cpLQBDYTpOjTj5+0cqgMMLMfiWdRzQ2aqkxE/qjxEpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lqmUp035nxaOYeI3ndmNaqokZJeYb9dlNMEga2KXNlm1ox5mqQpd4Toie3YngqjO4
	 6dKQrHRM4C70UzIJPZu/VOi2wgFCAjyYTmkdTK26ydwHD5kg3ouYu5ILw7f3nFaIQa
	 cEAD9ER7Vee+iNKJfFRBZ1QWrCAQltJX73Z3+ZpQqs/F2JjjWtckwtOMUh6r7n+vbJ
	 ne7xdxWDBY3x550xE5IrZ08gbF0jwlMxf0sYBdxRb09j2aIf5JMduxXqclyzh9zIPy
	 0M1JhnxpjAMsfH6bnJ/D6Hm4tZqEoZpiD1D1INADYz9nY6B+kYTo9tgzNT/30Hmnwo
	 gneHFCaeDkwCQ==
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
	aurabindo.pillai@amd.com,
	Le.Ma@amd.com,
	li.ma@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 19/23] drm/amdgpu: silence UBSAN warning
Date: Wed,  5 Jun 2024 08:02:02 -0400
Message-ID: <20240605120220.2966127-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120220.2966127-1-sashal@kernel.org>
References: <20240605120220.2966127-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
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
index af3eebb4c9bcb..f732182218330 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -3540,7 +3540,7 @@ struct atom_gpio_voltage_object_v4
    uint8_t  phase_delay_us;                      // phase delay in unit of micro second
    uint8_t  reserved;   
    uint32_t gpio_mask_val;                         // GPIO Mask value
-   struct atom_voltage_gpio_map_lut voltage_gpio_lut[1];
+   struct atom_voltage_gpio_map_lut voltage_gpio_lut[] __counted_by(gpio_entry_num);
 };
 
 struct  atom_svid2_voltage_object_v4
-- 
2.43.0


