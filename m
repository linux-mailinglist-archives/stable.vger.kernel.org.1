Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBB0775C26
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbjHILYY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjHILYX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:24:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3B119A1
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:24:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8F266323C
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064FCC433C7;
        Wed,  9 Aug 2023 11:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580262;
        bh=Y530gCH9zJpjayNRflKYQVufNppUQO/VjFyHYGZssF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dsdEQPYPuO6+06YkuzwppwnQLWBLSoUZF1qO1mGhLLuGouXN8q/uvGisnze0oeY0e
         8+O7LTssHXHbvPifMjzxf1C2NZ2GHUnnBL2rORJqwLUnZaV+sIZLywZYZY5xuGwczK
         lJ55opPq9hrLnih1HDQH6DGHpdcW0zjisCDuWl38=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Zubin Mithra <zsm@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 4.19 268/323] usb: xhci-mtk: set the dma max_seg_size
Date:   Wed,  9 Aug 2023 12:41:46 +0200
Message-ID: <20230809103710.322990860@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
@@ -538,6 +538,7 @@ static int xhci_mtk_probe(struct platfor
 	}
 
 	device_init_wakeup(dev, true);
+	dma_set_max_seg_size(dev, UINT_MAX);
 
 	xhci = hcd_to_xhci(hcd);
 	xhci->main_hcd = hcd;


