Return-Path: <stable+bounces-267950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u49dMfqSOmoaAggAu9opvQ
	(envelope-from <stable+bounces-267950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 16:06:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 763EF6B7BC4
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 16:06:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=lkTJKMBT;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267950-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267950-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01C203019131
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 14:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855F03803E3;
	Tue, 23 Jun 2026 14:06:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F86A37F73A;
	Tue, 23 Jun 2026 14:06:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223586; cv=none; b=fyG8oJTwvbr6o0xzWc7IhA9mwn/0I1Imcu+iYZxxlyzr+an7Nr3e+ayrmAmK0HW+pFH9gnM4YaEtfSVQac0wytzdql1n5Tn6W3NCdIgTqZVMO0E0l76YbAgjTTDuc2EQIaKIDN9slBHSofW6CMaXyrgst8fjhAEM+tc24S5UnFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223586; c=relaxed/simple;
	bh=z6GDjsUGIlwyHRyw1xG5g0OfWMUpauoLdGL47fs9Ubs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oIYPEeXSI8ZX/QNTxyD5PoYk9XXt9Zqb1zFGDdtKdSf+I9e/wbxDKXE4ulo5R7psNe37cg6drnQT2IdZ6dTFL30T57am6aSBccYwWHuJuond1fM0WeaC/03rMaDhpgNpfs6nCvvgdc2pl3tmxpp9gkb3NfJvZAmPZMOm1t3q1RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lkTJKMBT; arc=none smtp.client-ip=117.135.210.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=aT
	v+wkBB37xC90rzQCgTwjMuNSUOS0H7CSzz5L9FwHM=; b=lkTJKMBTVOi+lst0k4
	KlldoEBlG5+Uwdao9hznL+7+dvmeZbyj/2RVXVA48P+4dN6Qtobf+f1CAMg0Jbxn
	tIsBMAU6lN2Y7Ijdunp6dNxgNnvR4dJhry79F8bvfKdWkYEkNKkTbi90qTpQ71Ji
	JI5tBaFoNH6twlID87RTjmBxw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBX1PK0kjpqSyOxDQ--.24150S2;
	Tue, 23 Jun 2026 22:05:42 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	andriy.shevchenko@linux.intel.com,
	fourier.thomas@gmail.com,
	2426767509@qq.com,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] tty: serial: pch_uart: add check for pci_get_slot()
Date: Tue, 23 Jun 2026 22:05:39 +0800
Message-Id: <20260623140539.2272473-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBX1PK0kjpqSyOxDQ--.24150S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF1fur1fXrW3JFyDKw45Jrb_yoWfZFbEkF
	nFv3srtry0vFZ0yr43XF18uFyav3yIvFn5XFn2gas3XrykZa97AryqqrZ3JFZ7Wa1DAr17
	W3sru3yFkr4q9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRLa9VtUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7hb6aWo6krZ-qAAA3I
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:jirislaby@kernel.org,m:andriy.shevchenko@linux.intel.com,m:fourier.thomas@gmail.com,m:2426767509@qq.com,m:kees@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-serial@vger.kernel.org,m:haoxiang_li2024@163.com,m:stable@vger.kernel.org,m:fourierthomas@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267950-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,linux.intel.com,gmail.com,qq.com];
	DKIM_TRACE(0.00)[163.com:+];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 763EF6B7BC4

Add check for pci_get_slot() to prevent a potetial
null pointer dereference in pch_request_dma().

Fixes: 8368d6a2b739 ("pch_uart: don't hardcode PCI slot to get DMA device")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/tty/serial/pch_uart.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index ba1fcd663fe2..6c9e596a14e7 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -678,6 +678,11 @@ static void pch_request_dma(struct uart_port *port)
 	/* Get DMA's dev information */
 	dma_dev = pci_get_slot(priv->pdev->bus,
 			PCI_DEVFN(PCI_SLOT(priv->pdev->devfn), 0));
+	if (!dma_dev) {
+		dev_err(priv->port.dev, "%s: failed to get DMA device\n",
+			__func__);
+		return;
+	}
 
 	/* Set Tx DMA */
 	param = &priv->param_tx;
-- 
2.25.1


