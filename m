Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6165B6FAD52
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbjEHLdl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbjEHLdS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:33:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549383D232
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:32:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5552C62F17
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5667BC433D2;
        Mon,  8 May 2023 11:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545504;
        bh=tABDN212CA76MVrgvoONGmEu4F/MywUwtIQNv3n17ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uHNnC/9pn5pTun2LLfdg+6dQIlKcaiogrF1R97rY07CLYY1UTRGYZzu/tju2GKCQ8
         AkI3UIr0wSiBvcV1URKYQJtM3wESjaNOjN/B5aUorvQrGlZevSEN+sFLgmPCXMIvkY
         EisOkuPSOkAe8s8mbFeXbvzPYptSlljAVfOLGO48=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fenghua Yu <fenghua.yu@intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 060/371] selftests/resctrl: Return NULL if malloc_and_init_memory() did not alloc mem
Date:   Mon,  8 May 2023 11:44:21 +0200
Message-Id: <20230508094814.473574916@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 22a8be280383812235131dda18a8212a59fadd2d ]

malloc_and_init_memory() in fill_buf isn't checking if memalign()
successfully allocated memory or not before accessing the memory.

Check the return value of memalign() and return NULL if allocating
aligned memory fails.

Fixes: a2561b12fe39 ("selftests/resctrl: Add built in benchmark")
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/resctrl/fill_buf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 56ccbeae0638d..c20d0a7ecbe63 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -68,6 +68,8 @@ static void *malloc_and_init_memory(size_t s)
 	size_t s64;
 
 	void *p = memalign(PAGE_SIZE, s);
+	if (!p)
+		return NULL;
 
 	p64 = (uint64_t *)p;
 	s64 = s / sizeof(uint64_t);
-- 
2.39.2



