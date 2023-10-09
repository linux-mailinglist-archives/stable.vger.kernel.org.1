Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED0D7BDFA4
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377095AbjJINcS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377109AbjJINcR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:32:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E02AAB
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:32:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26EEC433C8;
        Mon,  9 Oct 2023 13:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858334;
        bh=AgldSrLe5ULYV04+GjlSJQWk0g3iD2iNG2MREOnGFrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IADgf4tq7vesqnF2SoyhbjKWDD4vRZB7fnJYgZ0aqljqBDOQQe8q0cDUjy7s9rKvl
         0WmHy1MHK424fgN1dSRgfTD/HeO6RlyceZtbDDdZZXkb27rfeW8kXLLsZpppwfufXE
         oLOm66uEkbEwaT8xx9Rx4CohOMlaf+Kd7zL6rQeY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 5.4 090/131] Revert "PCI: qcom: Disable write access to read only registers for IP v2.3.3"
Date:   Mon,  9 Oct 2023 15:02:10 +0200
Message-ID: <20231009130119.127189930@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 35c95eda7b6d9883d1cc9bb1f89d454baa140ebc which is
commit a33d700e8eea76c62120cb3dbf5e01328f18319a upstream.

It was applied to the incorrect function as the original function the
commit changed is not in this kernel branch.

Reported-by: Ben Hutchings <ben@decadent.org.uk>
Link: https://lore.kernel.org/r/f23affddab4d8b3cc07508f2d8735d88d823821d.camel@decadent.org.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -807,8 +807,6 @@ static int qcom_pcie_get_resources_2_4_0
 			return PTR_ERR(res->phy_ahb_reset);
 	}
 
-	dw_pcie_dbi_ro_wr_dis(pci);
-
 	return 0;
 }
 


