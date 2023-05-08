Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBE56FAE20
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbjEHLll (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbjEHLlU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:41:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DDA411A4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:40:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0D9C63579
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D6FC4339C;
        Mon,  8 May 2023 11:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546048;
        bh=RJTPGN6oEi6Yos+3WycusWIvGhfbzMyFii435hEou30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0G/7XRt2EP507ftbGz6qGxcpUTYaWtHPI/6rQihU0G9NjW5CwEmpGoNX7dK9Xg+1X
         HJlxys/+HKL5BDsWipn0WQJnFe8aLlgIQG+BzkFkg5ByDBIfcD3THo0j2frV/mlbQe
         2pTUvx7mmpx1xnv9JbsWQKmMWVsQPiSlgh+Vgm74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 240/371] usb: host: xhci-rcar: remove leftover quirk handling
Date:   Mon,  8 May 2023 11:47:21 +0200
Message-Id: <20230508094821.597458564@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 5d67f4861884762ebc2bddb5d667444e45f25782 ]

Loading V3 firmware does not need a quirk anymore, remove the leftover
code.

Fixes: ed8603e11124 ("usb: host: xhci-rcar: Simplify getting the firmware name for R-Car Gen3")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20230307163041.3815-10-wsa+renesas@sang-engineering.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-rcar.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index 9888ba7d85b6a..cfafa1c50adea 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -75,7 +75,6 @@ MODULE_FIRMWARE(XHCI_RCAR_FIRMWARE_NAME_V3);
 
 /* For soc_device_attribute */
 #define RCAR_XHCI_FIRMWARE_V2   BIT(0) /* FIRMWARE V2 */
-#define RCAR_XHCI_FIRMWARE_V3   BIT(1) /* FIRMWARE V3 */
 
 static const struct soc_device_attribute rcar_quirks_match[]  = {
 	{
@@ -147,8 +146,6 @@ static int xhci_rcar_download_firmware(struct usb_hcd *hcd)
 
 	if (quirks & RCAR_XHCI_FIRMWARE_V2)
 		firmware_name = XHCI_RCAR_FIRMWARE_NAME_V2;
-	else if (quirks & RCAR_XHCI_FIRMWARE_V3)
-		firmware_name = XHCI_RCAR_FIRMWARE_NAME_V3;
 	else
 		firmware_name = priv->firmware_name;
 
-- 
2.39.2



