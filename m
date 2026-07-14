Return-Path: <stable+bounces-274056-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SLvGBfGNVWoRqAAAu9opvQ
	(envelope-from <stable+bounces-274056-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 03:16:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F01750089
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 03:16:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=O1HzCior;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274056-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274056-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AB713023DFD
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 01:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AE72EA498;
	Tue, 14 Jul 2026 01:16:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A2020DD51
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 01:16:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991787; cv=none; b=rz2xWtOxoF2or15CMsVgbTjL9AK6HHrDkQBY5ZZjMZHE+yNpjV9gbtzgt7czXtOw2t/WkJeGO/VY6bnISI9F0RPjE80UKPlEGnUM1dtqNeEDN/ljCEzUsUNskFkHOCcLmjLYsF4k/0NftdAQn83fTJKFko69AiEvHRKChMTOOA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991787; c=relaxed/simple;
	bh=+X98hHr+ePy36u8YPVWGjxIqXs5o2lsr3BNSTTcrLWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcXchlTJIxncMczSjv7B8zVipxP6k+jiysT4vl1JVFVFUdkl/9+7G17TVby4PHvjrpf2LoTX/MWAVWlbA6LkpgLRjGeWjHsMjHHoZ8wpf9Wt1p3739nA7LtEj9hajaAfghx9PGzAkmFjcjIn6LRE+bEka4aDJisgcAMKJCQhSvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1HzCior; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1BD1F00A3A;
	Tue, 14 Jul 2026 01:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783991786;
	bh=+HkUyZoxk6mcjJ0amj2XUWbAw6H2yFMAxG8O6KGxbrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O1HzCiorxEr+aihVFVULi1Ll253NADP2AbB/g1jPC2xYb4wL/1FwkOdIYpt1bDQM5
	 Bfn3E95DA2WVyzvh8JEjKbNxicjfQ+A6HvdtKk39cuBF24tNAVTpjcQ/BgcA/HAoH8
	 AMlcGp//URVFfAMOo31SfJUqcrAdJbuDdJCQTDGCegdd60GA4IifRSk1zF5iJASFzy
	 d3WOLoaiZZQYlYO8c7e2Ll1N6g3CmRZv0QmEudP73dAzA1trpgTPJKhWwzi2JRHeY2
	 g46MYhh4I2R7KCFg+MJoL5cKXJ4hvELmRvy+HtO2OA3TsV/2HlKJ5MbpJfy2/4dP1m
	 9gI1pbIraZ51Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Geoffrey D. Bennett" <g@b4.vu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/2] ALSA: scarlett2: Update offsets for 2i2 Gen 4 firmware 2417
Date: Mon, 13 Jul 2026 21:16:23 -0400
Message-ID: <20260714011623.2188610-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714011623.2188610-1-sashal@kernel.org>
References: <2026071349-volatile-trustable-cfdf@gregkh>
 <20260714011623.2188610-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:g@b4.vu,m:tiwai@suse.de,m:sashal@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274056-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,b4.vu:email,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1F01750089

From: "Geoffrey D. Bennett" <g@b4.vu>

[ Upstream commit 3ca15754b561483aa7a1bce51677d6389f8ff5bb ]

Firmware 2417 for the Scarlett 4th Gen 2i2 moved the direct monitor gain
parameters, so add a second config_set with the shifted offset and
select it for firmware versions >= 2417.

Fixes: 4e809a299677 ("ALSA: scarlett2: Add support for Solo, 2i2, and 4i4 Gen 4")
Cc: stable@vger.kernel.org # ALSA: scarlett2: Allow selecting config_set by firmware version
Cc: stable@vger.kernel.org # ALSA: scarlett2: Fold min_firmware_version into config_sets
Cc: stable@vger.kernel.org
Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/ad0fc5a131e76eb656a24e0e198382f7134068fe.1777151532.git.g@b4.vu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_scarlett2.c | 58 +++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index 4be667ed0c5b09..d7b8c204110c33 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -937,6 +937,63 @@ static const struct scarlett2_config_set scarlett2_config_set_gen4_2i2 = {
 	}
 };
 
+/* 2i2 Gen 4, firmware version 2417 and above
+ *
+ * Firmware 2417 shifted DIRECT_MONITOR_GAIN by 4 bytes; all other
+ * offsets are unchanged from scarlett2_config_set_gen4_2i2.
+ */
+static const struct scarlett2_config_set scarlett2_config_set_gen4_2i2_2417 = {
+	.notifications = scarlett4_2i2_notifications,
+	.param_buf_addr = 0xfc,
+	.input_gain_tlv = db_scale_gen4_gain,
+	.autogain_status_texts = scarlett2_autogain_status_gen4,
+	.items = {
+		[SCARLETT2_CONFIG_MSD_SWITCH] = {
+			.offset = 0x49, .size = 8, .activate = 4 },
+
+		[SCARLETT2_CONFIG_DIRECT_MONITOR] = {
+			.offset = 0x14a, .size = 8, .activate = 16, .pbuf = 1 },
+
+		[SCARLETT2_CONFIG_AUTOGAIN_SWITCH] = {
+			.offset = 0x135, .size = 8, .activate = 10, .pbuf = 1 },
+
+		[SCARLETT2_CONFIG_AUTOGAIN_STATUS] = {
+			.offset = 0x137, .size = 8 },
+
+		[SCARLETT2_CONFIG_AG_MEAN_TARGET] = {
+			.offset = 0x131, .size = 8, .activate = 29, .pbuf = 1 },
+
+		[SCARLETT2_CONFIG_AG_PEAK_TARGET] = {
+			.offset = 0x132, .size = 8, .activate = 30, .pbuf = 1 },
+
+		[SCARLETT2_CONFIG_PHANTOM_SWITCH] = {
+			.offset = 0x48, .size = 8, .activate = 11, .pbuf = 1,
+			.mute = 1 },
+
+		[SCARLETT2_CONFIG_INPUT_GAIN] = {
+			.offset = 0x4b, .size = 8, .activate = 12, .pbuf = 1 },
+
+		[SCARLETT2_CONFIG_LEVEL_SWITCH] = {
+			.offset = 0x3c, .size = 8, .activate = 13, .pbuf = 1,
+			.mute = 1 },
+
+		[SCARLETT2_CONFIG_SAFE_SWITCH] = {
+			.offset = 0x147, .size = 8, .activate = 14, .pbuf = 1 },
+
+		[SCARLETT2_CONFIG_AIR_SWITCH] = {
+			.offset = 0x3e, .size = 8, .activate = 15, .pbuf = 1 },
+
+		[SCARLETT2_CONFIG_INPUT_SELECT_SWITCH] = {
+			.offset = 0x14b, .size = 8, .activate = 17, .pbuf = 1 },
+
+		[SCARLETT2_CONFIG_INPUT_LINK_SWITCH] = {
+			.offset = 0x14e, .size = 8, .activate = 18, .pbuf = 1 },
+
+		[SCARLETT2_CONFIG_DIRECT_MONITOR_GAIN] = {
+			.offset = 0x2a4, .size = 16, .activate = 36 }
+	}
+};
+
 /* 4i4 Gen 4 */
 static const struct scarlett2_config_set scarlett2_config_set_gen4_4i4 = {
 	.notifications = scarlett4_4i4_notifications,
@@ -1999,6 +2056,7 @@ static const struct scarlett2_device_info solo_gen4_info = {
 static const struct scarlett2_device_info s2i2_gen4_info = {
 	.config_sets = (const struct scarlett2_config_set_entry[]) {
 		{ 2115, &scarlett2_config_set_gen4_2i2 },
+		{ 2417, &scarlett2_config_set_gen4_2i2_2417 },
 		{ }
 	},
 	.min_firmware_version = 2115,
-- 
2.53.0


