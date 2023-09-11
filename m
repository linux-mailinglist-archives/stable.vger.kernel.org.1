Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0A279BEA7
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbjIKVE3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbjIKObR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:31:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09A0F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:31:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B31C433C8;
        Mon, 11 Sep 2023 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442673;
        bh=4ahIq3wP3mk0HetFg/ww5WsQl6vAS9pOb8us1GUdi44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IhyniWyWbcgBeuG1SMEax55pJpK3G0jpKpPwosteZV/qjrmNL+iXoI7HBrH2iyiJe
         zjZuW2gF+hJGTyOn9s/e1F6TRnz16+Ty7IoNQpBpe38ATtNIivH/asIxh/MKiNzffz
         Bdp4VDp4vwaOALqJrokXANTCoQetoVzI4Kd7v73o=
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
Subject: [PATCH 6.4 107/737] ARM: ptrace: Restore syscall restart tracing
Date:   Mon, 11 Sep 2023 15:39:26 +0200
Message-ID: <20230911134653.498855239@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

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
index 03d4c5578c5c9..b60bba3c1d516 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -90,6 +90,7 @@ slow_work_pending:
 	cmp	r0, #0
 	beq	no_work_pending
 	movlt	scno, #(__NR_restart_syscall - __NR_SYSCALL_BASE)
+	str	scno, [tsk, #TI_ABI_SYSCALL]	@ make sure tracers see update
 	ldmia	sp, {r0 - r6}			@ have to reload r0 - r6
 	b	local_restart			@ ... and off we go
 ENDPROC(ret_fast_syscall)
-- 
2.40.1



