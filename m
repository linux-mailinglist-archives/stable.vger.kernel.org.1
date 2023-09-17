Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4327A3751
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjIQTRv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjIQTRY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:17:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B395BFA
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:17:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8292C433C8;
        Sun, 17 Sep 2023 19:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978239;
        bh=aCvsjbYM2sHMfDK7EX5yg7+GC4Wg28nf+2zfPLZ0qPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OegvBPm2AoisU+WDfCmOjQ7b9RbKR+u8FmMWODN2uUfGOzIix8i2IYICRi6wcdZRD
         DvXDPkAwT/OFBJ7JTDZehuA/6qofstAYltzjoR7oGQkD4exJpskECf9ydKdFD2noKv
         mA0qWBmp5ptAN8Gs2muliP8tP3/Ehonxxkbg9AtY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 5.10 004/406] net: enetc: use EXPORT_SYMBOL_GPL for enetc_phc_index
Date:   Sun, 17 Sep 2023 21:07:38 +0200
Message-ID: <20230917191101.193676050@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

commit 569820befb16ffc755ab7af71f4f08cc5f68f0fe upstream.

enetc_phc_index is only used via symbol_get, which was only ever
intended for very internal symbols like this one.  Use EXPORT_SYMBOL_GPL
for it so that symbol_get can enforce only being used on
EXPORT_SYMBOL_GPL symbols.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/enetc/enetc_ptp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
@@ -8,7 +8,7 @@
 #include "enetc.h"
 
 int enetc_phc_index = -1;
-EXPORT_SYMBOL(enetc_phc_index);
+EXPORT_SYMBOL_GPL(enetc_phc_index);
 
 static struct ptp_clock_info enetc_ptp_caps = {
 	.owner		= THIS_MODULE,


