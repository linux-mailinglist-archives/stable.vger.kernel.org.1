Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7F06FA6E0
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjEHKZI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjEHKYf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:24:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03632647A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:24:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33230625AC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8BBC433D2;
        Mon,  8 May 2023 10:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541452;
        bh=p2jOAqfTUG+lhGE8yFbCbVhaP/o6oN3h1uXpODlee3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w4BJvycrlB/c+wNXlzzyVuQlEcdOoLeoSkWRGFs9ACMM7a5bvqp/SfmpJikb2Wb1F
         bFtfswiVwLE3eOmr6h/4RPxyj5c2tSZF/4VxDslYHbU6XVPBFUKppyiuWEbxdSmMnI
         Bim/OBZqeMUBjenO/nlcGaXfSnvgr57gYc/JcO2U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fenghua Yu <fenghua.yu@intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 119/663] selftests/resctrl: Move ->setup() call outside of test specific branches
Date:   Mon,  8 May 2023 11:39:05 +0200
Message-Id: <20230508094432.372877646@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

[ Upstream commit c90b3b588e369c20087699316259fa5ebbb16f2d ]

resctrl_val() function is called only by MBM, MBA, and CMT tests which
means the else branch is never used.

Both test branches call param->setup().

Remove the unused else branch and place the ->setup() call outside of
the test specific branches reducing code duplication.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Stable-dep-of: fa10366cc6f4 ("selftests/resctrl: Allow ->setup() to return errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index b32b96356ec70..787546a528493 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -734,29 +734,22 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
+		ret = param->setup(1, param);
+		if (ret) {
+			ret = 0;
+			break;
+		}
+
 		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-			ret = param->setup(1, param);
-			if (ret) {
-				ret = 0;
-				break;
-			}
-
 			ret = measure_vals(param, &bw_resc_start);
 			if (ret)
 				break;
 		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-			ret = param->setup(1, param);
-			if (ret) {
-				ret = 0;
-				break;
-			}
 			sleep(1);
 			ret = measure_cache_vals(param, bm_pid);
 			if (ret)
 				break;
-		} else {
-			break;
 		}
 	}
 
-- 
2.39.2



