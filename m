Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6207ED486
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344843AbjKOU6U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344611AbjKOU5k (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA884172A
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8170AC32779;
        Wed, 15 Nov 2023 20:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081323;
        bh=j+V4AOth914tlv9D88g7NypVmY0rzcTu+bHR/DJUGaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c843d9V/ioU9rzEJwkbJi2ghnYlAx4tO0z20v00bdgb3iP4AK/yMdAtbRWHopHs0T
         AiWmtr/s1xMa8NuLFFxtbgOOzLe3DILcBJ6su9OurMp76q/vDQZxt3O72uU5DSVgax
         lcai/2lqaUta41/zCS/Wdqz7sr8dRes9JdWFC8LE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 047/244] ACPI: sysfs: Fix create_pnp_modalias() and create_of_modalias()
Date:   Wed, 15 Nov 2023 15:33:59 -0500
Message-ID: <20231115203551.190802984@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 48cf49d31994ff97b33c4044e618560ec84d35fb ]

snprintf() does not return negative values on error.

To know if the buffer was too small, the returned value needs to be
compared with the length of the passed buffer. If it is greater or
equal, the output has been truncated, so add checks for the truncation
to create_pnp_modalias() and create_of_modalias(). Also make them
return -ENOMEM in that case, as they already do that elsewhere.

Moreover, the remaining size of the buffer used by snprintf() needs to
be updated after the first write to avoid out-of-bounds access as
already done correctly in create_pnp_modalias(), but not in
create_of_modalias(), so change the latter accordingly.

Fixes: 8765c5ba1949 ("ACPI / scan: Rework modalias creation when "compatible" is present")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
[ rjw: Merge two patches into one, combine changelogs, add subject ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/device_sysfs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 61271e61c3073..da9cd11adfb56 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -157,8 +157,8 @@ static int create_pnp_modalias(struct acpi_device *acpi_dev, char *modalias,
 		return 0;
 
 	len = snprintf(modalias, size, "acpi:");
-	if (len <= 0)
-		return len;
+	if (len >= size)
+		return -ENOMEM;
 
 	size -= len;
 
@@ -211,8 +211,10 @@ static int create_of_modalias(struct acpi_device *acpi_dev, char *modalias,
 	len = snprintf(modalias, size, "of:N%sT", (char *)buf.pointer);
 	ACPI_FREE(buf.pointer);
 
-	if (len <= 0)
-		return len;
+	if (len >= size)
+		return -ENOMEM;
+
+	size -= len;
 
 	of_compatible = acpi_dev->data.of_compatible;
 	if (of_compatible->type == ACPI_TYPE_PACKAGE) {
-- 
2.42.0



