Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6706FAB96
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbjEHLPH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbjEHLPG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:15:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3E236574
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:15:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 728C862BBD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC02C433D2;
        Mon,  8 May 2023 11:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544503;
        bh=HEJjA6ByPB3z7YcJMR6szPccgJQ9178/Rx2Z0VCIP90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QfZnkelEDL4q++xixvMjN3/DX5KRSsjxdiZLYOEQAPlVB8l1HO57YULOg+hM5BlAa
         dbEyYAeH0yb1eFhZR2cvkdmDJcIsgFHxMMuuLP6IIktneC30ik5Th5u9lRZVp1sP4Z
         5V5ZHWYFcXjAR/HSYVxPh1rtnwSutv6v1eaUNvYc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Deren Wu <deren.wu@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 431/694] wifi: mt76: remove redundent MCU_UNI_CMD_* definitions
Date:   Mon,  8 May 2023 11:44:26 +0200
Message-Id: <20230508094447.355466247@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

[ Upstream commit 532f0482fc577a78c0086893ab39acb406ac3e65 ]

clear redundent definitions only

Fixes: 5b55b6da982c ("wifi: mt76: mt7921: add unified ROC cmd/event support")
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index a5e6ee4daf92e..40a99e0caded8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -967,9 +967,6 @@ enum {
 	DEV_INFO_MAX_NUM
 };
 
-#define MCU_UNI_CMD_EVENT                       BIT(1)
-#define MCU_UNI_CMD_UNSOLICITED_EVENT           BIT(2)
-
 /* event table */
 enum {
 	MCU_EVENT_TARGET_ADDRESS_LEN = 0x01,
-- 
2.39.2



