Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFB8761270
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbjGYLCc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbjGYLCR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:02:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8161C59CD
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:59:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6EF76168A
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CF4C433C8;
        Tue, 25 Jul 2023 10:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282759;
        bh=zI4TukLV4h6IsoVU6qizxAg+Rn6N4tRytu2d6FNV1c4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oATXiPzf5HnqSvyMoNTdpQZ94OOwFyFnpXgD8wrnZb7fcQW1kh2lb6Ff4vUO+GhgD
         vJf9/DZDLQNA/aXjbt2Jf+0/eZZdPjmQuQg3Vf/wq/MAq4uQVSIniABlBhEFIzELll
         Nc08Wk3EoJd54wau27xSB/t0Cdx0zLYcM35aePfA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pedro Tammela <pctammela@mojatatu.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 017/183] selftests: tc: add ct action kconfig dep
Date:   Tue, 25 Jul 2023 12:44:05 +0200
Message-ID: <20230725104508.485747805@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matthieu Baerts <matthieu.baerts@tessares.net>

commit 719b4774a8cb1a501e2d22a5a4a3a0a870e427d5 upstream.

When looking for something else in LKFT reports [1], I noticed most of
the tests were skipped because the "teardown stage" did not complete
successfully.

Pedro found out this is due to the fact CONFIG_NF_FLOW_TABLE is required
but not listed in the 'config' file. Adding it to the list fixes the
issues on LKFT side. CONFIG_NET_ACT_CT is now set to 'm' in the final
kconfig.

Fixes: c34b961a2492 ("net/sched: act_ct: Create nf flow table per zone")
Cc: stable@vger.kernel.org
Link: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230711/testrun/18267241/suite/kselftest-tc-testing/test/tc-testing_tdc_sh/log [1]
Link: https://lore.kernel.org/netdev/0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net/T/ [2]
Suggested-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Tested-by: Zhengchao Shao <shaozhengchao@huawei.com>
Link: https://lore.kernel.org/r/20230713-tc-selftests-lkft-v1-2-1eb4fd3a96e7@tessares.net
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/tc-testing/config |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -5,6 +5,7 @@ CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_MARK=y
 CONFIG_NF_CONNTRACK_ZONES=y
 CONFIG_NF_CONNTRACK_LABELS=y
+CONFIG_NF_FLOW_TABLE=m
 CONFIG_NF_NAT=m
 CONFIG_NETFILTER_XT_TARGET_LOG=m
 


