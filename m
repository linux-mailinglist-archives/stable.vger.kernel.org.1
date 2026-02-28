Return-Path: <stable+bounces-220441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAYMN1Q7o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:00:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 380721C6812
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A0BE32D2FCB
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AE83B63F6;
	Sat, 28 Feb 2026 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmhzBLt8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533F13B63EC;
	Sat, 28 Feb 2026 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300330; cv=none; b=TcVcuypf9obFX/Ze3ZC1xBJqLuWjEmTGrHUrIQLz/KfeO3uFpMG7nj5phZNCdrUkZbjOwq+5rJXWNm/ye2nf9scS1eftaM5X0+kdG56pGkwZaPpTmJ495oCMYBO39wOkCY6CPnZYglqccH0oM25AL/J8n5rTi9nWKMZEw19ES0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300330; c=relaxed/simple;
	bh=EBltPShLdHRg5MHLH88vzR0tSq7BbpzYUrYZ3TMQlZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAmWtmS5fAOdwk0h8ge97lbNNbOuvzMhdbmfua7FNYcqa6oedxmYow3bA7Vx7mtXzAx0jRpoCkzB91HtCmpkKcqOz71Iy2YYr1+tD4ifGJCd4wLAGkfa5eeGZVpAYhl9zV6yAvAPtgiwnPKFEx1dMJGzLK8rrSi9wjt8Z6l/BB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmhzBLt8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76600C19424;
	Sat, 28 Feb 2026 17:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300330;
	bh=EBltPShLdHRg5MHLH88vzR0tSq7BbpzYUrYZ3TMQlZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gmhzBLt8+thvvc7N9+Q5bDstNjFrKXQOEy/5CjP4iwM5qo2poDVbCim+QkGmqVvl9
	 Gu0gtQEY98+9zwolmGDd8agsQcGMIQfiRq+uVeSKZ7B+tLhdpm+N1D0I1h8tbLg0Mg
	 PfYLMDQYymkMYGL9aFTKNiBFM1CUvnRpZuAwPmpZ9koHEWSgTLpa0RERlfVJ2nxsxt
	 jjqZDiavKJaL/gjtvc7QlRxidOJPi3b0aE/CSl51MT9C70L8782XFmHelj//2ohSBL
	 Jriodkt8ikqCKYBqDprpvARrbRxb4SiAXXLZAnd0wv9FwyQDu3BfBkdW4olRtXM63F
	 /D7Tl+CtyMihQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>,
	Jiri Kosina <jkosina@suse.com>,
	Douglas Anderson <dianders@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 362/844] HID: i2c-hid: Add FocalTech FT8112
Date: Sat, 28 Feb 2026 12:24:35 -0500
Message-ID: <20260228173244.1509663-363-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[pegatron.corp-partner.google.com,suse.com,chromium.org,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220441-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,chromium.org:email,suse.com:email]
X-Rspamd-Queue-Id: 380721C6812
X-Rspamd-Action: no action

From: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>

[ Upstream commit 3d9586f1f90c9101b1abf5b0e9d70ca45f5f16db ]

Information for touchscreen model HKO/RB116AS01-2 as below:
- HID :FTSC1000
- slave address:0X38
- Interface:HID over I2C
- Touch control lC:FT8112
- I2C ID: PNP0C50

Signed-off-by: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>
Acked-by: Jiri Kosina <jkosina@suse.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://patch.msgid.link/20251117094041.300083-2-Daniel_Peng@pegatron.corp-partner.google.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/i2c-hid/i2c-hid-of-elan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
index 0215f217f6d86..b81fcc6ff49ee 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
@@ -168,6 +168,13 @@ static const struct elan_i2c_hid_chip_data elan_ekth6a12nay_chip_data = {
 	.power_after_backlight = true,
 };
 
+static const struct elan_i2c_hid_chip_data focaltech_ft8112_chip_data = {
+	.post_power_delay_ms = 10,
+	.post_gpio_reset_on_delay_ms = 150,
+	.hid_descriptor_address = 0x0001,
+	.main_supply_name = "vcc33",
+};
+
 static const struct elan_i2c_hid_chip_data ilitek_ili9882t_chip_data = {
 	.post_power_delay_ms = 1,
 	.post_gpio_reset_on_delay_ms = 200,
@@ -191,6 +198,7 @@ static const struct elan_i2c_hid_chip_data ilitek_ili2901_chip_data = {
 static const struct of_device_id elan_i2c_hid_of_match[] = {
 	{ .compatible = "elan,ekth6915", .data = &elan_ekth6915_chip_data },
 	{ .compatible = "elan,ekth6a12nay", .data = &elan_ekth6a12nay_chip_data },
+	{ .compatible = "focaltech,ft8112", .data = &focaltech_ft8112_chip_data },
 	{ .compatible = "ilitek,ili9882t", .data = &ilitek_ili9882t_chip_data },
 	{ .compatible = "ilitek,ili2901", .data = &ilitek_ili2901_chip_data },
 	{ }
-- 
2.51.0


