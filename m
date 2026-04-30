Return-Path: <stable+bounces-242156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEc2G/B/82mr4gEAu9opvQ
	(envelope-from <stable+bounces-242156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:14:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C89D54A5806
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FCDA3039136
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44E044E03B;
	Thu, 30 Apr 2026 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbPcAfnn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F3744B679
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565263; cv=none; b=GtvN0AIg2WMocWuWYmKjEjIcCeBWJHNyWVHXSJODOv9mhSYSkFhNAt5BMcE2ezTp7MTeD9V8E6qL8ueVldzmXbT9+nTTlaa8UXXDu9xy1bU+8atVLD1L0GqYPx60quff0V23g2KvN84ptoG0pLj5Zobw+WV9EKVubJmj9rRcuU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565263; c=relaxed/simple;
	bh=EDvEIsx4hFKctIMvwFTrs239wv5fVJECz9vVBM/ePo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d99S9eAGklI9KsiipGjY6pT+hCKxFK1/08lWqsZnuTyrVhPdyky4Xal3+rSJM+9NKDlcX6E63f9nVqhApraTAX5+4iORvAM0SH+TXqBAnWqBCJXQL3aGbkyzbvNq23BD4thyKnvh/ZrM5dMSBkJDBsHKMtfuENVp5PTdp+pvCVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbPcAfnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE0DC2BCB3;
	Thu, 30 Apr 2026 16:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777565263;
	bh=EDvEIsx4hFKctIMvwFTrs239wv5fVJECz9vVBM/ePo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kbPcAfnnBfDJEFl/vYfzGrbfPlyDckJ52vnaRCsv3qRxAW0gUxJtIZXPGS5olAs0G
	 z9nZ/FpqPcQM4XCijDp3VuTlLs5E02nJA+MFKe8EiYrPMOSSO3h6DmiApSdTbAkiwX
	 XYIvjDLUb6j5ZFTwmudAEOrJx8EkbkkCO8Ey15W37CaQ8yR+MRFeL5z39hCrzQi1Ah
	 sZ6pmAmV0LEEB6knrKt6fg13skaVIrL3viPN4XNbcBx2PLphgfoyKbzUNSPb3eKuKz
	 Pi1bXlg5Vin1Hi95IZTmP6KGqSImdjjhbeJfciVNEQrMmj9kd1cOxzpM4fU3C275j2
	 Kn4LnpNsSl5Pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jimmy Hon <honyuenkwun@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] rtw88: 8821ce: Disable PCIe ASPM L1 for 8821CE using chip ID
Date: Thu, 30 Apr 2026 12:07:39 -0400
Message-ID: <20260430160740.1785374-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026043013-untainted-dominion-7f06@gregkh>
References: <2026043013-untainted-dominion-7f06@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C89D54A5806
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242156-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Jimmy Hon <honyuenkwun@gmail.com>

[ Upstream commit b9eb5f0742d107ca9c0f33da58f61ce83e3ce2fc ]

Make workaround work for other 8821CE devices with different PCI ID

Signed-off-by: Jimmy Hon <honyuenkwun@gmail.com>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20220407075123.420696-3-honyuenkwun@gmail.com
Stable-dep-of: eb101d2abdcc ("wifi: rtw88: check for PCI upstream bridge existence")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 08cf66141889b..0d1b1dfab8a2c 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1766,7 +1766,7 @@ int rtw_pci_probe(struct pci_dev *pdev,
 	}
 
 	/* Disable PCIe ASPM L1 while doing NAPI poll for 8821CE */
-	if (pdev->device == 0xc821 && bridge->vendor == PCI_VENDOR_ID_INTEL)
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8821C && bridge->vendor == PCI_VENDOR_ID_INTEL)
 		rtwpci->rx_no_aspm = true;
 
 	rtw_pci_phy_cfg(rtwdev);
-- 
2.53.0


