Return-Path: <stable+bounces-210930-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HRPFtoqcWniewAAu9opvQ
	(envelope-from <stable+bounces-210930-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:36:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 937905C4F3
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C616F88E479
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295CD3A63ED;
	Wed, 21 Jan 2026 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LzjoZwnP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FAB361DAB;
	Wed, 21 Jan 2026 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019865; cv=none; b=Qwr30uJGJMq+Qd1N9v7D7gCmG5p8HN0AZN4ZS+7W+6pH9uXYXefDK+slIkTzzTSdx8PiC3xsUU4CmSR0mp01SPpU3SYbA1xZSuhfyJbA+BS/dugN0KATB4SKEYdl1nbmiyAnju/NgS+20x6xbklrBH0YVowrCBAT5AdOMZQoLOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019865; c=relaxed/simple;
	bh=dcYxDB7dhZWgvUtdyksk+cWCajRj3aukeUeJ5py0Lho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9IadQGc74fOAz69At/Dw2sh0iOfGiYUDJrfQF7PNqPvdWISx48yC+q3+3vd3j5XfOlcrpXbPUimJjwGz1/tLhOXnXUw8Boy17uY1ccNOTLQwuhOARfy/o4TJ697/cQuN4r41I9+Irfc3M6gW4GMecRwFReeKGaiZ/mUNTTK5WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LzjoZwnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7B3C4CEF1;
	Wed, 21 Jan 2026 18:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019865;
	bh=dcYxDB7dhZWgvUtdyksk+cWCajRj3aukeUeJ5py0Lho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LzjoZwnPj1CPz0eBPoKTws0Jef0JHLwBU1LQmn+/nOTcki4gJKNV4TuMwJXcxql1c
	 KPXVhNDkzHwit5GoT8Rprzx95X6HAgQ7tX57uCK+UPquSiNXESfgEQeOwB/AISZ+gs
	 6PZ2jYxamFRs1B7f3Mhb4mjPipnObKFczR2yTvCY=
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
Subject: [PATCH 6.12 098/139] drm/amd/display: Bump the HDMI clock to 340MHz
Date: Wed, 21 Jan 2026 19:15:46 +0100
Message-ID: <20260121181414.979413474@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	RCVD_COUNT_THREE(0.00)[4];
	URIBL_MULTI_FAIL(0.00)[linuxfoundation.org:server fail,amd.com:server fail,dfw.mirrors.kernel.org:server fail,gitlab.freedesktop.org:server fail,skoll.ca:server fail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210930-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,gitlab.freedesktop.org:url,skoll.ca:email]
X-Rspamd-Queue-Id: 937905C4F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -329,7 +329,7 @@ static void query_dp_dual_mode_adaptor(
 
 	/* Assume we have no valid DP passive dongle connected */
 	*dongle = DISPLAY_DONGLE_NONE;
-	sink_cap->max_hdmi_pixel_clock = DP_ADAPTOR_HDMI_SAFE_MAX_TMDS_CLK;
+	sink_cap->max_hdmi_pixel_clock = DP_ADAPTOR_DVI_MAX_TMDS_CLK;
 
 	/* Read DP-HDMI dongle I2c (no response interpreted as DP-DVI dongle)*/
 	if (!i2c_read(
@@ -385,6 +385,8 @@ static void query_dp_dual_mode_adaptor(
 
 		}
 	}
+	if (is_valid_hdmi_signature)
+		sink_cap->max_hdmi_pixel_clock = DP_ADAPTOR_HDMI_SAFE_MAX_TMDS_CLK;
 
 	if (is_type2_dongle) {
 		uint32_t max_tmds_clk =



