Return-Path: <stable+bounces-132504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DB1A882A7
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881EF18865E4
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0242749E0;
	Mon, 14 Apr 2025 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bC4ztG2g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FC82749C4;
	Mon, 14 Apr 2025 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637291; cv=none; b=WXHr3azqpQifofZ7pYzbRI8TNqbW39zEVjBEQhxKf6K62ntff5g1EIh77rcecEqWoBViTni2/NmuBpdxOPA5rKqS0n+RGYg6tdPMJRiJ2xgV45yJfBXBImdHSrpt/p6xxjjUV0hZRNOFwIs90CbG0zFBOP1acCpoxT8c/xp/zZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637291; c=relaxed/simple;
	bh=k+SL8dEg7ENs/COZj5rZ0WhegA0J+cWXSyZ+EquTBI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ILb4YjiiCvU422XHec4hsXcRruPQM82FlDP0XLC13DlDHKkP0bzOeICMT7ldGZo3vx9Bd3UXLrq8JMGSsrWFTWfeoduK2nADSUQ4Wf17J4coKqLRhgyRr+Bv/sT8Zs1eDKmBpH5Ys2Gwjba07Lkz0omn6YRN21LPXhrzsru8T+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bC4ztG2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD9FC4CEE2;
	Mon, 14 Apr 2025 13:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637289;
	bh=k+SL8dEg7ENs/COZj5rZ0WhegA0J+cWXSyZ+EquTBI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bC4ztG2grhUYedyZ7KoSk6RAw1w/au/GlIX8S2JFlu4orvN4/IRUQBU5MYcne32lu
	 TQTv2L69GWdg62DBQ2JldmTDD2I/AdbLg0HiJII5LU24tDoLukmwIZKiQwllYMDiuY
	 aon3pC9AZYLp67ipMsPJqY8WkE0+FQOByhJsEbAJJfLkV6sCu0R+fc14KFaBNehHoY
	 OwFCm1h2cnIM+c6M8dnLQP7GsNhwNCxoPtTurddZdp1sz52cZPB9NW6QhEiX4HCTj2
	 9usQLlVM5PFxtDhZwvdYg87mHVXPhR3/GO0WoPHEvwpYUIML2ET/Ahl5D7sQ4oYtMa
	 8MjCRjqjkSgLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Julia Filipchuk <julia.filipchuk@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 16/34] drm/xe/xe3lpg: Apply Wa_14022293748, Wa_22019794406
Date: Mon, 14 Apr 2025 09:27:10 -0400
Message-Id: <20250414132729.679254-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132729.679254-1-sashal@kernel.org>
References: <20250414132729.679254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.11
Content-Transfer-Encoding: 8bit

From: Julia Filipchuk <julia.filipchuk@intel.com>

[ Upstream commit 00e0ae4f1f872800413c819f8a2a909dc29cdc35 ]

Extend Wa_14022293748, Wa_22019794406 to Xe3_LPG

Signed-off-by: Julia Filipchuk <julia.filipchuk@intel.com>
Reviewed-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Signed-off-by: John Harrison <John.C.Harrison@Intel.com>
Link: https://lore.kernel.org/r/20250325224310.1455499-1-julia.filipchuk@intel.com
(cherry picked from commit 32af900f2c6b1846fd3ede8ad36dd180d7e4ae70)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_wa_oob.rules | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
index bcd04464b85e8..7fc65f1cec02d 100644
--- a/drivers/gpu/drm/xe/xe_wa_oob.rules
+++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
@@ -29,8 +29,10 @@
 13011645652	GRAPHICS_VERSION(2004)
 14022293748	GRAPHICS_VERSION(2001)
 		GRAPHICS_VERSION(2004)
+		GRAPHICS_VERSION_RANGE(3000, 3001)
 22019794406	GRAPHICS_VERSION(2001)
 		GRAPHICS_VERSION(2004)
+		GRAPHICS_VERSION_RANGE(3000, 3001)
 22019338487	MEDIA_VERSION(2000)
 		GRAPHICS_VERSION(2001)
 		MEDIA_VERSION(3000), MEDIA_STEP(A0, B0)
-- 
2.39.5


