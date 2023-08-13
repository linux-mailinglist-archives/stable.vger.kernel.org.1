Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA7877ABEA
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjHMV1K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjHMV1J (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:27:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028A010D7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:27:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95640629D0
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08EAC433C8;
        Sun, 13 Aug 2023 21:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962031;
        bh=tr6jEyLlBDIdM8vx8Fa82jezzI4IohXavw1kuEqk9ZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X/XxSlY6CP20BI3E8uqnAqe2VEbRQ1l9nGjwcW1UFFDgP/PWFO+YtZk0ROQdRbMhp
         UkgQDUEOXhkyUYBevbXqGjbBLYvY/O8MnY9sP6XdrZ/mcg3MRhlEClyx2ky6OPZaIz
         zDdgHc/4mGdFntEESr5SSowqWHdOFvbbj3IzdBg4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.4 060/206] mm/damon/core: initialize damo_filter->list from damos_new_filter()
Date:   Sun, 13 Aug 2023 23:17:10 +0200
Message-ID: <20230813211726.789359655@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

commit 5f1fc67f2cb8d3035d3acd273b48b97835af8afd upstream.

damos_new_filter() is not initializing the list field of newly allocated
filter object.  However, DAMON sysfs interface and DAMON_RECLAIM are not
initializing it after calling damos_new_filter().  As a result, accessing
uninitialized memory is possible.  Actually, adding multiple DAMOS filters
via DAMON sysfs interface caused NULL pointer dereferencing.  Initialize
the field just after the allocation from damos_new_filter().

Link: https://lkml.kernel.org/r/20230729203733.38949-2-sj@kernel.org
Fixes: 98def236f63c ("mm/damon/core: implement damos filter")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 91cff7f2997e..eb9580942a5c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -273,6 +273,7 @@ struct damos_filter *damos_new_filter(enum damos_filter_type type,
 		return NULL;
 	filter->type = type;
 	filter->matching = matching;
+	INIT_LIST_HEAD(&filter->list);
 	return filter;
 }
 
-- 
2.41.0



