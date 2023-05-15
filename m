Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C57703916
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244454AbjEORit (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243327AbjEORid (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:38:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5871563B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:35:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B73F62DC8
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC4AC433EF;
        Mon, 15 May 2023 17:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172158;
        bh=TnlvqDMMSK26SQ9lQeKyCYCFbtqYADCFrHvek/Y2gA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wmlUSOxeWU7pXBPlHVFAXqdIvho6qh1G9ANtw4XNRIKLgt2JN7CjWEZkE5QCLGCTl
         uQIJpZLmiiOfRv0JGLET/30uSVV9gDAAPUyeJTpwxbr795DbNXmSgQcOTj/5FLxdtn
         UxeSX9FAReJYOgVmY6HkrK4ydC4ZUqipKWRqnp9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fenghua Yu <fenghua.yu@intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 062/381] selftests/resctrl: Check for return value after write_schemata()
Date:   Mon, 15 May 2023 18:25:13 +0200
Message-Id: <20230515161739.629713876@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

[ Upstream commit 0d45c83b95da414e98ad333e723141a94f6e2c64 ]

MBA test case writes schemata but it does not check if the write is
successful or not.

Add the error check and return error properly.

Fixes: 01fee6b4d1f9 ("selftests/resctrl: Add MBA test")
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/resctrl/mba_test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 6449fbd96096a..6cfddd1d43558 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -28,6 +28,7 @@ static int mba_setup(int num, ...)
 	struct resctrl_val_param *p;
 	char allocation_str[64];
 	va_list param;
+	int ret;
 
 	va_start(param, num);
 	p = va_arg(param, struct resctrl_val_param *);
@@ -45,7 +46,11 @@ static int mba_setup(int num, ...)
 
 	sprintf(allocation_str, "%d", allocation);
 
-	write_schemata(p->ctrlgrp, allocation_str, p->cpu_no, p->resctrl_val);
+	ret = write_schemata(p->ctrlgrp, allocation_str, p->cpu_no,
+			     p->resctrl_val);
+	if (ret < 0)
+		return ret;
+
 	allocation -= ALLOCATION_STEP;
 
 	return 0;
-- 
2.39.2



