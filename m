Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7544E70C904
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbjEVToO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjEVToM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:44:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCE7CF
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:44:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33325621A1
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F2CC433EF;
        Mon, 22 May 2023 19:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784650;
        bh=DJugA/gi0HDfnlA98AYwhyAVdhZMFQgHuFck+8tKJ40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WKwcpjZmqNSdL3KIKNXIpWIXOE0ZzVRmbdqroh300WiUbTpMCXgI76+Z8pyXNbkai
         nPYwgCpF1z3cX1a/Ko7TsSLi4hYTmhwt3ijhbdr8qSRhfpyqkRUDU+hiowH+6TqYLw
         S6AlPlCf6GUf5sfactcAmKAfFWbr3LsMAcAHVQjc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 151/364] spi: intel-pci: Add support for Meteor Lake-S SPI serial flash
Date:   Mon, 22 May 2023 20:07:36 +0100
Message-Id: <20230522190416.530096545@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit c2912d42e86e494935722669e4d9eade69649072 ]

Intel Meteor Lake-S has the same SPI serial flash controller as Meteor
Lake-P. Add Meteor Lake-S PCI ID to the driver list of supported
devices.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://lore.kernel.org/r/20230331052812.39983-1-mika.westerberg@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-intel-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index 4d69e320d0185..a7381e774b953 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -83,6 +83,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa2a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xae23), (unsigned long)&cnl_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, intel_spi_pci_ids);
-- 
2.39.2



