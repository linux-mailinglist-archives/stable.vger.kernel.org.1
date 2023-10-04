Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909817B8A14
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244348AbjJDScD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244353AbjJDScD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:32:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBE7C4
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:31:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FAFC433C7;
        Wed,  4 Oct 2023 18:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444318;
        bh=2ikV3NqGAJKxG5Y2XDYjPaD4fvRwSBWGgrAF76XcE8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QDn+NwmI+6Ao3ZBon/6/ZAr8cNHEcn5f/CfdJCIZCVuEjM/qwY6UMkt0yOgYQEbxz
         8bMsEKSSKYyzfFaaHXeZQJ7quIFyqcDRC+8XjWNx6lAs8x6pIjqcbFGwYfQ+IZeLkI
         V0lhzT5qwk2w4DalfcwWBo0HETCYR+Z0g7GkR61c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 207/321] spi: intel-pci: Add support for Granite Rapids SPI serial flash
Date:   Wed,  4 Oct 2023 19:55:52 +0200
Message-ID: <20231004175238.833033668@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 9855d60cfc720ff32355484c119acafd3c4dc806 ]

Intel Granite Rapids has a flash controller that is compatible with the
other Cannon Lake derivatives. Add Granite Rapids PCI ID to the driver
list of supported devices.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://lore.kernel.org/r/20230911074616.3473347-1-mika.westerberg@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-intel-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index a7381e774b953..57d767a68e7b2 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -72,6 +72,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x4da4), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x51a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x54a4), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x5794), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7a24), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7aa4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7e23), (unsigned long)&cnl_info },
-- 
2.40.1



