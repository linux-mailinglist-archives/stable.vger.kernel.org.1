Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACCA7A3B07
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240570AbjIQULu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240594AbjIQULf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:11:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B399B5
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:11:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B939C433C7;
        Sun, 17 Sep 2023 20:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981489;
        bh=xPjn7kaaAJWedm4jTVgGZEpD6jlDa/lK8uvC85bs464=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRvoaWK7ZzKWZFLkMRdZxYLCRrEiAxTMfUGvyRlZJ2/R8GL7C9F1RCD15wDfuoiGn
         WzqFmItWM3TRaLeOxxUkwGW5+bbEPbOYWWB1EWwO/+3IiwBTvy8sR8nVy5WwuadidD
         4sVUBcapE+1MUGWECigYlVYLbyHIwJ51GWkVMvP0=
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
Subject: [PATCH 5.15 062/511] ARM: ptrace: Restore syscall skipping for tracers
Date:   Sun, 17 Sep 2023 21:08:09 +0200
Message-ID: <20230917191115.382954440@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 24c19d63ff0a1..95bf70ebd878e 100644
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
index 43b963ea4a0e2..71c98ca3a455a 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -786,8 +786,9 @@ long arch_ptrace(struct task_struct *child, long request,
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



