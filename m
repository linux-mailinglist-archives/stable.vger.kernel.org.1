Return-Path: <stable+bounces-257117-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNY5LHsWG2pV/AgAu9opvQ
	(envelope-from <stable+bounces-257117-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:55:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1C760E9BE
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 651EA3093294
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EABA34167B;
	Sat, 30 May 2026 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nzKQe5NG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF943403F3;
	Sat, 30 May 2026 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780159860; cv=none; b=HqvuCTRq8W8La1z/VA6qiDy0BaxbxXqhSS1E5n1BHDH0t03iGgKAPWT0dALZ3XUqpFaM6V27AJahcGxdEc3KLHZBVWnx9/eZH9tJbqyP6zubyz9wbV6oSzXomXKmsX/ZPQU9mxEEWkAAVY4pOquk4ar6cyS3kiHdW4LYM3aaw3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780159860; c=relaxed/simple;
	bh=j7B1O+x8o2PCV433C2WWL8VKL76eaqbctIulOMwMl4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcnDWXFIkEDVDbl61Bdvt9EUpnEq0cC78BvhMWDwwX82gMKX6cCy+5qX2xoy9Dc6cRZLYWJK1lkTAXbZo/8zeJA9Qyb4c4FzoFihD01pkq6dNN4WfzZxLO5rwmt6GXW5wOWhgGW3+Lw4AqZ4SU15yb7+W9xb10qPlwsllz9WCCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nzKQe5NG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325F91F00898;
	Sat, 30 May 2026 16:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780159857;
	bh=VokPjfki+mBzDOJuXHMmXFx4/SGON/d94E7E3Lle+iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nzKQe5NGHpzdwtAfWAZYg13FmqO+2MB1GyJFufTLruN3tVglhgGbv8cSATKzoNOLJ
	 oa4Z189y+N7d3XwkHT6e9xsrmbttcK8GATF9vt0cBAwy4VTlQsq+dCHI5hOaMbvj1j
	 SUxJyz4QSSObAaM7w8c7Lo+cMkDi4FVehz9mAwMk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH 6.1 180/969] wifi: rtw88: check for PCI upstream bridge existence
Date: Sat, 30 May 2026 17:55:04 +0200
Message-ID: <20260530160305.465348577@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [7.84 / 15.00];
	URIBL_BLACK(7.50)[linuxtesting.org:url];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257117-lists,stable=lfdr.de];
	R_DKIM_ALLOW(0.00)[linuxfoundation.org:s=korg];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.968];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0D1C760E9BE
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fedor Pchelkin <pchelkin@ispras.ru>

commit eb101d2abdcccb514ca4fccd3b278dd8267374f6 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtw88/pci.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1784,7 +1784,8 @@ int rtw_pci_probe(struct pci_dev *pdev,
 	}
 
 	/* Disable PCIe ASPM L1 while doing NAPI poll for 8821CE */
-	if (rtwdev->chip->id == RTW_CHIP_TYPE_8821C && bridge->vendor == PCI_VENDOR_ID_INTEL)
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8821C &&
+	    bridge && bridge->vendor == PCI_VENDOR_ID_INTEL)
 		rtwpci->rx_no_aspm = true;
 
 	rtw_pci_phy_cfg(rtwdev);



