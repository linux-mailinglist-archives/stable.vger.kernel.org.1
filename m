Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6439879B46D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbjIKVKr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241116AbjIKPCK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:02:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDDE125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:02:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3333C433C8;
        Mon, 11 Sep 2023 15:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444526;
        bh=Lt1DKVdQWbJn/6aPuY3u5XWxJ3qu7InJMh4b+tQNUr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QuJol/dRDdn67F8Sk+Mu9X6nfh002ieyTdYqgmLLlYBSbXvuXky/mfop6y8t8ETH+
         t9k77Es65Sq428jncE1x694hKG21PjC50Gk7fKKzDytM32viqOEY4Se6lQQlvnUIrp
         O2z90PSEvgSzMmZ7QMmsm37dYFEQdtzXcINbplq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 009/600] Revert "MIPS: unhide PATA_PLATFORM"
Date:   Mon, 11 Sep 2023 15:40:42 +0200
Message-ID: <20230911134633.893259953@linuxfoundation.org>
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

From: Maciej W. Rozycki <macro@orcam.me.uk>

[ Upstream commit 1e13da548fbffb807633df85a244b70caa90bdf7 ]

Revert commit 75b18aac6fa3 ("MIPS: unhide PATA_PLATFORM") now that
HAVE_PATA_PLATFORM is set selectively for all the relevant platforms.

Verified with `db1xxx_defconfig' and `sb1250_swarm_defconfig' by making
sure PATA_PLATFORM is still there in `.config' with this change applied,
and with `malta_defconfig' by making sure it's now gone.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cf1fbf4eaa8a0..0e62f5edaee2e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -83,7 +83,6 @@ config MIPS
 	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
-	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-- 
2.40.1



