Return-Path: <stable+bounces-220281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCU6GRwvo2nb+AQAu9opvQ
	(envelope-from <stable+bounces-220281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:08:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 056E71C572C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 913B230A8B58
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0778A384527;
	Sat, 28 Feb 2026 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4i4WcSM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6D4384520;
	Sat, 28 Feb 2026 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300185; cv=none; b=J3eAlEK+pNi/O2hzG39iBkmW4dSPmuiB28Ledpa2T6UumO++3CK8e7PVs3aBx91JK5kH+rlIwW4MIAY4Qn0ThULoym16J7CipeqfYIxOm24FNQ2DQkN05TvQtYjgg9nL9SKYcZanMjrN71NORD1VfhlCi+8sxFOMgO9tydV+KMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300185; c=relaxed/simple;
	bh=pUC00dQjKHBTt5nZppW0FFDjlsWQZo9tD2+ybHrc3VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRjZFyhVZ+89GWy7SuXtzRsiqZZh8L2UW7JWbHqe6T7N1kVar7IHOX/woUBodr5EE0KDU31NHb6J1WGO0jyf/roxdpDZJk+DLTUBQQ8/cMhTY6ulBKbcp3o9SBg7UpIxaw35jwjkcXyoeH3GyhgEATc1+skUS6b2VtpHkfeI428=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4i4WcSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC63C19423;
	Sat, 28 Feb 2026 17:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300185;
	bh=pUC00dQjKHBTt5nZppW0FFDjlsWQZo9tD2+ybHrc3VU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4i4WcSMd1Rsb0XNJlQhRcFbpFGO4g4kZematVi4t9QiK1FDKvD4SwKXB3NP4EEgV
	 Ue69EfDyolqitDRiZBJ2mXKFCK5nSZgOG9R8fl6ufY0dzBCtrgJLTMSKIKjTF602Ux
	 31tHrLAdi6sQPTAHh05//XC7Aq41izaJmqnEWfObL/ede8P9HfQdlX238oVuNyp/SD
	 KCLzcyj1WrGwsbhWisQKUWV2CQTmWY1tkb/tXoyA3zdNR762tMy66F1ZlIxtOyQ0vs
	 lkSx6dzSuTxZ26wy+l10ThrhupLyISLzY8w/zHA70JtwPKz1j2yGfdJmaCePahCFJs
	 KTLQLaA7zb51g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ovidiu Bunea <ovidiu.bunea@amd.com>,
	Karen Chen <karen.chen@amd.com>,
	Matthew Stewart <matthew.stewart2@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 203/844] drm/amd/display: Disable FEC when powering down encoders
Date: Sat, 28 Feb 2026 12:21:56 -0500
Message-ID: <20260228173244.1509663-204-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-220281-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 056E71C572C
X-Rspamd-Action: no action

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[ Upstream commit 8cee62904caf95e5698fa0f2d420f5f22b4dea15 ]

[why & how]
VBIOS DMCUB FW can enable FEC for capable eDPs, but S/W DC state is
only updated for link0 when transitioning into OS with driver loaded.
This causes issues when the eDP is immediately hidden and DIG0 is
assigned to another link that does not support FEC. Driver will
attempt to disable FEC but FEC enablement occurs based on the link
state, which does not have fec_state updated since it is a different
link. Thus, FEC disablement on DIG0 will get skipped and cause no
light up.

Reviewed-by: Karen Chen <karen.chen@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 9f7087ac41f21..3d2673a22759a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -59,6 +59,7 @@
 #include "dc_state_priv.h"
 #include "dpcd_defs.h"
 #include "dsc.h"
+#include "dc_dp_types.h"
 /* include DCE11 register header files */
 #include "dce/dce_11_0_d.h"
 #include "dce/dce_11_0_sh_mask.h"
@@ -1736,20 +1737,25 @@ static void power_down_encoders(struct dc *dc)
 	int i;
 
 	for (i = 0; i < dc->link_count; i++) {
-		enum signal_type signal = dc->links[i]->connector_signal;
-
-		dc->link_srv->blank_dp_stream(dc->links[i], false);
+		struct dc_link *link = dc->links[i];
+		struct link_encoder *link_enc = link->link_enc;
+		enum signal_type signal = link->connector_signal;
 
+		dc->link_srv->blank_dp_stream(link, false);
 		if (signal != SIGNAL_TYPE_EDP)
 			signal = SIGNAL_TYPE_NONE;
 
-		if (dc->links[i]->ep_type == DISPLAY_ENDPOINT_PHY)
-			dc->links[i]->link_enc->funcs->disable_output(
-					dc->links[i]->link_enc, signal);
+		if (link->ep_type == DISPLAY_ENDPOINT_PHY)
+			link_enc->funcs->disable_output(link_enc, signal);
+
+		if (link->fec_state == dc_link_fec_enabled) {
+			link_enc->funcs->fec_set_enable(link_enc, false);
+			link_enc->funcs->fec_set_ready(link_enc, false);
+			link->fec_state = dc_link_fec_not_ready;
+		}
 
-		dc->links[i]->link_status.link_active = false;
-		memset(&dc->links[i]->cur_link_settings, 0,
-				sizeof(dc->links[i]->cur_link_settings));
+		link->link_status.link_active = false;
+		memset(&link->cur_link_settings, 0, sizeof(link->cur_link_settings));
 	}
 }
 
-- 
2.51.0


