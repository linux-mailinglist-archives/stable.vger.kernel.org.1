Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DCF74C377
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjGILcr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjGILc3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:32:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8228695
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:32:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 166EE60BA4
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B81C433C8;
        Sun,  9 Jul 2023 11:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902347;
        bh=H6AQEucR+NeeiJtWOFSzGLNQac2h7ccUxIC3aOhoBbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eHVtscc/VR28fpFSn6QKShOxGF5BCSxFBc7R+whR60W96yD7m1LEM/y0kYHZQZQFA
         vYvuiFOvfAP4TQC93r8oN6NP96co6hCNJCNOWKzvKUn3Fd5okk3eh7KJsI6K22blgj
         l1sFm3zNP2+QzpozOuOYUoPPlKjO2ZFIglhVRbAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 344/431] platform/x86: lenovo-yogabook: Reprobe devices on remove()
Date:   Sun,  9 Jul 2023 13:14:52 +0200
Message-ID: <20230709111459.233915646@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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



