Return-Path: <stable+bounces-266086-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mGRaCSKWMWoKngUAu9opvQ
	(envelope-from <stable+bounces-266086-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:29:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 238056942E1
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:29:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=UThe9pU3;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266086-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-266086-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 524D03002F72
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01698472798;
	Tue, 16 Jun 2026 18:29:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ADC47A0CD;
	Tue, 16 Jun 2026 18:29:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634586; cv=none; b=MlIdXEOHF3Uk8Tliy4Iynfh9zfh2A+090aNdHmCt2+fsXs3/tFgFaB0y/tqNXiqJZ0caKKoNwt41CZE4njXEQyhTOZ8PqsDbvkTE+xA+heECsNbAW2Z0qQt2OYOzwZeYifzvgNS34r3NiTYufHdVMTIgT9yRQm8JHC61pkges6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634586; c=relaxed/simple;
	bh=nTlL5Gpw3zt4VuUO3JxkHzYxB5V1S4qe+I2AvRpTmo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Avt2+jlJxnKoAsEz7/2saXFddUBrEkHiCIAASJgwiPe3NxsFdoBMY4/kc15/pz/g4U0F0/mAq8k/EjgzLl5ZhO28nT72zyThnvgOGnsTMnUTWJuTau9cSWpb3XwwHsX7wqwroa81C78JRdG6cIaR3n0dfgHAnQv7YoATOGI5Gzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UThe9pU3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5E61F00A3A;
	Tue, 16 Jun 2026 18:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781634585;
	bh=p/tGtc5w1wIkgFr/rxF/KDVf9PflvBZtdR1bih0BOEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UThe9pU3707ZcNErrNe2+AdUEWEImO5P6AA47zZDaEhNv9yLeTAsbn2rBdutC4Z8b
	 okM5vn5N89/o1bvOPb5kai0AKuxXea/vazIJuqbh2eVBITqxXbJci+JCKr0fwIK6jF
	 ok2ZpZymDDCJsanty5s+NMWgkvceTRzcWQm4EqAU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jimmy Hon <honyuenkwun@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 260/411] rtw88: 8821ce: Disable PCIe ASPM L1 for 8821CE using chip ID
Date: Tue, 16 Jun 2026 20:28:18 +0530
Message-ID: <20260616145114.838080524@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,realtek.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-266086-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:honyuenkwun@gmail.com,m:pkshih@realtek.com,m:kvalo@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 238056942E1

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jimmy Hon <honyuenkwun@gmail.com>

[ Upstream commit b9eb5f0742d107ca9c0f33da58f61ce83e3ce2fc ]

Make workaround work for other 8821CE devices with different PCI ID

Signed-off-by: Jimmy Hon <honyuenkwun@gmail.com>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20220407075123.420696-3-honyuenkwun@gmail.com
Stable-dep-of: eb101d2abdcc ("wifi: rtw88: check for PCI upstream bridge existence")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtw88/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1766,7 +1766,7 @@ int rtw_pci_probe(struct pci_dev *pdev,
 	}
 
 	/* Disable PCIe ASPM L1 while doing NAPI poll for 8821CE */
-	if (pdev->device == 0xc821 && bridge->vendor == PCI_VENDOR_ID_INTEL)
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8821C && bridge->vendor == PCI_VENDOR_ID_INTEL)
 		rtwpci->rx_no_aspm = true;
 
 	rtw_pci_phy_cfg(rtwdev);



