Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A5276AD4D
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjHAJ2T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbjHAJ1n (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:27:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B7BCF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 470EC614EC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568DCC433C8;
        Tue,  1 Aug 2023 09:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881992;
        bh=VT/91pgKjNCt/BsoG3IcvlM8apZHOO/cvtmaGhHIg+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1C08aXojS9Y2GycXu0cDBq/u+rawHBuQ74JHgMPDVA7iICqUK3YfToO4/BKxBJowp
         sYvyWiqKuVDdVZeA9cU0l18fClRC2xqYNVHW0a7kdNC5jVxxP88Uk8xrjBqmoCHqkd
         NNtp5Fn5eILuxLozGAWTZ5/ch9JFp607nByhIkII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 5.15 102/155] usb: gadget: call usb_gadget_check_config() to verify UDC capability
Date:   Tue,  1 Aug 2023 11:20:14 +0200
Message-ID: <20230801091913.871481175@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
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

From: Frank Li <Frank.Li@nxp.com>

commit f4fc01af5b640bc39bd9403b5fd855345a2ad5f8 upstream.

The legacy gadget driver omitted calling usb_gadget_check_config()
to ensure that the USB device controller (UDC) has adequate resources,
including sufficient endpoint numbers and types, to support the given
configuration.

Previously, usb_add_config() was solely invoked by the legacy gadget
driver. Adds the necessary usb_gadget_check_config() after the bind()
operation to fix the issue.

Fixes: dce49449e04f ("usb: cdns3: allocate TX FIFO size according to composite EP number")
Cc: stable <stable@kernel.org>
Reported-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20230707230015.494999-1-Frank.Li@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/composite.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1033,6 +1033,10 @@ int usb_add_config(struct usb_composite_
 		goto done;
 
 	status = bind(config);
+
+	if (status == 0)
+		status = usb_gadget_check_config(cdev->gadget);
+
 	if (status < 0) {
 		while (!list_empty(&config->functions)) {
 			struct usb_function		*f;


