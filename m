Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7D070C9BF
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjEVTvj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbjEVTv2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:51:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128A410E6
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:51:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33A0D62B11
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD1EC4339C;
        Mon, 22 May 2023 19:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785067;
        bh=0s7OeVPXxbWU+cnOOgxV/yP6r4GLDt0CrqSWoWTdM/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=01AX2tfTwM3bt/z1ZhqXpNMaOG12jgbkE7KNvARJ5E3yY0jf8pIwjAfX+mQjLb+eB
         RlLVdHWcKMl+k9netW2awgwqQ72gpzESn9lZvbGRABCbYYLx0QvTQYsXADoFVlP1Wn
         ONqGX+d8BNgbO4ez5SQU36vdwLCl4EbjUO/jdxU4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephan Gerhold <stephan@gerhold.net>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 6.3 297/364] Revert "usb: gadget: udc: core: Prevent redundant calls to pullup"
Date:   Mon, 22 May 2023 20:10:02 +0100
Message-Id: <20230522190420.197254441@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

commit 5e1617210aede9f1b91bb9819c93097b6da481f9 upstream.

This reverts commit a3afbf5cc887fc3401f012fe629810998ed61859.

This depends on commit 0db213ea8eed ("usb: gadget: udc: core: Invoke
usb_gadget_connect only when started") that introduces a regression,
revert it till the issue is fixed.

Cc: stable@vger.kernel.org
Reported-by: Stephan Gerhold <stephan@gerhold.net>
Reported-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Link: https://lore.kernel.org/all/ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com/
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Link: https://lore.kernel.org/r/20230512131435.205464-2-francesco@dolcini.it
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/core.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -676,9 +676,6 @@ static int usb_gadget_connect_locked(str
 		goto out;
 	}
 
-	if (gadget->connected)
-		goto out;
-
 	if (gadget->deactivated || !gadget->udc->started) {
 		/*
 		 * If gadget is deactivated we only save new state.


