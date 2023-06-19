Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8DE7353F5
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjFSKum (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjFSKuP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:50:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5F210FA
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:49:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F5E460B9B
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10A0C433C8;
        Mon, 19 Jun 2023 10:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171779;
        bh=pQknnUIGTrufniS4kWBHkPjtXpRs2Hm2zKFwlHmJzLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9h3reduQ0UeQguWkfiuIdB2HXyzamWK7P9QwImw+xjr6J3qbKAJBv1ErJTemlJhy
         1awHzpZxDBQttWVpAr0AtwTP5biWltCViD1g+B/pIB0MVg0xvuhB/MetNIgqXGscKN
         eIajL9yQkJNuwkH88Kh6tfRIEgcRnnSnBKi721Ig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vlad Buslov <vladbu@nvidia.com>,
        Victor Nogueira <victor@mojatatu.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 136/166] selftests/tc-testing: Fix Error: Specified qdisc kind is unknown.
Date:   Mon, 19 Jun 2023 12:30:13 +0200
Message-ID: <20230619102201.368890276@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vlad Buslov <vladbu@nvidia.com>

[ Upstream commit aef6e908b54200d04f2d77dab31509fcff2e60ae ]

All TEQL tests assume that sch_teql module is loaded. Load module in tdc.sh
before running qdisc tests.

Fixes following example error when running tests via tdc.sh for all TEQL
tests:

 # $ sudo ./tdc.py -d eth2 -e 84a0
 #  -- ns/SubPlugin.__init__
 # Test 84a0: Create TEQL with default setting
 # exit: 2
 # exit: 0
 # Error: Specified qdisc kind is unknown.
 #
 # -----> teardown stage *** Could not execute: "$TC qdisc del dev $DUMMY handle 1: root"
 #
 # -----> teardown stage *** Error message: "Error: Invalid handle.
 # "
 # returncode 2; expected [0]
 #
 # -----> teardown stage *** Aborting test run.
 #
 # <_io.BufferedReader name=3> *** stdout ***
 #
 # <_io.BufferedReader name=5> *** stderr ***
 # "-----> teardown stage" did not complete successfully
 # Exception <class '__main__.PluginMgrTestFail'> ('teardown', 'Error: Specified qdisc kind is unknown.\n', '"-----> teardown stage" did not complete successfully') (caught in test_runner, running test 2 84a0 Create TEQL with default setting stage teardown)
 # ---------------
 # traceback
 #   File "/images/src/linux/tools/testing/selftests/tc-testing/./tdc.py", line 495, in test_runner
 #     res = run_one_test(pm, args, index, tidx)
 #   File "/images/src/linux/tools/testing/selftests/tc-testing/./tdc.py", line 434, in run_one_test
 #     prepare_env(args, pm, 'teardown', '-----> teardown stage', tidx['teardown'], procout)
 #   File "/images/src/linux/tools/testing/selftests/tc-testing/./tdc.py", line 245, in prepare_env
 #     raise PluginMgrTestFail(
 # ---------------
 # accumulated output for this test:
 # Error: Specified qdisc kind is unknown.
 #
 # ---------------
 #
 # All test results:
 #
 # 1..1
 # ok 1 84a0 - Create TEQL with default setting # skipped - "-----> teardown stage" did not complete successfully

Fixes: cc62fbe114c9 ("selftests/tc-testing: add selftests for teql qdisc")
Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/tc-testing/tdc.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tc-testing/tdc.sh b/tools/testing/selftests/tc-testing/tdc.sh
index afb0cd86fa3df..eb357bd7923c0 100755
--- a/tools/testing/selftests/tc-testing/tdc.sh
+++ b/tools/testing/selftests/tc-testing/tdc.sh
@@ -2,5 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 modprobe netdevsim
+modprobe sch_teql
 ./tdc.py -c actions --nobuildebpf
 ./tdc.py -c qdisc
-- 
2.39.2



