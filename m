Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B8F79BA50
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239088AbjIKVRB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241323AbjIKPGi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:06:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF074FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:06:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C80C433C8;
        Mon, 11 Sep 2023 15:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444794;
        bh=1Ys1HDMifCoyYMdonIIOdP55VVHEsIP2nS9nHZZbohs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W1HInhBc4s+DggDhWJ/o3Ayf5iEP8p2ex75bVFEa/5bwaacYJsK4C3ra1Ea6SyQLQ
         oBzio4VI+wNrexSmOk80+HCMflSTNdwZKMxv62AkmID5sL0uBxe0/h+mCoqnunViMg
         +/lK6DEDZIhQ0BjT7OgosdtroaspFt51TNtKt1QQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 117/600] sched/psi: Select KERNFS as needed
Date:   Mon, 11 Sep 2023 15:42:30 +0200
Message-ID: <20230911134637.066539223@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 98dfdd9ee93995a408192dbbf3dd219ba23e3738 ]

Users of KERNFS should select it to enforce its being built, so
do this to prevent a build error.

In file included from ../kernel/sched/build_utility.c:97:
../kernel/sched/psi.c: In function 'psi_trigger_poll':
../kernel/sched/psi.c:1479:17: error: implicit declaration of function 'kernfs_generic_poll' [-Werror=implicit-function-declaration]
 1479 |                 kernfs_generic_poll(t->of, wait);

Fixes: aff037078eca ("sched/psi: use kernfs polling functions for PSI trigger polling")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Suren Baghdasaryan <surenb@google.com>
Link: lore.kernel.org/r/202307310732.r65EQFY0-lkp@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index 2028ed4d50f5b..de255842f5d09 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -627,6 +627,7 @@ config TASK_IO_ACCOUNTING
 
 config PSI
 	bool "Pressure stall information tracking"
+	select KERNFS
 	help
 	  Collect metrics that indicate how overcommitted the CPU, memory,
 	  and IO capacity are in the system.
-- 
2.40.1



