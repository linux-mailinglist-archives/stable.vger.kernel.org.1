Return-Path: <stable+bounces-196505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA871C7A885
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD6C3A4D31
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7676E292918;
	Fri, 21 Nov 2025 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3AWxVGK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353632D94B8
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763738418; cv=none; b=CRfEiebU2Vj4mMbc4SC7tC1AEBPx22/jR9SXfKeQtmeBWekrj/9XnV7X1WwD7MNH+YkxKelXW2D2r+9eAMk5GTCE3JmS2Xc9KmVPkSVYGVwm6gy+328Vh+bUTg6/5pa/e/MNHTwR9eEtuweZYnbvNu8vey0Wt26pIAn/AE93eQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763738418; c=relaxed/simple;
	bh=YzNdjNocdBS+qC3NrgKrXhno1tFz3DUKWrX6DXN4x0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ryr3LidLvS/qv7AvuPTJM/V4n7ev+bdLxIlP1O0wEHUvKwqUC2WiFAQeBckA37+MUI8+4VK4KaRMBTn1/sRhmfWRNn079hvBFAWDx6kwjIoAQVBz9iYxuCRhkoorhwLO4W54BhzT7EawJ/MAehKYq2a9VQK0vyGB7cVEAhoOTBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3AWxVGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3125DC4CEF1;
	Fri, 21 Nov 2025 15:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763738417;
	bh=YzNdjNocdBS+qC3NrgKrXhno1tFz3DUKWrX6DXN4x0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L3AWxVGKOcbYA4cTRub0ZlEAbvEHoNJH5CSnmowJ6ND6eE2XG16C3NrxRTEVTtISm
	 YScTjIeCkNu7hYM1ZESG/aP0pAx8k4rz2QfFcbydtd7uMOwDCq0iuxwn6TJ7TAs45n
	 e23DP4UZ+iHTbsYgg7DVGXATZs55Jx/u6qYv31kiV3uCnqaTezvbeR2R4Sa5KC6Iyq
	 82Hx9vSz+TRuyXv4IOuOr/vVFU9Zd+Vtqw+cB0kAJOyeLO539cFiT6k0bRfC/HkEwP
	 JxZMIyPbl1Jx1V9xNHr2VG2P7aAomM//IQY5XbIe1AOp6cOJjbz/7bt11ZB3HiAVX+
	 BFROGzI6hLIsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/2] drm/i915/psr: Check drm_dp_dpcd_read return value on PSR dpcd init
Date: Fri, 21 Nov 2025 10:20:14 -0500
Message-ID: <20251121152015.2567941-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112017-voter-absentee-5ffd@gregkh>
References: <2025112017-voter-absentee-5ffd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jouni Högander <jouni.hogander@intel.com>

[ Upstream commit 9cc10041e9fe7f32c4817e3cdd806ff1986d266c ]

Currently we are ignoriong drm_dp_dpcd_read return values when reading PSR
and Panel Replay capability DPCD register. Rework intel_psr_dpcd a bit to
take care of checking the return value.

v2: use drm_dp_dpcd_read_data

Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Link: https://lore.kernel.org/r/20250821045918.17757-1-jouni.hogander@intel.com
Stable-dep-of: f2687d3cc9f9 ("drm/i915/dp_mst: Disable Panel Replay")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 32 ++++++++++++++++--------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 41988e193a415..88531c9be22cb 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -600,6 +600,16 @@ static void intel_dp_get_su_granularity(struct intel_dp *intel_dp)
 static void _panel_replay_init_dpcd(struct intel_dp *intel_dp)
 {
 	struct intel_display *display = to_intel_display(intel_dp);
+	int ret;
+
+	ret = drm_dp_dpcd_read_data(&intel_dp->aux, DP_PANEL_REPLAY_CAP_SUPPORT,
+				    &intel_dp->pr_dpcd, sizeof(intel_dp->pr_dpcd));
+	if (ret < 0)
+		return;
+
+	if (!(intel_dp->pr_dpcd[INTEL_PR_DPCD_INDEX(DP_PANEL_REPLAY_CAP_SUPPORT)] &
+	      DP_PANEL_REPLAY_SUPPORT))
+		return;
 
 	if (intel_dp_is_edp(intel_dp)) {
 		if (!intel_alpm_aux_less_wake_supported(intel_dp)) {
@@ -631,6 +641,15 @@ static void _panel_replay_init_dpcd(struct intel_dp *intel_dp)
 static void _psr_init_dpcd(struct intel_dp *intel_dp)
 {
 	struct intel_display *display = to_intel_display(intel_dp);
+	int ret;
+
+	ret = drm_dp_dpcd_read_data(&intel_dp->aux, DP_PSR_SUPPORT, intel_dp->psr_dpcd,
+				    sizeof(intel_dp->psr_dpcd));
+	if (ret < 0)
+		return;
+
+	if (!intel_dp->psr_dpcd[0])
+		return;
 
 	drm_dbg_kms(display->drm, "eDP panel supports PSR version %x\n",
 		    intel_dp->psr_dpcd[0]);
@@ -676,18 +695,9 @@ static void _psr_init_dpcd(struct intel_dp *intel_dp)
 
 void intel_psr_init_dpcd(struct intel_dp *intel_dp)
 {
-	drm_dp_dpcd_read(&intel_dp->aux, DP_PSR_SUPPORT, intel_dp->psr_dpcd,
-			 sizeof(intel_dp->psr_dpcd));
-
-	drm_dp_dpcd_read(&intel_dp->aux, DP_PANEL_REPLAY_CAP_SUPPORT,
-			 &intel_dp->pr_dpcd, sizeof(intel_dp->pr_dpcd));
-
-	if (intel_dp->pr_dpcd[INTEL_PR_DPCD_INDEX(DP_PANEL_REPLAY_CAP_SUPPORT)] &
-	    DP_PANEL_REPLAY_SUPPORT)
-		_panel_replay_init_dpcd(intel_dp);
+	_psr_init_dpcd(intel_dp);
 
-	if (intel_dp->psr_dpcd[0])
-		_psr_init_dpcd(intel_dp);
+	_panel_replay_init_dpcd(intel_dp);
 
 	if (intel_dp->psr.sink_psr2_support ||
 	    intel_dp->psr.sink_panel_replay_su_support)
-- 
2.51.0


