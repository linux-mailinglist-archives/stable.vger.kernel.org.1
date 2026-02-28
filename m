Return-Path: <stable+bounces-220184-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iANOK/oyo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220184-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:24:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C609A1C5C27
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE5A530C3119
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49704C0400;
	Sat, 28 Feb 2026 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT5vfDSY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663A84BCAD6;
	Sat, 28 Feb 2026 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300091; cv=none; b=a5q8YWTRT/ICmtVZXYSikwazLaNdBxZIn/IfN+bAqrM9+L6BwYRTF7o0TRuGs6lSgckZV2iFKWwNyuMZhUTtKixrS/BcX5YAmJC7Ww76qZ6ZB1gLH4gHgXGtAH3gQuTpA267GcA4PEAo92VvnzmBV4hiLvsigxVPGNzUjuezAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300091; c=relaxed/simple;
	bh=dnKOTn7uV2wDaoLtoSPJID9JuTwR5i5ibtM0JG+68U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJnj5+KHEC6t0XVwqF7txNkGfBHUZNFMHqvVAa81B4jc1/28ojur0Y56FG7rsOO+c6vUVGXerdB+9E78NsRwdYKwf81mRzPb9rcSOxUiSeSHQftFWwVicJ6YU2DicYrwcNmkwgQVKkBLs5GMe5nO1E8MGM9HFf+OMfyHdNCZjOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WT5vfDSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04C7C2BC87;
	Sat, 28 Feb 2026 17:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300091;
	bh=dnKOTn7uV2wDaoLtoSPJID9JuTwR5i5ibtM0JG+68U8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WT5vfDSYkOH//HU1gFNJioiX+Xcou+blcrmAZQg22JsS2xEhs5z0NjSPfEEOHF0A9
	 /bzB1nPNUQ1+g/TQD7IbAG6vPwU50fURENpoAg12/JddHD4MsIwfoorAc7ET/44mr9
	 m9NJRzI0FOy7dE9Ubgu346p+IS0J+9GKJ11k+ySC/vYySWd0E6ukj1Ej71o0SiFU6m
	 Z1evNlFmvh0LrxYJ9pIZ6uueXH9rKIXiyCHnPvf2Dm5DhCCK4xJhNzE5sr8brxA8Et
	 UjEbEVap78as/yAdmooqOSYz2Tzd3UWxWcBEQQIJ05CE+/oFN/UlqDpKnjxT5rSWbi
	 FB3O7+MbFOh9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 106/844] PCI/MSI: Unmap MSI-X region on error
Date: Sat, 28 Feb 2026 12:20:19 -0500
Message-ID: <20260228173244.1509663-107-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220184-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C609A1C5C27
X-Rspamd-Action: no action

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

[ Upstream commit 1a8d4c6ecb4c81261bcdf13556abd4a958eca202 ]

msix_capability_init() fails to unmap the MSI-X region if
msix_setup_interrupts() fails.

Add the missing iounmap() for that error path.

[ tglx: Massaged change log ]

Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260125144452.2103812-1-lihaoxiang@isrc.iscas.ac.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/msi/msi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 34d664139f48f..e010ecd9f90dd 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -737,7 +737,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 
 	ret = msix_setup_interrupts(dev, entries, nvec, affd);
 	if (ret)
-		goto out_disable;
+		goto out_unmap;
 
 	/* Disable INTX */
 	pci_intx_for_msi(dev, 0);
@@ -758,6 +758,8 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	pcibios_free_irq(dev);
 	return 0;
 
+out_unmap:
+	iounmap(dev->msix_base);
 out_disable:
 	dev->msix_enabled = 0;
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE, 0);
-- 
2.51.0


