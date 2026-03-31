Return-Path: <stable+bounces-232554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGuGGu8OzGnGNgYAu9opvQ
	(envelope-from <stable+bounces-232554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 20:14:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A948836FD0F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 20:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29BDD306CF22
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B4B449EB8;
	Tue, 31 Mar 2026 17:57:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F83333B6E3;
	Tue, 31 Mar 2026 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979839; cv=none; b=CkewO/pjAxEMp3m/pR0NJt4/L6ibt/wVsfeNIEJYBMrszc6rIzbxzyP9BA+iZjVGeWk01zaYDseBea6BWHMT1dwmNa/kdkZ9s82yynK4fqzM0VuJKARKVo6cQ1tc1coCL2CPgnMIlt4CgA42V7eMNxtDMdTfbVUn3BxTM1iCKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979839; c=relaxed/simple;
	bh=0dXOCc2EyLPPDQsyb8K7thSsKu2KeZEGb65KV4d/SRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlXHzIZO0/EwASvfCvIMBY3cwXlSC2I7uU6C8T3iGqA2vV+mAV+++6wcnKw4KQpLe3iHuT31TrqS5rfWd8aA0KffF6YMvDq5T+M9utoQhfjnOu5mIP7m8cCjVZPfpDUt1p8JxHlaSVTJzkT2l5O0dEynmZx29S2BPHzN2pBijVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [223.166.95.230])
	by APP-01 (Coremail) with SMTP id qwCowABH8GvrCsxpCP3GCw--.20050S4;
	Wed, 01 Apr 2026 01:57:01 +0800 (CST)
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
Subject: [PATCH 2/2] PCI: Add quirk to disable PCIe port services on Sophgo SG2042
Date: Wed,  1 Apr 2026 01:56:58 +0800
Message-ID: <20260331175658.1015829-3-gaohan@iscas.ac.cn>
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
X-CM-TRANSID:qwCowABH8GvrCsxpCP3GCw--.20050S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4fXw1rAr17XrykAr48tFb_yoW8uw17pF
	s8GF9ayr4FgFyUGw4kZw1kuF9xua1vy34FkrZ3Wa9IvF1ay3s5XFsrtr9IyF47WFsrXFW5
	Xwn8Cws8Wa4DWFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnI
	WIevJa73UjIFyTuYvjTRNiSHDUUUU
X-CM-SenderInfo: xjdrxt3q6l2u1dvotugofq/1tbiDAgDDGnL4tWXegAAsz
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
	TAGGED_FROM(0.00)[bounces-232554-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.799];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A948836FD0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SG2042's PCIe root ports [1f1c:2042] fail to deliver MSI interrupts to
downstream devices when native port services are enabled. Devices under
an affected root port receive zero interrupts despite successful vector
allocation, causing driver timeouts (e.g. amdgpu fence fallback timer
expired on all rings).

Set PCI_DEV_FLAGS_NO_PORT_SERVICES on SG2042 root ports to prevent the
port service driver from probing, restoring correct MSI delivery.

Fixes: 1c72774df028 ("PCI: sg2042: Add Sophgo SG2042 PCIe driver")
Cc: stable@vger.kernel.org
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 drivers/pci/quirks.c    | 12 ++++++++++++
 include/linux/pci_ids.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 48946cca4be7..bbde482ff7cb 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6380,3 +6380,15 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
 #endif
+
+/*
+ * SG2042's PCIe root ports do not correctly deliver MSI interrupts to
+ * downstream devices when native PCIe port services are enabled. All
+ * services including bwctrl must be disabled, equivalent to pcie_ports=compat.
+ */
+static void quirk_sg2042_no_port_services(struct pci_dev *dev)
+{
+	pci_info(dev, "SG2042: disabling native PCIe port services\n");
+	dev->dev_flags |= PCI_DEV_FLAGS_NO_PORT_SERVICES;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SOPHGO, 0x2042, quirk_sg2042_no_port_services);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 406abf629be2..9663be526dd0 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2630,6 +2630,8 @@
 
 #define PCI_VENDOR_ID_CXL		0x1e98
 
+#define PCI_VENDOR_ID_SOPHGO		0x1f1c
+
 #define PCI_VENDOR_ID_TEHUTI		0x1fc9
 #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
 #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
-- 
2.47.3


