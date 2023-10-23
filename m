Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E117D30A8
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjJWLBA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjJWLA7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:00:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819BAD6E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:00:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1939C433C7;
        Mon, 23 Oct 2023 11:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698058857;
        bh=J8Cy3bgd90JSHGMnTHsNOT7TfeO1mCRGZo8F1nf4oTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o1S7zwqVxmaFH/+TW26DP4zjf3o+QUocIJNxZLgWnPCSYcUxjGPYJNxM581+0whsu
         wDElFyo/7INqyX8CG31NV6pTWwuZ2sP7xUq/UEdIqBD2/i0QsA36M+sXbWR+IQrj0/
         Z7ukdVt+wW75TGYUOkTI06OFgcEI8jyo02ehSnwM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ma Ke <make_ruc2021@163.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 49/66] HID: holtek: fix slab-out-of-bounds Write in holtek_kbd_input_event
Date:   Mon, 23 Oct 2023 12:56:39 +0200
Message-ID: <20231023104812.665793535@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104810.781270702@linuxfoundation.org>
References: <20231023104810.781270702@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make_ruc2021@163.com>

[ Upstream commit ffe3b7837a2bb421df84d0177481db9f52c93a71 ]

There is a slab-out-of-bounds Write bug in hid-holtek-kbd driver.
The problem is the driver assumes the device must have an input
but some malicious devices violate this assumption.

Fix this by checking hid_device's input is non-empty before its usage.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-holtek-kbd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-holtek-kbd.c b/drivers/hid/hid-holtek-kbd.c
index 2f8eb66397444..72788ca260e08 100644
--- a/drivers/hid/hid-holtek-kbd.c
+++ b/drivers/hid/hid-holtek-kbd.c
@@ -133,6 +133,10 @@ static int holtek_kbd_input_event(struct input_dev *dev, unsigned int type,
 		return -ENODEV;
 
 	boot_hid = usb_get_intfdata(boot_interface);
+	if (list_empty(&boot_hid->inputs)) {
+		hid_err(hid, "no inputs found\n");
+		return -ENODEV;
+	}
 	boot_hid_input = list_first_entry(&boot_hid->inputs,
 		struct hid_input, list);
 
-- 
2.40.1



