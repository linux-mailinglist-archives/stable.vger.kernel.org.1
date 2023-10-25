Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249DC7D78A8
	for <lists+stable@lfdr.de>; Thu, 26 Oct 2023 01:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjJYXhP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 19:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJYXhO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 19:37:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCC9181
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 16:37:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F83C433CC;
        Wed, 25 Oct 2023 23:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698277032;
        bh=FSAtE+zTZHOTHK+nbnYCG0cPYtBr9fiZYXPBuLJCWXg=;
        h=From:Subject:Date:To:Cc:From;
        b=gHx2IQSsCfscN2H0LDbAUTDY3Z26HwWwJooRc1L78El1Meb+mUwcIpSFRXwgMEzve
         u+k5hy4P6Fmi/lXr/8YSJzVeCejhg0SUWqbZ2QXUYs9ayMxRrXVZipzJA0nyv4fc0b
         kKwoOCNO5j2xPXDBLT5XatCcr2rcCmgzjOBWUvKKU9xwpXPQPg+LvRJ1vBZzptVqX/
         60PhWaaPuna//1x1AVlG587JshjkP+w3wlXMf7Lbpx9MceSjkrT/WBRMPnAmPIzrly
         NAb6/ILLuVYFnE0T6x5PnR5qfMRGPAMyYcGLmiU07d/CP1Vw6KYKJFP5xj0mfLlchE
         h5XJLzrWDCgZA==
From:   Mat Martineau <martineau@kernel.org>
Subject: [PATCH net-next 00/10] mptcp: Fixes and cleanup for v6.7
Date:   Wed, 25 Oct 2023 16:37:01 -0700
Message-Id: <20231025-send-net-next-20231025-v1-0-db8f25f798eb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ2mOWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAyNT3eLUvBTdvNQSIK4o0YULmyWlGKSmGqVYpJinKAE1FxSlpmVWgA2
 OVoIpV4qtrQUA+M7qI3IAAAA=
To:     Matthieu Baerts <matttbe@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Kishen Maloor <kishen.maloor@intel.com>
Cc:     netdev@vger.kernel.org, mptcp@lists.linux.dev,
        Mat Martineau <martineau@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This series includes three initial patches that we had queued in our
mptcp-net branch, but given the likely timing of net/net-next syncs this
week, the need to avoid introducing branch conflicts, and another batch
of net-next patches pending in the mptcp tree, the most practical route
is to send everything for net-next.

Patches 1 & 2 fix some intermittent selftest failures by adjusting timing.

Patch 3 removes an unneccessary userspace path manager restriction on
the removal of subflows with subflow ID 0.

The remainder of the patches are all cleanup or selftest changes:

Patches 4-8 clean up kernel code by removing unused parameters, making
more consistent use of existing helper functions, and reducing extra
casting of socket pointers.

Patch 9 removes an unused variable in a selftest script.

Patch 10 adds a little more detail to some mptcp_join test output.

Signed-off-by: Mat Martineau <martineau@kernel.org>
---
Geliang Tang (10):
      selftests: mptcp: run userspace pm tests slower
      selftests: mptcp: fix wait_rm_addr/sf parameters
      mptcp: userspace pm send RM_ADDR for ID 0
      mptcp: drop useless ssk in pm_subflow_check_next
      mptcp: use mptcp_check_fallback helper
      mptcp: use mptcp_get_ext helper
      mptcp: move sk assignment statement ahead
      mptcp: define more local variables sk
      selftests: mptcp: sockopt: drop mptcp_connect var
      selftests: mptcp: display simult in extra_msg

 net/mptcp/pm.c                                     |  2 +-
 net/mptcp/pm_userspace.c                           | 81 +++++++++++++++++-----
 net/mptcp/protocol.c                               |  6 +-
 net/mptcp/protocol.h                               |  4 +-
 net/mptcp/sockopt.c                                |  2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 23 ++++--
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  1 -
 7 files changed, 88 insertions(+), 31 deletions(-)
---
base-commit: 8846f9a04b10b7f61214425409838d764df7080d
change-id: 20231025-send-net-next-20231025-6bd0ee2d8d7d

Best regards,
-- 
Mat Martineau <martineau@kernel.org>

