Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B48F7CA22F
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjJPIrI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjJPIrB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:47:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC04107
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:46:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD59C433C8;
        Mon, 16 Oct 2023 08:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446019;
        bh=Ih7Y+gIH611j1XiCwRDTqh+YLB+CAI2+memE6Pkdi8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AurZXSutn97jAHsTWsfEAUr9zwGXV6JW1JDUNcWvLlH1UW6TD6/9Qq4YAZbkLxC+b
         L1ATbnLdOxusXxbvjX4ydcSOwixz0354vqplrrbxyW9jXmmGa4LzYlU8PJfJwp8zbx
         vvzpkxaXdY7v+GvQRlUWB/zh2ShwbcE6dtt67I6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.15 060/102] ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA
Date:   Mon, 16 Oct 2023 10:40:59 +0200
Message-ID: <20231016083955.302767973@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

commit c1ed72171ed580fbf159e703b77685aa4b0d0df5 upstream.

Like various other ASUS ExpertBook-s, the ASUS ExpertBook B1402CBA
has an ACPI DSDT table that describes IRQ 1 as ActiveLow while
the kernel overrides it to EdgeHigh.

This prevents the keyboard from working. To fix this issue, add this laptop
to the skip_override_table so that the kernel does not override IRQ 1.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217901
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/resource.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -433,6 +433,13 @@ static const struct dmi_system_id lenovo
 		},
 	},
 	{
+		.ident = "Asus ExpertBook B1402CBA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B1402CBA"),
+		},
+	},
+	{
 		.ident = "LENOVO IdeaPad Flex 5 16ALC7",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),


