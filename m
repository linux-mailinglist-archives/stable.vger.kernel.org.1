Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E2C79B70D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbjIKVSU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241300AbjIKPGO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:06:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A18FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:06:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7ECC433C8;
        Mon, 11 Sep 2023 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444769;
        bh=9NUDY4c+yoLTRB4PP3SUcIeC0bX4tJWqlTLynlYkS1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=di1Xm4NDzUe1IW0Iq5HUIw50yMnmYtXXETHCqlXZaayM+m9tRYXrW5nXbZ8EtFabq
         C1fKemQN743Cpy73bAk2HmRD4UYDU5yFvxQPNfdgT5BpHUj9VfQOFZ4eho270NvI58
         aFBf7tomokqHgLyOm9P1skGUKT5GDrk2VhBuWyuc=
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
Subject: [PATCH 6.1 109/600] ARM: ptrace: Restore syscall skipping for tracers
Date:   Mon, 11 Sep 2023 15:42:22 +0200
Message-ID: <20230911134636.819377001@linuxfoundation.org>
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

[ Upstream commit 4697b5848bd933f68ebd04836362c8de0cacaf71 ]

Since commit 4e57a4ddf6b0 ("ARM: 9107/1: syscall: always store
thread_info->abi_syscall"), the seccomp selftests "syscall_errno"
and "syscall_faked" have been broken. Both seccomp and PTRACE depend
on using the special value of "-1" for skipping syscalls. This value
wasn't working because it was getting masked by __NR_SYSCALL_MASK in
both PTRACE_SET_SYSCALL and get_syscall_nr().

Explicitly test for -1 in PTRACE_SET_SYSCALL and get_syscall_nr(),
leaving it exposed when present, allowing tracers to skip syscalls
again.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Fixes: 4e57a4ddf6b0 ("ARM: 9107/1: syscall: always store thread_info->abi_syscall")
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20230810195422.2304827-2-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/include/asm/syscall.h | 3 +++
 arch/arm/kernel/ptrace.c       | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index dfeed440254a8..fe4326d938c18 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -25,6 +25,9 @@ static inline int syscall_get_nr(struct task_struct *task,
 	if (IS_ENABLED(CONFIG_AEABI) && !IS_ENABLED(CONFIG_OABI_COMPAT))
 		return task_thread_info(task)->abi_syscall;
 
+	if (task_thread_info(task)->abi_syscall == -1)
+		return -1;
+
 	return task_thread_info(task)->abi_syscall & __NR_SYSCALL_MASK;
 }
 
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index bfe88c6e60d58..cef106913ab7b 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -785,8 +785,9 @@ long arch_ptrace(struct task_struct *child, long request,
 			break;
 
 		case PTRACE_SET_SYSCALL:
-			task_thread_info(child)->abi_syscall = data &
-							__NR_SYSCALL_MASK;
+			if (data != -1)
+				data &= __NR_SYSCALL_MASK;
+			task_thread_info(child)->abi_syscall = data;
 			ret = 0;
 			break;
 
-- 
2.40.1



