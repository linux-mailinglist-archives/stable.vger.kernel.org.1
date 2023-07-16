Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0469A75518A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjGPT5g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjGPT5f (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:57:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FF6EE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:57:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2B7C60DFD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97660C433C8;
        Sun, 16 Jul 2023 19:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537454;
        bh=gSFMdE26uMJr+YJfjdvUfjH0EENDnqfNzD2H+Ozblc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NNTrN0xLD3SORk76ZNkefNJUjKXlERqe+sM0nQXlq/9vyUEptbk4BQqiXNbHS3QvX
         cWhZsT15pXHL+oHCsQ3MVwCDiD64e3QDDT0Yf2sDC9bQglQywpk+fNQb9klag3qaII
         nM4enKc7DTCKzjt0xIRjrlQb0OlwFLn/Khjqm3C0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 084/800] rcutorture: Correct name of use_softirq module parameter
Date:   Sun, 16 Jul 2023 21:38:57 +0200
Message-ID: <20230716194951.059475993@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paul E. McKenney <paulmck@kernel.org>

[ Upstream commit b409afe0268faeb77267f028ea85f2d93438fced ]

The BUSTED-BOOST and TREE03 scenarios specify a mythical tree.use_softirq
module parameter, which means a failure to get full test coverage.  This
commit therefore corrects the name to rcutree.use_softirq.

Fixes: e2b949d54392 ("rcutorture: Make TREE03 use real-time tree.use_softirq setting")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot  | 2 +-
 tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
index f57720c52c0f9..84f6bb98ce993 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
@@ -5,4 +5,4 @@ rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
 rcutree.kthread_prio=2
 threadirqs
-tree.use_softirq=0
+rcutree.use_softirq=0
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
index 64f864f1f361f..8e50bfd4b710d 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
@@ -4,4 +4,4 @@ rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
 rcutree.kthread_prio=2
 threadirqs
-tree.use_softirq=0
+rcutree.use_softirq=0
-- 
2.39.2



