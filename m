Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257C57552EA
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjGPUN2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjGPUN1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:13:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D3E90
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:13:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7EAF60EB3
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C1BC433C8;
        Sun, 16 Jul 2023 20:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538406;
        bh=H6AQEucR+NeeiJtWOFSzGLNQac2h7ccUxIC3aOhoBbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UXCXcWTVRfWjEBziWtYugio748nE5OwxJg4Z/t/Fri79QaHP8/dnVuPddcgD7px+0
         H4rItX/ZMJnFmj7kv+hQSVp+IQ6kyuV5x3peYEmUTUBKa0TxFtfWUov3Bt79GNsO3U
         w5NJEBnWvH+IOADyKlfYuSs5kyhKDp422EWQWsIQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 440/800] platform/x86: lenovo-yogabook: Reprobe devices on remove()
Date:   Sun, 16 Jul 2023 21:44:53 +0200
Message-ID: <20230716194959.303597998@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 711bcc0cb34e96a60e88d7b0260862781de3e530 ]

Ensure that both the keyboard touchscreen and the digitizer have their
driver bound after remove(). Without this modprobing lenovo-yogabook-wmi
after a rmmod fails because lenovo-yogabook-wmi defers probing until
both devices have their driver bound.

Fixes: c0549b72d99d ("platform/x86: lenovo-yogabook-wmi: Add driver for Lenovo Yoga Book")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230430165807.472798-4-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index 3a6de4ab74a41..5948ffa74acd5 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -332,9 +332,20 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 static void yogabook_wmi_remove(struct wmi_device *wdev)
 {
 	struct yogabook_wmi *data = dev_get_drvdata(&wdev->dev);
+	int r = 0;
 
 	free_irq(data->backside_hall_irq, data);
 	cancel_work_sync(&data->work);
+
+	if (!test_bit(YB_KBD_IS_ON, &data->flags))
+		r |= device_reprobe(data->kbd_dev);
+
+	if (!test_bit(YB_DIGITIZER_IS_ON, &data->flags))
+		r |= device_reprobe(data->dig_dev);
+
+	if (r)
+		dev_warn(&wdev->dev, "Reprobe of devices failed\n");
+
 	put_device(data->dig_dev);
 	put_device(data->kbd_dev);
 	acpi_dev_put(data->dig_adev);
-- 
2.39.2



