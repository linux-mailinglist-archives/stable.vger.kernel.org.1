Return-Path: <stable+bounces-64475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3750941DF8
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574821F255E5
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E111A76BA;
	Tue, 30 Jul 2024 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M/Nm72pL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D8F1A76A1;
	Tue, 30 Jul 2024 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360244; cv=none; b=AwcOLvrGscpaJPIsA9kJ3RPLi8BorsnAZM3LCJdPFA6z3H23j0nMr2zfxg5Z38pLLACdgLJda+FyJ43Z33Udt95XJg5iqhJ/cGc3to8A1mQexnqr2EcfYVwucBiTiWEQ7fTD2VMJ6iN+HD4So6CCzoTMyxp6zYcJ+ij/2L4O20w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360244; c=relaxed/simple;
	bh=1E4pItoU0nhb/D7AtIw/W/ZHdaecy60uJwjpZzblnNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUujzRiLyIzrTHMwi7IGVZU2SeIwSKDwgpFJY/XADJ7Hk8fu9trEDaB9nKhVqI2e+B/nI2EieHJs4dRNoI9KDrOVNKZKoSBdKbFpQOCqocmNGpkmRhLjrhGVGzuMvYhi7jxb+W2FllfLAO9X9VZxaktrQqq6Rkbt6RsUHhMW/SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M/Nm72pL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF827C32782;
	Tue, 30 Jul 2024 17:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360244;
	bh=1E4pItoU0nhb/D7AtIw/W/ZHdaecy60uJwjpZzblnNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M/Nm72pLOIyR9IO0hsisY0Yy7bSbybI71jH2RlAvrtSPVMPbToQpZyIZYrcfOZSrO
	 Fqg1RPJaShqiXXsFTAuIALgUai4VtqYvOAs3k8zH1p8PokggrNn0nH+4aXfBU5gdbl
	 A24mA8A1iKCiZ2vJtNbQbdokcB8qGS56BC6OllmM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sheng Wu <wusheng@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6.10 641/809] PCI: loongson: Enable MSI in LS7A Root Complex
Date: Tue, 30 Jul 2024 17:48:37 +0200
Message-ID: <20240730151750.181431735@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

commit a4bbcac11d3cea85822af8b40daed7e96bca5068 upstream.

The LS7A chipset can be used as part of a PCIe Root Complex with
Loongson-3C6000 and similar CPUs.  In this case, DEV_LS7A_PCIE_PORT5 has a
PCI_CLASS_BRIDGE_HOST class code, and it is a Type 0 Function whose config
space provides access to Root Complex registers.

The DEV_LS7A_PCIE_PORT5 has an MSI Capability, and its MSI Enable bit must
be set before other devices below the Root Complex can use MSI.  This is
not the standard PCI behavior of MSI Enable, so the normal PCI MSI code
does not set it.

Set the DEV_LS7A_PCIE_PORT5 MSI Enable bit via a quirk so other devices
below the Root Complex can use MSI.

[kwilczynski: exit early to reduce indentation; commit log]
Link: https://lore.kernel.org/linux-pci/20240612065315.2048110-1-chenhuacai@loongson.cn
Signed-off-by: Sheng Wu <wusheng@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
[bhelgaas: commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/pci-loongson.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -163,6 +163,19 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LO
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
 			DEV_LS7A_HDMI, loongson_pci_pin_quirk);
 
+static void loongson_pci_msi_quirk(struct pci_dev *dev)
+{
+	u16 val, class = dev->class >> 8;
+
+	if (class != PCI_CLASS_BRIDGE_HOST)
+		return;
+
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &val);
+	val |= PCI_MSI_FLAGS_ENABLE;
+	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, val);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT5, loongson_pci_msi_quirk);
+
 static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
 {
 	struct pci_config_window *cfg;



