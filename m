Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EAA7CA353
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjJPJEZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjJPJEY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 05:04:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55395EB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 02:04:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943B0C433C7;
        Mon, 16 Oct 2023 09:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697447063;
        bh=A7EIEdOqe8ky4IIBp5rKzi6JkBO5uI2JmBMDAUHFKZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KBUqS4Mva3x56uIK0u3rMtpdW8kmlYcbj/4El+tdlo9bqtaAM7TvAT84JrLbm2L4k
         i4ji7D/ZEs4782terQL7OFdBvErMoWv+kiZZBH+ymuNNWP+LzNhTsy1jiCGb3W1WT6
         IewLG0k00q0whrPIKHZbXA1pgg+/KMoC0Rg6saWg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.1 094/131] ACPI: EC: Add quirk for the HP Pavilion Gaming 15-dk1xxx
Date:   Mon, 16 Oct 2023 10:41:17 +0200
Message-ID: <20231016084002.401940240@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit cd4aece493f99f95d41edcce32927d70a5dde923 upstream.

Added GPE quirk entry for the HP Pavilion Gaming 15-dk1xxx.
There is a quirk entry for 2 15-c..... laptops, this is
for a new version which has 15-dk1xxx as identifier.

This fixes the LID switch and rfkill and brightness hotkeys
not working.

Closes: https://github.com/systemd/systemd/issues/28942
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/ec.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1888,6 +1888,17 @@ static const struct dmi_system_id ec_dmi
 	},
 	{
 		/*
+		 * HP Pavilion Gaming Laptop 15-dk1xxx
+		 * https://github.com/systemd/systemd/issues/28942
+		 */
+		.callback = ec_honor_dsdt_gpe,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Gaming Laptop 15-dk1xxx"),
+		},
+	},
+	{
+		/*
 		 * Samsung hardware
 		 * https://bugzilla.kernel.org/show_bug.cgi?id=44161
 		 */


