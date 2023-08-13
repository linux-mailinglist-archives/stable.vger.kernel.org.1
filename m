Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F0377AE0C
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 00:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjHMWAR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 18:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjHMV7I (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:59:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CD9273B
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:44:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99869623FF
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC82C433C9;
        Sun, 13 Aug 2023 21:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963066;
        bh=hwEnLo2tP0fO46fvhCBenOu25yC4/esmOUwiZ6XLvwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xO92B+AZCwjd7mBBn6smwuimi9so+TrYD9DVHIZaQ3NQuuuZ4HBPBw+7RoMnLUXxK
         i8T49mCAo1JmOKGjdRCkB19kL5KrqEGEujqu7qrXWklNE9J2HWBVXWOyAFy+8/EVg6
         SVTHTqNv+wGqJSeSKumVglnkJhqLcPj680KORhas=
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
Subject: [PATCH 5.15 41/89] selftests: forwarding: Switch off timeout
Date:   Sun, 13 Aug 2023 23:19:32 +0200
Message-ID: <20230813211712.020316983@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
References: <20230813211710.787645394@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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


