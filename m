Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D77D726B34
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjFGUXr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjFGUX3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:23:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3772125
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:23:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 393B8643E0
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC50C433EF;
        Wed,  7 Jun 2023 20:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169384;
        bh=wEHtG6VLel2QgpdGA3+37ZL/FZd5p2AoGEukOfRRNbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ltojKeFm6tkDRZxhMRlF4Ke5joEGo/olzqaNZoWpeBDMGVWED/G3Z8Cqdwc4K7xr7
         WnFlcdywqVticrjO/2XqiKpYrBOrV/SqNXuS9x8NA5hLvRx/oIl7NbbwZ2f2JMwxXj
         LrWTTCiLzz+ddANbc0sTcWcoaA5a6hqli7zJpK1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bastien Nocera <hadess@hadess.net>,
        Mark Lord <mlord@pobox.com>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 060/286] HID: logitech-hidpp: Handle timeout differently from busy
Date:   Wed,  7 Jun 2023 22:12:39 +0200
Message-ID: <20230607200925.030740504@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
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

From: Bastien Nocera <hadess@hadess.net>

[ Upstream commit 6199d23c91ce53bfed455f09a8c5ed170d516824 ]

If an attempt at contacting a receiver or a device fails because the
receiver or device never responds, don't restart the communication, only
restart it if the receiver or device answers that it's busy, as originally
intended.

This was the behaviour on communication timeout before commit 586e8fede795
("HID: logitech-hidpp: Retry commands when device is busy").

This fixes some overly long waits in a critical path on boot, when
checking whether the device is connected by getting its HID++ version.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
Suggested-by: Mark Lord <mlord@pobox.com>
Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when device is busy")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217412
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index da89e84c9cbeb..0853114e16a08 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -311,6 +311,7 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 			dbg_hid("%s:timeout waiting for response\n", __func__);
 			memset(response, 0, sizeof(struct hidpp_report));
 			ret = -ETIMEDOUT;
+			goto exit;
 		}
 
 		if (response->report_id == REPORT_ID_HIDPP_SHORT &&
-- 
2.39.2



