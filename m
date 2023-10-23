Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0977D34F5
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbjJWLoQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbjJWLoI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:44:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6855AD7B
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:43:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629BAC433C8;
        Mon, 23 Oct 2023 11:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061438;
        bh=33tgtK1JP8J68IJbP4L0kVP+9lXPwox+onGXQ3pCokk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z/44YycQxpf6Oe36DQ4O7psXz4LW2QOpV4xseASdfypWxalJtmoZy2rxF7onWTWXF
         n1YkF4kt14Jx3BiL0L44NFbe2gdm25Osx3s7YTYHQf1ITd9RQE6XSL6ymuaG0SS72M
         K+s8KQTwm0d/YDrjZxi9AEPCgFdjRENdMC6zQz2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        syzbot+0434ac83f907a1dbdd1e@syzkaller.appspotmail.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.10 048/202] Input: powermate - fix use-after-free in powermate_config_complete
Date:   Mon, 23 Oct 2023 12:55:55 +0200
Message-ID: <20231023104827.989052354@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

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


