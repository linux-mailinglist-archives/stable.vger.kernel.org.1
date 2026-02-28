Return-Path: <stable+bounces-220330-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gO+RF4Exo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220330-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:18:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE5C1C5A47
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B858033E8595
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FBD47F2CB;
	Sat, 28 Feb 2026 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcjxBbNJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F31346E70;
	Sat, 28 Feb 2026 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300230; cv=none; b=YSsuEBxXEODOCGHtB2Vx/Cj7ZimRcqF1DcSsi8I/LhxHAsy2I3QK69dukIPaWEs2riWZb0pEnaNGkxqPR6x3CUc/j3/nDokWocHq2xxbIY6j7FD2oCoSyj5VCscyEKbziDMtKCud+OYKVzFN1fYyVRlz0NmF5C74DfRPROb2blc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300230; c=relaxed/simple;
	bh=my6dfp/GlCwi863JA+wggFe1YwcrV031OmpqAIPoVt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdc0petmA/c7XedjFYb3lUS3Uk5boda86crH76K4ep1iOQwgVx5gAGmU8vrtOqFb/iEzAl4ABCDh80877BcA1KHaoFfB3gm1lV0K8aHK5qQNQNrXMjRd6rBqwAe8Shs2ZDOQ5sZgg6FYEcxd5iYFJImFMXhPJqCHho4Q1Agb5FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcjxBbNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235A7C116D0;
	Sat, 28 Feb 2026 17:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300230;
	bh=my6dfp/GlCwi863JA+wggFe1YwcrV031OmpqAIPoVt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EcjxBbNJNR0iQcy9C5pbsextZ+wSX/jo2f0F8/lXkIvFoLlcslAmFIvBFowmvAkXM
	 L2oHMvTPL5vY6hyZEBcGu0gA5p1U3WdINL9Gw9mmcbKlPPE7iHtt19o3mBMRm1VFpn
	 oGs4MunIntjSoTRT3nq1BSZ6ZdsLoLbbHCGlhpFNcCXy48brncDqlEeAHKMRvl4qNc
	 yN5Uv2j8jsfSyrQqO28yLOIz3NiCydRSUfrG/9x0R8g2Elzs2M9L/PZQ7ZucSqQ0ky
	 PC4hNbfI3svln64zucBswnTG6QD5+MBAsr8ViJ/HdpLoNFmmIrV6yxr7z5+WcRRtzg
	 ZF7HuOHPhXsAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Gerber <j@mailb.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 252/844] wifi: rtw89: 8852au: add support for TP TX30U Plus
Date: Sat, 28 Feb 2026 12:22:45 -0500
Message-ID: <20260228173244.1509663-253-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220330-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailb.org:email]
X-Rspamd-Queue-Id: BEE5C1C5A47
X-Rspamd-Action: no action

From: Jan Gerber <j@mailb.org>

[ Upstream commit a2f1fc9ab6fb0d5c9d701a516c342944258fb20e ]

the device shows up like this and everything seams to work:

Bus 004 Device 003: ID 3625:010d Realtek 802.11ax WLAN Adapter

Signed-off-by: Jan Gerber <j@mailb.org>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20251212005515.2059533-1-j@mailb.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/rtw8852au.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852au.c b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
index ca782469c455d..74a976c984ad8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852au.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
@@ -60,6 +60,8 @@ static const struct usb_device_id rtw_8852au_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0141, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010d, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010f, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{},
-- 
2.51.0


