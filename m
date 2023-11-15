Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EBC7ECB7A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjKOTWh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjKOTWg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:22:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDD3D49
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:22:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F136C433C8;
        Wed, 15 Nov 2023 19:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076146;
        bh=z+IU6j5aot5FTtxRHeOxG4sRkLrA6TuqT9Rnt5g1tqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BAX54HMyoRNzGoyI88o3BVf2maqI57ofQjFglKg24gtFgISa1L2tu1iH8FAQSRx5i
         +d4rLF1MGrAnzsdIyu9pSobhwClNQ6esd3dPvUfdIXLe7+fhxUCF42Zo1QUtw6DMA/
         SllcxyKaSP34WuR3J/8USiiRcYRjyxhWfYob6CBI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 102/550] ACPI: property: Allow _DSD buffer data only for byte accessors
Date:   Wed, 15 Nov 2023 14:11:26 -0500
Message-ID: <20231115191607.783930115@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 046ece773cc77ef5d2a1431b188ac3d0840ed150 ]

In accordance with ACPI specificication and _DSD data buffer
representation the data there is an array of bytes. Hence,
accessing it with something longer will create a sparse data
which is against of how device property APIs work in general
and also not defined in the ACPI specification (see [1]).
Fix the code to emit an error if non-byte accessor is used to
retrieve _DSD buffer data.

Fixes: 369af6bf2c28 ("ACPI: property: Read buffer properties as integers")
Link: https://uefi.org/specs/ACPI/6.5/19_ASL_Reference.html#buffer-declare-buffer-object # [1]
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
[ rjw: Add missing braces ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/property.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 413e4fcadcaf7..99b4e33554355 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1102,25 +1102,26 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
 	switch (proptype) {
 	case DEV_PROP_STRING:
 		break;
-	case DEV_PROP_U8 ... DEV_PROP_U64:
+	default:
 		if (obj->type == ACPI_TYPE_BUFFER) {
 			if (nval > obj->buffer.length)
 				return -EOVERFLOW;
-			break;
+		} else {
+			if (nval > obj->package.count)
+				return -EOVERFLOW;
 		}
-		fallthrough;
-	default:
-		if (nval > obj->package.count)
-			return -EOVERFLOW;
 		break;
 	}
 	if (nval == 0)
 		return -EINVAL;
 
-	if (obj->type != ACPI_TYPE_BUFFER)
-		items = obj->package.elements;
-	else
+	if (obj->type == ACPI_TYPE_BUFFER) {
+		if (proptype != DEV_PROP_U8)
+			return -EPROTO;
 		items = obj;
+	} else {
+		items = obj->package.elements;
+	}
 
 	switch (proptype) {
 	case DEV_PROP_U8:
-- 
2.42.0



