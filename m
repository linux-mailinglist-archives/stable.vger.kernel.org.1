Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4787BE1B8
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377532AbjJINxX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377521AbjJINxX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:53:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6783C91
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:53:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0C9C433C9;
        Mon,  9 Oct 2023 13:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859602;
        bh=Eld1f+wXYRYkCJfhmaeyyQ5D963XGgnLkjA4IuJQoyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iG54fYZB/mehc2CktaxH2A2f3v5CnVuZIXnas5AjCf7EdKOBGGYS+FKW2egBHi8Rq
         LTjPbd/E2riaqsr9nD/85QiD3x/SaeoBBfBnSKZfI+M5M+tSwm4mKBLBnXLfsSsndZ
         Tx3hqd/u4Fg5ednaMpVQa9RzONxvuxxSeDaXfqnY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.19 65/91] Revert "PCI: qcom: Disable write access to read only registers for IP v2.3.3"
Date:   Mon,  9 Oct 2023 15:06:37 +0200
Message-ID: <20231009130113.754883469@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.518916887@linuxfoundation.org>
References: <20231009130111.518916887@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 3a4ecf4c9d793d0ecd07fc49cd76a2e24652d3b7 which is
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
@@ -758,8 +758,6 @@ static int qcom_pcie_get_resources_2_4_0
 	if (IS_ERR(res->phy_ahb_reset))
 		return PTR_ERR(res->phy_ahb_reset);
 
-	dw_pcie_dbi_ro_wr_dis(pci);
-
 	return 0;
 }
 


