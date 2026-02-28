Return-Path: <stable+bounces-220868-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBFUI3lHo2lM/AQAu9opvQ
	(envelope-from <stable+bounces-220868-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:52:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1DB1C7740
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D27531D9F26
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3797C41E5DC;
	Sat, 28 Feb 2026 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6sA5efJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E883241E5D0;
	Sat, 28 Feb 2026 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300753; cv=none; b=giohgWwPKwKqd02/EdfWtG1yZyWyRuTOhfe+TAFCO9czhYxnCDv0H5RKdH3mz6m7zo1GVCgvDqdGNyl68gaebGN9ujcotTAKCtht33baaXZDwpbtR79IkBb+kvPAbuRW4IYeEVYz491LWuMORwIciQZib8mXY9oV0bScfdX+NbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300753; c=relaxed/simple;
	bh=sJPjn9/el1BMGHGiVhN4lm3RjvPSjPUYYJVsKWZ2OkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMZrYIofyWIOIpaAs9MIFi+pn2NaL05zbWlzb5i6NOzSx8QQIzBSvj0n+R1bI1sWOySnWoAXZ4XJxCVaMo5QNHqrXl8PvXyG7AwXMB3IazaCZTHYlfFsWAQXhHOzl1H8acb0YEUisA6wruYeKMaVVCWB344YWcftdqq4SsyOF9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6sA5efJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B37C19424;
	Sat, 28 Feb 2026 17:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300752;
	bh=sJPjn9/el1BMGHGiVhN4lm3RjvPSjPUYYJVsKWZ2OkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i6sA5efJ4j5B8XxeywiawjWA5RNrvlIcRYW9UUi5lCP0tvoV6b2qiRecwBWonCylT
	 eZOfAEVII1phcAr74fjNoPRyfibf6Ur1YKm+3WEjmA2vaJiO0LP/ix0axhpeHWRtxz
	 CmliRAAOKSoUYkpqOE3/HjNphP8+5oJnxRPkrLnQnY66Xr0RyUlp4aXjOGqdtmrqoN
	 XrH6UbqJOmC4JNXjPNDWXQZze//EowYVF6BPZ0YznH0Uhhz8wcTIK9KQ9nY1S9zWE+
	 DSwAsmKNdY2JEq98OjTh85rp87Dez74J2SoUXgeJD4Muz1cwcdGlmRI5nMmLzp4Era
	 aBlHD+9EHd2yA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Imre Deak <imre.deak@intel.com>,
	Vinod Govindapillai <vinod.govindapillai@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 789/844] drm/i915/dp: Fail state computation for invalid DSC source input BPP values
Date: Sat, 28 Feb 2026 12:31:42 -0500
Message-ID: <20260228173244.1509663-790-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220868-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 0B1DB1C7740
X-Rspamd-Action: no action

From: Imre Deak <imre.deak@intel.com>

[ Upstream commit 338465490cf7bd4a700ecd33e4855fee4622fa5f ]

There is no reason to accept an invalid minimum/maximum DSC source input
BPP value (i.e a minimum DSC input BPP value above the maximum pipe BPP
or a maximum DSC input BPP value below the minimum pipe BPP value), fail
the state computation in these cases.

Reviewed-by: Vinod Govindapillai <vinod.govindapillai@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patch.msgid.link/20251215192357.172201-17-imre.deak@intel.com
Stable-dep-of: fe26ae6ac8b8 ("drm/i915/dp: Fix pipe BPP clamping due to HDR")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 28 ++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 0ec82fcbcf48e..d0dbc6715717d 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -2605,16 +2605,30 @@ intel_dp_compute_config_link_bpp_limits(struct intel_dp *intel_dp,
 	return true;
 }
 
-static void
-intel_dp_dsc_compute_pipe_bpp_limits(struct intel_dp *intel_dp,
+static bool
+intel_dp_dsc_compute_pipe_bpp_limits(struct intel_connector *connector,
 				     struct link_config_limits *limits)
 {
-	struct intel_display *display = to_intel_display(intel_dp);
+	struct intel_display *display = to_intel_display(connector);
+	const struct link_config_limits orig_limits = *limits;
 	int dsc_min_bpc = intel_dp_dsc_min_src_input_bpc();
 	int dsc_max_bpc = intel_dp_dsc_max_src_input_bpc(display);
 
-	limits->pipe.max_bpp = clamp(limits->pipe.max_bpp, dsc_min_bpc * 3, dsc_max_bpc * 3);
-	limits->pipe.min_bpp = clamp(limits->pipe.min_bpp, dsc_min_bpc * 3, dsc_max_bpc * 3);
+	limits->pipe.min_bpp = max(limits->pipe.min_bpp, dsc_min_bpc * 3);
+	limits->pipe.max_bpp = min(limits->pipe.max_bpp, dsc_max_bpc * 3);
+
+	if (limits->pipe.min_bpp <= 0 ||
+	    limits->pipe.min_bpp > limits->pipe.max_bpp) {
+		drm_dbg_kms(display->drm,
+			    "[CONNECTOR:%d:%s] Invalid DSC src/sink input BPP (src:%d-%d pipe:%d-%d)\n",
+			    connector->base.base.id, connector->base.name,
+			    dsc_min_bpc * 3, dsc_max_bpc * 3,
+			    orig_limits.pipe.min_bpp, orig_limits.pipe.max_bpp);
+
+		return false;
+	}
+
+	return true;
 }
 
 bool
@@ -2654,8 +2668,8 @@ intel_dp_compute_config_limits(struct intel_dp *intel_dp,
 							respect_downstream_limits);
 	}
 
-	if (dsc)
-		intel_dp_dsc_compute_pipe_bpp_limits(intel_dp, limits);
+	if (dsc && !intel_dp_dsc_compute_pipe_bpp_limits(connector, limits))
+		return false;
 
 	if (is_mst || intel_dp->use_max_params) {
 		/*
-- 
2.51.0


