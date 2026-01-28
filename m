Return-Path: <stable+bounces-212080-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJ4QJNQuemmO3wEAu9opvQ
	(envelope-from <stable+bounces-212080-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:44:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D960A4538
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E05BE302BE09
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CEA23EAB7;
	Wed, 28 Jan 2026 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eFDc2kpW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1AD13B7A3;
	Wed, 28 Jan 2026 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614334; cv=none; b=hYuvgL01SfYPfDjokwXv/5fS+3cGABpIS1jeuOF5Yr8bc4Qfn62b32nLjrNA44S42jeWAZlAkYBOzWDskGUkRkCHWY01CZQ2a1XTNsAD6AIPLIc7/leSZ07rrnE18bxDdIVLo5oHJ0PsTbXCgLjFbjkkxBz+c/OKvY29QT6rz0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614334; c=relaxed/simple;
	bh=oQzBAZyh0zfdteb6REq4WldWw467h1fWaYlQNmg8Xlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/XzBt/zyK+9QnFUS0Afb2X12aD1QsUQ6BFWX7SujZhKcfhbYukLz5Mv0R5U2bOsDJBLEmydWgWpIGhzlLkeOQ8anBdFowingyLhVZl9IeO65gQf/8ZbBebSpeXoZKSHwoD7FDCCC04QwCkz/88bHpnd8x0lMhATs49N7oWjXUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eFDc2kpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A095C4CEF1;
	Wed, 28 Jan 2026 15:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614334;
	bh=oQzBAZyh0zfdteb6REq4WldWw467h1fWaYlQNmg8Xlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eFDc2kpW5k8u7r4QTFWvIj3hHQoML+JN3aap/RQR2n1I9epJS3HUffyaeAGE4NLtY
	 kDWZ49s40i/nRJxjBFGSUmb6Dc2skGCnLHtMGge5I3C3ByHFXZqXyAYKFxwghoiK3D
	 Zbtak6xTTFd3vXsLmCEVY0r1vvAcXEmRJP9JpYbI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dianne Skoll <dianne@skoll.ca>,
	Chris Park <chris.park@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Matthew Stewart <matthew.stewart2@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 072/254] drm/amd/display: Bump the HDMI clock to 340MHz
Date: Wed, 28 Jan 2026 16:20:48 +0100
Message-ID: <20260128145347.287430814@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212080-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,skoll.ca:email]
X-Rspamd-Queue-Id: 1D960A4538
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit fee50077656d8a58011f13bca48f743d1b6d6015 upstream.

[Why]
DP-HDMI dongles can execeed bandwidth requirements on high resolution
monitors. This can lead to pruning the high resolution modes.

HDMI 1.3 bumped the clock to 340MHz, but display code never matched it.

[How]
Set default to (DVI) 165MHz.  Once HDMI display is identified update
to 340MHz.

Reported-by: Dianne Skoll <dianne@skoll.ca>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4780
Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ac1e65d8ade46c09fb184579b81acadf36dcb91e)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h       |    2 +-
 drivers/gpu/drm/amd/display/dc/link/link_detection.c |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
@@ -41,7 +41,7 @@
 /* kHZ*/
 #define DP_ADAPTOR_DVI_MAX_TMDS_CLK 165000
 /* kHZ*/
-#define DP_ADAPTOR_HDMI_SAFE_MAX_TMDS_CLK 165000
+#define DP_ADAPTOR_HDMI_SAFE_MAX_TMDS_CLK 340000
 
 struct dp_hdmi_dongle_signature_data {
 	int8_t id[15];/* "DP-HDMI ADAPTOR"*/
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -325,7 +325,7 @@ static void query_dp_dual_mode_adaptor(
 
 	/* Assume we have no valid DP passive dongle connected */
 	*dongle = DISPLAY_DONGLE_NONE;
-	sink_cap->max_hdmi_pixel_clock = DP_ADAPTOR_HDMI_SAFE_MAX_TMDS_CLK;
+	sink_cap->max_hdmi_pixel_clock = DP_ADAPTOR_DVI_MAX_TMDS_CLK;
 
 	/* Read DP-HDMI dongle I2c (no response interpreted as DP-DVI dongle)*/
 	if (!i2c_read(
@@ -381,6 +381,8 @@ static void query_dp_dual_mode_adaptor(
 
 		}
 	}
+	if (is_valid_hdmi_signature)
+		sink_cap->max_hdmi_pixel_clock = DP_ADAPTOR_HDMI_SAFE_MAX_TMDS_CLK;
 
 	if (is_type2_dongle) {
 		uint32_t max_tmds_clk =



