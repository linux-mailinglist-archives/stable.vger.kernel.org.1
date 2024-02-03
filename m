Return-Path: <stable+bounces-18409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C67B584829C
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5683D1F220B6
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E0C4BAAA;
	Sat,  3 Feb 2024 04:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HE8EAJpZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170E013ADB;
	Sat,  3 Feb 2024 04:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933778; cv=none; b=iR1gEnrntg6kcA0a0ppnvwr/jOhqUcjhvmQxsDwkoazU6gw9lrgOO/he7ury9M0czGU4p3ruPQ02E77UQP/+/7701oMflwcjrvSUxUCx7/0SEVvxkailYVqsQYXcyQ0GjR25XSsOhFNcLdZeD7H5fLasKXiRXltPgyocCrzo4Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933778; c=relaxed/simple;
	bh=Rb3mbr4j66SvtelwodPhrultwgoO7MO0r013PZLSIN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/vc++CBHGIaBU3d0f2OuN/JwuMwaptS9FePrSkRy88ofdksclaHdrFy7p519G5l+qFzyrA1fDm69/6sINlEXODOk+i9WxX8NSS4s0/Zm2UZEhy1x23r9t8lDK9NRAy5I1OGSkI2VKJrCy5iU/DGxB70/6758keTl+Y/UUpaxcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HE8EAJpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82869C433C7;
	Sat,  3 Feb 2024 04:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933777;
	bh=Rb3mbr4j66SvtelwodPhrultwgoO7MO0r013PZLSIN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HE8EAJpZotegC9zs4P+AKfm2w/o6uCDHRvfwX6VQ6sWZCnw/6nWEHk80AEoj4Dst9
	 R/FdVI9r2b3JkGTPV40GU/Xiu5tLdZN1to7bbJ4+og0teYRGVYcpoBhKtXyyF6wSs7
	 CZBxfMWqVa07+Qe5BpwTVsILEXdyZq4Dm7HwkUVs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ido Schimmel <idosch@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 081/353] PCI: Add no PM reset quirk for NVIDIA Spectrum devices
Date: Fri,  2 Feb 2024 20:03:19 -0800
Message-ID: <20240203035406.372902273@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 3ed48c80b28d8dcd584d6ddaf00c75b7673e1a05 ]

Spectrum-{1,2,3,4} devices report that a D3hot->D0 transition causes a
reset (i.e., they advertise NoSoftRst-). However, this transition does
not have any effect on the device: It continues to be operational and
network ports remain up. Advertising this support makes it seem as if a
PM reset is viable for these devices. Mark it as unavailable to skip it
when testing reset methods.

Before:

 # cat /sys/bus/pci/devices/0000\:03\:00.0/reset_method
 pm bus

After:

 # cat /sys/bus/pci/devices/0000\:03\:00.0/reset_method
 bus

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d55a3ffae4b8..a991710efa40 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3786,6 +3786,19 @@ static void quirk_no_pm_reset(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
 			       PCI_CLASS_DISPLAY_VGA, 8, quirk_no_pm_reset);
 
+/*
+ * Spectrum-{1,2,3,4} devices report that a D3hot->D0 transition causes a reset
+ * (i.e., they advertise NoSoftRst-). However, this transition does not have
+ * any effect on the device: It continues to be operational and network ports
+ * remain up. Advertising this support makes it seem as if a PM reset is viable
+ * for these devices. Mark it as unavailable to skip it when testing reset
+ * methods.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcb84, quirk_no_pm_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf6c, quirk_no_pm_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf70, quirk_no_pm_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf80, quirk_no_pm_reset);
+
 /*
  * Thunderbolt controllers with broken MSI hotplug signaling:
  * Entire 1st generation (Light Ridge, Eagle Ridge, Light Peak) and part
-- 
2.43.0




