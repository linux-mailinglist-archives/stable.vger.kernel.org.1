Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFD67A378F
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239411AbjIQTWJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239447AbjIQTVi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:21:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7135119
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:21:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56A8C433C9;
        Sun, 17 Sep 2023 19:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978493;
        bh=jhsIVnDQbJ72vP42LVD0LgF17jrT/kJyLWXMJGOaINo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ocw5lQ0vbtnmVO7DOxo1Y1hYPkusNvclPf7w3eZrnG20lIOma5x28t888Tp6KIV2U
         qmzxtfewB3K2RM7PQPI1ENLvt9PXdq7knhKboyf8+XVKu8Jle2jBZzT+yQD5kSqiDZ
         JcGZHLB3Nq2KIbyLEHQlvoG4obGNRXTwwjxfbTyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 074/406] selftests/resctrl: Unmount resctrl FS if child fails to run benchmark
Date:   Sun, 17 Sep 2023 21:08:48 +0200
Message-ID: <20230917191103.089372547@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit f99e413eb54652e2436cc56d081176bc9a34cd8d ]

A child calls PARENT_EXIT() when it fails to run a benchmark to kill
the parent process. PARENT_EXIT() lacks unmount for the resctrl FS and
the parent won't be there to unmount it either after it gets killed.

Add the resctrl FS unmount also to PARENT_EXIT().

Fixes: 591a6e8588fc ("selftests/resctrl: Add basic resctrl file system operations and data")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan (Fujitsu) <tan.shaopeng@fujitsu.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/resctrl/resctrl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 36da6136af968..c38f2d58df927 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -33,6 +33,7 @@
 	do {					\
 		perror(err_msg);		\
 		kill(ppid, SIGKILL);		\
+		umount_resctrlfs();		\
 		exit(EXIT_FAILURE);		\
 	} while (0)
 
-- 
2.40.1



