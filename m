Return-Path: <stable+bounces-268278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9rAWL1fNPGrIsQgAu9opvQ
	(envelope-from <stable+bounces-268278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 08:40:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C37A6C3161
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 08:40:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268278-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268278-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED7853044294
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 06:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55F53C1099;
	Thu, 25 Jun 2026 06:40:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A73F2FD681;
	Thu, 25 Jun 2026 06:40:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782369609; cv=none; b=OgO/GXa3PgQlLUknalRP9RfcHbcketuK4T4adKa/T2BecFWy9yBDXRV6IQW9EXDnnvyiDMP/1TRTpaoykXTH5dCgdycAUK2m7JIGOaZ+tDWrmIXo2H21gsA4zQOHrtLhWm1ZvWGZpE3g2z8hRkR43fZwwUrihmvA8dtLqvMNxds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782369609; c=relaxed/simple;
	bh=2JMoRHKUQ/kQHqvaMEdRcJ0m8VcfYZX/7FHNM/oWlks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k5pLMxV6M+u287cFtDJ90TdfJh9nbFIgzRL+CCf6pxW5HA3PY2Q1ooEi8PxIe8AH9jmrE/n1WIlCEIQ0BvZtln2AcrE3RWGOSbVl910CPdg3Tc1H5SR28nfH56Nyc4HTd2MYt8sKxweg53D+wMRcGoAhDeO60p9usZak+bnJJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowAAXbhE6zTxqV6YpFQ--.19217S2;
	Thu, 25 Jun 2026 14:39:56 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] octeontx2-af: Fix pci_dev reference leak in cgx_print_dmac_flt
Date: Thu, 25 Jun 2026 14:39:51 +0800
Message-Id: <20260625063951.44361-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXbhE6zTxqV6YpFQ--.19217S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy7tFW8AFy3Jr1xuw4DArb_yoW8Aw4kpa
	1Y9a4rArW8tryftw4UJa10yr98Ga1vq393K3y8Cw1F93WrJr1Fqa48KayUKF1SyFWkW3W3
	tF1Y9a1xua1Dt3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAcJA2o8pXKEjgABsL
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vulab@iscas.ac.cn,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268278-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C37A6C3161

In cgx_print_dmac_flt(), pci_get_device() is called to look up the AF
PCI device, but its return value is passed directly to pci_get_drvdata()
without saving the pointer. This means pci_dev_put() can never be called
for the obtained device, causing a reference count leak.

Fix it by saving the return value of pci_get_device() in a local variable
and releasing it via pci_dev_put() after the drvdata is extracted.

Cc: stable@vger.kernel.org
Fixes: dbc52debf95f ("octeontx2-af: Debugfs support for DMAC filters")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 .../net/ethernet/marvell/octeontx2/af/rvu_debugfs.c   | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index fa461489acdd..90dc13df9ff9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -2949,7 +2949,7 @@ RVU_DEBUG_SEQ_FOPS(cgx_stat, cgx_stat_display, NULL);
 
 static int cgx_print_dmac_flt(struct seq_file *s, int lmac_id)
 {
-	struct pci_dev *pdev = NULL;
+	struct pci_dev *af_pdev, *pdev = NULL;
 	void *cgxd = s->private;
 	char *bcast, *mcast;
 	u16 index, domain;
@@ -2958,8 +2958,13 @@ static int cgx_print_dmac_flt(struct seq_file *s, int lmac_id)
 	u64 cfg, mac;
 	int pf;
 
-	rvu = pci_get_drvdata(pci_get_device(PCI_VENDOR_ID_CAVIUM,
-					     PCI_DEVID_OCTEONTX2_RVU_AF, NULL));
+	af_pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
+				 PCI_DEVID_OCTEONTX2_RVU_AF, NULL);
+	if (!af_pdev)
+		return -ENODEV;
+
+	rvu = pci_get_drvdata(af_pdev);
+	pci_dev_put(af_pdev);
 	if (!rvu)
 		return -ENODEV;
 
-- 
2.39.5 (Apple Git-154)


