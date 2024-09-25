Return-Path: <stable+bounces-77283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8D5985B6B
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77BC1F20F20
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70C119341F;
	Wed, 25 Sep 2024 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKnpdKct"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8423C192D99;
	Wed, 25 Sep 2024 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264954; cv=none; b=fgJq//IYzmc3DzYhKdeinCoz+TnQuyF6ZDZmNvBoM0XOFBt4SNd3uUnMo93VkZvgzh0nIpn/ObPhgDN124ML1zWyYeKONiiEjjBv2VbCKZgUNM+KmZrgg/RwUMI3ksEyD+6ty+/WV5VYwekuf+tUKFmU4FQjJUC7ZAQE5psfQN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264954; c=relaxed/simple;
	bh=gjTH1Eu975+Nj/evwLe8wgP6Kq0WnfEk+LdENP6QqEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHpYxVUTfvAinoAUR0bJpCW/VrVMjnVjbqbRNd/Rhdvl2ygak7Uvq5dare7CAqO+ACqCjOnH7tET0mFhMhvy5kDJ4b4uPPNRudEhTZSArX/ItdeEAJ4Wrvfj4lcKX33mFIEY5v9i/Yp263bCFHxs205+zXKsgBnEtg86LeOBtJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKnpdKct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21B6C4CEC7;
	Wed, 25 Sep 2024 11:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264954;
	bh=gjTH1Eu975+Nj/evwLe8wgP6Kq0WnfEk+LdENP6QqEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKnpdKcts00dQzFdtM3aOVtWlTKC3qXQUBII6Z9dNPWJ++oUmw9LtDj/K7SjHywfG
	 67IMu+dg6jxbF83vR0ysKTiySu6KjrnwHiF35V1W470nNtICkPtTc/HvBnX0JBfRPC
	 jrh474oTLQ2MYc/WnPDOZStKYRlNvbpf8sGbdxcyNmGCLBdDbaDm2LJLhlOIiIOoXB
	 KkTYOq6xtlOrhbYPBraX9v5gKyKhyXtqoBWntgnYdSJ5PyyrXoAJifqD2c5GWKqbw8
	 BxqDHxEqQMV5psnFbUVOa4dYAcjQHGy2ejM9ksaYSBUHJ12zSd9xgdbgDpQy/BIlgG
	 hJdqidji5qTuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	aurabindo.pillai@amd.com,
	hersenxs.wu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 185/244] drm/amd/display: Increase array size of dummy_boolean
Date: Wed, 25 Sep 2024 07:26:46 -0400
Message-ID: <20240925113641.1297102-185-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 6d64d39486197083497a01b39e23f2f8474b35d3 ]

[WHY]
dml2_core_shared_mode_support and dml_core_mode_support access the third
element of dummy_boolean, i.e. hw_debug5 = &s->dummy_boolean[2], when
dummy_boolean has size of 2. Any assignment to hw_debug5 causes an
OVERRUN.

[HOW]
Increase dummy_boolean's array size to 3.

This fixes 2 OVERRUN issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
index 1343b744eeb31..67e32a4ab0114 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -865,7 +865,7 @@ struct dml2_core_calcs_mode_support_locals {
 	unsigned int dpte_row_bytes_per_row_l[DML2_MAX_PLANES];
 	unsigned int dpte_row_bytes_per_row_c[DML2_MAX_PLANES];
 
-	bool dummy_boolean[2];
+	bool dummy_boolean[3];
 	unsigned int dummy_integer[3];
 	unsigned int dummy_integer_array[36][DML2_MAX_PLANES];
 	enum dml2_odm_mode dummy_odm_mode[DML2_MAX_PLANES];
-- 
2.43.0


