Return-Path: <stable+bounces-238691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOyZNRa35WkonQEAu9opvQ
	(envelope-from <stable+bounces-238691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 07:18:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FCE426D4A
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 07:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4924F3016937
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 05:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489D72C237C;
	Mon, 20 Apr 2026 05:18:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5103C21A453
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 05:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776662290; cv=none; b=cGYjs0wRxgjtIbY62ThaNpWEmKp+a4MMSMshRI/HMeA0HbVebJuDZem9JSZBc1VR0cik9fcDJ+jd3B+mVxalkp6BHgv636XQyBWPu2jNgeNvjz2vtdjACsQoSOKzhCkDRAZftybFHI82OfgFxT15EucXzEYHlZ/gD7RzAyZvwVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776662290; c=relaxed/simple;
	bh=qGL1j5S8UliL0ONrvVHlx6y+ZF1CnNxlpLGyBIf9h04=;
	h=Message-ID:From:Date:Subject:To:Cc; b=AeNoP7UumJEVQ7m/IHEAuSAD2pwHVkvBHCmP1zNzQ6ZLCViIvn8y9dD46Wo4Xv8MjgP7AcLqI/iLczEYsxBB/sBdMsjBJIlth5uyZ4V7KM1FA2Lt+JTpO8hHxpxIAwt9RyUVKB1ysslZoj1OtSrunThkMuAqg2rF5dp7tijOvm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id B6F2838F;
	Mon, 20 Apr 2026 07:11:08 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8CBB9602379A; Mon, 20 Apr 2026 07:11:08 +0200 (CEST)
Message-ID: <06ca9feb332381c7809d4734ae087273cd8a3d31.1776661622.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 20 Apr 2026 07:11:07 +0200
Subject: [PATCH 6.12-stable] PCI: Fix placement of pci_save_state() in
 pci_bus_add_device()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238691-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wunner.de:mid,wunner.de:email]
X-Rspamd-Queue-Id: 79FCE426D4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 58130e7ce6cb ("PCI/ERR: Ensure error recoverability at all
times") sought to backport upstream commit a2f1e22390ac, but misplaced
the call to pci_save_state() in pci_bus_add_device():

It put the call at the top of the function even though the upstream
commit deliberately put it in the middle to capture config space changes
caused by pci_fixup_final().

Fix the placement.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 429c0c8ce93d..bdb3e10f947a 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -331,9 +331,6 @@ void pci_bus_add_device(struct pci_dev *dev)
 	struct device_node *dn = dev->dev.of_node;
 	int retval;
 
-	/* Save config space for error recoverability */
-	pci_save_state(dev);
-
 	/*
 	 * Can not put in pci_device_add yet because resources
 	 * are not assigned yet for some devices.
@@ -346,6 +343,9 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
 
+	/* Save config space for error recoverability */
+	pci_save_state(dev);
+
 	dev->match_driver = !dn || of_device_is_available(dn);
 	retval = device_attach(&dev->dev);
 	if (retval < 0 && retval != -EPROBE_DEFER)
-- 
2.51.0


