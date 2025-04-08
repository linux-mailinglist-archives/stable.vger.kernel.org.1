Return-Path: <stable+bounces-129458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECC2A7FFAC
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2281188F4CD
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A95267F65;
	Tue,  8 Apr 2025 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DkaLw7dr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055DC266EFC;
	Tue,  8 Apr 2025 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111084; cv=none; b=YOzyngbrm5r31+udFU3kpQua3xTdfWAPQljGq7asTmKsXp+nSCAiGpIaIrpbSSoxkeBizq9XE3jtVMMHy3rL1MkmPx4m845kYam7iasJ27JyJNalrgqYe0cY9N0jLgO0jDJgvDsva3OqK33dgRPmSgthlR6+BeeiRbJ+QUJtCCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111084; c=relaxed/simple;
	bh=eybWzt0FwCYcgo9uhw1xKgSTcIvc+Odu5rMD7MEEDGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/Bva0Z7RULeKogiaSb1YeVk80jteB5fzd7c23UhWzjGhUwqEqLefEBRgQEaxlk9EK3tyujxaYnEpfY6cjLH4XmMbWSBLyGBzziZL9Nv79/zklirct5Kf0x6vzNRgaEDWJzX1pUeKmjO7ro3SZnsj5umpNJXWt/5RVYG/K8dxVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DkaLw7dr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD93C4CEE5;
	Tue,  8 Apr 2025 11:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111083;
	bh=eybWzt0FwCYcgo9uhw1xKgSTcIvc+Odu5rMD7MEEDGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DkaLw7drOuBDzZKA6LYS712zgLBI4KsE1xz5djMj1tkgMlqaxxA8Lf/Slkw+j9/3t
	 YI89+Yh9fLsafAummXzg/wUyAYS1AG07dZv4rO9VXZT7xchEh7leAm4Fse9mYsyV+a
	 dlU/lM6tkKOeZca7WkC1tZO5bH9ma38a5rVlEBYk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 295/731] drm/amd/display: fix an indent issue in DML21
Date: Tue,  8 Apr 2025 12:43:12 +0200
Message-ID: <20250408104921.140309505@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[ Upstream commit a1addcf8499a566496847f1e36e1cf0b4ad72a26 ]

Remove extraneous tab and newline in dml2_core_dcn4.c that was
reported by the bot

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502211920.txUfwtSj-lkp@intel.com/
Fixes: 70839da6360 ("drm/amd/display: Add new DCN401 sources")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c   | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
index d68b4567e218a..7216d25c783e6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -141,9 +141,8 @@ bool core_dcn4_initialize(struct dml2_core_initialize_in_out *in_out)
 		core->clean_me_up.mode_lib.ip.subvp_fw_processing_delay_us = core_dcn4_ip_caps_base.subvp_pstate_allow_width_us;
 		core->clean_me_up.mode_lib.ip.subvp_swath_height_margin_lines = core_dcn4_ip_caps_base.subvp_swath_height_margin_lines;
 	} else {
-			memcpy(&core->clean_me_up.mode_lib.ip, &core_dcn4_ip_caps_base, sizeof(struct dml2_core_ip_params));
+		memcpy(&core->clean_me_up.mode_lib.ip, &core_dcn4_ip_caps_base, sizeof(struct dml2_core_ip_params));
 		patch_ip_params_with_ip_caps(&core->clean_me_up.mode_lib.ip, in_out->ip_caps);
-
 		core->clean_me_up.mode_lib.ip.imall_supported = false;
 	}
 
-- 
2.39.5




