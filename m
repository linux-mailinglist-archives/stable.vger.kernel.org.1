Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6B5775C99
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjHIL3B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjHIL3A (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:29:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066E610D4
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:29:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 904A063304
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E8BC433C8;
        Wed,  9 Aug 2023 11:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580539;
        bh=tTxCWegzfyMd49qUmnIJdIIE/aw1dK+tlXQPmddkrAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=afiAcGEmix9O2SGxDngolsO3XjFpqknfk5Trwp4ql2MyC1fGU2ADVivhBK8SFIDYn
         tt1GIyD72nwvAcuPCNPDQSI/dtVCOwUovRK5r/KKSvpwOb6eSdQhHlKczPNd5OXg4d
         nD2VJnGoQ8/FFZiq+FrogxOCi93xwHhpUeuYFSyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.4 061/154] can: gs_usb: gs_can_close(): add missing set of CAN state to CAN_STATE_STOPPED
Date:   Wed,  9 Aug 2023 12:41:32 +0200
Message-ID: <20230809103639.023470761@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
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

From: Marc Kleine-Budde <mkl@pengutronix.de>

commit f8a2da6ec2417cca169fa85a8ab15817bccbb109 upstream.

After an initial link up the CAN device is in ERROR-ACTIVE mode. Due
to a missing CAN_STATE_STOPPED in gs_can_close() it doesn't change to
STOPPED after a link down:

| ip link set dev can0 up
| ip link set dev can0 down
| ip --details link show can0
| 13: can0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 10
|     link/can  promiscuity 0 allmulti 0 minmtu 0 maxmtu 0
|     can state ERROR-ACTIVE restart-ms 1000

Add missing assignment of CAN_STATE_STOPPED in gs_can_close().

Cc: stable@vger.kernel.org
Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Link: https://lore.kernel.org/all/20230718-gs_usb-fix-can-state-v1-1-f19738ae2c23@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/gs_usb.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -732,6 +732,8 @@ static int gs_can_close(struct net_devic
 	usb_kill_anchored_urbs(&dev->tx_submitted);
 	atomic_set(&dev->active_tx_urbs, 0);
 
+	dev->can.state = CAN_STATE_STOPPED;
+
 	/* reset the device */
 	rc = gs_cmd_reset(dev);
 	if (rc < 0)


