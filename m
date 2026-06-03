Return-Path: <stable+bounces-259987-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s0qMA+bWH2pBqwAAu9opvQ
	(envelope-from <stable+bounces-259987-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 09:25:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8686352E5
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 09:25:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259987-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259987-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DD3C30507E7
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 07:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC12399CE6;
	Wed,  3 Jun 2026 07:18:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2002D73B8;
	Wed,  3 Jun 2026 07:17:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471081; cv=none; b=lA1tXNzPcIPl5uwHTfN817jDxgfAoZq4XfCV3I+iF352UgJCXC7N2UV34xaPVf8j9dZibuQmx4iWRCIEZbVDfe47PyX+wQnmg9FTuLJqy/Pnj7TWajWP24tVl92U8emnpz619Poxn0eOJs9wFLQ0ZUimj14V8T8XhEx0gn3+iLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471081; c=relaxed/simple;
	bh=eGMA2kfukIoeyI725SFDEiyovjQe2K1z/IFmf/wWKd8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vfs2/XI88Xjy0IFQpGwL1Cihyat6ZIqx1DxpIdlwJRIqllNz7JQH9EI3+UWV49CfXckZR0sPCJ1u/XUV9iBY4v2Zp7G3I/5fIRsBGbUczKiugZnI0QJCNoM/mkobsoaD0S5O0+4SQRlk0zl4vfqNiJMmc+ewWknZB9BqyGlZzy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-01 (Coremail) with SMTP id qwCowAC3XNUK1R9q8eqAAA--.1949S2;
	Wed, 03 Jun 2026 15:17:30 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: skalluru@marvell.com,
	manishc@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ariele@broadcom.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] bnx2x: clean up VF PCI resources on probe failure
Date: Wed,  3 Jun 2026 15:17:29 +0800
Message-Id: <20260603071729.799370-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC3XNUK1R9q8eqAAA--.1949S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF13Wry7KF4xAw48tF4xWFg_yoW5Gw1fpa
	9rXFy5Xr18GrsxAa1UXFWUAFnxA398t34UKayUJ3yavryYyF98JF47Ka47ZrW8GrZ5CF4S
	qw4jvwn8W3WYvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiCRAHE2ofveVYpAAAsc
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259987-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:skalluru@marvell.com,m:manishc@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ariele@broadcom.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lihaoxiang@isrc.iscas.ac.cn,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lihaoxiang@isrc.iscas.ac.cn,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihaoxiang@isrc.iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,iscas.ac.cn:email,isrc.iscas.ac.cn:from_mime,isrc.iscas.ac.cn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B8686352E5

bnx2x_init_one() allocates VF PCI resources by calling
bnx2x_vf_pci_alloc(), but later error paths fall through
the common cleanup path without calling bnx2x_vf_pci_dealloc().

This can leak the VF PCI resources allocated for the VF
when probe fails after bnx2x_vf_pci_alloc() succeeds.

Add a VF-specific error label to call bnx2x_vf_pci_dealloc()
before falling through to the existing common cleanup path.

Fixes: 6411280ac94d ("bnx2x: Segregate SR-IOV code")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index da0f8c353e6a..acb0379d94b9 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -13932,13 +13932,13 @@ static int bnx2x_init_one(struct pci_dev *pdev,
 		dev_err(&bp->pdev->dev,
 			"Cannot map doorbell space, aborting\n");
 		rc = -ENOMEM;
-		goto init_one_freemem;
+		goto init_one_vf_pci_dealloc;
 	}
 
 	if (IS_VF(bp)) {
 		rc = bnx2x_vfpf_acquire(bp, tx_count, rx_count);
 		if (rc)
-			goto init_one_freemem;
+			goto init_one_vf_pci_dealloc;
 
 #ifdef CONFIG_BNX2X_SRIOV
 		/* VF with OLD Hypervisor or old PF do not support filtering */
@@ -13952,7 +13952,7 @@ static int bnx2x_init_one(struct pci_dev *pdev,
 	/* Enable SRIOV if capability found in configuration space */
 	rc = bnx2x_iov_init_one(bp, int_mode, BNX2X_MAX_NUM_OF_VFS);
 	if (rc)
-		goto init_one_freemem;
+		goto init_one_vf_pci_dealloc;
 
 	/* calc qm_cid_count */
 	bp->qm_cid_count = bnx2x_set_qm_cid_count(bp);
@@ -13971,7 +13971,7 @@ static int bnx2x_init_one(struct pci_dev *pdev,
 	rc = bnx2x_set_int_mode(bp);
 	if (rc) {
 		dev_err(&pdev->dev, "Cannot set interrupts\n");
-		goto init_one_freemem;
+		goto init_one_vf_pci_dealloc;
 	}
 	BNX2X_DEV_INFO("set interrupts successfully\n");
 
@@ -13979,7 +13979,7 @@ static int bnx2x_init_one(struct pci_dev *pdev,
 	rc = register_netdev(dev);
 	if (rc) {
 		dev_err(&pdev->dev, "Cannot register net device\n");
-		goto init_one_freemem;
+		goto init_one_vf_pci_dealloc;
 	}
 	BNX2X_DEV_INFO("device name after netdev register %s\n", dev->name);
 
@@ -14001,6 +14001,10 @@ static int bnx2x_init_one(struct pci_dev *pdev,
 
 	return 0;
 
+init_one_vf_pci_dealloc:
+	if (IS_VF(bp))
+		bnx2x_vf_pci_dealloc(bp);
+
 init_one_freemem:
 	bnx2x_free_mem_bp(bp);
 
-- 
2.25.1


