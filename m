Return-Path: <stable+bounces-10729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF4E82CB5F
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EAAE2843A7
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 09:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E0E1095B;
	Sat, 13 Jan 2024 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="woti+4ic"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2C51869;
	Sat, 13 Jan 2024 09:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6899C433F1;
	Sat, 13 Jan 2024 09:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705139932;
	bh=MfcE9PjhiqsMiqpOmGMEverxxjiSaSYZ1+H1S+9vPLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=woti+4ic0utH8KBSUu8Hq/vAzIzOyb0x0YlDnp9R9n3gH4PDUyY7Ea1K4Q4BWNSqz
	 CxsPecEn0eVou6ghcqBjE4oV24oWZ5mVEWViDtjDL9h/XVJG/QrKy4eVExprTXAjBo
	 YJeMQfoxjyitirrCshV+oza1Q9JoK5/497WKMVuo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5.10 41/43] PCI: Extract ATS disabling to a helper function
Date: Sat, 13 Jan 2024 10:50:20 +0100
Message-ID: <20240113094208.280788483@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113094206.930684111@linuxfoundation.org>
References: <20240113094206.930684111@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Pawlowski <bartosz.pawlowski@intel.com>

commit f18b1137d38c091cc8c16365219f0a1d4a30b3d1 upstream.

Introduce quirk_no_ats() helper function to provide a standard way to
disable ATS capability in PCI quirks.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20230908143606.685930-2-bartosz.pawlowski@intel.com
Signed-off-by: Bartosz Pawlowski <bartosz.pawlowski@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/quirks.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5353,6 +5353,12 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SE
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
 
 #ifdef CONFIG_PCI_ATS
+static void quirk_no_ats(struct pci_dev *pdev)
+{
+	pci_info(pdev, "disabling ATS\n");
+	pdev->ats_cap = 0;
+}
+
 /*
  * Some devices require additional driver setup to enable ATS.  Don't use
  * ATS for those devices as ATS will be enabled before the driver has had a
@@ -5365,8 +5371,7 @@ static void quirk_amd_harvest_no_ats(str
 	    (pdev->device == 0x7341 && pdev->revision != 0x00))
 		return;
 
-	pci_info(pdev, "disabling ATS\n");
-	pdev->ats_cap = 0;
+	quirk_no_ats(pdev);
 }
 
 /* AMD Stoney platform GPU */



