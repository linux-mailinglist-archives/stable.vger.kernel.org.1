Return-Path: <stable+bounces-6332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CB280DA23
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9EB1F21BB1
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A9E524B9;
	Mon, 11 Dec 2023 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uN0BhM+D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB17A321B8;
	Mon, 11 Dec 2023 18:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC57C433C7;
	Mon, 11 Dec 2023 18:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702321143;
	bh=vgtiyLeln55Zh+3RL05zdLdkhffXkM5unnjJyZX1qMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uN0BhM+D5DmCtV5G0K0K9y9asq4GR4DijxFZPPQJ6ZjMDCHZwSwwev9NaLJ9F9CYs
	 eZZHDg+CugFsQmKIi/pqUxrEf1X7RKQH+q494nDfteQb3yFxwk07BqW+ZvT3b7a9FW
	 DtqwBPZ8HJNt4LNrqQw82xxTAcRGJl2GwvpPMN48=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 5.15 125/141] Revert "xhci: Loosen RPM as default policy to cover for AMD xHC 1.1"
Date: Mon, 11 Dec 2023 19:23:04 +0100
Message-ID: <20231211182031.980895061@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
References: <20231211182026.503492284@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 24be0b3c40594a14b65141ced486ae327398faf8 upstream.

This reverts commit 4baf1218150985ee3ab0a27220456a1f027ea0ac.

Enabling runtime pm as default for all AMD xHC 1.1 controllers caused
regression. An initial attempt to fix those was done in commit a5d6264b638e
("xhci: Enable RPM on controllers that support low-power states") but new
issues are still seen.

Revert this to get those AMD xHC 1.1 systems working

This patch went to stable an needs to be reverted from there as well.

Fixes: 4baf12181509 ("xhci: Loosen RPM as default policy to cover for AMD xHC 1.1")
Link: https://lore.kernel.org/linux-usb/55c50bf5-bffb-454e-906e-4408c591cb63@molgen.mpg.de
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20231205090548.1377667-1-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-pci.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -349,8 +349,6 @@ static void xhci_pci_quirks(struct devic
 	/* xHC spec requires PCI devices to support D3hot and D3cold */
 	if (xhci->hci_version >= 0x120)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
-	else if (pdev->vendor == PCI_VENDOR_ID_AMD && xhci->hci_version >= 0x110)
-		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
 		xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,



