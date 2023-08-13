Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E8277AC70
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjHMVdH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjHMVdH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:33:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC0D91
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:33:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A40E462C0E
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C99C433C7;
        Sun, 13 Aug 2023 21:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962388;
        bh=25zy2sfNmWktLZNtxAWSxp4BB/hpjp8WHHPBl3cyHEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zv5an+PQqw7JIqmBtXl7+/sEHqhjXReQz2fIm2QvpYGDovAC+DlreQcVlzdBa1FDd
         OVUptazLcHOrSRCOUgymBLyFKZZ9z/DjFTAZ1sHz87uXxZtwcEWx2aF/ukrw+PeDoO
         ituL3Ad1WRarsq+F875q3j5YSlXpS2oq7Vw8iK8c=
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
Subject: [PATCH 6.1 011/149] selftests: forwarding: Set default IPv6 traceroute utility
Date:   Sun, 13 Aug 2023 23:17:36 +0200
Message-ID: <20230813211719.137290885@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
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

commit 38f7c44d6e760a8513557e27340d61b820c91b8f upstream.

The test uses the 'TROUTE6' environment variable to encode the name of
the IPv6 traceroute utility. By default (without a configuration file),
this variable is not set, resulting in failures:

 # ./ip6_forward_instats_vrf.sh
 TEST: ping6                                                         [ OK ]
 TEST: Ip6InTooBigErrors                                             [ OK ]
 TEST: Ip6InHdrErrors                                                [FAIL]
 TEST: Ip6InAddrErrors                                               [ OK ]
 TEST: Ip6InDiscards                                                 [ OK ]

Fix by setting a default utility name and skip the test if the utility
is not present.

Fixes: 0857d6f8c759 ("ipv6: When forwarding count rx stats on the orig netdev")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://lore.kernel.org/r/20230808141503.4060661-6-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh |    2 ++
 tools/testing/selftests/net/forwarding/lib.sh                     |    1 +
 2 files changed, 3 insertions(+)

--- a/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh
+++ b/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh
@@ -14,6 +14,8 @@ ALL_TESTS="
 NUM_NETIFS=4
 source lib.sh
 
+require_command $TROUTE6
+
 h1_create()
 {
 	simple_if_init $h1 2001:1:1::2/64
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -30,6 +30,7 @@ REQUIRE_MZ=${REQUIRE_MZ:=yes}
 REQUIRE_MTOOLS=${REQUIRE_MTOOLS:=no}
 STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
 TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
+TROUTE6=${TROUTE6:=traceroute6}
 
 relative_path="${BASH_SOURCE%/*}"
 if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then


