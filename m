Return-Path: <stable+bounces-36503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0826889C025
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2B41F23506
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD6B71727;
	Mon,  8 Apr 2024 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0iNJNjBL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9CD6FE1A;
	Mon,  8 Apr 2024 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581515; cv=none; b=b6vMrnc6xfq/ru2lJHnrx/eFaTF6Ks0LvwdQV+MP8gL2LTSN7gt7GLaZxU5lFwxJ2RjAs5opZF6brvpe87V6MJBmSo2dfU5oIKlyHEE7uF+GJcmm+2yEluD6IDaFmFWEeawrDNNeC2dbgkCXGUbDeeQJK4t7kNOgZ2T3YSXLaCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581515; c=relaxed/simple;
	bh=HPcFGR4aMdEmQFN6n3FNF/nP0uWHSK/T08wheaVE2uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXVEjXw9cX0GAbhd/QGkTQbc+OXgRBzZELVDm0c/jE1ghofn4hacAgR3ij7iI9cXQR7X4Ss8WQmcs8AZ23S120y8vPOERg4a3wYfrb6gEEK0xGBSR8i8v4eCvDZdC4AG7E75JufG6+RvrRFezo+nqeZB3FYefWrHyi+Cm80LEJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0iNJNjBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DC6C433F1;
	Mon,  8 Apr 2024 13:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581515;
	bh=HPcFGR4aMdEmQFN6n3FNF/nP0uWHSK/T08wheaVE2uQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0iNJNjBL/LF6CC5ot7yDGX+KydLmmZg/QfPCnWknNEE4x1E5sXAM9CbAVX8r7a0IU
	 eHoZ+0Ha+kmoD45zirco7Q1DFG980VWMWqThaHQnzHYc3pcsKJOTTgrKgbibg+0Xsh
	 X461/d1RjV+zHNofEjm6tfPWvI4TjPMoUAby6oPo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Clayton Craft <clayton@craftyguy.net>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.1 029/138] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT"
Date: Mon,  8 Apr 2024 14:57:23 +0200
Message-ID: <20240408125257.133031527@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
References: <20240408125256.218368873@linuxfoundation.org>
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

From: Johan Hovold <johan+linaro@kernel.org>

commit 4790a73ace86f3d165bbedba898e0758e6e1b82d upstream.

This reverts commit 7dcd3e014aa7faeeaf4047190b22d8a19a0db696.

Qualcomm Bluetooth controllers like WCN6855 do not have persistent
storage for the Bluetooth address and must therefore start as
unconfigured to allow the user to set a valid address unless one has
been provided by the boot firmware in the devicetree.

A recent change snuck into v6.8-rc7 and incorrectly started marking the
default (non-unique) address as valid. This specifically also breaks the
Bluetooth setup for some user of the Lenovo ThinkPad X13s.

Note that this is the second time Qualcomm breaks the driver this way
and that this was fixed last year by commit 6945795bc81a ("Bluetooth:
fix use-bdaddr-property quirk"), which also has some further details.

Fixes: 7dcd3e014aa7 ("Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT")
Cc: stable@vger.kernel.org      # 6.8
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reported-by: Clayton Craft <clayton@craftyguy.net>
Tested-by: Clayton Craft <clayton@craftyguy.net>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/hci_qca.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -7,7 +7,6 @@
  *
  *  Copyright (C) 2007 Texas Instruments, Inc.
  *  Copyright (c) 2010, 2012, 2018 The Linux Foundation. All rights reserved.
- *  Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  *
  *  Acknowledgements:
  *  This file is based on hci_ll.c, which was...
@@ -1845,17 +1844,7 @@ retry:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-
-		/* Set BDA quirk bit for reading BDA value from fwnode property
-		 * only if that property exist in DT.
-		 */
-		if (fwnode_property_present(dev_fwnode(hdev->dev.parent), "local-bd-address")) {
-			set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
-			bt_dev_info(hdev, "setting quirk bit to read BDA from fwnode later");
-		} else {
-			bt_dev_dbg(hdev, "local-bd-address` is not present in the devicetree so not setting quirk bit for BDA");
-		}
-
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 		hci_set_aosp_capable(hdev);
 
 		ret = qca_read_soc_version(hdev, &ver, soc_type);



