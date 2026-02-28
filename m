Return-Path: <stable+bounces-220335-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qI1oJf9Fo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220335-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:46:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B75991C757A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 841803186FE7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C38397C93;
	Sat, 28 Feb 2026 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCuJSsmm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4780839847D;
	Sat, 28 Feb 2026 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300235; cv=none; b=jmoYi0UIHzugRxMG71Vi0jmW3EQ3y4mRg8We5XYkU9I4W315amHp/+PKqpwrbsxqsP4wvtTIMLTOwsz6GhloHjxtT9pMV5Fmlk3gK6vuAC1cA+L0AklRUxBBeYDmYKpP/0vpHjNs5M9sKv3jCPK08BJMURJJ4QhcF08S3tbGu2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300235; c=relaxed/simple;
	bh=zLXSp2DUbR19ppVFOb8GLP5YuAim+D6173r6sPqsfd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDcWJAINf4O9E2hKB5s1kUMgxnugHRdqfZFpKO1boQidqC2aXGW+gv9Hqh6Q0C6jIef1f9K6XXJthBIE28TvMWsH2cHt2RF1AaEwyVUe9iYQL34tDg/IFdO+eS3xSqnx7XtK3NjArR0cwpx+3esukioH1zZjAREuLLIOMxE9a38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCuJSsmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBB2C19423;
	Sat, 28 Feb 2026 17:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300235;
	bh=zLXSp2DUbR19ppVFOb8GLP5YuAim+D6173r6sPqsfd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HCuJSsmm2xmOszXdvMh7LqRe+dx7vPHbJ8+78eB8cBW/0E1cvgEfIgT7G0xEPE8BQ
	 SDvkmcVzT/KaSrn4ToRGR3t2kjqyxe/U2ieOka4fCCEZxzi90n86bUcqcFujZyKqog
	 2W+HWI/l0ibhTt/d1s3aKQdWH8dSA9a1FNsJaXHifIjf0zgGdXY34XpIxmHQ7tOSv/
	 y1h9jHolZKmkykJtJVLc8qSZKdmYjwFaipZPMuXOtS9wQfxQCHjcmTa0tqAYoPkfl0
	 kQX6oUip//NA3Tk+J9E94E6x8319cy1ghmhE6ZHe46JhEH9Dm5urnw+jatxQly/sZd
	 eE3CW9B3NeARg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chih-Kang Chang <gary.chang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 257/844] wifi: rtw89: setting TBTT AGG number when mac port initialization
Date: Sat, 28 Feb 2026 12:22:50 -0500
Message-ID: <20260228173244.1509663-258-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220335-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: B75991C757A
X-Rspamd-Action: no action

From: Chih-Kang Chang <gary.chang@realtek.com>

[ Upstream commit 5e5f83fba48381098b26a8b2513a6d5fc5c66ccb ]

When initializing mac port, needs to set TBTT AGG number to trigger TBTT
related interrupts. Otherwise, after sending join info H2C command with
disconnection mode, firmware will clear TBTT AGG number. Without the
setting from mac port initialization after that, this port will not be
able to transmit beacons.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20251223030651.480633-12-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b4c292c7e829d..6734e5d5a5e22 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4341,6 +4341,7 @@ static void rtw89_mac_bcn_drop(struct rtw89_dev *rtwdev,
 #define BCN_HOLD_DEF 200
 #define BCN_MASK_DEF 0
 #define TBTT_ERLY_DEF 5
+#define TBTT_AGG_DEF 1
 #define BCN_SET_UNIT 32
 #define BCN_ERLY_SET_DLY (10 * 2)
 
@@ -4644,6 +4645,16 @@ static void rtw89_mac_port_cfg_tbtt_early(struct rtw89_dev *rtwdev,
 				B_AX_TBTTERLY_MASK, TBTT_ERLY_DEF);
 }
 
+static void rtw89_mac_port_cfg_tbtt_agg(struct rtw89_dev *rtwdev,
+					struct rtw89_vif_link *rtwvif_link)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
+
+	rtw89_write16_port_mask(rtwdev, rtwvif_link, p->tbtt_agg,
+				B_AX_TBTT_AGG_NUM_MASK, TBTT_AGG_DEF);
+}
+
 static void rtw89_mac_port_cfg_bss_color(struct rtw89_dev *rtwdev,
 					 struct rtw89_vif_link *rtwvif_link)
 {
@@ -4904,6 +4915,7 @@ int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvi
 	rtw89_mac_port_cfg_bcn_hold_time(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_bcn_mask_area(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_tbtt_early(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_tbtt_agg(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_bss_color(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_mbssid(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_func_en(rtwdev, rtwvif_link, true);
-- 
2.51.0


