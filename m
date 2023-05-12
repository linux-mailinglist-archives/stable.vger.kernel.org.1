Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B1F7008E5
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 15:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240587AbjELNPn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 09:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241074AbjELNPm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 09:15:42 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4B514E42;
        Fri, 12 May 2023 06:15:01 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 172AC20690;
        Fri, 12 May 2023 15:14:42 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, stable@vger.kernel.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Subject: [PATCH v1 0/2] usb: gadget: udc: core: fix hang during configuration
Date:   Fri, 12 May 2023 15:14:33 +0200
Message-Id: <20230512131435.205464-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

These revert 2 patches that cause a regression introduced in v6.4-rc1 and that
were back-ported to stable/LTS kernels.

The regression is that the USB gadget configuration hangs forever.

Link: https://lore.kernel.org/all/ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com/

Francesco Dolcini (2):
  Revert "usb: gadget: udc: core: Prevent redundant calls to pullup"
  Revert "usb: gadget: udc: core: Invoke usb_gadget_connect only when
    started"

 drivers/usb/gadget/udc/core.c | 151 ++++++++++------------------------
 1 file changed, 44 insertions(+), 107 deletions(-)

-- 
2.25.1

