Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC3376AFB3
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjHAJtx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbjHAJtc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:49:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A6D30CB
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:48:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDE0C614EC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5937C433C8;
        Tue,  1 Aug 2023 09:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883310;
        bh=6nDTA5dSPRFhD+LRx17yxe+1axQfS9QwS/DF8h6+PUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+vsi7MVtukeHzXB+r4MIREViwIum0BXSyPQgLJnoEmn6KyaPNFWSWG3JstX9z8rn
         wUzCtg0mmjcbxn4RIKtYnc2Dp9HcLGjASYPCljqrxqMsU6jMZsrO9eZuAyD1mVccz6
         nhJvCDlY6n+fSzNKzkFSCwuhXi7cjRJAqRJj0m8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kyle Tso <kyletso@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.4 161/239] usb: typec: Use sysfs_emit_at when concatenating the string
Date:   Tue,  1 Aug 2023 11:20:25 +0200
Message-ID: <20230801091931.432511949@linuxfoundation.org>
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

commit 609fded3f91972ada551c141c5d04a71704f8967 upstream.

The buffer address used in sysfs_emit should be aligned to PAGE_SIZE.
Use sysfs_emit_at instead to offset the buffer.

Fixes: a7cff92f0635 ("usb: typec: USB Power Delivery helpers for ports and partners")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Tso <kyletso@google.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20230623151036.3955013-4-kyletso@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/class.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1288,9 +1288,9 @@ static ssize_t select_usb_power_delivery
 
 	for (i = 0; pds[i]; i++) {
 		if (pds[i] == port->pd)
-			ret += sysfs_emit(buf + ret, "[%s] ", dev_name(&pds[i]->dev));
+			ret += sysfs_emit_at(buf, ret, "[%s] ", dev_name(&pds[i]->dev));
 		else
-			ret += sysfs_emit(buf + ret, "%s ", dev_name(&pds[i]->dev));
+			ret += sysfs_emit_at(buf, ret, "%s ", dev_name(&pds[i]->dev));
 	}
 
 	buf[ret - 1] = '\n';


