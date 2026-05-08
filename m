Return-Path: <stable+bounces-244824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMAoC2xO/mllowAAu9opvQ
	(envelope-from <stable+bounces-244824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 22:58:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A824FBB50
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 22:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA1D630091EC
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 20:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49903E92BA;
	Fri,  8 May 2026 20:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BA1Jgvaz"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp11.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE753FE368;
	Fri,  8 May 2026 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778273892; cv=none; b=eD/xZkHeFgUjRCELLnbN8lXX/v6hZ/tvEahUfVl+HyC6b3RQ9HCvQ4edeo5qv3ruKzCFIOmDZYHL+JqfnN/wV4wOYP6A7zSUaSmxqEczlqcEf8b16HcG9t+ttIgra2/A/WMkJgH4lgk0z+INZVYOce5SmXrMSrCxOBB9hleYHCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778273892; c=relaxed/simple;
	bh=H1EvY1PsxDZA4+rF1Z4pbyqEwCYNC0lzM+PFx/IcTmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ge3TQ6oHA8gXUZv2p21UHKHlC5nkOF+DdcuOBU0Wr7rP1VVHkK2dgPaRwW6AKY6IXDPQT9R12an0SI/9BSRK5NWx6WmaQsrSZZwX/W97qzWyGZIaPrEYWltaRUGxICLNoWIRKfUL2Zz/nnKvSqy5kbxhy+EGgZYY2yF3689SwAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BA1Jgvaz; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 79FC7C000320;
	Fri,  8 May 2026 13:52:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 79FC7C000320
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1778273566;
	bh=H1EvY1PsxDZA4+rF1Z4pbyqEwCYNC0lzM+PFx/IcTmw=;
	h=From:To:Cc:Subject:Date:From;
	b=BA1JgvazB+N8dB8CaF6pWp/FmsWczlsVWdEWPLp3qsOoVguofm+8GOAIe7j2nAyTH
	 qfqrVUzkOBKWVbZWnvR5kVT17mT8wZyWzpQaJ9TKudDY1vHiH/38kgdeUIQe3jcmar
	 MyVYuYSlghZle2wFBLPyURAjBD6sD07AH2Ksi4jk=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 5942EB70;
	Fri,  8 May 2026 13:52:46 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jeff Dike <jdike@addtoit.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH stable 5.15] um: virt-pci: Fix build failure
Date: Fri,  8 May 2026 13:52:41 -0700
Message-ID: <20260508205241.962178-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E4A824FBB50
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=dkimrelay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244824-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Commit a27e95a6ff3f ("um: virt-pci: properly remove PCI device from
bus") assumed that virtio_reset_device() is present in the 5.15.y kernel
but it is not and so backport would now cause a build failure.

Fixes: a27e95a6ff3f ("um: virt-pci: properly remove PCI device from bus")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/um/drivers/virt-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index d762d726b66c..0666c9e0998d 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -641,7 +641,7 @@ static void um_pci_virtio_remove(struct virtio_device *vdev)
 	}
 
 	/* Stop all virtqueues */
-	virtio_reset_device(vdev);
+	vdev->config->reset(vdev);
 	dev->cmd_vq = NULL;
 	dev->irq_vq = NULL;
 	vdev->config->del_vqs(vdev);
-- 
2.43.0


