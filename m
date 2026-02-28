Return-Path: <stable+bounces-220349-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GOeCJU0o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220349-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:31:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 951CE1C5E7A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87B44317E334
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C7039D329;
	Sat, 28 Feb 2026 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbNgusUv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6AB39C22C;
	Sat, 28 Feb 2026 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300247; cv=none; b=Akm2n7rqUa4ZcAp8sAerXs1gLY0pDRXXae8JXa4vI4qkvd//zLmqVfEgivjcrmCaE9/a1VWguShdJiJxv4384BVzccnqzIZx1ZPJE0das16PuZ2nx9paeyWVNr+2SMlwzYsDhA9R0QPnOa20kLtJLX9Jyx10ESKWvINDJpFQB2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300247; c=relaxed/simple;
	bh=jOUKICtjarUdH2jwSIzpvfw1DpKiGcF8oJMBxay09/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwhPVTDkVy3/1Rx/rIEodVHzeblJiFq8ZiCABbcjpGSIrL4On1mFKz8U0KrVdvSb77YdD/Ssn9WKK0tq8XeycKuDZ8eXvka43w+BklV8cke0veIFrsPh5TDtU1ejpHlBacJXalxDZG+nR+eypBDXmV6fEesV637pONhBg/rp6Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbNgusUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0DEC19423;
	Sat, 28 Feb 2026 17:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300247;
	bh=jOUKICtjarUdH2jwSIzpvfw1DpKiGcF8oJMBxay09/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gbNgusUvoyX8Y+sjbGNsrgZIpo8Dh2A/Ro9jia93sReFchwHppv3PumlxQZcUsoWE
	 j8M3Bd+skCM0+sLBUNjcmJ7rrjkt/aIGTkwIPiAJuO7xe2XWPLj7c52Im9dHE9QhPn
	 caoQzjQHHk3hnqosw9SebONevklrtm/il/qdc99VjJkyClaEn+1iCnzXFK6VtvYC+h
	 gJNwo2wQhIXFC7dNQavgPN9HGAB1hE4367mysXj6nVXZG8OrKwXJuNT70vsPARyBqI
	 Y5YB83iEm1LDr7DDMZ+UD8p2++NdkbwW0ebryOhBLNPPBiIOu3vhEG49w89p/Qe0Ap
	 iUTUFubP4vItw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zenm Chen <zenmchen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 271/844] wifi: rtw89: Add support for MSI AX1800 Nano (GUAX18N)
Date: Sat, 28 Feb 2026 12:23:04 -0500
Message-ID: <20260228173244.1509663-272-sashal@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220349-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 951CE1C5E7A
X-Rspamd-Action: no action

From: Zenm Chen <zenmchen@gmail.com>

[ Upstream commit 3116f287b81fe777a00b93ab07ec3c270093b185 ]

Add the ID 0db0:f0c8 to the table to support an additional RTL8832BU
adapter: MSI AX1800 Nano (GUAX18N).

Compile tested only.

Link: https://github.com/morrownr/rtl8852bu-20250826/pull/2
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260112004358.5516-1-zenmchen@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
index 980d17ef68d0a..84cd3ec971f98 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
@@ -54,6 +54,8 @@ static const struct usb_device_id rtw_8852bu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0db0, 0x6931, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0db0, 0xf0c8, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3327, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3574, 0x6121, 0xff, 0xff, 0xff),
-- 
2.51.0


