Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6FB79B559
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbjIKWWv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239659AbjIKOZo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:25:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377EFDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:25:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFA3C433C8;
        Mon, 11 Sep 2023 14:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442339;
        bh=61D1kthUek0IR9XnPkew+uROd+QNdjlkoqdNRbO3uS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KgDwPqilJn3nCqwuVbCDWXEPt9FKdfMapKNARR6idGjtTy/HPJBCVTRHHvFXZBN47
         iNqg0//7DVHKVKGQ9KqA7G8uX1j2mJcmL/UPQZt9CSrllIWrXRqLpA2OU1Z+iW4zY3
         HxGg0jwU+6oVV34m+CkWSyCdlFHVzD1ylKBam86w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.5 702/739] r8169: fix ASPM-related issues on a number of systems with NIC version from RTL8168h
Date:   Mon, 11 Sep 2023 15:48:21 +0200
Message-ID: <20230911134710.696285694@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

commit 90ca51e8c654699b672ba61aeaa418dfb3252e5e upstream.

This effectively reverts 4b5f82f6aaef. On a number of systems ASPM L1
causes tx timeouts with RTL8168h, see referenced bug report.

Fixes: 4b5f82f6aaef ("r8169: enable ASPM L1/L1.1 from RTL8168h")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217814
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169_main.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5239,13 +5239,9 @@ static int rtl_init_one(struct pci_dev *
 
 	/* Disable ASPM L1 as that cause random device stop working
 	 * problems as well as full system hangs for some PCIe devices users.
-	 * Chips from RTL8168h partially have issues with L1.2, but seem
-	 * to work fine with L1 and L1.1.
 	 */
 	if (rtl_aspm_is_safe(tp))
 		rc = 0;
-	else if (tp->mac_version >= RTL_GIGA_MAC_VER_46)
-		rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
 	else
 		rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1);
 	tp->aspm_manageable = !rc;


