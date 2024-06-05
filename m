Return-Path: <stable+bounces-48183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710188FCD71
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70817288B09
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634251C95FC;
	Wed,  5 Jun 2024 12:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dy+Dhs3n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5731C95C7;
	Wed,  5 Jun 2024 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589077; cv=none; b=NCCnpbpQEVpyCVwFwn1KvIcWXbCfT6lGPIIxFBsXsyD7AlmMyr46gEWvXzU7yBb1lUkWPAxY+K9XaD8fiq2HBKSmE4YSM11ZxWC5C1zZH9wbhR8lfftD6+NzG1a+5IRLgFezoeGvRgHgUbp9gjbqtUTWAQkxdQgb1PWIIx/iMwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589077; c=relaxed/simple;
	bh=mhF2FMNKnJzLhKnTFHQyPQ5Vg1uXY8LbYLMJ+EGQuNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lR2KpSvCAV6ueQCa6hfAw/xm48tVaCCguoLK63MrmXos1fESJUABt7uzAC0g5JRbVOCf78qaogv2+edleBYSRdJ4jyVSWgoVOxYCXd7OpA2d6Lp5/16Sy7rlR+6QJmEfnzMwbwJbR/XQKKR48jZvmXkEjZjsjfaT+ZBRMdVkVaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dy+Dhs3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5B0C32781;
	Wed,  5 Jun 2024 12:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589076;
	bh=mhF2FMNKnJzLhKnTFHQyPQ5Vg1uXY8LbYLMJ+EGQuNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dy+Dhs3nnUWzMDjtYr53dzY9b3qtqladJB+cCDZS/v/CA2stXsid16hOruWk2c5ck
	 urkXTiHQ06oMa5FCtuvnSCPsTy0oK7DxgoytcqcU+8xQH2gqTQra1n+QBWeNEQwNbE
	 tfM+Ap+RDDM58GSZkMospq+5buP9kHTFSY0AP2C1MlfRgrE/PHNsTm/CQu6tkkuyp3
	 Y33xBCNFaD61fHnLfYZKVxFnC360WHM7Y3mLIStLqbRH7TuLCMdmNOQCJZmWLsZDXp
	 RAsKpG2V8Pf4vjr8AtvWay9DzDKj/sV/BIJZCMQjmUT6giDVe6P3iOjJvwUpXlCX7y
	 5k1wD8NA3XJrA==
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
	li.ma@amd.com,
	aurabindo.pillai@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 15/18] drm/amdgpu: silence UBSAN warning
Date: Wed,  5 Jun 2024 08:03:54 -0400
Message-ID: <20240605120409.2967044-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120409.2967044-1-sashal@kernel.org>
References: <20240605120409.2967044-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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


