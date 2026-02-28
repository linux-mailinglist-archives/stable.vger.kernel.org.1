Return-Path: <stable+bounces-220869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC6aI25Ho2lM/AQAu9opvQ
	(envelope-from <stable+bounces-220869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:52:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B551C7732
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0B57313056B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA0F41EDFA;
	Sat, 28 Feb 2026 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eh9zG95B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB2041EDEE;
	Sat, 28 Feb 2026 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300754; cv=none; b=Gd7e/w4hQoexXihA9se+fF2sdo6A/jgobUst+ltsWtfTEQ3MmigdeLC7Efqts3TpJ227oibuKkTJnaaUcQZv6IuBf43KLj0ZTKFZ35x0Ouq6+wbN6h9wNlpMqRqkY0AbNsCDI7uOlTWAAZDawIUmDix+0JK61EW8rE1TsDVNoDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300754; c=relaxed/simple;
	bh=GO/zWVd/A/W2BF9fwRjLNvOo5WKl075fDPmIaoAKY3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PM9eYc5Tpxqp1strZrIiev4jaVMMRdfUBFXJKZAP8L/cNRy5rWNov/chihdVwZfo2qBXVkpVmLc5LoQmfrjrKI2vyo4hbsqU56+ekwifpbK8Ec+3LDolI+w3MpmkMhxinS8zHPJvKLh2Z5Ap6j4cvuIf8jni+QDtJWd3jh5irKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eh9zG95B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2289AC19423;
	Sat, 28 Feb 2026 17:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300753;
	bh=GO/zWVd/A/W2BF9fwRjLNvOo5WKl075fDPmIaoAKY3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eh9zG95B5Xh0eqBwJPiT1+lJGA41y8dFpZZOYyX1Fx9F86Mbx1ipoX6e8xhOboFEK
	 hvk0ouHD0YINTRcntmIvpW5F/TrONuLgF6O5aLD1zkcnDOz5jKNRPzHBgGyMPX+k0w
	 kMeUSWHa07/gmbS6EcihdzQmHOjowcC84ce3l495izye536q5lZdsyj6U3p0/uy27W
	 FP54R5llYe6AvqoVvxyY/NJC0ldjf2znjFjcSBK6FCG0As75O2FVsk+4H4vKlEOP3X
	 2EP1ZHM/LHF+YgldLkuhX7B8tahRFVQxFi1TspEj+Z7dnCE2E0tX/yQzMYtqmtomnv
	 L9jjdM4Q58s4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Imre Deak <imre.deak@intel.com>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 790/844] drm/i915/dp: Fix pipe BPP clamping due to HDR
Date: Sat, 28 Feb 2026 12:31:43 -0500
Message-ID: <20260228173244.1509663-791-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220869-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,gitlab.freedesktop.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32B551C7732
X-Rspamd-Action: no action

From: Imre Deak <imre.deak@intel.com>

[ Upstream commit fe26ae6ac8b88fcdac5036b557c129a17fe520d2 ]

The pipe BPP value shouldn't be set outside of the source's / sink's
valid pipe BPP range, ensure this when increasing the minimum pipe BPP
value to 30 due to HDR.

While at it debug print if the HDR mode was requested for a connector by
setting the corresponding HDR connector property. This indicates
if the requested HDR mode could not be enabled, since the selected
pipe BPP is below 30, due to a sink capability or link BW limit.

v2:
- Also handle the case where the sink could support the target 30 BPP
  only in DSC mode due to a BW limit, but the sink doesn't support DSC
  or 30 BPP as a DSC input BPP. (Chaitanya)
- Debug print the connector's HDR mode in the link config dump, to
  indicate if a BPP >= 30 required by HDR couldn't be reached. (Ankit)
- Add Closes: trailer. (Ankit)
- Don't print the 30 BPP-outside of valid BPP range debug message if
  the min BPP is already > 30 (and so a target BPP >= 30 required
  for HDR is ensured).

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7052
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15503
Fixes: ba49a4643cf53 ("drm/i915/dp: Set min_bpp limit to 30 in HDR mode")
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Cc: <stable@vger.kernel.org> # v6.18+
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com> # v1
Reviewed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patch.msgid.link/20260209133817.395823-1-imre.deak@intel.com
(cherry picked from commit 08b7ef16b6a03e8c966e286ee1ac608a6ffb3d4a)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index d0dbc6715717d..ee258df439a7d 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -2639,6 +2639,7 @@ intel_dp_compute_config_limits(struct intel_dp *intel_dp,
 			       bool dsc,
 			       struct link_config_limits *limits)
 {
+	struct intel_display *display = to_intel_display(intel_dp);
 	bool is_mst = intel_crtc_has_type(crtc_state, INTEL_OUTPUT_DP_MST);
 	struct intel_connector *connector =
 		to_intel_connector(conn_state->connector);
@@ -2651,8 +2652,7 @@ intel_dp_compute_config_limits(struct intel_dp *intel_dp,
 	limits->min_lane_count = intel_dp_min_lane_count(intel_dp);
 	limits->max_lane_count = intel_dp_max_lane_count(intel_dp);
 
-	limits->pipe.min_bpp = intel_dp_in_hdr_mode(conn_state) ? 30 :
-				intel_dp_min_bpp(crtc_state->output_format);
+	limits->pipe.min_bpp = intel_dp_min_bpp(crtc_state->output_format);
 	if (is_mst) {
 		/*
 		 * FIXME: If all the streams can't fit into the link with their
@@ -2668,6 +2668,19 @@ intel_dp_compute_config_limits(struct intel_dp *intel_dp,
 							respect_downstream_limits);
 	}
 
+	if (!dsc && intel_dp_in_hdr_mode(conn_state)) {
+		if (intel_dp_supports_dsc(intel_dp, connector, crtc_state) &&
+		    limits->pipe.max_bpp >= 30)
+			limits->pipe.min_bpp = max(limits->pipe.min_bpp, 30);
+		else
+			drm_dbg_kms(display->drm,
+				    "[CONNECTOR:%d:%s] Can't force 30 bpp for HDR (pipe bpp: %d-%d DSC-support: %s)\n",
+				    connector->base.base.id, connector->base.name,
+				    limits->pipe.min_bpp, limits->pipe.max_bpp,
+				    str_yes_no(intel_dp_supports_dsc(intel_dp, connector,
+								     crtc_state)));
+	}
+
 	if (dsc && !intel_dp_dsc_compute_pipe_bpp_limits(connector, limits))
 		return false;
 
@@ -2798,10 +2811,11 @@ intel_dp_compute_link_config(struct intel_encoder *encoder,
 	}
 
 	drm_dbg_kms(display->drm,
-		    "DP lane count %d clock %d bpp input %d compressed " FXP_Q4_FMT " link rate required %d available %d\n",
+		    "DP lane count %d clock %d bpp input %d compressed " FXP_Q4_FMT " HDR %s link rate required %d available %d\n",
 		    pipe_config->lane_count, pipe_config->port_clock,
 		    pipe_config->pipe_bpp,
 		    FXP_Q4_ARGS(pipe_config->dsc.compressed_bpp_x16),
+		    str_yes_no(intel_dp_in_hdr_mode(conn_state)),
 		    intel_dp_config_required_rate(pipe_config),
 		    intel_dp_max_link_data_rate(intel_dp,
 						pipe_config->port_clock,
-- 
2.51.0


