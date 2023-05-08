Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879B66FAC0E
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbjEHLUR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjEHLUQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:20:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CA037C74
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76D6662C66
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C10C433D2;
        Mon,  8 May 2023 11:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544814;
        bh=tdaGVHC91hk58RYFDYl7oJTJx6nHQiB5NYUyPkvpScQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=npePH803eU4mCUmsHa89H+ef8U5rm1Gp00KSeuRZtdgbwkoJqCREGjWV0raTkSttR
         ct/yBtdIRppqAmJiA7pkwDGtpe+zRsgEYYe9Hh2MEVJDAggsflYCiTPIUm6jWVETNg
         oG023KhcJyHyDL7DKjYU1fpKmAXBxFlrYUzzo8xw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pierre Gondois <pierre.gondois@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 531/694] cacheinfo: Check sib_leaf in cache_leaves_are_shared()
Date:   Mon,  8 May 2023 11:46:06 +0200
Message-Id: <20230508094451.578012891@linuxfoundation.org>
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

[ Upstream commit 7a306e3eabf2b2fd8cffa69b87b32dbf814d79ce ]

If there is no ACPI/DT information, it is assumed that L1 caches
are private and L2 (and higher) caches are shared. A cache is
'shared' between two CPUs if it is accessible from these two
CPUs.

Each CPU owns a representation (i.e. has a dedicated cacheinfo struct)
of the caches it has access to. cache_leaves_are_shared() tries to
identify whether two representations are designating the same actual
cache.

In cache_leaves_are_shared(), if 'this_leaf' is a L2 cache (or higher)
and 'sib_leaf' is a L1 cache, the caches are detected as shared as
only this_leaf's cache level is checked.
This is leads to setting sib_leaf as being shared with another CPU,
which is incorrect as this is a L1 cache.

Check 'sib_leaf->level'. Also update the comment as the function is
called when populating 'shared_cpu_map'.

Fixes: f16d1becf96f ("cacheinfo: Use cache identifiers to check if the caches are shared if available")
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20230414081453.244787-2-pierre.gondois@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/cacheinfo.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index f3903d002819e..c5d2293ac2a63 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -38,11 +38,10 @@ static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 {
 	/*
 	 * For non DT/ACPI systems, assume unique level 1 caches,
-	 * system-wide shared caches for all other levels. This will be used
-	 * only if arch specific code has not populated shared_cpu_map
+	 * system-wide shared caches for all other levels.
 	 */
 	if (!(IS_ENABLED(CONFIG_OF) || IS_ENABLED(CONFIG_ACPI)))
-		return !(this_leaf->level == 1);
+		return (this_leaf->level != 1) && (sib_leaf->level != 1);
 
 	if ((sib_leaf->attributes & CACHE_ID) &&
 	    (this_leaf->attributes & CACHE_ID))
-- 
2.39.2



