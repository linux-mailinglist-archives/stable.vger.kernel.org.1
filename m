Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CEB7CA241
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjJPIrx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjJPIrt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:47:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278D7FC
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:47:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D09BC433C7;
        Mon, 16 Oct 2023 08:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446066;
        bh=oBoXTAzoMVEh3l+CRF4GH40iE3LPR6fCyPPFCW/bIrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GqgrtnUlQQdc89IBXB9+OXcGZm7Ua//NHvToslVm0f92+kMP3AsViBndkGKxGksw7
         w13CyhIFrjcBCXCkilqTmoC3O8ic6G7fa2dJLIy6ZYOeBMQ91zrVXodj97QLYQa83j
         q9mgaFtT5VElwK0UB99rP1YEB4wPr69Teyalmx3w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        syzbot+0434ac83f907a1dbdd1e@syzkaller.appspotmail.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.15 068/102] Input: powermate - fix use-after-free in powermate_config_complete
Date:   Mon, 16 Oct 2023 10:41:07 +0200
Message-ID: <20231016083955.514242998@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

commit 5c15c60e7be615f05a45cd905093a54b11f461bc upstream.

syzbot has found a use-after-free bug [1] in the powermate driver. This
happens when the device is disconnected, which leads to a memory free from
the powermate_device struct.  When an asynchronous control message
completes after the kfree and its callback is invoked, the lock does not
exist anymore and hence the bug.

Use usb_kill_urb() on pm->config to cancel any in-progress requests upon
device disconnection.

[1] https://syzkaller.appspot.com/bug?extid=0434ac83f907a1dbdd1e

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reported-by: syzbot+0434ac83f907a1dbdd1e@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/20230916-topic-powermate_use_after_free-v3-1-64412b81a7a2@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/misc/powermate.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/misc/powermate.c
+++ b/drivers/input/misc/powermate.c
@@ -425,6 +425,7 @@ static void powermate_disconnect(struct
 		pm->requires_update = 0;
 		usb_kill_urb(pm->irq);
 		input_unregister_device(pm->input);
+		usb_kill_urb(pm->config);
 		usb_free_urb(pm->irq);
 		usb_free_urb(pm->config);
 		powermate_free_buffers(interface_to_usbdev(intf), pm);


