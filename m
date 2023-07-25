Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F67761190
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjGYKxe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbjGYKv4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:51:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA111BCF
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:51:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BF336165C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DC3C433C8;
        Tue, 25 Jul 2023 10:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282268;
        bh=mcphBhLLIf1cioV4bNCf0dtTj6ptqrqod4gTHb69Px8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cmkMG+mMJobbqYP0ucp3KlxT2OGZSZy+SNNVlMnm66BH+aalr43yjNIAVGmK9KebW
         ecpqTAx0c+W0x+2iJp9DF9Zcb65llsg110+ABZl71UHGxI5+50IrFqXSD54PzUCs3u
         F/tb/I8KrqqVdSHI9URQysNYrQPL584WL/bL/QkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.4 039/227] selftests: tc: add ConnTrack procfs kconfig
Date:   Tue, 25 Jul 2023 12:43:26 +0200
Message-ID: <20230725104516.442213949@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
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

commit 031c99e71fedcce93b6785d38b7d287bf59e3952 upstream.

When looking at the TC selftest reports, I noticed one test was failing
because /proc/net/nf_conntrack was not available.

  not ok 373 3992 - Add ct action triggering DNAT tuple conflict
  	Could not match regex pattern. Verify command output:
  cat: /proc/net/nf_conntrack: No such file or directory

It is only available if NF_CONNTRACK_PROCFS kconfig is set. So the issue
can be fixed simply by adding it to the list of required kconfig.

Fixes: e46905641316 ("tc-testing: add test for ct DNAT tuple collision")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netdev/0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net/T/ [1]
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Tested-by: Zhengchao Shao <shaozhengchao@huawei.com>
Link: https://lore.kernel.org/r/20230713-tc-selftests-lkft-v1-3-1eb4fd3a96e7@tessares.net
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
+CONFIG_NF_CONNTRACK_PROCFS=y
 CONFIG_NF_FLOW_TABLE=m
 CONFIG_NF_NAT=m
 CONFIG_NETFILTER_XT_TARGET_LOG=m


