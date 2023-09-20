Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8417A80E8
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbjITMlI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbjITMlD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:41:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D0E118
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:40:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308D0C433C8;
        Wed, 20 Sep 2023 12:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213652;
        bh=SR5LK3EQge2pTNSXI1kwagJcyH9klmAs64KayfAfNb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XZPkpZen4i9dq+usTmaxMiXJQluqCABS5w0yaSfOFSwCCWleWWGQwUoRDWwbI+fQl
         +OLI/ooNtvaG1SiABCttteeclVTK/sZ+a4cO1rWrSZYRSx0jbaB1p2VhA6U8tJSG9t
         zl/N/WoKB36NZkLojkWS7KLd6hkYbUWAl88K1DZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 315/367] ACPI: video: Add backlight=native DMI quirk for Lenovo Ideapad Z470
Date:   Wed, 20 Sep 2023 13:31:32 +0200
Message-ID: <20230920112906.704050342@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index ef40cd7f36eba..be9c70806b620 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -310,6 +310,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
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



