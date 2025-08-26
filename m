Return-Path: <stable+bounces-173570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FB3B35E24
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F70464230
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180202FAC02;
	Tue, 26 Aug 2025 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DTC+uV1c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97742F6564;
	Tue, 26 Aug 2025 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208592; cv=none; b=dKtG3ZGskaxCnwq245vQbSrjmnJa9R+WvN8FxdnDThRiSPj+eEgUD/3zK+TKzdBSt8MpKgtHrKY6m8Ar9awpVd7svK0cDRzFxLpHNHrbDwbVHpeq/MNjEGBHRTGoOm3sNZSyUXmPmNsurLUlfzp515yHnmXRm9W2DQUgYFtlqU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208592; c=relaxed/simple;
	bh=5Il5qF1omSB09EvtPOW2qGZy5W6ipkdAugzWCRlySGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFMu0x7F6uyuqhoMok42//tLTLqyTQ/TEewT43QrHdrjKUyWQoY2HkgSocUIlSu8QVZDbDHlQ9C8vH5Gypi35CNYubg3wwyZdO40VlkiTO+zq8GhoppnSQ+e/h+6QBfWP80RvKBOec4ZzD5GYENyCSJfp/AZm/6S6/KUBPZs36o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DTC+uV1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595B1C4CEF1;
	Tue, 26 Aug 2025 11:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208592;
	bh=5Il5qF1omSB09EvtPOW2qGZy5W6ipkdAugzWCRlySGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DTC+uV1cOS3hIU0GTHEa/6zgJcX9joeO5f/dIwKvwgjqWt3PsNakKm5dG5l0EOnyk
	 AQv7BA8F0w7tutBVSegX5c5mL4SF/4OP9B0kLcfn3tvL+N/xRV9YoM8BrEsKG4UWkg
	 BE8+QQg94JzLJVm4W6PrXIAwo4nYF6MNnrHPBySc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.12 169/322] mmc: sdhci-pci-gli: GL9763e: Rename the gli_set_gl9763e() for consistency
Date: Tue, 26 Aug 2025 13:09:44 +0200
Message-ID: <20250826110920.014839710@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Victor Shih <victor.shih@genesyslogic.com.tw>

commit 293ed0f5f34e1e9df888456af4b0a021f57b5f54 upstream.

In preparation to fix replay timer timeout, rename the
gli_set_gl9763e() to gl9763e_hw_setting() for consistency.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")
Cc: stable@vger.kernel.org
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20250731065752.450231-3-victorshihgli@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-pci-gli.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -1335,7 +1335,7 @@ cleanup:
 	return ret;
 }
 
-static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
+static void gl9763e_hw_setting(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
 	u32 value;
@@ -1510,7 +1510,7 @@ static int gli_probe_slot_gl9763e(struct
 	gli_pcie_enable_msi(slot);
 	host->mmc_host_ops.hs400_enhanced_strobe =
 					gl9763e_hs400_enhanced_strobe;
-	gli_set_gl9763e(slot);
+	gl9763e_hw_setting(slot);
 	sdhci_enable_v4_mode(host);
 
 	return 0;



