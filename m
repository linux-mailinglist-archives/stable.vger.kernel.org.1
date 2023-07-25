Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2839761509
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbjGYLY6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbjGYLY6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:24:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE549D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:24:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52FE4615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62039C433C8;
        Tue, 25 Jul 2023 11:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284296;
        bh=01jCrS5B+z6Nw4qJZ5yxfHzFJ9JmhhnKwbAGUAnjkPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=exVN0x/uY3oj40/wijBUTzGwVn04uNU5BzsZCUjt3I9PxYKiLg2SXcLPT+QvumFfM
         QrMsIp5MpdO9VICxH0WYZnVW97jJgELOmGyiL36Bo5zMch8CvhmxwZ4/JWs6Mq4KlE
         PffMqQ4caBzWV3rDeKSqfTXwgL2wmnFPijZ7rhgk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Lee Jones <lee@kernel.org>
Subject: [PATCH 5.10 305/509] leds: trigger: netdev: Recheck NETDEV_LED_MODE_LINKUP on dev rename
Date:   Tue, 25 Jul 2023 12:44:04 +0200
Message-ID: <20230725104607.707753777@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christian Marangi <ansuelsmth@gmail.com>

commit cee4bd16c3195a701be683f7da9e88c6e11acb73 upstream.

Dev can be renamed also while up for supported device. We currently
wrongly clear the NETDEV_LED_MODE_LINKUP flag on NETDEV_CHANGENAME
event.

Fix this by rechecking if the carrier is ok on NETDEV_CHANGENAME and
correctly set the NETDEV_LED_MODE_LINKUP bit.

Fixes: 5f820ed52371 ("leds: trigger: netdev: fix handling on interface rename")
Cc: stable@vger.kernel.org # v5.5+
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20230419210743.3594-2-ansuelsmth@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/leds/trigger/ledtrig-netdev.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -318,6 +318,9 @@ static int netdev_trig_notify(struct not
 	clear_bit(NETDEV_LED_MODE_LINKUP, &trigger_data->mode);
 	switch (evt) {
 	case NETDEV_CHANGENAME:
+		if (netif_carrier_ok(dev))
+			set_bit(NETDEV_LED_MODE_LINKUP, &trigger_data->mode);
+		fallthrough;
 	case NETDEV_REGISTER:
 		if (trigger_data->net_dev)
 			dev_put(trigger_data->net_dev);


