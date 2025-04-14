Return-Path: <stable+bounces-132535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C6BA88335
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16BE93BC5D6
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D4A29963C;
	Mon, 14 Apr 2025 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vChunc63"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0FB299637;
	Mon, 14 Apr 2025 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637360; cv=none; b=VJWsbv4gFOpL71ZlEvvXNO/m1rhCtiiCLAITVMQ3yx/0ejpFT2XspBR+gVpKusIXrIhdxybNT4V/6hSy7evr7b4TT/YJPax2ZyTgmaxBcPXlyNBlcZerKr24/3GdJWIL7vx1brNO5IeOZdO5go6A91u2wYGX+sP3y87Gci/b96Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637360; c=relaxed/simple;
	bh=Xrq2Yfzw5zZd5Mm2iqX65yI4BHFIBG2Z1/asqp7BWNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M9FbNKr0LpWgsh0pBsJU5SiBX41ErWgKBvwXUviIIBzk0CGoObeVs1wBu6oMWx0h1ww/mbj6koHU15mDy/bvVXduxPDBSopPDlzbBjCMAXI0cMMdyyK00e99z/78oxWYuSeH2kbgCjdl0StGQjX5clV3VvZy+/FxxiEqrarjECQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vChunc63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BF5C4CEEB;
	Mon, 14 Apr 2025 13:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637360;
	bh=Xrq2Yfzw5zZd5Mm2iqX65yI4BHFIBG2Z1/asqp7BWNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vChunc63qjtqrwupt/24rbQKqu4+PWCOGY7TePtsstvInTVnMA6bYol/Aadih62Kw
	 qPmWsnoH2RblUd2WcUoayH6Hgu0llY2PQKpNfzQCqoCXKI7Q08+R2b6ewLTw6OzrwG
	 cPA00E9VtFf7bIGb4fFCv5f7Vq4fXXxyfP/ZPQ6CpMXDDPJ7z0nU+LCVjfvBuNfR04
	 gpoKso8k/Bm77VFGJj/Oy/eoG+1u4wCV4MbaYLP2SDeSSIg1HNLkycAsmeqxDcd89r
	 uYvLEpbgCgK9eA0vL7Y8dkbxy2C4EtK9ThTNvHfaV9dIU/dVox0nMunffO6nEJ9JIM
	 7+tNXz3x0sGTg==
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
Subject: [PATCH AUTOSEL 6.12 12/30] drm/xe/xe3lpg: Apply Wa_14022293748, Wa_22019794406
Date: Mon, 14 Apr 2025 09:28:29 -0400
Message-Id: <20250414132848.679855-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132848.679855-1-sashal@kernel.org>
References: <20250414132848.679855-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.23
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
index 264d6e116499c..93fa2708ee378 100644
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


