Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4F1721C7E
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 05:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjFEDZb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 4 Jun 2023 23:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjFEDZa (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 4 Jun 2023 23:25:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE474CA
        for <stable@vger.kernel.org>; Sun,  4 Jun 2023 20:25:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74B0661142
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 03:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80613C433EF;
        Mon,  5 Jun 2023 03:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685935528;
        bh=ykcDhIkIKHonAYObMsjSf4+ZeFZ33xoCZovgTPucXpM=;
        h=From:Subject:Date:To:Cc:From;
        b=BGJ/ZPIbDyls/WgfdWnuJgS1o0PIuSCUvYDizjU+DlBBf0kis1peUHd2jc4gwhcWP
         UQ+qHedLhdPc6WYFMsungWipORdopstDDaDnBBrWNl/6cmVW1SKEKCRiiN4Y2oJ4rd
         aHXYGWWaT3u0fiX8eUOoCK5NckJn1RvAAAWdzsbVGV3e6Iv66t+wCW1J1MhHjvgV8b
         sAYHma8RhBkz+3y6lAgDJumWyStrxYVmg6GQsCZrkbrzV0z9q6IHpeoX8n53mYMqAO
         ONnZVqAr+YtiXY30j9sbtDGk5J0zxAh0IfTYi+mMn8X3FvCQnTmSgNgFmzIBECzmdb
         ibsrNtnbNdSbQ==
From:   Mat Martineau <martineau@kernel.org>
Subject: [PATCH net 0/5] mptcp: Fixes for address advertisement
Date:   Sun, 04 Jun 2023 20:25:16 -0700
Message-Id: <20230602-send-net-20230602-v1-0-fe011dfa859d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJxVfWQC/z2NSw6DMAxEr4K8rqUQ/r1K1UUS3OIFBsWoqoS4O
 wkLlvNmnmYHpcik8Cx2iPRj5UVSKB8FhMnJl5DHlMEaW5nWWFSSEYU2vMngbOu7JtTG95A875T
 QRydhyuY2r3mfmzXSh//X2wsyex/HCV7GQX6CAAAA
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kishen Maloor <kishen.maloor@intel.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Florian Westphal <fw@strlen.de>
Cc:     netdev@vger.kernel.org, mptcp@lists.linux.dev,
        Mat Martineau <martineau@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Patches 1 and 2 allow address advertisements to be removed without
affecting current connected subflows, and updates associated self tests.

Patches 3 and 4 correctly track (and allow removal of) addresses that
were implicitly announced as part of subflow creation. Also updates
associated self tests.

Patch 5 makes subflow and address announcement counters work consistently
between the userspace and in-kernel path managers.

Signed-off-by: Mat Martineau <martineau@kernel.org>
---
Geliang Tang (5):
      mptcp: only send RM_ADDR in nl_cmd_remove
      selftests: mptcp: update userspace pm addr tests
      mptcp: add address into userspace pm list
      selftests: mptcp: update userspace pm subflow tests
      mptcp: update userspace pm infos

 net/mptcp/pm.c                                  | 23 +++++++++---
 net/mptcp/pm_netlink.c                          | 18 ++++++++++
 net/mptcp/pm_userspace.c                        | 48 ++++++++++++++++++++++++-
 net/mptcp/protocol.h                            |  1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 +++++-
 5 files changed, 95 insertions(+), 6 deletions(-)
---
base-commit: 37a826d86ff746c4eac8bd3415af19f3c9598206
change-id: 20230602-send-net-20230602-9a26b75c40b8

Best regards,
-- 
Mat Martineau <martineau@kernel.org>

