Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDCD7A37E7
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239558AbjIQT00 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239653AbjIQT0F (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:26:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BDF119
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:26:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B81AC433CB;
        Sun, 17 Sep 2023 19:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978760;
        bh=yQ36qSVAp8a9ZKNUYcCns3gWsmn+PZBGVrJzQoZH/6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G3uRlgxTyaJgSHvfIAW2ZUh4hoT/aNhX0ERcs+J5ADYyCjG5aitnUO9dFfmcjCI7n
         QkAuwLZ2lNR22HluU8KWv+bnhUT9vAJPkfIL4Q0JjszOEhAE4/3criNkelMCpFYsXw
         ElwuLx2q2a5gCjlRaArCXoVqttlOo94s4SBBIuas=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ruan Jinjie <ruanjinjie@huawei.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 153/406] of: unittest: fix null pointer dereferencing in of_unittest_find_node_by_name()
Date:   Sun, 17 Sep 2023 21:10:07 +0200
Message-ID: <20230917191105.211803901@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ruan Jinjie <ruanjinjie@huawei.com>

[ Upstream commit d6ce4f0ea19c32f10867ed93d8386924326ab474 ]

when kmalloc() fail to allocate memory in kasprintf(), name
or full_name will be NULL, strcmp() will cause
null pointer dereference.

Fixes: 0d638a07d3a1 ("of: Convert to using %pOF instead of full_name")
Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Link: https://lore.kernel.org/r/20230727080246.519539-1-ruanjinjie@huawei.com
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/unittest.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 5407bbdb64395..1058e23eca7d2 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -69,7 +69,7 @@ static void __init of_unittest_find_node_by_name(void)
 
 	np = of_find_node_by_path("/testcase-data");
 	name = kasprintf(GFP_KERNEL, "%pOF", np);
-	unittest(np && !strcmp("/testcase-data", name),
+	unittest(np && name && !strcmp("/testcase-data", name),
 		"find /testcase-data failed\n");
 	of_node_put(np);
 	kfree(name);
@@ -80,14 +80,14 @@ static void __init of_unittest_find_node_by_name(void)
 
 	np = of_find_node_by_path("/testcase-data/phandle-tests/consumer-a");
 	name = kasprintf(GFP_KERNEL, "%pOF", np);
-	unittest(np && !strcmp("/testcase-data/phandle-tests/consumer-a", name),
+	unittest(np && name && !strcmp("/testcase-data/phandle-tests/consumer-a", name),
 		"find /testcase-data/phandle-tests/consumer-a failed\n");
 	of_node_put(np);
 	kfree(name);
 
 	np = of_find_node_by_path("testcase-alias");
 	name = kasprintf(GFP_KERNEL, "%pOF", np);
-	unittest(np && !strcmp("/testcase-data", name),
+	unittest(np && name && !strcmp("/testcase-data", name),
 		"find testcase-alias failed\n");
 	of_node_put(np);
 	kfree(name);
@@ -98,7 +98,7 @@ static void __init of_unittest_find_node_by_name(void)
 
 	np = of_find_node_by_path("testcase-alias/phandle-tests/consumer-a");
 	name = kasprintf(GFP_KERNEL, "%pOF", np);
-	unittest(np && !strcmp("/testcase-data/phandle-tests/consumer-a", name),
+	unittest(np && name && !strcmp("/testcase-data/phandle-tests/consumer-a", name),
 		"find testcase-alias/phandle-tests/consumer-a failed\n");
 	of_node_put(np);
 	kfree(name);
@@ -1376,6 +1376,8 @@ static void attach_node_and_children(struct device_node *np)
 	const char *full_name;
 
 	full_name = kasprintf(GFP_KERNEL, "%pOF", np);
+	if (!full_name)
+		return;
 
 	if (!strcmp(full_name, "/__local_fixups__") ||
 	    !strcmp(full_name, "/__fixups__")) {
-- 
2.40.1



