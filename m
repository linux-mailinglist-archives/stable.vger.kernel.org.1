Return-Path: <stable+bounces-232550-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOhVIJ8JzGn+NQYAu9opvQ
	(envelope-from <stable+bounces-232550-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:51:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C557936F674
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65BB231BCCE5
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915A432720D;
	Tue, 31 Mar 2026 17:13:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC78331D371;
	Tue, 31 Mar 2026 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977187; cv=none; b=MyA7DxHa+2Ax9oxdfzupKIzBs3Hv0rGM586060ge4NEaaaQcgEmZJj1pQJwDsRdlca/lECK0q/AMLr8q666evS0dRkkrkrqSsckBXOk3bVgfmCJTJAYWKdfHr3d8iI5TP+ESlaxC0ub9930xdJmk7pmnP3ToPUyiv2frEkEJReU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977187; c=relaxed/simple;
	bh=LjAqqBgNW2sWmyeSHjj7o/HH2Z1LXM/vDtlzhXMFot8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWwbOyJiFhaMJtg7qpdu48MGsrM5o5hBJMKpSZx9Ni/JTIfon/ueU7D5UX5A1+glahzd2n4nrJTAP4E7z/seOMdKHUJ1Z59ZeMfEC3KnyNXocq/mtphxCZcealE10YlatiiPAXfXFYWVWnKU3w0TIZeFomcXFZgNBcyzcybbuA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [223.166.95.230])
	by APP-03 (Coremail) with SMTP id rQCowABnhdyRAMxpydRzDA--.42156S4;
	Wed, 01 Apr 2026 01:12:52 +0800 (CST)
From: Han Gao <gaohan@iscas.ac.cn>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Han Gao <gaohan@iscas.ac.cn>,
	Zixian Zeng <sycamoremoon376@gmail.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Han Gao <rabenda.cn@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] riscv: dts: sophgo: Add dma-coherent to SG2042 PCIe controllers
Date: Wed,  1 Apr 2026 01:12:48 +0800
Message-ID: <20260331171248.973014-3-gaohan@iscas.ac.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331171248.973014-1-gaohan@iscas.ac.cn>
References: <20260331171248.973014-1-gaohan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABnhdyRAMxpydRzDA--.42156S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWrJFyxZFWkXry7tFyftFb_yoW8Gw45pr
	srCF45KFyxXrZYv3W7GFy0gr43JFZYkasxKrnYk3W8W3yYvryUXrn3Aw1Ig3WDGr4jq343
	WFs8tFyrKF1qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS
	14v26r4a6rW5MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIx
	AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRNiSHDUUUU
X-CM-SenderInfo: xjdrxt3q6l2u1dvotugofq/1tbiBg0DDGnL4ih7zAAAsb
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-232550-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[google.com,kernel.org,outlook.com,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,iscas.ac.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaohan@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.infradead.org,gmail.com];
	NEURAL_HAM(-0.00)[-0.824];
	TAGGED_RCPT(0.00)[stable,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[164.249.198.128:email,164.219.66.0:email,164.237.145.128:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,164.207.13.0:email,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: C557936F674
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SG2042's PCIe root complexes are cache-coherent with the CPU. Mark all
four PCIe controller nodes (pcie_rc0 through pcie_rc3) as dma-coherent
so the kernel uses coherent DMA mappings instead of non-coherent bounce
buffering.

Cc: stable@vger.kernel.org
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index 9fddf3f0b3b9..3af770549742 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -417,6 +417,7 @@ pcie_rc0: pcie@7060000000 {
 			vendor-id = <0x1f1c>;
 			device-id = <0x2042>;
 			cdns,no-bar-match-nbits = <48>;
+			dma-coherent;
 			msi-parent = <&msi>;
 			status = "disabled";
 		};
@@ -439,6 +440,7 @@ pcie_rc1: pcie@7060800000 {
 			vendor-id = <0x1f1c>;
 			device-id = <0x2042>;
 			cdns,no-bar-match-nbits = <48>;
+			dma-coherent;
 			msi-parent = <&msi>;
 			status = "disabled";
 		};
@@ -461,6 +463,7 @@ pcie_rc2: pcie@7062000000 {
 			vendor-id = <0x1f1c>;
 			device-id = <0x2042>;
 			cdns,no-bar-match-nbits = <48>;
+			dma-coherent;
 			msi-parent = <&msi>;
 			status = "disabled";
 		};
@@ -483,6 +486,7 @@ pcie_rc3: pcie@7062800000 {
 			vendor-id = <0x1f1c>;
 			device-id = <0x2042>;
 			cdns,no-bar-match-nbits = <48>;
+			dma-coherent;
 			msi-parent = <&msi>;
 			status = "disabled";
 		};
-- 
2.47.3


