Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497977BDE7C
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346506AbjJINT5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377096AbjJINS6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:18:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F271F8F
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:18:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFD7C433C8;
        Mon,  9 Oct 2023 13:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857537;
        bh=aDxcey5qiL4Vbxx1HJEEg3DCEl93r4q47hwE9JDsRgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sRHK7w2acexVwOeIULFwOv30nNDq2bDI3l0qnuBHQjy5SdhUyUKPQFXm8+yySeja1
         om+cK3a3k1AqWwpBMINnfaDeC93huBrBjPSE5jfKaZiTbK0KlamOtLXiiW1I/NNdSl
         9NNoJ4aovqTTwbnezZclddxojO9h+2ThXszfLJmU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Herman Fries <baracoder@googlemail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.1 051/162] hwmon: (nzxt-smart2) Add device id
Date:   Mon,  9 Oct 2023 15:00:32 +0200
Message-ID: <20231009130124.346439519@linuxfoundation.org>
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

From: Herman Fries <baracoder@googlemail.com>

commit e247510e1baad04e9b7b8ed7190dbb00989387b9 upstream.

Adding support for new device id
1e71:2019 NZXT NZXT RGB & Fan Controller

Signed-off-by: Herman Fries <baracoder@googlemail.com>
Link: https://lore.kernel.org/r/20221214194627.135692-1-baracoder@googlemail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/nzxt-smart2.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/hwmon/nzxt-smart2.c
+++ b/drivers/hwmon/nzxt-smart2.c
@@ -791,6 +791,7 @@ static const struct hid_device_id nzxt_s
 	{ HID_USB_DEVICE(0x1e71, 0x2009) }, /* NZXT RGB & Fan Controller */
 	{ HID_USB_DEVICE(0x1e71, 0x200e) }, /* NZXT RGB & Fan Controller */
 	{ HID_USB_DEVICE(0x1e71, 0x2010) }, /* NZXT RGB & Fan Controller */
+	{ HID_USB_DEVICE(0x1e71, 0x2019) }, /* NZXT RGB & Fan Controller */
 	{},
 };
 


