Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B2376AF9A
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjHAJtN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjHAJsz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:48:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC022128
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:47:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DCBC614EC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E880C433C8;
        Tue,  1 Aug 2023 09:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883248;
        bh=kxfpY6qDGIo4B7YcmvoMoD87rCQNclqR231SwAZFGLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SE4wC1O8w8lPHCxlaSAPrUt9NGkmnBSsdt6buwUPhe9LRt/0D5uPgdJ1a4yiKubzf
         J4NupTXJHo8U1cAWyV2ocIfgnkHD+U3rFITGHqMddFVccJ8cRereqZK3vd15zpM/sa
         AbVfsFOs8vXnQfqEzfOXjNdHMlFB3HbqdUyDdJv4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Zubin Mithra <zsm@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 6.4 169/239] usb: xhci-mtk: set the dma max_seg_size
Date:   Tue,  1 Aug 2023 11:20:33 +0200
Message-ID: <20230801091931.733646688@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ricardo Ribalda <ribalda@chromium.org>

commit 9fd10829a9eb482e192a845675ecc5480e0bfa10 upstream.

Allow devices to have dma operations beyond 64K, and avoid warnings such
as:

DMA-API: xhci-mtk 11200000.usb: mapping sg segment longer than device claims to support [len=98304] [max=65536]

Fixes: 0cbd4b34cda9 ("xhci: mediatek: support MTK xHCI host controller")
Cc: stable <stable@kernel.org>
Tested-by: Zubin Mithra <zsm@chromium.org>
Reported-by: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Link: https://lore.kernel.org/r/20230628-mtk-usb-v2-1-c8c34eb9f229@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-mtk.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -592,6 +592,7 @@ static int xhci_mtk_probe(struct platfor
 	}
 
 	device_init_wakeup(dev, true);
+	dma_set_max_seg_size(dev, UINT_MAX);
 
 	xhci = hcd_to_xhci(hcd);
 	xhci->main_hcd = hcd;


