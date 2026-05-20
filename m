Return-Path: <stable+bounces-250218-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCWPF4jkDWpz4gUAu9opvQ
	(envelope-from <stable+bounces-250218-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:42:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDA05924AF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3FA33051FDC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B438C33AD9D;
	Wed, 20 May 2026 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DZUfYcmG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CB1228CB0;
	Wed, 20 May 2026 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294838; cv=none; b=avzSyVLARqTgqtfB2Ic1/CHU141R3LJ2b5sKHGFAB4J/KUKGn4m3ShWqJmvjeZzaiXITodCYeUJpWUC+gOov9Z+7kycN1XRzAEN608vYrpduXBjHT8L2FBUgox5MM2UHjt5gGjzZjZfHFR0E3tAYLrtmSyjlmO6iwov7/0/Ox7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294838; c=relaxed/simple;
	bh=VhpRDSaLniwQAmdV2E3q3S0O6MIQ4ZN8Z96M9hhoJxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zur2SVBXYgGGqFl8dI5tVLG69Wv8mU2Idotgmn6fGZ47wNkkVeiqQ/7/8i0yrI7Ka/pL9VJj58qqvgGtxVaORAKJUWIdyKR2Bewvwlrczvl2e62nwzGEewqubHD2N1hP4VTGvvBhrAjVVlP10mDaviI8EsBe/PXJAd5zsN2RYiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DZUfYcmG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52F71F000E9;
	Wed, 20 May 2026 16:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294837;
	bh=cTyZx2ZDl8B1oROxK8lXj/1K8cT6gEL65BV9XgOpTbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DZUfYcmGbnuARTw8Zae49QF4yo0dbJlEylwXJODYlApWsfmtltca1JoQ+4bAWGnQS
	 vajFAcKcYSbBI3+uOMqDUE6okwDEoiCwllx8Oi3RK6+RztgaZ+CNLZ/xiEcDH26T77
	 Pfs5pVQZZNBxUMm16kv0xZG9Jc6jNaeyvD+kfK10=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0191/1146] net: mana: Use pci_name() for debugfs directory naming
Date: Wed, 20 May 2026 18:07:21 +0200
Message-ID: <20260520162152.601143099@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250218-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: EFDA05924AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

[ Upstream commit c116f07ab9d22bb6f355f3cf9e44c1e6a47fe559 ]

Use pci_name(pdev) for the per-device debugfs directory instead of
hardcoded "0" for PFs and pci_slot_name(pdev->slot) for VFs. The
previous approach had two issues:

1. pci_slot_name() dereferences pdev->slot, which can be NULL for VFs
   in environments like generic VFIO passthrough or nested KVM,
   causing a NULL pointer dereference.

2. Multiple PFs would all use "0", and VFs across different PCI
   domains or buses could share the same slot name, leading to
   -EEXIST errors from debugfs_create_dir().

pci_name(pdev) returns the unique BDF address, is always valid, and is
unique across the system.

Fixes: 6607c17c6c5e ("net: mana: Enable debugfs files for MANA device")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260408081224.302308-2-ernis@linux.microsoft.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 786186c9a115f..c2e855ff3ca9a 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -2007,11 +2007,8 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	gc->dev = &pdev->dev;
 	xa_init(&gc->irq_contexts);
 
-	if (gc->is_pf)
-		gc->mana_pci_debugfs = debugfs_create_dir("0", mana_debugfs_root);
-	else
-		gc->mana_pci_debugfs = debugfs_create_dir(pci_slot_name(pdev->slot),
-							  mana_debugfs_root);
+	gc->mana_pci_debugfs = debugfs_create_dir(pci_name(pdev),
+						  mana_debugfs_root);
 
 	err = mana_gd_setup(pdev);
 	if (err)
-- 
2.53.0




