Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F98A76AFB2
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbjHAJtx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjHAJtb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:49:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8724D30CD
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DBB4614EC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC8AC433C8;
        Tue,  1 Aug 2023 09:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883307;
        bh=wWYRWzYgxtfjky5wxR0L13puQ3+7Iryqu2Guo4iCHsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lpTLLMJA+ShdMBre7LS20yFABJZ6kBRv7m3L9q1LSX4by0NBuSkFM6xUYAsm9SiOg
         t3FJA+WAZ++3oo21Kb7WOmaJUOC91xkMrRwr1W9IrQFiBcQms+Myz+H4Ld9mrAPxOt
         q43rjY9SQWy7ZvXHGsiCslFuHNJoNmcSLrVr8hhY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kyle Tso <kyletso@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.4 160/239] usb: typec: Iterate pds array when showing the pd list
Date:   Tue,  1 Aug 2023 11:20:24 +0200
Message-ID: <20230801091931.402291432@linuxfoundation.org>
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

From: Kyle Tso <kyletso@google.com>

commit 4b642dc9829507e4afabc03d32a18abbdb192c5e upstream.

The pointers of each usb_power_delivery handles are stored in "pds"
array returned from the pd_get ops but not in the adjacent memory
calculated from "pd". Get the handles from "pds" array directly instead
of deriving them from "pd".

Fixes: a7cff92f0635 ("usb: typec: USB Power Delivery helpers for ports and partners")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Tso <kyletso@google.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20230623151036.3955013-3-kyletso@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/class.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1277,8 +1277,7 @@ static ssize_t select_usb_power_delivery
 {
 	struct typec_port *port = to_typec_port(dev);
 	struct usb_power_delivery **pds;
-	struct usb_power_delivery *pd;
-	int ret = 0;
+	int i, ret = 0;
 
 	if (!port->ops || !port->ops->pd_get)
 		return -EOPNOTSUPP;
@@ -1287,11 +1286,11 @@ static ssize_t select_usb_power_delivery
 	if (!pds)
 		return 0;
 
-	for (pd = pds[0]; pd; pd++) {
-		if (pd == port->pd)
-			ret += sysfs_emit(buf + ret, "[%s] ", dev_name(&pd->dev));
+	for (i = 0; pds[i]; i++) {
+		if (pds[i] == port->pd)
+			ret += sysfs_emit(buf + ret, "[%s] ", dev_name(&pds[i]->dev));
 		else
-			ret += sysfs_emit(buf + ret, "%s ", dev_name(&pd->dev));
+			ret += sysfs_emit(buf + ret, "%s ", dev_name(&pds[i]->dev));
 	}
 
 	buf[ret - 1] = '\n';


