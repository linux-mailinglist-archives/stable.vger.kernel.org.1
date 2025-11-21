Return-Path: <stable+bounces-196506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EF2C7A8F7
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 669AA363C62
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7875E280A56;
	Fri, 21 Nov 2025 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERFCp15Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F39E2D97BD
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763738419; cv=none; b=net7i2lmuZcL4k06AFe9oIKhg8BkmsNqtk0y6FYNimIHIcXb6U4WmoFO0jYego+hyRJTr0/uBbrb6cx8zC57+IYOgPEYVXzFMIgy2shhjXNGYvR4eZDclJNF8mY95D2I0R4ns6semQMvEc7WM2bk6Wobf/sG43lOI8qyOkKXMuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763738419; c=relaxed/simple;
	bh=udFqrM9u3Us7FpBuFP9VzE5E39QigyJqtD1GmTRFO+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sP6pKafwpy1ooq2iPjMVloD2mu4k8WZdqD6G2EylYXgspaPnDo6Ciw3TZK3VFxMcNsGakvRIs1k3QeMmuJCI5DDFHumM4lKxqPOb67cUUJvEcEIT7f8rDfrMll1TjFsb25nKfDx3dk5A0DMS+ftqSQ1b6I1/9/6DnxUHgJ+wekU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERFCp15Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A4DC4CEFB;
	Fri, 21 Nov 2025 15:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763738418;
	bh=udFqrM9u3Us7FpBuFP9VzE5E39QigyJqtD1GmTRFO+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ERFCp15QhDOGG8IhYsWziW9jh9S6R/owl9ii24RSHu1onx05WhL8hbA1IroD15upl
	 TC+IlOt07r8twnpj8JS55NIeoV14n4Zx8dDvOg/y3iPgAvyH1kGlBdG8DFcjuRDn0W
	 Cx5g4ThvDkiKeC9JFaM5ntKOuMb3kJpJUvxZZAlTR0R9Pasnadc1TMYg3wzptXufnN
	 qERbaOT0iQcMr3+NdJNU3jKHzwhMHo//3nlWUSCSHfIw4u/prHoZllfms2GF4oOFI+
	 JxPwICJsHzVQn8EiBee4C0r+lR5kkA5xmC83YCcWqtS+tZviNEI/qfjxtFpftQStci
	 BJTNltBXFi0dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imre Deak <imre.deak@intel.com>,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Animesh Manna <animesh.manna@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 2/2] drm/i915/dp_mst: Disable Panel Replay
Date: Fri, 21 Nov 2025 10:20:15 -0500
Message-ID: <20251121152015.2567941-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121152015.2567941-1-sashal@kernel.org>
References: <2025112017-voter-absentee-5ffd@gregkh>
 <20251121152015.2567941-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Imre Deak <imre.deak@intel.com>

[ Upstream commit f2687d3cc9f905505d7b510c50970176115066a2 ]

Disable Panel Replay on MST links until it's properly implemented. For
instance the required VSC SDP is not programmed on MST and FEC is not
enabled if Panel Replay is enabled.

Fixes: 3257e55d3ea7 ("drm/i915/panelreplay: enable/disable panel replay")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15174
Cc: Jouni Högander <jouni.hogander@intel.com>
Cc: Animesh Manna <animesh.manna@intel.com>
Cc: stable@vger.kernel.org # v6.8+
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patch.msgid.link/20251107124141.911895-1-imre.deak@intel.com
(cherry picked from commit e109f644b871df8440c886a69cdce971ed533088)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 88531c9be22cb..42e1f044f77f5 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -602,6 +602,10 @@ static void _panel_replay_init_dpcd(struct intel_dp *intel_dp)
 	struct intel_display *display = to_intel_display(intel_dp);
 	int ret;
 
+	/* TODO: Enable Panel Replay on MST once it's properly implemented. */
+	if (intel_dp->mst_detect == DRM_DP_MST)
+		return;
+
 	ret = drm_dp_dpcd_read_data(&intel_dp->aux, DP_PANEL_REPLAY_CAP_SUPPORT,
 				    &intel_dp->pr_dpcd, sizeof(intel_dp->pr_dpcd));
 	if (ret < 0)
-- 
2.51.0


