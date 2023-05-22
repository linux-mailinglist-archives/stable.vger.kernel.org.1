Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3EB70C6C2
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjEVTWI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbjEVTWI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:22:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98049A9
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:22:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 347BC62842
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4454EC433D2;
        Mon, 22 May 2023 19:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783326;
        bh=SziM+m8/qxWT77h6bP7BQ9YWaCksXg1puRGW77keGcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qD7XuB4dsh7EuQKErnA0i2C6SvK9xKFhiX5qgJwp1FBcEJWDbTek238jCZa4G5YjP
         Xurpg1nss5Dal1XB8P/nvZFMy7BTkspX/yasC0U07E5rFQwHFH2OfzUrwCe69gtl+U
         N8qhJorghPdmW2U6v5f/jX6zgGuPQ1j2xdB6TUEc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jimmy Assarsson <extja@kvaser.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.15 177/203] can: kvaser_pciefd: Set CAN_STATE_STOPPED in kvaser_pciefd_stop()
Date:   Mon, 22 May 2023 20:10:01 +0100
Message-Id: <20230522190359.900387367@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
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


