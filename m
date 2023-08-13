Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E86177ACB9
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjHMVgV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjHMVgU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:36:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0814710DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:36:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B69F62D18
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24E0C433C8;
        Sun, 13 Aug 2023 21:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962582;
        bh=hwEnLo2tP0fO46fvhCBenOu25yC4/esmOUwiZ6XLvwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SL+3TntUH/f+n21n0vUmb+W8b7eXA7tJxaKR009/aPUkISg41a1ygwC9VfIn94ilL
         odf/rt844Mj0BEeKKwy5ENB4V6Is71dKPQgGuBVXIIV5Zpe/sFwXciPfBeF3N04M+8
         ZLT9mJ+JYEM5+wnmq1HE3YUv2dVJkPtDoUWs24p8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 081/149] selftests: forwarding: Switch off timeout
Date:   Sun, 13 Aug 2023 23:18:46 +0200
Message-ID: <20230813211721.217919974@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
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

From: Ido Schimmel <idosch@nvidia.com>

commit 0529883ad102f6c04e19fb7018f31e1bda575bbe upstream.

The default timeout for selftests is 45 seconds, but it is not enough
for forwarding selftests which can takes minutes to finish depending on
the number of tests cases:

 # make -C tools/testing/selftests TARGETS=net/forwarding run_tests
 TAP version 13
 1..102
 # timeout set to 45
 # selftests: net/forwarding: bridge_igmp.sh
 # TEST: IGMPv2 report 239.10.10.10                                    [ OK ]
 # TEST: IGMPv2 leave 239.10.10.10                                     [ OK ]
 # TEST: IGMPv3 report 239.10.10.10 is_include                         [ OK ]
 # TEST: IGMPv3 report 239.10.10.10 include -> allow                   [ OK ]
 #
 not ok 1 selftests: net/forwarding: bridge_igmp.sh # TIMEOUT 45 seconds

Fix by switching off the timeout and setting it to 0. A similar change
was done for BPF selftests in commit 6fc5916cc256 ("selftests: bpf:
Switch off timeout").

Fixes: 81573b18f26d ("selftests/net/forwarding: add Makefile to install tests")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/8d149f8c-818e-d141-a0ce-a6bae606bc22@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://lore.kernel.org/r/20230808141503.4060661-3-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/forwarding/settings |    1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/net/forwarding/settings

--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/settings
@@ -0,0 +1 @@
+timeout=0


