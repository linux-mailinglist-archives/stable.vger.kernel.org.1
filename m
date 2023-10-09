Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E057BDE60
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377030AbjJINTN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377126AbjJINTC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:19:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF9791
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:19:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57359C433C8;
        Mon,  9 Oct 2023 13:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857540;
        bh=Lb9fu2kQuj+nSQC8IhJi5WfXn/CZCsTDhxhHhSgBrBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kjJddS9Jbpmlk+9S4AJQgG4iQ31Ty8XE34FfdvmCeo86XpQFzcImRItbkTNkP6Hx/
         XvnuFQpT86tHPZTejNE4Qrrd/XtqJcVw5s1gYjdHJEYZOn5CHT8fVA8lSNTSbzMuNC
         aqIVAuN2658wU6SEVr0Dxj4o2G9qa5gsCVvVmEe0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Aleksandr Mezin <mezin.alexander@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.1 052/162] hwmon: (nzxt-smart2) add another USB ID
Date:   Mon,  9 Oct 2023 15:00:33 +0200
Message-ID: <20231009130124.372016580@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksandr Mezin <mezin.alexander@gmail.com>

commit 4a148e9b1ee04e608263fa9536a96214d5561220 upstream.

This seems to be a new revision of the device. RGB controls have changed,
but this driver doesn't touch them anyway.

Fan speed control reported to be working with existing userspace (hidraw)
software, so I assume it's compatible. Fan channel count is the same.

Recently added (0x1e71, 0x2019) seems to be the same device.

Discovered in liquidctl project:

https://github.com/liquidctl/liquidctl/issues/541

Signed-off-by: Aleksandr Mezin <mezin.alexander@gmail.com>
Link: https://lore.kernel.org/r/20230219105924.333007-1-mezin.alexander@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/nzxt-smart2.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/hwmon/nzxt-smart2.c
+++ b/drivers/hwmon/nzxt-smart2.c
@@ -791,7 +791,8 @@ static const struct hid_device_id nzxt_s
 	{ HID_USB_DEVICE(0x1e71, 0x2009) }, /* NZXT RGB & Fan Controller */
 	{ HID_USB_DEVICE(0x1e71, 0x200e) }, /* NZXT RGB & Fan Controller */
 	{ HID_USB_DEVICE(0x1e71, 0x2010) }, /* NZXT RGB & Fan Controller */
-	{ HID_USB_DEVICE(0x1e71, 0x2019) }, /* NZXT RGB & Fan Controller */
+	{ HID_USB_DEVICE(0x1e71, 0x2011) }, /* NZXT RGB & Fan Controller (6 RGB) */
+	{ HID_USB_DEVICE(0x1e71, 0x2019) }, /* NZXT RGB & Fan Controller (6 RGB) */
 	{},
 };
 


