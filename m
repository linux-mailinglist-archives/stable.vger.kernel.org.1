Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE67A7615A6
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbjGYLbc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjGYLbb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:31:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7854E69
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:31:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EB1861683
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DA6C433C8;
        Tue, 25 Jul 2023 11:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284687;
        bh=AsPTQrPzTDhdK/72JF3qBlfWN0iPBbmFkZvJ++WrSw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zpljtYjyjV9Oc3wjC8IdLKyskGnkSI8R/1qBXLZwYg2iu24I1mJMwDKqAiORBMRIU
         6unSaHRBa6DImjWKaDFGAY1Q2RHkbWJw2M4RVzOA/HTrXNQgwvEanYgSYYuxLO8wa9
         Hy7PicqFLUKJz4wnaGWjtR/qBXwk21/FyHMEytLI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pedro Tammela <pctammela@mojatatu.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10 446/509] selftests: tc: set timeout to 15 minutes
Date:   Tue, 25 Jul 2023 12:46:25 +0200
Message-ID: <20230725104614.170780728@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matthieu Baerts <matthieu.baerts@tessares.net>

commit fda05798c22a354efde09a76bdfc276b2d591829 upstream.

When looking for something else in LKFT reports [1], I noticed that the
TC selftest ended with a timeout error:

  not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 45 seconds

The timeout had been introduced 3 years ago, see the Fixes commit below.

This timeout is only in place when executing the selftests via the
kselftests runner scripts. I guess this is not what most TC devs are
using and nobody noticed the issue before.

The new timeout is set to 15 minutes as suggested by Pedro [2]. It looks
like it is plenty more time than what it takes in "normal" conditions.

Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
Cc: stable@vger.kernel.org
Link: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230711/testrun/18267241/suite/kselftest-tc-testing/test/tc-testing_tdc_sh/log [1]
Link: https://lore.kernel.org/netdev/0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net/T/ [2]
Suggested-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Reviewed-by: Zhengchao Shao <shaozhengchao@huawei.com>
Link: https://lore.kernel.org/r/20230713-tc-selftests-lkft-v1-1-1eb4fd3a96e7@tessares.net
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/tc-testing/settings |    1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/tc-testing/settings

--- /dev/null
+++ b/tools/testing/selftests/tc-testing/settings
@@ -0,0 +1 @@
+timeout=900


