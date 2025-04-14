Return-Path: <stable+bounces-132470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 989F2A88258
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6F13BAA6C
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91589274FF4;
	Mon, 14 Apr 2025 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c28KFnPf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0A3274FEF;
	Mon, 14 Apr 2025 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637212; cv=none; b=Y1q2ZBnJq0p9Kwu13vwm5D2bBRe+uniEv96P0dtM/1a+SZmGL19uVu0O+MhnuSl/w3LmVqvyxncBF4Mnxqz1ecSRKJZANVLz9pQ9c8kvJCp7BXnKDYpleKutGLSvtFRQ2O0VZ4SgaLPvcpDwBZzmtPRYz7ZBO+SMs39CJAJnQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637212; c=relaxed/simple;
	bh=Qp6THprdWDFWle92yah0O82HvsSdGxsVeMTRew2db0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=faIBqTRaYNb8wBK2fC3iiVG1dEnwDwxflN1FSutTRrLXJWDcJ+161neQhM7ARZ1+0h9qNXBSYyjkfnhV4WLxrBse9x5in6Qota8T4Ku1slHYH1/gMnCktfzmTrGQ7ytjG9+4fjUIpfUtuKlZPYmbFhIGy+8+4tEhhuY+b5luj9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c28KFnPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25B2C4CEEC;
	Mon, 14 Apr 2025 13:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637211;
	bh=Qp6THprdWDFWle92yah0O82HvsSdGxsVeMTRew2db0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c28KFnPfyXlJi9B+gFDTnhXBRQrlmO9tkvfLkzsMNtQgaJ8G7Svmg3rxxUg+nxD54
	 6wdBMm+olWpHU27/yr8wYNxFDiqRPLLP4GyfsNYSoO9vpYB6xvoMhk5bwyeI3TAcvh
	 Qq91gdSzc/pxtT6InHN3yz5OiTTjBu0ktP/gya1kfbWYBG1AMCVtMLom7vwwwQJJpc
	 02ApqMH3n1uWs4MANXeELQO08QtvoGCTxwLf+9aTAVHcE39P+eeXgzg3NOz7La7ol0
	 Nnx9qS9vqIJXQ+5YaDwaBDLzvp0dQ4ZZM5Gj7FtiI2eF8J3rD9tP8gkrRjl3Q5z1NE
	 RDyPRktUuJyLw==
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
Subject: [PATCH AUTOSEL 6.14 16/34] drm/xe/xe3lpg: Apply Wa_14022293748, Wa_22019794406
Date: Mon, 14 Apr 2025 09:25:52 -0400
Message-Id: <20250414132610.677644-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132610.677644-1-sashal@kernel.org>
References: <20250414132610.677644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.2
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
index 40438c3d9b723..32d3853b08ec8 100644
--- a/drivers/gpu/drm/xe/xe_wa_oob.rules
+++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
@@ -30,8 +30,10 @@
 13011645652	GRAPHICS_VERSION(2004)
 14022293748	GRAPHICS_VERSION(2001)
 		GRAPHICS_VERSION(2004)
+		GRAPHICS_VERSION_RANGE(3000, 3001)
 22019794406	GRAPHICS_VERSION(2001)
 		GRAPHICS_VERSION(2004)
+		GRAPHICS_VERSION_RANGE(3000, 3001)
 22019338487	MEDIA_VERSION(2000)
 		GRAPHICS_VERSION(2001)
 		MEDIA_VERSION(3000), MEDIA_STEP(A0, B0), FUNC(xe_rtp_match_not_sriov_vf)
-- 
2.39.5


