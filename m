Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28D870C9E5
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbjEVTw6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbjEVTwq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:52:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEE9A9
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:52:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3252262B38
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC7DC433EF;
        Mon, 22 May 2023 19:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785164;
        bh=QLWCniFPzTo65y/n7dqj3Cb4Sj5kGNmT0mbAznCMCQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wITZH8hDqXLgDsgkOD3d7eiyamWDEjsdEuobqRel0SmusIGO08MQvSU2DYrBsC6ux
         i3WCsRchaBp3cKWlJnoCT6zFgEmKRaCsqr6U6vN1roP8jEzZaElq5WMN0JQEhqguw1
         k2VuX4qKmE6Mrrq20TeSeHLRe7Si0omtsnvUalBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jimmy Assarsson <extja@kvaser.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.3 313/364] can: kvaser_pciefd: Clear listen-only bit if not explicitly requested
Date:   Mon, 22 May 2023 20:10:18 +0100
Message-Id: <20230522190420.599212758@linuxfoundation.org>
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

From: Jimmy Assarsson <extja@kvaser.com>

commit bf7ac55e991ca177f1ac16be51152f1ef291a4df upstream.

The listen-only bit was never cleared, causing the controller to
always use listen-only mode, if previously set.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Cc: stable@vger.kernel.org
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://lore.kernel.org/r/20230516134318.104279-3-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/kvaser_pciefd.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -559,6 +559,8 @@ static void kvaser_pciefd_setup_controll
 
 	if (can->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
 		mode |= KVASER_PCIEFD_KCAN_MODE_LOM;
+	else
+		mode &= ~KVASER_PCIEFD_KCAN_MODE_LOM;
 
 	mode |= KVASER_PCIEFD_KCAN_MODE_EEN;
 	mode |= KVASER_PCIEFD_KCAN_MODE_EPEN;


