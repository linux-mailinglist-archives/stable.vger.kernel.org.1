Return-Path: <stable+bounces-220333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDi4CdM1o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:37:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 899CD1C6091
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6712326B866
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA46C398450;
	Sat, 28 Feb 2026 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myLQ3GNR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B038398444;
	Sat, 28 Feb 2026 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300233; cv=none; b=ZryzZ3raVTyQBsGbHYZldqrtX28YiKX+ccxK3xnUQhp4Ye+8HowyEsFRbDg9fQpcrAV5uTCgMv+8O2S2shIOwB3JO40LSyM1pwNHl0cctlO9bFjSE424/IhjsAzwAoCqB1g4CcG+GBj/CzZARMPmfb+i7SwRXXD/WxmVs4YhvZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300233; c=relaxed/simple;
	bh=X4EwNMlb1Dmanb2m8IMn07TlqZ8ZWIolvnkALcmQxTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOTR3Q9QPQey2H/+mVhnJCMDaHal9PSXP6BG0rZ93/XR5JcqrZbSmGA+y/kAykg/zxZtQJtFF+NID/RjZZe0JaeG/MEzVwzXbOoyGT8lgCzY4qRTO4SeFcsI4le2LQUtrpL8MIsWPhkOuuiat1AzSOnwvHwihMb8HnzIZai16Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myLQ3GNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC00FC19423;
	Sat, 28 Feb 2026 17:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300233;
	bh=X4EwNMlb1Dmanb2m8IMn07TlqZ8ZWIolvnkALcmQxTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=myLQ3GNRp+PCE75W8nT20FOs4G9bWF8rJh2RbiyA5U1AYhn370Umh4n95efmAM5B5
	 e/6C2aj1cPlxBxn1OTOrI6JuUh/Xc4wRJwuZhda/FgGae2UxxJeXPqZd4EPCyrdrkP
	 OnILpmUgQL7sQm/afQuCwyHTXiUTRMSwpvBvCza9YRuHwoNdeuV/PU16c+IpeGai9I
	 vgLW/U5Nhd657GPKvJ0Wh7NLHnIzmZ7zR4ZBEZsNACbF8zGKdLjKqjW7epUAk8qhIV
	 PGcr/gvfTVcHCLefspqON4HZpRA++9hYNdE1iqhcK2GetZV4+os3BR2TOiSvoL/nVa
	 eESuVimerKIgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 255/844] wifi: rtw89: 8922a: set random mac if efuse contains zeroes
Date: Sat, 28 Feb 2026 12:22:48 -0500
Message-ID: <20260228173244.1509663-256-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220333-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 899CD1C6091
X-Rspamd-Action: no action

From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

[ Upstream commit 41be33d3efc120f6a2c02d12742655f2aa09e1b6 ]

I have some rtl8922ae devices with no permanent mac stored in efuse.

It could be properly saved and/or configured from user tools like
NetworkManager, but it would be desirable to be able to initialize it
somehow to get the device working by default.

So, in the same way as with other devices, if the mac address read from
efuse contains zeros, a random mac address is assigned to at least allow
operation, and the user is warned about this in case any action needs to
be considered.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20251126091905.217951-1-jtornosm@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 4437279c554b0..4bcf20612a455 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -636,16 +636,30 @@ static int rtw8922a_read_efuse_rf(struct rtw89_dev *rtwdev, u8 *log_map)
 static int rtw8922a_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 			       enum rtw89_efuse_block block)
 {
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	int ret;
+
 	switch (block) {
 	case RTW89_EFUSE_BLOCK_HCI_DIG_PCIE_SDIO:
-		return rtw8922a_read_efuse_pci_sdio(rtwdev, log_map);
+		ret = rtw8922a_read_efuse_pci_sdio(rtwdev, log_map);
+		break;
 	case RTW89_EFUSE_BLOCK_HCI_DIG_USB:
-		return rtw8922a_read_efuse_usb(rtwdev, log_map);
+		ret = rtw8922a_read_efuse_usb(rtwdev, log_map);
+		break;
 	case RTW89_EFUSE_BLOCK_RF:
-		return rtw8922a_read_efuse_rf(rtwdev, log_map);
+		ret = rtw8922a_read_efuse_rf(rtwdev, log_map);
+		break;
 	default:
-		return 0;
+		ret = 0;
+		break;
+	}
+
+	if (!ret && is_zero_ether_addr(efuse->addr)) {
+		rtw89_info(rtwdev, "efuse mac address is zero, using random mac\n");
+		eth_random_addr(efuse->addr);
 	}
+
+	return ret;
 }
 
 #define THM_TRIM_POSITIVE_MASK BIT(6)
-- 
2.51.0


