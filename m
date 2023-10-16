Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E777CA34A
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjJPJEK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjJPJEJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 05:04:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B93BDE
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 02:04:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE48C433C8;
        Mon, 16 Oct 2023 09:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697447048;
        bh=KTOPw8Mbj6dgjlHXoWpDG6J8OABB0pHyFQv/i8tM+3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sNDzRgDcrpTvndLrLzzUPAC5h557odn7mM+CmbcxtdyWCM7GMehDOpSoJOAi/2rcU
         9PfHzBTuhO3Kyo2l+8EJo15XbBbz3sQrC3ZUPnYnG88T6bukPhPNWPKoqi2ij9eeV5
         oZMFp8JYkh3DNmzcTuQ1YXGw4DhFEWc/mJ3EzAGM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.1 114/131] usb: typec: ucsi: Use GET_CAPABILITY attributes data to set power supply scope
Date:   Mon, 16 Oct 2023 10:41:37 +0200
Message-ID: <20231016084002.899471550@linuxfoundation.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

commit c9ca8de2eb15f9da24113e652980c61f95a47530 upstream.

On some OEM systems, adding a W7900 dGPU triggers RAS errors and hangs
at a black screen on startup.  This issue occurs only if `ucsi_acpi` has
loaded before `amdgpu` has loaded.  The reason for this failure is that
`amdgpu` uses power_supply_is_system_supplied() to determine if running
on AC or DC power at startup. If this value is reported incorrectly the
dGPU will also be programmed incorrectly and trigger errors.

power_supply_is_system_supplied() reports the wrong value because UCSI
power supplies provided as part of the system don't properly report the
scope as "DEVICE" scope (not powering the system).

In order to fix this issue check the capabilities reported from the UCSI
power supply to ensure that it supports charging a battery and that it can
be powered by AC.  Mark the scope accordingly.

Cc: stable@vger.kernel.org
Fixes: a7fbfd44c020 ("usb: typec: ucsi: Mark dGPUs as DEVICE scope")
Link: https://www.intel.com/content/www/us/en/products/docs/io/universal-serial-bus/usb-type-c-ucsi-spec.html p28
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20231009184643.129986-1-mario.limonciello@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/ucsi/psy.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -37,6 +37,15 @@ static int ucsi_psy_get_scope(struct ucs
 	struct device *dev = con->ucsi->dev;
 
 	device_property_read_u8(dev, "scope", &scope);
+	if (scope == POWER_SUPPLY_SCOPE_UNKNOWN) {
+		u32 mask = UCSI_CAP_ATTR_POWER_AC_SUPPLY |
+			   UCSI_CAP_ATTR_BATTERY_CHARGING;
+
+		if (con->ucsi->cap.attributes & mask)
+			scope = POWER_SUPPLY_SCOPE_SYSTEM;
+		else
+			scope = POWER_SUPPLY_SCOPE_DEVICE;
+	}
 	val->intval = scope;
 	return 0;
 }


