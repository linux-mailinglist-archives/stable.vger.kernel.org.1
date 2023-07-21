Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A099E75D3B5
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjGUTNo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjGUTNn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:13:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DAA30E4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:13:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E78261D02
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB4FC433C8;
        Fri, 21 Jul 2023 19:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966821;
        bh=4OOsQUp3bPzcAklVGfXwhL/65/jhre1NfMusWXH1HiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aB2yX2IcjU4xnLzylXX0ioevN67ewplkhvf4vDpW9k4W1EXWNhICbI1aexSuxNF+u
         HCB/dj1sWbe8Co9JyKts0n/2ef1QoBkhXCGwNEZBig9PRg6aS5Y8pvWPyLJF01LkE0
         /hJlMEF9iQ9HDbsv6AnPkbClCHhDJDsvjSPRn36Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH 5.15 480/532] PCI: rockchip: Set address alignment for endpoint mode
Date:   Fri, 21 Jul 2023 18:06:24 +0200
Message-ID: <20230721160640.544264046@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Damien Le Moal <dlemoal@kernel.org>

commit 7e6689b34a815bd379dfdbe9855d36f395ef056c upstream.

The address translation unit of the rockchip EP controller does not use
the lower 8 bits of a PCIe-space address to map local memory. Thus we
must set the align feature field to 256 to let the user know about this
constraint.

Link: https://lore.kernel.org/r/20230418074700.1083505-12-rick.wertenbroek@gmail.com
Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -485,6 +485,7 @@ static const struct pci_epc_features roc
 	.linkup_notifier = false,
 	.msi_capable = true,
 	.msix_capable = false,
+	.align = 256,
 };
 
 static const struct pci_epc_features*


