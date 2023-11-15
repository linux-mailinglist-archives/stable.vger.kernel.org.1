Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87FC7ED049
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjKOTyC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbjKOTyB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:54:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9735492
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:53:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B01C433C7;
        Wed, 15 Nov 2023 19:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078037;
        bh=/vx67c9LRN/Elk3GxdxrJvW0BwhmuNV5rhmKHYVlNCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EnLkDO3qPS/JyXd92EcVeWuqtvuDmgHqQ5/x2vBuI1CLWRpCUKcdrtzWAdkJ0ktn6
         o7oJa6jF5FCuF6RK8YhkfxcqXqTIHlHp30O3b5mXK3z6NqR106L5K+pvavTB7GoH6w
         tAkWXWEd/gyf1fZKHmsoMZu0vTordfXIv1p9hQkY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 072/379] ACPI: sysfs: Fix create_pnp_modalias() and create_of_modalias()
Date:   Wed, 15 Nov 2023 14:22:27 -0500
Message-ID: <20231115192649.410988605@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 120873dad2cc5..c727fb320eeea 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -158,8 +158,8 @@ static int create_pnp_modalias(struct acpi_device *acpi_dev, char *modalias,
 		return 0;
 
 	len = snprintf(modalias, size, "acpi:");
-	if (len <= 0)
-		return len;
+	if (len >= size)
+		return -ENOMEM;
 
 	size -= len;
 
@@ -212,8 +212,10 @@ static int create_of_modalias(struct acpi_device *acpi_dev, char *modalias,
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



