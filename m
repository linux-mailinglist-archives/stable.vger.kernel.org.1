Return-Path: <stable+bounces-220235-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AJwAagxo2lN+QQAu9opvQ
	(envelope-from <stable+bounces-220235-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:19:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D41C1C5A8D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C57231A0001
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFC536D9F9;
	Sat, 28 Feb 2026 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nk/WeIUk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6349E36D9F0;
	Sat, 28 Feb 2026 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300139; cv=none; b=swS/5WtlRB6zAnyy5lto8NfY2Kb3krNN2c9sbQRTAXvj/rjDC+TodVqlKml2l2D6OLKN9mfN3o5BWR609zbzsjRDUZZBSpeuGnjArgA8SfwfZFkXFzLOTE4H0ifGzys45oHHPRGM13jeqGK668KrQ01xP68VW5YD9VlD1nw34TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300139; c=relaxed/simple;
	bh=XLhhosNDhsVYiB5cqGxb2IWumSIAvhbevaDOB5YKtFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGPtko99yR7xADZBYJbblHYTLvxkLDR4phrEoruayDALD3yYOXSspiaCaVbMGJCfAZiZhNPPjAIfsIW1a8E2wMuKyTw4WyMFGap1xj8PaQycntBVjCjuX885Nz8eLOcU5Oq0LTWO5xslUWpoBcxkNSOB0jOjIoSNpk7XfkUZJJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nk/WeIUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3237C19424;
	Sat, 28 Feb 2026 17:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300139;
	bh=XLhhosNDhsVYiB5cqGxb2IWumSIAvhbevaDOB5YKtFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nk/WeIUkcc2qP6ncHWmDU5HWGck5StQ34LZhGSNqppOoH/2LJTqoJHG+oZMe97LkH
	 I2Ub7PJ+t1iERIOAF22c7WiBMr7NT8DRveoZh4QtbA15ddWRAkt3C52CTrAWS3AG2M
	 z0GBtrj08bAaiv9vgroGoqMYyZC6BAkSrebAed66Yc6d9MvyCBfiPTdUyB86cummUt
	 ENIXDxNYCySXIx1saX9JM3vHE4HhaU5hib07uFIiWXT+gX55A6DsJbCg+O3sparVZB
	 hODbwOicE6q59OMqUQvYauYxB6x3Z+GAoSjogO3nLsYsglOh8oIcal06L+ZKuqLk7C
	 5P+yFo2RzffZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Douglas Anderson <dianders@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 157/844] drm/panel: edp: add BOE NV140WUM-T08 panel
Date: Sat, 28 Feb 2026 12:21:10 -0500
Message-ID: <20260228173244.1509663-158-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-220235-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,msgid.link:url,chromium.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D41C1C5A8D
X-Rspamd-Action: no action

From: Hans de Goede <johannes.goede@oss.qualcomm.com>

[ Upstream commit 349d4efadc1f831ebc0b872ba1e3a2b7dd58b72b ]

Add powerseq timing info for the BOE NV140WUM-T08 panel used on Lenovo
Thinkpad T14s gen 6 (Snapdragon X1 Elite) laptops.

edid-decode (hex):

00 ff ff ff ff ff ff 00 09 e5 26 0c 00 00 00 00
0a 21 01 04 a5 1e 13 78 03 d6 62 99 5e 5a 8e 27
25 53 58 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 33 3f 80 dc 70 b0 3c 40 30 20
36 00 2e bc 10 00 00 1a 00 00 00 fd 00 28 3c 4c
4c 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 42
4f 45 20 43 51 0a 20 20 20 20 20 20 00 00 00 fe
00 4e 56 31 34 30 57 55 4d 2d 54 30 38 0a 00 fa

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patch.msgid.link/20260105155134.83266-1-johannes.goede@oss.qualcomm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 85dd3f4cb8e1c..679f4af5246d8 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1730,6 +1730,12 @@ static const struct panel_delay delay_200_500_p2e100 = {
 	.prepare_to_enable = 100,
 };
 
+static const struct panel_delay delay_200_500_p2e200 = {
+	.hpd_absent = 200,
+	.unprepare = 500,
+	.prepare_to_enable = 200,
+};
+
 static const struct panel_delay delay_200_500_e50 = {
 	.hpd_absent = 200,
 	.unprepare = 500,
@@ -1977,6 +1983,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b56, &delay_200_500_e80, "NT140FHM-N47"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b66, &delay_200_500_e80, "NE140WUM-N6G"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c20, &delay_200_500_e80, "NT140FHM-N47"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c26, &delay_200_500_p2e200, "NV140WUM-T08"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c93, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT116WHM-N44"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cf2, &delay_200_500_e200, "NV156FHM-N4S"),
-- 
2.51.0


