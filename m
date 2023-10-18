Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524D57CE643
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 20:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjJRSYF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 14:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjJRSYE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 14:24:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F06D10F
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 11:24:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFF5C433C9;
        Wed, 18 Oct 2023 18:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697653442;
        bh=MqbWF9KWr+fDWmDuFscKuEg2a6ksnYydthQmw8YMP5s=;
        h=From:Subject:Date:To:Cc:From;
        b=nW1vBzhRpKtassDHekDkfjI+vv/pSTzuWk2CiSts7XikL1l5NTOqbC75zCZ8YeTH0
         ap+pxSuITI7ioEFdrkraehPbRZ8AUkqjcBHaL2sSNujqkMz/OZ5SaWOb2wVKGFIkeL
         wemtcEhXS/S+IukTe2noizSNwiCzdeOIZL1K9aylYoJ1mcisZTb0I/WpgdiYrk+6O8
         GF8tIQhScJAuvzWbKL1YNbguMJAKuc6bAQ5tL31qjprEdSCmpaXYg/RmFuyGF5fAMW
         A9CIV8w5LRXBcnEOk0sFuIJNWPfw3ZTLAHnyaZRmQhN/Lf2ISy0fQM8co72NJop2BO
         pjUad1Z3NBwRA==
From:   Mat Martineau <martineau@kernel.org>
Subject: [PATCH net 0/5] mptcp: Fixes for v6.6
Date:   Wed, 18 Oct 2023 11:23:51 -0700
Message-Id: <20231018-send-net-20231018-v1-0-17ecb002e41d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALciMGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDA0ML3eLUvBTdvNQSXbhIYrJZkrFFSpqBaaqRElBfQVFqWmYF2MxoJaB
 KpdjaWgAcInu2aAAAAA==
To:     Matthieu Baerts <matttbe@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Davide Caratti <dcaratti@redhat.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Florian Westphal <fw@strlen.de>
Cc:     netdev@vger.kernel.org, mptcp@lists.linux.dev,
        Mat Martineau <martineau@kernel.org>, stable@vger.kernel.org,
        Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Patch 1 corrects the logic for MP_JOIN tests where 0 RSTs are expected.

Patch 2 ensures MPTCP packets are not incorrectly coalesced in the TCP
backlog queue.

Patch 3 avoids a zero-window probe and associated WARN_ON_ONCE() in an
expected MPTCP reinjection scenario.

Patches 4 & 5 allow an initial MPTCP subflow to be closed cleanly
instead of always sending RST. Associated selftest is updated.

Signed-off-by: Mat Martineau <martineau@kernel.org>
---
Geliang Tang (1):
      mptcp: avoid sending RST when closing the initial subflow

Matthieu Baerts (2):
      selftests: mptcp: join: correctly check for no RST
      selftests: mptcp: join: no RST when rm subflow/addr

Paolo Abeni (2):
      tcp: check mptcp-level constraints for backlog coalescing
      mptcp: more conservative check for zero probes

 net/ipv4/tcp_ipv4.c                             |  1 +
 net/mptcp/protocol.c                            | 36 ++++++++++++++++---------
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 21 +++++++++++++--
 3 files changed, 43 insertions(+), 15 deletions(-)
---
base-commit: 2915240eddba96b37de4c7e9a3d0ac6f9548454b
change-id: 20231018-send-net-20231018-ac6b38df05e2

Best regards,
-- 
Mat Martineau <martineau@kernel.org>

