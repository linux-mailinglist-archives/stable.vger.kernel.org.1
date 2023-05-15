Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B981070395A
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244457AbjEORla (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244490AbjEORlK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:41:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC5B15521
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:38:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E69FF62E0F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43BFC433D2;
        Mon, 15 May 2023 17:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172315;
        bh=z99qIT2lq0WuKPPyuPN9zdkcIcIZlCenqAxLta/hhSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BdSlMKw0g8Cytmsy++9HmTjz0yN3B+QmAkgVsEoixfVs+S9XhsfogeXv62/tjZ0nR
         Rcrt9LZBud5PYmxmxf4an0FXegeHOe7M9eUHeKZMIvXY7EqMp72squHnybMoJ0Kwve
         Evq8Llen4Bcz6NCrAayZ0ojXCtMSoelWKHCKOUd4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Matthew Lear <matthew.lear@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sean Young <sean@mess.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 114/381] media: rc: gpio-ir-recv: Fix support for wake-up
Date:   Mon, 15 May 2023 18:26:05 +0200
Message-Id: <20230515161741.971082405@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 9c592f8ab114875fdb3b2040f01818e53de44991 ]

The driver was intended from the start to be a wake-up source for the
system, however due to the absence of a suitable call to
device_set_wakeup_capable(), the device_may_wakeup() call used to decide
whether to enable the GPIO interrupt as a wake-up source would never
happen. Lookup the DT standard "wakeup-source" property and call
device_init_wakeup() to ensure the device is flagged as being wakeup
capable.

Reported-by: Matthew Lear <matthew.lear@broadcom.com>
Fixes: fd0f6851eb46 ("[media] rc: Add support for GPIO based IR Receiver driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/gpio-ir-recv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/rc/gpio-ir-recv.c b/drivers/media/rc/gpio-ir-recv.c
index a56c844d7f816..16795e07dc103 100644
--- a/drivers/media/rc/gpio-ir-recv.c
+++ b/drivers/media/rc/gpio-ir-recv.c
@@ -107,6 +107,8 @@ static int gpio_ir_recv_probe(struct platform_device *pdev)
 		rcdev->map_name = RC_MAP_EMPTY;
 
 	gpio_dev->rcdev = rcdev;
+	if (of_property_read_bool(np, "wakeup-source"))
+		device_init_wakeup(dev, true);
 
 	rc = devm_rc_register_device(dev, rcdev);
 	if (rc < 0) {
-- 
2.39.2



