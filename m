Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D477ECC86
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjKOTbC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjKOTbB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:31:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A051A8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:30:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6F7C433C7;
        Wed, 15 Nov 2023 19:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076658;
        bh=V4iIzYC0ZVNwoPILTnEtwfGf2xPpA7fE2aXQENwX18k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G0tOKN6P1AajDvO8gpjomNkOGMTqE+l/7gE9DXoPRtkGHZh3cVV06QfHvJqO19m7J
         jqs0XL2ulHEtzGF8veC40fZQvHP7PJ4mJEWIpd+GY9dLKimoWCRWtFGbzE7ehF2l87
         fQDK+EKkNzfcRQ5LE7IZ8yrOxuV9z+fZfhKQUc9Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Herve Codina <herve.codina@bootlin.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 367/550] mfd: core: Ensure disabled devices are skipped without aborting
Date:   Wed, 15 Nov 2023 14:15:51 -0500
Message-ID: <20231115191626.258461317@linuxfoundation.org>
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

From: Herve Codina <herve.codina@bootlin.com>

[ Upstream commit 7ba7bdef4d14e3722e2842da3b48cbadb73e52d6 ]

The loop searching for a matching device based on its compatible
string is aborted when a matching disabled device is found.
This abort prevents to add devices as soon as one disabled device
is found.

Continue searching for an other device instead of aborting on the
first disabled one fixes the issue.

Fixes: 22380b65dc70 ("mfd: mfd-core: Ensure disabled devices are ignored without error")
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Link: https://lore.kernel.org/r/528425d6472176bb1d02d79596b51f8c28a551cc.1692376361.git.christophe.leroy@csgroup.eu
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/mfd-core.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 0ed7c0d7784e1..2b85509a90fc2 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -146,6 +146,7 @@ static int mfd_add_device(struct device *parent, int id,
 	struct platform_device *pdev;
 	struct device_node *np = NULL;
 	struct mfd_of_node_entry *of_entry, *tmp;
+	bool disabled = false;
 	int ret = -ENOMEM;
 	int platform_id;
 	int r;
@@ -183,11 +184,10 @@ static int mfd_add_device(struct device *parent, int id,
 	if (IS_ENABLED(CONFIG_OF) && parent->of_node && cell->of_compatible) {
 		for_each_child_of_node(parent->of_node, np) {
 			if (of_device_is_compatible(np, cell->of_compatible)) {
-				/* Ignore 'disabled' devices error free */
+				/* Skip 'disabled' devices */
 				if (!of_device_is_available(np)) {
-					of_node_put(np);
-					ret = 0;
-					goto fail_alias;
+					disabled = true;
+					continue;
 				}
 
 				ret = mfd_match_of_node_to_dev(pdev, np, cell);
@@ -197,10 +197,17 @@ static int mfd_add_device(struct device *parent, int id,
 				if (ret)
 					goto fail_alias;
 
-				break;
+				goto match;
 			}
 		}
 
+		if (disabled) {
+			/* Ignore 'disabled' devices error free */
+			ret = 0;
+			goto fail_alias;
+		}
+
+match:
 		if (!pdev->dev.of_node)
 			pr_warn("%s: Failed to locate of_node [id: %d]\n",
 				cell->name, platform_id);
-- 
2.42.0



