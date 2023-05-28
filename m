Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9974713F56
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjE1ToX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjE1ToW (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:44:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E2FA3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:44:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93EE461195
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B278CC433EF;
        Sun, 28 May 2023 19:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303060;
        bh=SziM+m8/qxWT77h6bP7BQ9YWaCksXg1puRGW77keGcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JyQmzsbEmH6+nvAnI53jni0yDuGnGFrsIxO0KvrwFUzgrOoj+9wd8HQrgiREkx08/
         NjMqJ5zkurAWA+x09H4kEWldqJdsL929owzoqrEL23cN6QiAQDhswj1410u+aDNv+Z
         OINOxKScsaieUGu2865ArZe1v39FnvuaVgqvFJTg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jimmy Assarsson <extja@kvaser.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.10 137/211] can: kvaser_pciefd: Set CAN_STATE_STOPPED in kvaser_pciefd_stop()
Date:   Sun, 28 May 2023 20:10:58 +0100
Message-Id: <20230528190846.927058907@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

commit aed0e6ca7dbb8fbea9bc69c9ac663d5533c8c5d8 upstream.

Set can.state to CAN_STATE_STOPPED in kvaser_pciefd_stop().
Without this fix, wrong CAN state was repported after the interface was
brought down.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Cc: stable@vger.kernel.org
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://lore.kernel.org/r/20230516134318.104279-2-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/kvaser_pciefd.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -721,6 +721,7 @@ static int kvaser_pciefd_stop(struct net
 		iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 		del_timer(&can->bec_poll_timer);
 	}
+	can->can.state = CAN_STATE_STOPPED;
 	close_candev(netdev);
 
 	return ret;


