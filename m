Return-Path: <stable+bounces-274541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NUIpMBqWVmpp+QAAu9opvQ
	(envelope-from <stable+bounces-274541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:03:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B528C75895A
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:03:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XyBfFRz3;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274541-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274541-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94F98301AB5F
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 20:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A29E41D635;
	Tue, 14 Jul 2026 20:02:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F115C41F341
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059359; cv=none; b=VcRWOvxfu/imOSsL8u8dPzjddOrn3pmnb1e4UAOxHL2sm9kLlYajhMT6iEpzaN+/WCxLLs+HZNBUDuIh6Ge6PLI+G6yhuSvtPRe3NHpiR9yb7vpJZPL+s/JfKbdZVxyek/Aw/2tpFZDTcZR4dP4EdI9WqU825bzlRBDur7UZX48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059359; c=relaxed/simple;
	bh=KZyYLoNh0d9jK9knLuz8aSmqilF3RGk4SASIlOd+x4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2i5793d2oxkiVVc5H+c79a5N8+ETlvvbUUfnqkfwwjygHXljWpCuPlM2IeYgIPLSgdpLqlZYme4fN2M0xHqpo2QdAHz8Q05WghIBfHkQCMorfG2Q34QHR3D/mOFS+xp0T1Emt7Qgg62xtt1STaoYun1O4tcR5qIMLHagjVaOWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyBfFRz3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA4B1F00ADE;
	Tue, 14 Jul 2026 20:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059351;
	bh=nlbBFbaCAF+Fg+PmanXnSWc9fx0JATp2ua6E3pmh35A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XyBfFRz3pUQ3MiI+AfnrG7BmvM76tGH8Yia4BdLesKfGjnQoay3oEOKQ6cy49wMBJ
	 pBzP7J/AYr7fGFhuKGjziNlmMSsLcd6j8wfPpS6IF0eY2HpA182Cc13Hu3Y4cZZuP0
	 6ws9uArNUnru9tLgPUJjgZgRigvbKnaEiKCC2GzmEXG3b411rurYv/WnmlPI6P4v87
	 /87dHcjpDCPC/YySCJHneQMjZb/G+UdcTn8OwK4WfvGKJLJjJWtHeG+yQB7pbbbeds
	 NsRNbtLBcn44JUC+bKCC20JbBkYVys0G7h4XHoMKn1gNLwTFasE3CbpOoSfdAs8IGc
	 KJUKL+5bgZTWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Caleb James DeLisle <cjd@cjdns.fr>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/5] PCI: mediatek: Fix IRQ domain leak when port fails to enable
Date: Tue, 14 Jul 2026 16:02:26 -0400
Message-ID: <20260714200226.3152882-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714200226.3152882-1-sashal@kernel.org>
References: <2026071353-appointee-tactful-9ca3@gregkh>
 <20260714200226.3152882-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274541-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:manivannan.sadhasivam@oss.qualcomm.com,m:mani@kernel.org,m:cjd@cjdns.fr,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B528C75895A

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

[ Upstream commit f865a57896bd92d7662eb2818d8f48872e2cbbc7 ]

When mtk_pcie_enable_port() fails, mtk_pcie_port_free() removes the port
from pcie->ports and frees the port structure. However, the IRQ domains set
up earlier by mtk_pcie_init_irq_domain() are never freed.

Fix this by refactoring mtk_pcie_irq_teardown() into a per-port helper,
mtk_pcie_irq_teardown_port(), and calling it from mtk_pcie_setup() when
mtk_pcie_enable_port() fails. Since the IRQ teardown must only happen in
the probe error path (during resume, child devices may have active MSI
mappings and the NOIRQ context prohibits sleeping locks),
mtk_pcie_enable_port() is changed to return an error code so callers can
distinguish the two paths and act accordingly.

This issue was reported by Sashiko while reviewing the EcoNet EN7528 SoC
support series.

Fixes: b099631df160 ("PCI: mediatek: Add controller support for MT2712 and MT7622")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Cc: stable@vger.kernel.org # 5.10
Cc: Caleb James DeLisle <cjd@cjdns.fr>
Link: https://patch.msgid.link/20260521174617.17692-1-mani@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-mediatek.c | 75 ++++++++++++++++----------
 1 file changed, 48 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index c6fa43fb094175..5f97a8e25a9762 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -12,7 +12,7 @@
 #include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
-#include <linux/irqchip/irq-msi-lib.h>
+#include "../../irqchip/irq-msi-lib.h"
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
@@ -488,7 +488,6 @@ static const struct msi_parent_ops mtk_msi_parent_ops = {
 	.required_flags		= MTK_MSI_FLAGS_REQUIRED,
 	.supported_flags	= MTK_MSI_FLAGS_SUPPORTED,
 	.bus_select_token	= DOMAIN_BUS_PCI_MSI,
-	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
 	.prefix			= "MTK-",
 	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
@@ -502,13 +501,18 @@ static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
 		.ops		= &msi_domain_ops,
 		.host_data	= port,
 		.size		= MTK_MSI_IRQS_NUM,
+		.hwirq_max	= MTK_MSI_IRQS_NUM,
+		.bus_token	= DOMAIN_BUS_PCI_MSI,
+		.domain_flags	= IRQ_DOMAIN_FLAG_MSI_PARENT,
 	};
 
-	port->inner_domain = msi_create_parent_irq_domain(&info, &mtk_msi_parent_ops);
-	if (!port->inner_domain) {
+	port->inner_domain = irq_domain_instantiate(&info);
+	if (IS_ERR(port->inner_domain)) {
 		dev_err(port->pcie->dev, "failed to create IRQ domain\n");
+		port->inner_domain = NULL;
 		return -ENOMEM;
 	}
+	port->inner_domain->msi_parent_ops = &mtk_msi_parent_ops;
 
 	return 0;
 }
@@ -527,23 +531,27 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
 	writel(val, port->base + PCIE_INT_MASK);
 }
 
-static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
+static void mtk_pcie_irq_teardown_port(struct mtk_pcie_port *port)
 {
-	struct mtk_pcie_port *port, *tmp;
+	irq_set_chained_handler_and_data(port->irq, NULL, NULL);
 
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
-		irq_set_chained_handler_and_data(port->irq, NULL, NULL);
+	if (port->irq_domain)
+		irq_domain_remove(port->irq_domain);
 
-		if (port->irq_domain)
-			irq_domain_remove(port->irq_domain);
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		if (port->inner_domain)
+			irq_domain_remove(port->inner_domain);
+	}
 
-		if (IS_ENABLED(CONFIG_PCI_MSI)) {
-			if (port->inner_domain)
-				irq_domain_remove(port->inner_domain);
-		}
+	irq_dispose_mapping(port->irq);
+}
 
-		irq_dispose_mapping(port->irq);
-	}
+static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
+{
+	struct mtk_pcie_port *port, *tmp;
+
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		mtk_pcie_irq_teardown_port(port);
 }
 
 static int mtk_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
@@ -826,7 +834,7 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
 	return 0;
 }
 
-static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
+static int mtk_pcie_enable_port(struct mtk_pcie_port *port)
 {
 	struct mtk_pcie *pcie = port->pcie;
 	struct device *dev = pcie->dev;
@@ -835,7 +843,7 @@ static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
 	err = clk_prepare_enable(port->sys_ck);
 	if (err) {
 		dev_err(dev, "failed to enable sys_ck%d clock\n", port->slot);
-		goto err_sys_clk;
+		return err;
 	}
 
 	err = clk_prepare_enable(port->ahb_ck);
@@ -883,11 +891,15 @@ static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
 		goto err_phy_on;
 	}
 
-	if (!pcie->soc->startup(port))
-		return;
+	err = pcie->soc->startup(port);
+	if (err) {
+		dev_info(dev, "Port%d link down\n", port->slot);
+		goto err_soc_startup;
+	}
 
-	dev_info(dev, "Port%d link down\n", port->slot);
+	return 0;
 
+err_soc_startup:
 	phy_power_off(port->phy);
 err_phy_on:
 	phy_exit(port->phy);
@@ -903,8 +915,8 @@ static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
 	clk_disable_unprepare(port->ahb_ck);
 err_ahb_clk:
 	clk_disable_unprepare(port->sys_ck);
-err_sys_clk:
-	mtk_pcie_port_free(port);
+
+	return err;
 }
 
 static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
@@ -1072,8 +1084,13 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 		return err;
 
 	/* enable each port, and then check link status */
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
-		mtk_pcie_enable_port(port);
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+		err = mtk_pcie_enable_port(port);
+		if (err) {
+			mtk_pcie_irq_teardown_port(port);
+			mtk_pcie_port_free(port);
+		}
+	}
 
 	/* power down PCIe subsys if slots are all empty (link down) */
 	if (list_empty(&pcie->ports))
@@ -1175,14 +1192,18 @@ static int mtk_pcie_resume_noirq(struct device *dev)
 {
 	struct mtk_pcie *pcie = dev_get_drvdata(dev);
 	struct mtk_pcie_port *port, *tmp;
+	int err;
 
 	if (list_empty(&pcie->ports))
 		return 0;
 
 	clk_prepare_enable(pcie->free_ck);
 
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
-		mtk_pcie_enable_port(port);
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+		err = mtk_pcie_enable_port(port);
+		if (err)
+			mtk_pcie_port_free(port);
+	}
 
 	/* In case of EP was removed while system suspend. */
 	if (list_empty(&pcie->ports))
-- 
2.53.0


