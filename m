Return-Path: <stable+bounces-102504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4239EF25A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAA529095A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4218221DA4;
	Thu, 12 Dec 2024 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OlTZA9xT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25472054EF;
	Thu, 12 Dec 2024 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021471; cv=none; b=j6mJoN2zgglKFj/qZ6vXoLLNjbGzh+svLq2wJ3JFvXmy2QcfkdFu4u46PX43o/GxW5Rg9W8wtNYRa+ceDvoi7n7lEGZYdkg+hi7q6fYlNeSrFWcGW/xitll5cdaAV+/imRTqKIxXUcMxhGp8hFDH9KIfo4l9WIVoiAv9pRVC2zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021471; c=relaxed/simple;
	bh=qAru2EkUsZox3EJzezbLRgtgdCgEZYlL8oQCgrer9zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuoHOv6sL4PJyyKTphE5MPL18P9SO+nAFL+Ui2CItOZtAV7+h+oD+IcfrqUA5ZNd1mVTc49aQyC8teeJpd78exacA+oCocYPJhF38duO4MNZiYNaOFQflTcxV2VffAmTXmsPjlfXA6hxBJ3q4VoGQP8K/2DiuuOEynKmf+VOMqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OlTZA9xT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C39C4CECE;
	Thu, 12 Dec 2024 16:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734021471;
	bh=qAru2EkUsZox3EJzezbLRgtgdCgEZYlL8oQCgrer9zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OlTZA9xTQg6nKz867AArrfZsqymaymbVkqYXyNEadhVvjwapki/Xd+BvCAkejUKLp
	 TEbWdYpteJNzqPy93yWojEhMzHaO9oVaTz8uFB4FvkWu8S20nwpKfYJRGwB7sCbu3t
	 pM4JJje93CZdorjDh75XEHct1OBbZaGyUZY73wU0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 717/772] PCI: Add ACS quirk for Wangxun FF5xxx NICs
Date: Thu, 12 Dec 2024 16:01:02 +0100
Message-ID: <20241212144419.513883048@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mengyuan Lou <mengyuanlou@net-swift.com>

[ Upstream commit aa46a3736afcb7b0793766d22479b8b99fc1b322 ]

Wangxun FF5xxx NICs are similar to SFxxx, RP1000 and RP2000 NICs.  They may
be multi-function devices, but they do not advertise an ACS capability.

But the hardware does isolate FF5xxx functions as though it had an ACS
capability and PCI_ACS_RR and PCI_ACS_CR were set in the ACS Control
register, i.e., all peer-to-peer traffic is directed upstream instead of
being routed internally.

Add ACS quirk for FF5xxx NICs in pci_quirk_wangxun_nic_acs() so the
functions can be in independent IOMMU groups.

Link: https://lore.kernel.org/r/E16053DB2B80E9A5+20241115024604.30493-1-mengyuanlou@net-swift.com
Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8887f3b3b38f0..d0da564ac94bf 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4881,18 +4881,21 @@ static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
 }
 
 /*
- * Wangxun 10G/1G NICs have no ACS capability, and on multi-function
- * devices, peer-to-peer transactions are not be used between the functions.
- * So add an ACS quirk for below devices to isolate functions.
+ * Wangxun 40G/25G/10G/1G NICs have no ACS capability, but on
+ * multi-function devices, the hardware isolates the functions by
+ * directing all peer-to-peer traffic upstream as though PCI_ACS_RR and
+ * PCI_ACS_CR were set.
  * SFxxx 1G NICs(em).
  * RP1000/RP2000 10G NICs(sp).
+ * FF5xxx 40G/25G/10G NICs(aml).
  */
 static int  pci_quirk_wangxun_nic_acs(struct pci_dev *dev, u16 acs_flags)
 {
 	switch (dev->device) {
-	case 0x0100 ... 0x010F:
-	case 0x1001:
-	case 0x2001:
+	case 0x0100 ... 0x010F: /* EM */
+	case 0x1001: case 0x2001: /* SP */
+	case 0x5010: case 0x5025: case 0x5040: /* AML */
+	case 0x5110: case 0x5125: case 0x5140: /* AML */
 		return pci_acs_ctrl_enabled(acs_flags,
 			PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
 	}
-- 
2.43.0




