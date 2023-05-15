Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB79703B00
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242573AbjEOR6g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242931AbjEOR6R (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:58:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343FF14912
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:55:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B327E62FDD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A269BC433EF;
        Mon, 15 May 2023 17:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173343;
        bh=IzsWtgIDSILuOzQHynFWukBRVpEtMLKGXm/cLahBJ94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MT2BuNuFUibPhWt9PQROH15TNgddqxnVKMN+LAjUgNjbEM4Ko9Eg7LAOD5mSuo2NE
         vnfeLg0jjn3nzJXuEXiT57ROt7oJxiFTjWO2Nf9fxEwZAaQQGV1FdaTMrF9h0Kz6V0
         ASVYN0M6nimAkwXnrUKtAteQvxTB2OlsgotaJbNg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Matthew Lear <matthew.lear@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sean Young <sean@mess.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 063/282] media: rc: gpio-ir-recv: Fix support for wake-up
Date:   Mon, 15 May 2023 18:27:21 +0200
Message-Id: <20230515161724.130423713@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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
index a20413008c3cb..f50398b3ed5f4 100644
--- a/drivers/media/rc/gpio-ir-recv.c
+++ b/drivers/media/rc/gpio-ir-recv.c
@@ -83,6 +83,8 @@ static int gpio_ir_recv_probe(struct platform_device *pdev)
 		rcdev->map_name = RC_MAP_EMPTY;
 
 	gpio_dev->rcdev = rcdev;
+	if (of_property_read_bool(np, "wakeup-source"))
+		device_init_wakeup(dev, true);
 
 	rc = devm_rc_register_device(dev, rcdev);
 	if (rc < 0) {
-- 
2.39.2



