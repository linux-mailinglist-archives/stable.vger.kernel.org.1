Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22347B8A76
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244419AbjJDSfp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244428AbjJDSfo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:35:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07647A6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:35:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A29C433C7;
        Wed,  4 Oct 2023 18:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444540;
        bh=pXrIHvEMJ8ovsyyoMwAzTAfHfJVw/FP4egT1nmcqZdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nw8hcZFz0uaNCqQhd69e3OLAokH5z8U4LQLsEkVM0b63zrd7SNiEVKtvtJOMb9zJf
         vXwwz678uwpUWQIqeRWilDAAF3YZEIh7qMj1p6O8Ah+DtwtJOzoYs64DhcVDXssVte
         l/U0XZlOrWoPTn81ZTl+PcNQ9aOG5YHztYZD/IKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 6.5 287/321] cxl/pci: Fix appropriate checking for _OSC while handling CXL RAS registers
Date:   Wed,  4 Oct 2023 19:57:12 +0200
Message-ID: <20231004175242.566252356@linuxfoundation.org>
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

From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

commit 0339dc39a521ead3dbcf101acd8c028c61db57dc upstream.

cxl_pci fails to unmask CXL protocol errors when CXL memory error reporting
is not granted native control. Given that CXL memory error reporting uses
the event interface and protocol errors use AER, unmask protocol errors
based only on the native AER setting. Without this change end user
deployments will fail to report protocol errors in the case where native
memory error handling is not granted to Linux.

Also, return zero instead of an error code to not block the communication
with the cxl device when in native memory error reporting mode.

Fixes: 248529edc86f ("cxl: add RAS status unmasking for CXL")
Cc: <stable@vger.kernel.org>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/20230823234305.27333-2-Smita.KoralahalliChannabasappa@amd.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cxl/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 1cb1494c28fe..2323169b6e5f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -541,9 +541,9 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 		return 0;
 	}
 
-	/* BIOS has CXL error control */
-	if (!host_bridge->native_cxl_error)
-		return -ENXIO;
+	/* BIOS has PCIe AER error control */
+	if (!host_bridge->native_aer)
+		return 0;
 
 	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
 	if (rc)
-- 
2.42.0



