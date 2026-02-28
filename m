Return-Path: <stable+bounces-220222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EYPG+Uxo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:20:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 003D51C5AD7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 233FA30F52D2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB754E378A;
	Sat, 28 Feb 2026 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbJklaLt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115024E3785;
	Sat, 28 Feb 2026 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300128; cv=none; b=tuE2pFYClEaubA8pCW9KglmzTwF1OfTtVugRretlC8DJrWzQodafwbjmo9vTGT6VKjaf0kUoD68KuWdRh5RCWM86xWjjf9z/WHvzTVIl40FRSj0kCt326/Z+bOzJpE6dor5MN5I+MBba5nrLED0kJ6iLI1BNxkkJQVI2cDBBM8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300128; c=relaxed/simple;
	bh=J6Mc6FQMD3ssfnVYyVPA+GPhArv1SfAYBOtYKv2Ql/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUqybuVzGD2Qtg7tFiiWBlHynOJ4zbaqZntmbi6nZ1B2Yeo6UkJ3ZbQk5RXISuWrpCkh/ldwZxhDGkbNR9RgIS9AIx4M8lwq1LoPbMg5iDCNT7yS+g1nIpgvnB0K7GxUTFTU5DrPxVviGpYUklRz2w1re5oLmNim0/ET+XIQa/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbJklaLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C356CC19423;
	Sat, 28 Feb 2026 17:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300127;
	bh=J6Mc6FQMD3ssfnVYyVPA+GPhArv1SfAYBOtYKv2Ql/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kbJklaLtHhfHQvbsl8tLNRcYSXN+nJypKk/MmNjCQ0Uy8MUlIln2opYVYLDzo0r5g
	 E+tokjEVS0giTV1gaCL4NOm1HpTwI07ceZK0BGguPxW/GsqZYsOqjsNy29o+zT07jn
	 FlozZz/HdBcPAkOPkEf3eKzu1+1ZUSR7BP3I3r8jezPCBjNDWXku9puK0aAqZ9YH+E
	 YMDdn9+QDzkMEhvvHizgiNPDawoxMAcpPLyysiVnr+Fi1LU2LE5G7413s5oZIxUTFQ
	 N/GjbbyeYDwOBDyq4DuunpbahTsPvTuiGOJBFlSOMa7RCwyG1o9stt1SubdIAKqMfx
	 G+Rj2PxtEWALg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peichen Huang <PeiChen.Huang@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Chenyu Chen <chen-yu.chen@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 144/844] drm/amd/display: Don't disable DPCD mst_en if sink connected
Date: Sat, 28 Feb 2026 12:20:57 -0500
Message-ID: <20260228173244.1509663-145-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220222-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 003D51C5AD7
X-Rspamd-Action: no action

From: Peichen Huang <PeiChen.Huang@amd.com>

[ Upstream commit 9aeb31b2456452257ad1ff7ec566f21bab1f3e8a ]

[WHY]
User may connect mst dock with multi monitors and do quick unplug
and plug in one of the monitor. This operatioin may create CSN from
dock to display driver. Then display driver would disable and then enable
mst link and also disable/enable DPCD mst_en bit in dock RX. However,
when mst_en bit being disabled, if dock has another CSN message to
transmit then the message would be removed because of the disabling of
mst_en. In this case, the message is missing and it ends up no display in
the replugged monitor.

[HOW]
Don't disable mst_en bit when link still has sink connected.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 770c9cd128ae8..a36762915943b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1931,7 +1931,7 @@ static void disable_link_dp(struct dc_link *link,
 			link->dc->hwss.edp_power_control(link, false);
 	}
 
-	if (signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
+	if (signal == SIGNAL_TYPE_DISPLAY_PORT_MST && link->sink_count == 0)
 		/* set the sink to SST mode after disabling the link */
 		enable_mst_on_sink(link, false);
 
@@ -2082,7 +2082,12 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 			pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT &&
 			link->dc->debug.set_mst_en_for_sst) {
 		enable_mst_on_sink(link, true);
+	} else if (link->dpcd_caps.is_mst_capable &&
+		pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT) {
+		/* disable mst on sink */
+		enable_mst_on_sink(link, false);
 	}
+
 	if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP) {
 		/*in case it is not on*/
 		if (!link->dc->config.edp_no_power_sequencing)
@@ -2380,9 +2385,9 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 	if (pipe_ctx->stream->sink) {
 		if (pipe_ctx->stream->sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
 			pipe_ctx->stream->sink->sink_signal != SIGNAL_TYPE_NONE) {
-			DC_LOG_DC("%s pipe_ctx dispname=%s signal=%x link=%d\n", __func__,
+			DC_LOG_DC("%s pipe_ctx dispname=%s signal=%x link=%d sink_count=%d\n", __func__,
 			pipe_ctx->stream->sink->edid_caps.display_name,
-			pipe_ctx->stream->signal, link->link_index);
+			pipe_ctx->stream->signal, link->link_index, link->sink_count);
 		}
 	}
 
@@ -2496,10 +2501,11 @@ void link_set_dpms_on(
 	if (pipe_ctx->stream->sink) {
 		if (pipe_ctx->stream->sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
 			pipe_ctx->stream->sink->sink_signal != SIGNAL_TYPE_NONE) {
-			DC_LOG_DC("%s pipe_ctx dispname=%s signal=%x link=%d\n", __func__,
+			DC_LOG_DC("%s pipe_ctx dispname=%s signal=%x link=%d sink_count=%d\n", __func__,
 			pipe_ctx->stream->sink->edid_caps.display_name,
 			pipe_ctx->stream->signal,
-			link->link_index);
+			link->link_index,
+			link->sink_count);
 		}
 	}
 
-- 
2.51.0


