Return-Path: <stable+bounces-242157-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OL62FvB/82mr4gEAu9opvQ
	(envelope-from <stable+bounces-242157-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:14:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A8E4A5805
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D11293039FE3
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F6945BD4E;
	Thu, 30 Apr 2026 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+9kKBgn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EF244E046
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565264; cv=none; b=PnDTTyO4enN6pYzgQUplVXUikD5bYvm02UW+CtEfSsfawt3hjzPcuDpi+DDAwFZ8nrOGeYJFqynVD8DY3wO7O6elMMQ86FaY5svsgbdK1hn8Gm5pRw5Go8LYwP5rNFDUvHIqA/iftuzplrX508MyImwzGRdUw6PN6w6khwihrL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565264; c=relaxed/simple;
	bh=T5Mie+1DVUvNQRGLKcZZ6+2ECG+6M5qMcOTxf9GXbv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbSJrmIiiuxNvIAcxKEFHOwiQqI2N1MeID0dJgmnppk3L3N6HLrMtAiubkDX79MGwU725Gg3xlOMhY1kt3zrNVjeu+LQ+Jd975N7l8Vnsr8hlPebEFal6mVwcTkjUUJAHCwDZ3XMseNPut3NO57mtkIJi9Gi4HN/EexUAOrAjAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+9kKBgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520B7C2BCC9;
	Thu, 30 Apr 2026 16:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777565263;
	bh=T5Mie+1DVUvNQRGLKcZZ6+2ECG+6M5qMcOTxf9GXbv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f+9kKBgnwEtYZOFIME3/Yo5u4xOFhcEBBjdLcByoQO+WYGbBfX3ioNX+jeJQFea/m
	 iLUGAwZnFvHZHqE8/c79bpUsoxOmgjf5IGC/choDPzyVdgiB4y0uEzlQY1FOENvAvh
	 zZIMlW5dyuHZZdhXErQEaNyP4I57i7sboWRo76UxsngHsbf/XS/abqia7o6rwCmOR8
	 sftSTpwcJgXwryI46+7CfrSqwRyk2aC8UMXmZhl1TIPAdbIa7zY9Ir/37HPaCgtpgx
	 pGhI6ud2stkRiCd42XSA54NTVk7dPGV4qKFEI4nC0vYDeV5llSFV5pFwtXhl5VIN5P
	 NV14LbW1wKQ7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] wifi: rtw88: check for PCI upstream bridge existence
Date: Thu, 30 Apr 2026 12:07:40 -0400
Message-ID: <20260430160740.1785374-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430160740.1785374-1-sashal@kernel.org>
References: <2026043013-untainted-dominion-7f06@gregkh>
 <20260430160740.1785374-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B8A8E4A5805
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242157-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,realtek.com:email,linuxtesting.org:url]

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit eb101d2abdcccb514ca4fccd3b278dd8267374f6 ]

pci_upstream_bridge() returns NULL if the device is on a root bus.  If
8821CE is installed in the system with such a PCI topology, the probing
routine will crash.  This has probably been unnoticed as 8821CE is mostly
supplied in laptops where there is a PCI-to-PCI bridge located upstream
from the device.  However the card might be installed on a system with
different configuration.

Check if the bridge does exist for the specific workaround to be applied.

Found by Linux Verification Center (linuxtesting.org) with Svace static
analysis tool.

Fixes: 24f5e38a13b5 ("rtw88: Disable PCIe ASPM while doing NAPI poll on 8821CE")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260220094730.49791-1-pchelkin@ispras.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 0d1b1dfab8a2c..fa302d5e7839d 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1766,7 +1766,8 @@ int rtw_pci_probe(struct pci_dev *pdev,
 	}
 
 	/* Disable PCIe ASPM L1 while doing NAPI poll for 8821CE */
-	if (rtwdev->chip->id == RTW_CHIP_TYPE_8821C && bridge->vendor == PCI_VENDOR_ID_INTEL)
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8821C &&
+	    bridge && bridge->vendor == PCI_VENDOR_ID_INTEL)
 		rtwpci->rx_no_aspm = true;
 
 	rtw_pci_phy_cfg(rtwdev);
-- 
2.53.0


