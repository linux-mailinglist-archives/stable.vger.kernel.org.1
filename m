Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670627B8E2E
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 22:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjJDUi1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 16:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjJDUi0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 16:38:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E307D9
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 13:38:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131DBC433C7;
        Wed,  4 Oct 2023 20:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696451902;
        bh=QfFTBi9KEdkLlgzoc5JzYXAlZ6hSq3LJtQETAQwzrDQ=;
        h=From:Subject:Date:To:Cc:From;
        b=PhCZJsNgjRFjHgA6y0xPEznwTA5TvFKpcL1iQyMRaP8vIS0rEVKMjEg8Q9Hzhgka3
         rRr4XB8JbUJBLLX22WALJBI5vZzcxoRgkC3tAAwy9Dl9QjxuQA/uZmoIvrvt0oRD9/
         Raxs+dulx5vfv+f/YCYPuTBVki2gEj/+oog2mDQFkmCcVz4XCD/VNQorfZ5sYwhezP
         41c5RPBW9AuF4+DkrHMh9BVgc2z/WGAYDuR4DSv0rBwdDahuKqPexuY9vEqu5QY3hJ
         Ds+pkivdgU0Vt88h7KoTzk0JxVI++qO9MJHmbNqacQ70t1820NspbEz10uH/9zNVxO
         F1I4cPFFZVo7w==
From:   Mat Martineau <martineau@kernel.org>
Subject: [PATCH net 0/3] mptcp: Fixes and maintainer email update for v6.6
Date:   Wed, 04 Oct 2023 13:38:10 -0700
Message-Id: <20231004-send-net-20231004-v1-0-28de4ac663ae@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADLNHWUC/z2MQQqAIBREryJ/naAmBF0lWkSO9Te/0IhAvHvSo
 uUb3rxCGYmRaVSFEm7OfEgD2yla90U2aA6NyRnXW2O8zpCgBZf+lwHWO4cQojfUfmdC5OdrTtR
 Mmmt9Aa+jY0doAAAA
To:     Matthieu Baerts <matttbe@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matttbe@kernel.org>
Cc:     netdev@vger.kernel.org, mptcp@lists.linux.dev,
        Kishen Maloor <kishen.maloor@intel.com>,
        Florian Westphal <fw@strlen.de>,
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

Patch 1 addresses a race condition in MPTCP "delegated actions"
infrastructure. Affects v5.19 and later.

Patch 2 removes an unnecessary restriction that did not allow additional
outgoing subflows using the local address of the initial MPTCP subflow.
v5.16 and later.

Patch 3 updates Matthieu's email address.

Signed-off-by: Mat Martineau <martineau@kernel.org>
---
Geliang Tang (1):
      mptcp: userspace pm allow creating id 0 subflow

Matthieu Baerts (1):
      MAINTAINERS: update Matthieu's email address

Paolo Abeni (1):
      mptcp: fix delegated action races

 .mailmap                 |  1 +
 MAINTAINERS              |  2 +-
 net/mptcp/pm_userspace.c |  6 ------
 net/mptcp/protocol.c     | 28 ++++++++++++++--------------
 net/mptcp/protocol.h     | 35 ++++++++++++-----------------------
 net/mptcp/subflow.c      | 10 ++++++++--
 6 files changed, 36 insertions(+), 46 deletions(-)
---
base-commit: 0add5c597f3253a9c6108a0a81d57f44ab0d9d30
change-id: 20231004-send-net-20231004-7e1422eddf40

Best regards,
-- 
Mat Martineau <martineau@kernel.org>

