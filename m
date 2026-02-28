Return-Path: <stable+bounces-220353-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JLvOZpGo2lM/AQAu9opvQ
	(envelope-from <stable+bounces-220353-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:48:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BE81C7623
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99D163182F27
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FA239DBA6;
	Sat, 28 Feb 2026 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALxapURR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA4E39DB9B;
	Sat, 28 Feb 2026 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300250; cv=none; b=HJGfFa6LL/iXeJivmNQ4bJZ0/FMlboo6YRJGjY18mr+VNTF02VWIvDjRML69py6AUXliU7IQ0ai/00KBxpvkWCnbAh6KpNnsTTertrAiI9ylrs/+JxNzrS264OEnO+nFgZdiVaQylzJso4i4L7OQsBH47ouvcltV+pinyLhykHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300250; c=relaxed/simple;
	bh=718sXwywzZnOib7WcAyrJJQedrPJtHdSSi9N3MuPfcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=km6+G4oxYEpMCvA1J1IvqenmTMkNPU86BiV9L4QH5+J6pwEJumdBrwf9i0PxGPRZn9bn0XCFBJDRfQTVY20xHlFUQJjs4HeCuIr3iyuPGhbUvs1NN8erBwnYoqJcBPdbutg4QvbrsdaGtdaaKu00AktatLL7hhe39d1tgP44w0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALxapURR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32764C19425;
	Sat, 28 Feb 2026 17:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300250;
	bh=718sXwywzZnOib7WcAyrJJQedrPJtHdSSi9N3MuPfcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ALxapURRpqyNHK16qUQbFvTTUBWTqP1s+1SI1VuarLFLZDAN04N1q9iRJBZHXFoOZ
	 MFBmotDDYyV7+Fd/8SfykkI6htKHwgMKUlrt9cIaA2myt2J1I/Wak8ikgzOHXpGSt6
	 F2AYqEJwX6ET5BVXPEtUWmER16+UQbY1zZmwl2jN64mGWGildR1IWC/5KMPpb/aSXe
	 ZzDgvJCx0bDPX4SGf9nAuliyn85r6apQjnbU0vOR1bwVJmTnfWOV3Ps+Gx785UNFJn
	 f0HWRN/F1cwg1h0/ePInDCXJlKFKYo42VyQ6O+2p27dbqjlakQ1A+O4YUuAo/UbDRf
	 aLmFwduk2X8PA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chin-Yen Lee <timlee@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 275/844] wifi: rtw89: wow: add reason codes for disassociation in WoWLAN mode
Date: Sat, 28 Feb 2026 12:23:08 -0500
Message-ID: <20260228173244.1509663-276-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220353-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12BE81C7623
X-Rspamd-Action: no action

From: Chin-Yen Lee <timlee@realtek.com>

[ Upstream commit 2fd8f953f25173d14981d8736b6f5bfcd757e51b ]

Some APs disconnect clients by sending a Disassociation frame
rather than a Deauthentication frame. Since these frames use
different reason codes in WoWLAN mode, this commit adds support
for handling Disassociation to prevent missed disconnection events.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260110022019.2254969-3-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/wow.c | 4 ++++
 drivers/net/wireless/realtek/rtw89/wow.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 46aba4cb2ee9e..534966b4d9c43 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -809,6 +809,10 @@ static void rtw89_wow_show_wakeup_reason(struct rtw89_dev *rtwdev)
 
 	reason = rtw89_read8(rtwdev, wow_reason_reg);
 	switch (reason) {
+	case RTW89_WOW_RSN_RX_DISASSOC:
+		wakeup.disconnect = true;
+		rtw89_debug(rtwdev, RTW89_DBG_WOW, "WOW: Rx disassoc\n");
+		break;
 	case RTW89_WOW_RSN_RX_DEAUTH:
 		wakeup.disconnect = true;
 		rtw89_debug(rtwdev, RTW89_DBG_WOW, "WOW: Rx deauth\n");
diff --git a/drivers/net/wireless/realtek/rtw89/wow.h b/drivers/net/wireless/realtek/rtw89/wow.h
index d2ba6cebc2a6b..71e07f482174f 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.h
+++ b/drivers/net/wireless/realtek/rtw89/wow.h
@@ -33,6 +33,7 @@
 enum rtw89_wake_reason {
 	RTW89_WOW_RSN_RX_PTK_REKEY = 0x1,
 	RTW89_WOW_RSN_RX_GTK_REKEY = 0x2,
+	RTW89_WOW_RSN_RX_DISASSOC = 0x4,
 	RTW89_WOW_RSN_RX_DEAUTH = 0x8,
 	RTW89_WOW_RSN_DISCONNECT = 0x10,
 	RTW89_WOW_RSN_RX_MAGIC_PKT = 0x21,
-- 
2.51.0


