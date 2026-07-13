Return-Path: <stable+bounces-273747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id srzFFpfrVGrehAAAu9opvQ
	(envelope-from <stable+bounces-273747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:43:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED40974BC82
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:43:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="Wh490nt/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273747-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273747-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D24D731EFCC4
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81537431E45;
	Mon, 13 Jul 2026 13:25:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4C442DFFA
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:25:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949126; cv=none; b=aeoLRqWH3i67v7M5/Q4viaPU223BSrdPJk6TMc4v+acYeq9/gJ40Ml3sf4IqPG4LXvowl6BopsOwBK9JXImYQn/vHFOADb7exaab2RnGZWbhmbJUkVoQmQRhPLp5+UJ4o55eUSW25mD4rB1u5jte5SnHCaYgx6MQ7DZKkjraajE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949126; c=relaxed/simple;
	bh=NmxrIptUaIKpixeSdH7sBMuStS7WGkVhUZbVT1IMQM4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kNOJgFXdWdXSdnqkYHofPzGGFFQk5EHJ0yLsVPqvJwHnjk0V57y8JCFzfbm4sOQUj1HyrCZSoxzR9r6UkwJT9c2C69Zb7C/RlZULLO1mUN7Ml/rjTRQ/TGB0X3fA0P1opeTqsWxVSFmyc5krnoi5psZJ0iBkGqPVs6T5QdbRhiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wh490nt/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F04F1F000E9;
	Mon, 13 Jul 2026 13:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783949124;
	bh=Fd3R7EUIkDCAyrIYutEYOj4CoBb/l5nLyHTh4LTmqJs=;
	h=Subject:To:Cc:From:Date;
	b=Wh490nt/5/E9BSTO6Aba4vJ50PDbpNHwL4TGqdOPQUPRkilgTrVqr9YPfBSUrnDah
	 c+zbDcSW+15ejnRUm9IAVOlEVyFIf6pcZnJG8LQq7xqcIRxeyDZB574rQFQyOiqwWY
	 /Htm5cr0pUg0gfyFer4Y+MIqr4yhbi6M/rDP+a5Q=
Subject: FAILED: patch "[PATCH] PCI: altera: Fix resource leaks on probe failure" failed to apply to 6.6-stable tree
To: mahesh.vaidya@altera.com,mani@kernel.org,subhransu.sekhar.prusty@altera.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:16:14 +0200
Message-ID: <2026071314-linseed-onslaught-176b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273747-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:mahesh.vaidya@altera.com,m:mani@kernel.org,m:subhransu.sekhar.prusty@altera.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,vger.kernel.org:from_smtp,msgid.link:url,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,altera.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED40974BC82


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7a94138caeb27f3c49c1dbd93bf422098925bb28
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071314-linseed-onslaught-176b@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7a94138caeb27f3c49c1dbd93bf422098925bb28 Mon Sep 17 00:00:00 2001
From: Mahesh Vaidya <mahesh.vaidya@altera.com>
Date: Thu, 30 Apr 2026 13:43:30 -0700
Subject: [PATCH] PCI: altera: Fix resource leaks on probe failure

The chained IRQ handler is set during probe, but is only removed during the
driver remove(). If pci_host_probe() fails, the handler and INTx IRQ
domain remain set even though the devm-managed host bridge storage
containing struct altera_pcie will be released, leaving the handler with
a stale data pointer.

Interrupts are also enabled before pci_host_probe() is called. If probe
fails after that point, the controller interrupt source should be disabled
before the chained handler and INTx domain are removed.

So set the chained handler only after the INTx domain has been created.
Disable controller interrupts during IRQ teardown, and tear the IRQ setup
down if pci_host_probe() fails.

Fixes: c63aed7334c2 ("PCI: altera: Use pci_host_probe() to register host")
Signed-off-by: Mahesh Vaidya <mahesh.vaidya@altera.com>
[mani: commit log]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Subhransu S. Prusty <subhransu.sekhar.prusty@altera.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260430204330.3121003-3-mahesh.vaidya@altera.com

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 3d3519b8d88f..76f3823d9613 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -864,8 +864,23 @@ static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
 	return 0;
 }
 
+static void altera_pcie_disable_irq(struct altera_pcie *pcie)
+{
+	if (pcie->pcie_data->version == ALTERA_PCIE_V1 ||
+	    pcie->pcie_data->version == ALTERA_PCIE_V2) {
+		/* Disable all P2A interrupts */
+		cra_writel(pcie, 0, P2A_INT_ENABLE);
+	} else if (pcie->pcie_data->version == ALTERA_PCIE_V3) {
+		/* Disable port-level interrupts (CFG_AER, etc.) */
+		writel(0, pcie->hip_base +
+			  pcie->pcie_data->port_conf_offset +
+			  pcie->pcie_data->port_irq_enable_offset);
+	}
+}
+
 static void altera_pcie_irq_teardown(struct altera_pcie *pcie)
 {
+	altera_pcie_disable_irq(pcie);
 	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
 	irq_domain_remove(pcie->irq_domain);
 }
@@ -890,7 +905,6 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 	if (pcie->irq < 0)
 		return pcie->irq;
 
-	irq_set_chained_handler_and_data(pcie->irq, pcie->pcie_data->ops->rp_isr, pcie);
 	return 0;
 }
 
@@ -1019,6 +1033,14 @@ static int altera_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * The chained handler uses pcie->irq_domain, so set it only after the
+	 * INTx domain has been created.
+	 */
+	irq_set_chained_handler_and_data(pcie->irq,
+					 pcie->pcie_data->ops->rp_isr,
+					 pcie);
+
 	if (pcie->pcie_data->version == ALTERA_PCIE_V1 ||
 	    pcie->pcie_data->version == ALTERA_PCIE_V2) {
 		/* clear all interrupts */
@@ -1036,7 +1058,16 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	bridge->busnr = pcie->root_bus_nr;
 	bridge->ops = &altera_pcie_ops;
 
-	return pci_host_probe(bridge);
+	ret = pci_host_probe(bridge);
+	if (ret)
+		goto err_teardown_irq;
+
+	return 0;
+
+err_teardown_irq:
+	altera_pcie_irq_teardown(pcie);
+
+	return ret;
 }
 
 static void altera_pcie_remove(struct platform_device *pdev)


