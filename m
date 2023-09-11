Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B9879BEE3
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350383AbjIKVhq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241782AbjIKPO2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:14:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F38FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:14:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CA3C433C9;
        Mon, 11 Sep 2023 15:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445263;
        bh=72f6KxTWOE7jifzfCmaptl2xkmhcEs6B6zDxOl7We8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eUkdOh0VNDTdlzXIAgj7oWYj6jJ2vTpqhfH6kHDsEu1vfn3QXj4ijqdpUdrCtZuOQ
         sOsPBkV2WkSKMUZTvvAuTjaKBDdZl/sNXwUieP7mYTJwm+69eq7819nuD1iPD13kA2
         HM1Z7a/17UYUqa/iXT0Sbo8FBgctJEn12n2LcYiU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ruan Jinjie <ruanjinjie@huawei.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 284/600] of: unittest: fix null pointer dereferencing in of_unittest_find_node_by_name()
Date:   Mon, 11 Sep 2023 15:45:17 +0200
Message-ID: <20230911134641.993274458@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 9be6ed47a1ce4..b815b8862e187 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -70,7 +70,7 @@ static void __init of_unittest_find_node_by_name(void)
 
 	np = of_find_node_by_path("/testcase-data");
 	name = kasprintf(GFP_KERNEL, "%pOF", np);
-	unittest(np && !strcmp("/testcase-data", name),
+	unittest(np && name && !strcmp("/testcase-data", name),
 		"find /testcase-data failed\n");
 	of_node_put(np);
 	kfree(name);
@@ -81,14 +81,14 @@ static void __init of_unittest_find_node_by_name(void)
 
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
@@ -99,7 +99,7 @@ static void __init of_unittest_find_node_by_name(void)
 
 	np = of_find_node_by_path("testcase-alias/phandle-tests/consumer-a");
 	name = kasprintf(GFP_KERNEL, "%pOF", np);
-	unittest(np && !strcmp("/testcase-data/phandle-tests/consumer-a", name),
+	unittest(np && name && !strcmp("/testcase-data/phandle-tests/consumer-a", name),
 		"find testcase-alias/phandle-tests/consumer-a failed\n");
 	of_node_put(np);
 	kfree(name);
@@ -1379,6 +1379,8 @@ static void attach_node_and_children(struct device_node *np)
 	const char *full_name;
 
 	full_name = kasprintf(GFP_KERNEL, "%pOF", np);
+	if (!full_name)
+		return;
 
 	if (!strcmp(full_name, "/__local_fixups__") ||
 	    !strcmp(full_name, "/__fixups__")) {
-- 
2.40.1



