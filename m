Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCBA6FAC0F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjEHLUW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbjEHLUT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:20:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B2838473
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4620C62C6D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9A3C433D2;
        Mon,  8 May 2023 11:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544817;
        bh=XVU5Vo3I5IXl8bDMikkqu6a3ptheLyt9rM9yyu1g+Pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HtnG63YqI2M2ojkzbg1rDuuTJc9w3zIvxSGY7k0cuzdI8E5SAZw+7I5ReocTbZVAs
         1EpjKxWi+Qrx9NndW5oz3a0rx5E7FS5XiF7QsLkyXp4dVwxT6d64j8ZGAM6URUzbl7
         WSDKoTggeNuTUbE42LwWWX54pAo7m5fjoAlh6mJU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexandre Ghiti <alexghiti@rivosinc.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 532/694] cacheinfo: Check cache properties are present in DT
Date:   Mon,  8 May 2023 11:46:07 +0200
Message-Id: <20230508094451.630724234@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pierre Gondois <pierre.gondois@arm.com>

[ Upstream commit cde0fbff07eff7e4e0e85fa053fe19a24c86b1e0 ]

If a Device Tree (DT) is used, the presence of cache properties is
assumed. Not finding any is not considered. For arm64 platforms,
cache information can be fetched from the clidr_el1 register.
Checking whether cache information is available in the DT
allows to switch to using clidr_el1.

init_of_cache_level()
\-of_count_cache_leaves()
will assume there a 2 cache leaves (L1 data/instruction caches), which
can be different from clidr_el1 information.

cache_setup_of_node() tries to read cache properties in the DT.
If there are none, this is considered a success. Knowing no
information was available would allow to switch to using clidr_el1.

Fixes: de0df442ee49 ("cacheinfo: Check 'cache-unified' property to count cache leaves")
Reported-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b57a@spud/
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20230414081453.244787-3-pierre.gondois@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/cacheinfo.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index c5d2293ac2a63..ea8f416852bd9 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -78,6 +78,9 @@ bool last_level_cache_is_shared(unsigned int cpu_x, unsigned int cpu_y)
 }
 
 #ifdef CONFIG_OF
+
+static bool of_check_cache_nodes(struct device_node *np);
+
 /* OF properties to query for a given cache type */
 struct cache_type_info {
 	const char *size_prop;
@@ -205,6 +208,11 @@ static int cache_setup_of_node(unsigned int cpu)
 		return -ENOENT;
 	}
 
+	if (!of_check_cache_nodes(np)) {
+		of_node_put(np);
+		return -ENOENT;
+	}
+
 	prev = np;
 
 	while (index < cache_leaves(cpu)) {
@@ -229,6 +237,25 @@ static int cache_setup_of_node(unsigned int cpu)
 	return 0;
 }
 
+static bool of_check_cache_nodes(struct device_node *np)
+{
+	struct device_node *next;
+
+	if (of_property_present(np, "cache-size")   ||
+	    of_property_present(np, "i-cache-size") ||
+	    of_property_present(np, "d-cache-size") ||
+	    of_property_present(np, "cache-unified"))
+		return true;
+
+	next = of_find_next_cache_node(np);
+	if (next) {
+		of_node_put(next);
+		return true;
+	}
+
+	return false;
+}
+
 static int of_count_cache_leaves(struct device_node *np)
 {
 	unsigned int leaves = 0;
@@ -260,6 +287,11 @@ int init_of_cache_level(unsigned int cpu)
 	struct device_node *prev = NULL;
 	unsigned int levels = 0, leaves, level;
 
+	if (!of_check_cache_nodes(np)) {
+		of_node_put(np);
+		return -ENOENT;
+	}
+
 	leaves = of_count_cache_leaves(np);
 	if (leaves > 0)
 		levels = 1;
-- 
2.39.2



