Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E3D79BFAB
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbjIKV0O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241299AbjIKPGL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:06:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E80FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:06:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66680C433C7;
        Mon, 11 Sep 2023 15:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444766;
        bh=B7YcQQlbXXmRryEeJnE6Ds1PY9emYbf6yhifTVhEHAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aOdzttqPvmLCfQ2Zqe5tvdAU5sdQjD59xWN++LJdXpfjrZOIH1bedPWMLA7akuhOM
         ckAJ8V0pbqcE08oLf+PHNRuRSu9whRAmkQnAsnt59wZLm3YXdp4l9M0QKfkl8WRJyX
         tRand5E1maVHygSI9DoozCzE9oND19f0DHvaGqAk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 108/600] ARM: ptrace: Restore syscall restart tracing
Date:   Mon, 11 Sep 2023 15:42:21 +0200
Message-ID: <20230911134636.787846296@linuxfoundation.org>
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

From: Kees Cook <keescook@chromium.org>

[ Upstream commit cf007647475b5090819c5fe8da771073145c7334 ]

Since commit 4e57a4ddf6b0 ("ARM: 9107/1: syscall: always store
thread_info->abi_syscall"), the seccomp selftests "syscall_restart" has
been broken. This was caused by the restart syscall not being stored to
"abi_syscall" during restart setup before branching to the "local_restart"
label. Tracers would see the wrong syscall, and scno would get overwritten
while returning from the TIF_WORK path. Add the missing store.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Fixes: 4e57a4ddf6b0 ("ARM: 9107/1: syscall: always store thread_info->abi_syscall")
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20230810195422.2304827-1-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/entry-common.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 405a607b754f4..b413b541c3c71 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -103,6 +103,7 @@ slow_work_pending:
 	cmp	r0, #0
 	beq	no_work_pending
 	movlt	scno, #(__NR_restart_syscall - __NR_SYSCALL_BASE)
+	str	scno, [tsk, #TI_ABI_SYSCALL]	@ make sure tracers see update
 	ldmia	sp, {r0 - r6}			@ have to reload r0 - r6
 	b	local_restart			@ ... and off we go
 ENDPROC(ret_fast_syscall)
-- 
2.40.1



