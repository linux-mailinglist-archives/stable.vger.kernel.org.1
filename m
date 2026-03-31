Return-Path: <stable+bounces-232555-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBkWGncOzGmHNwYAu9opvQ
	(envelope-from <stable+bounces-232555-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 20:12:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6248A36FC7A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 20:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D6E5307072D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3849644A71B;
	Tue, 31 Mar 2026 17:57:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCC33E95B5;
	Tue, 31 Mar 2026 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979840; cv=none; b=hEy1+TJ01FvK0eK/B2Sre4/KkmRc4WUGiIcN6Vvc6dXIdFZZ+K38V4r2th2YdEx6XHQsrQqyr7YJcFtsu6k488Zp/Q64GzM+X1YHZQdRL//ePq6/+qwkYENIjjQUFytUDPmO5Y+6K0j4cUxdjBox3FVSaslYyFLgILrT1AJh+i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979840; c=relaxed/simple;
	bh=RuWCEzqLii74sI1YSSDvwlhCBvb1Uf2iaKG1Hp8YNvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKZZEax1cIjU7nqmco9eWt9HaNUPRWMaTAmAO+N/kHwCPG1RpX/UWlpBZqwElCYjf4X9kJ+47SvEWU14EU0gw+cIgrbsOADluV4k7kI8sZB/IsVMMwGZFd8Lyl37Gm56GyBREd79Avkc9/ZwGwdOBGirVMgOHFPYi7dFwOdqxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [223.166.95.230])
	by APP-01 (Coremail) with SMTP id qwCowABH8GvrCsxpCP3GCw--.20050S3;
	Wed, 01 Apr 2026 01:57:00 +0800 (CST)
From: Han Gao <gaohan@iscas.ac.cn>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Han Gao <gaohan@iscas.ac.cn>,
	Chen Wang <unicorn_wang@outlook.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <zhengxingda@iscas.ac.cn>,
	Inochi Amaoto <inochiama@gmail.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Yao Zi <me@ziyao.cc>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] PCI: Add per-device flag to disable native PCIe port services
Date: Wed,  1 Apr 2026 01:56:57 +0800
Message-ID: <20260331175658.1015829-2-gaohan@iscas.ac.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331175658.1015829-1-gaohan@iscas.ac.cn>
References: <20260331175658.1015829-1-gaohan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABH8GvrCsxpCP3GCw--.20050S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw43CFWrXr1rKw4UAw4fXwb_yoW8AFykpF
	WvkFykKrWrKFyUWw4qy3W3Ca4rWan8ZrWSkrWUWwnxuFWayryrZF9rtFyaqrsxGFW0vFy5
	GrZxGry5CF47ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ2b7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRwL0rUUUUU
X-CM-SenderInfo: xjdrxt3q6l2u1dvotugofq/1tbiBg0DDGnL4iiZtwAAsC
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-232555-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[google.com,baylibre.com,huawei.com,wunner.de,linux.intel.com,kernel.org,iscas.ac.cn,outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaohan@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.infradead.org,gmail.com,iscas.ac.cn,ziyao.cc];
	NEURAL_HAM(-0.00)[-0.786];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 6248A36FC7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add PCI_DEV_FLAGS_NO_PORT_SERVICES to allow quirks to prevent the PCIe
port service driver from probing specific devices. This provides a
per-device equivalent of the global pcie_ports=compat kernel parameter.

Some platforms have PCIe root ports that break MSI delivery to downstream
devices when native port services (AER, PME, bwctrl, etc.) are active.
The existing pci_host_bridge native_* flags do not cover all services
(notably bwctrl), so a mechanism to skip port driver probing entirely
on a per-device basis is needed.

Cc: stable@vger.kernel.org
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 drivers/pci/pcie/portdrv.c | 3 +++
 include/linux/pci.h        | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 2d6aa488fe7b..3386818d200d 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -685,6 +685,9 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
 static int pcie_portdrv_probe(struct pci_dev *dev,
 					const struct pci_device_id *id)
 {
+	if (dev->dev_flags & PCI_DEV_FLAGS_NO_PORT_SERVICES)
+		return -ENODEV;
+
 	int type = pci_pcie_type(dev);
 	int status;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d5123..e038fe14ef78 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -253,6 +253,8 @@ enum pci_dev_flags {
 	 * integrated with the downstream devices and doesn't use real PCI.
 	 */
 	PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIAS = (__force pci_dev_flags_t) (1 << 14),
+	/* Do not use native PCIe port services (equivalent to pcie_ports=compat) */
+	PCI_DEV_FLAGS_NO_PORT_SERVICES = (__force pci_dev_flags_t) (1 << 15),
 };
 
 enum pci_irq_reroute_variant {
-- 
2.47.3


