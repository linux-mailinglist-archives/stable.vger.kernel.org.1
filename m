Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794557A8160
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbjITMpT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbjITMoq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:44:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F23A83
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:44:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A96C433C7;
        Wed, 20 Sep 2023 12:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213880;
        bh=Xu5pm8ev0H8JoW3KNYqzSaAAeHd1NcCCnDJSYzWjaus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vz6zCOJ8H5V0shLPhfOcVVhzZ9TO8uTKDD2mB6shQ+5GI6lCmq4Y40XPwDU6Mqc3u
         6v/5+eKzN97o3ZIfJwp4AxsmWJCW6UsK1NC1/oCa324QImZoGE9qKEW3rXtIuS5elU
         HlKXA6iesc6nPjcseqxfeJlDhpgkXZG5uEFFCx4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 008/110] ACPI: video: Add backlight=native DMI quirk for Lenovo Ideapad Z470
Date:   Wed, 20 Sep 2023 13:31:06 +0200
Message-ID: <20230920112830.700004759@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
References: <20230920112830.377666128@linuxfoundation.org>
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

From: Jiri Slaby (SUSE) <jirislaby@kernel.org>

[ Upstream commit 96b709be183c56293933ef45b8b75f8af268c6de ]

The Lenovo Ideapad Z470 predates Windows 8, so it defaults to using
acpi_video for backlight control. But this is not functional on this
model.

Add a DMI quirk to use the native backlight interface which works.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1208724
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/video_detect.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 038542b3a80a7..5afc42d52e49b 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -307,6 +307,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_BOARD_NAME, "Lenovo IdeaPad S405"),
 		},
 	},
+	{
+	 /* https://bugzilla.suse.com/show_bug.cgi?id=1208724 */
+	 .callback = video_detect_force_native,
+	 /* Lenovo Ideapad Z470 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Z470"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1187004 */
 	 .callback = video_detect_force_native,
-- 
2.40.1



