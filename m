Return-Path: <stable+bounces-220221-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBU9DTMxo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220221-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:17:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8CA1C59E1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC00633479AC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96D84E3771;
	Sat, 28 Feb 2026 17:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOBK4lRN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFBE4E376A;
	Sat, 28 Feb 2026 17:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300126; cv=none; b=iibPuDbHb1EQclR9F+4lT3WbrRqs54Xpw/c2T6CRocrO6i2tOikbQHlMiRJLOEVgxkwfJn3iuzNyK4UIWwTZArHK20/WSo46Mrydv4xSMSWhNdUGBjVNsCCoHs21mbiPdQ1WDkm1JEKXOW4OkPVa9oe/4b2oIdIWs12oqS8auIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300126; c=relaxed/simple;
	bh=xeZh3cF455He9JeR56322hkv854L2QK5u/JbF7eXb38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXDUozOMgK7lc0/Qhk15MtNVewfHrl62wDkbr0M9ph8aeaoECK/pKZ1uYnBgQZmCQ6MnZKwIbNhn2y6UITHWi0JXXIxCUqz0Qn66RYooEIQT9/8xTa/DteSHiWLcje5n5K3YJw3U+UboJkZMJZtSZw1ULxsV+6BTlze4iY8zzXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOBK4lRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C73C116D0;
	Sat, 28 Feb 2026 17:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300126;
	bh=xeZh3cF455He9JeR56322hkv854L2QK5u/JbF7eXb38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pOBK4lRNzxH74jIjbJkY+6zol57W17DZYOOlnw4ZKdGfOVwiE6XBojzv2/l41fW2f
	 mJahhwTZRt137MWegFItTvyu5cYbuNukwJF6wLOpmV62H/OyCeCmfxYVHMZMxnB0sB
	 xItHoqYgPlZzsxTh4MTWOM2AwUQDf6yCwYpCdhnmuNSS3xGRNDBFQwt+jTZ2O3aURX
	 AMy+UsLxr4ok2G+57rTsCyQKqx+3HVtBNWD7ruRXGkfDnMUMH95+2TDpUiG4BniLbT
	 rXsdVSwKRjRbrYoMD0/b9FYaV6TmdSIQamuAvMQRJBOK7fLA6Q0UTEF0+wx6nL+yS/
	 Z1pl6+Jl+y17w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: LinCheng Ku <lincheng.ku@amd.com>,
	PeiChen Huang <peichen.huang@amd.com>,
	Chenyu Chen <chen-yu.chen@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 143/844] drm/amd/display: Add USB-C DP Alt Mode lane limitation in DCN32
Date: Sat, 28 Feb 2026 12:20:56 -0500
Message-ID: <20260228173244.1509663-144-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220221-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 9F8CA1C59E1
X-Rspamd-Action: no action

From: LinCheng Ku <lincheng.ku@amd.com>

[ Upstream commit cea573a8e1ed83840a2173d153dd68e172849d44 ]

[Why]
USB-C DisplayPort Alt Mode with concurrent USB data needs lane count
limitation to prevent incorrect 4-lane DP configuration when only 2 lanes
are available due to hardware lane sharing between DP and USB3.

[How]
Query DMUB for Alt Mode status (is_dp_alt_disable, is_usb, is_dp4) in
dcn32_link_encoder_get_max_link_cap() and cap DP to 2 lanes when USB is
active on USB-C port. Added inline documentation explaining the USB-C
lane sharing constraint.

Reviewed-by: PeiChen Huang <peichen.huang@amd.com>
Signed-off-by: LinCheng Ku <lincheng.ku@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../display/dc/dio/dcn32/dcn32_dio_link_encoder.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c
index 06907e8a4eda1..ddc736af776c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c
@@ -188,9 +188,18 @@ void dcn32_link_encoder_get_max_link_cap(struct link_encoder *enc,
 	if (!query_dp_alt_from_dmub(enc, &cmd))
 		return;
 
-	if (cmd.query_dp_alt.data.is_usb &&
-			cmd.query_dp_alt.data.is_dp4 == 0)
-		link_settings->lane_count = MIN(LANE_COUNT_TWO, link_settings->lane_count);
+	/*
+	 * USB-C DisplayPort Alt Mode lane count limitation logic:
+	 * When USB and DP share the same USB-C connector, hardware must allocate
+	 * some lanes for USB data, limiting DP to maximum 2 lanes instead of 4.
+	 * This ensures USB functionality remains available while DP is active.
+	 */
+	if (cmd.query_dp_alt.data.is_dp_alt_disable == 0 &&
+		cmd.query_dp_alt.data.is_usb &&
+		cmd.query_dp_alt.data.is_dp4 == 0) {
+		link_settings->lane_count =
+			MIN(LANE_COUNT_TWO, link_settings->lane_count);
+	}
 }
 
 
-- 
2.51.0


