Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BC3791D34
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348941AbjIDSgR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243664AbjIDSgP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:36:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1B1CD4
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:36:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D549BB80EF4
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A847C433C8;
        Mon,  4 Sep 2023 18:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852566;
        bh=LshZ4vWiOpypdIcF0TZc1apHldQrTHKDmzgAyOUIxhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JA+KymiIsIDMiV9QQgjJxNS7XtkenNs++Z0AiBQ0ft2t+e23KJLkqd1J/v0K5VTQs
         yCebbnJaz/4/8uS+bSzFvzlXpslf3EGrZh3OSouf8vMrvrdagaenEpfkUV51WyhZl2
         eKGHyXFurL45KRVaoZwrFwWsUh4btK4YUZiTZ4e4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 5.15 06/28] net: enetc: use EXPORT_SYMBOL_GPL for enetc_phc_index
Date:   Mon,  4 Sep 2023 19:30:37 +0100
Message-ID: <20230904182945.483354410@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182945.178705038@linuxfoundation.org>
References: <20230904182945.178705038@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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


