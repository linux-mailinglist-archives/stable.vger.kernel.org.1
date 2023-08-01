Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AFA76AE96
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjHAJkJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjHAJjt (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:39:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30FF4EFD
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:37:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DB67614DF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAC3C433C8;
        Tue,  1 Aug 2023 09:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882638;
        bh=sIYRJS1mNNj24vGts/+bpU0Q01P3Yxexgz54GoAV+Qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ouYYcOv87QEqA9BLrE3OJMBYJ3izv5407xD/HBTrZdtq11eXQiT6sxrDFXjSD7gWz
         DfQIBJ4XamzTjT/b2/jRjY6AtIOsHfgHiNwOyVe8PHWyL/bWLHDtDivJSmCSqckwuO
         5Uv5oWhiSL5Igz3S6QgGI0LasVeDn+KQ4ZNKWnJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 6.1 149/228] usb: gadget: core: remove unbalanced mutex_unlock in usb_gadget_activate
Date:   Tue,  1 Aug 2023 11:20:07 +0200
Message-ID: <20230801091928.281758481@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
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

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

commit 6237390644fb92b81f5262877fe545d0d2c7b5d7 upstream.

Commit 286d9975a838 ("usb: gadget: udc: core: Prevent soft_connect_store() race")
introduced one extra mutex_unlock of connect_lock in the usb_gadget_active function.

Fixes: 286d9975a838 ("usb: gadget: udc: core: Prevent soft_connect_store() race")
Cc: stable <stable@kernel.org>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20230721222256.1743645-1-m.grzeschik@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/core.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -851,7 +851,6 @@ int usb_gadget_activate(struct usb_gadge
 	 */
 	if (gadget->connected)
 		ret = usb_gadget_connect_locked(gadget);
-	mutex_unlock(&gadget->udc->connect_lock);
 
 unlock:
 	mutex_unlock(&gadget->udc->connect_lock);


