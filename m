Return-Path: <stable+bounces-129198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 122FCA7FE80
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8FD44208B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BF8269899;
	Tue,  8 Apr 2025 11:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E78NVMyu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039B26988A;
	Tue,  8 Apr 2025 11:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110382; cv=none; b=hjeqGJJS8DkLwDFYGI7+5lcegadZlulL+KyDXULlJpE5dgtyBTwZkxqYreiufABVek/Xvpue0dfD36eApiyNbIz/K8WNd2Qx8gDjfEH/91kRh8yk5rdwnz/w/ltOVexY1k+DXmtE55nUJzj4uKsUB/bna9eLmIl6GJT0fH6y/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110382; c=relaxed/simple;
	bh=JZLaGGhi98l2h9URx/5qTaNr0ILeTesuZ8EbDPdayEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4J9wnfMGDdhPhBBr+MQgv/+Nlcv1H3uQ5ZvMLQ0XbY9z1IBAqVC77PLRUI7kNaXjhNI33f+jwcDoD7FUOToe/Hva6qyFsoZ9rCM4ctVMJHW8tSiSCErxVJaVDKBuiV7RLYb+1VJJrS5iAcCMRDv1UQlnrvijUhmW+KMP4uOMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E78NVMyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3158AC4CEEB;
	Tue,  8 Apr 2025 11:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744110382;
	bh=JZLaGGhi98l2h9URx/5qTaNr0ILeTesuZ8EbDPdayEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E78NVMyu/XcCNdO1b8lzRNi140yZ8a67J4rq6N6ETk/CW5ydhce7PB5SQsSyrwoL8
	 c4ZyvksEjaJ86u46xI9V0aiwmSBntWvjKwiQN8vDpFcHLs5LvShh7YVoBx700a2+8S
	 cRWlAnBSka3nKRIfHSGL2OORgxBBVY3cMe0uOrjA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oleg Nesterov <oleg@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 007/731] seccomp: fix the __secure_computing() stub for !HAVE_ARCH_SECCOMP_FILTER
Date: Tue,  8 Apr 2025 12:38:24 +0200
Message-ID: <20250408104914.429719733@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit b37778bec82ba82058912ca069881397197cd3d5 ]

Depending on CONFIG_HAVE_ARCH_SECCOMP_FILTER, __secure_computing(NULL)
will crash or not. This is not consistent/safe, especially considering
that after the previous change __secure_computing(sd) is always called
with sd == NULL.

Fortunately, if CONFIG_HAVE_ARCH_SECCOMP_FILTER=n, __secure_computing()
has no callers, these architectures use secure_computing_strict(). Yet
it make sense make __secure_computing(NULL) safe in this case.

Note also that with this change we can unexport secure_computing_strict()
and change the current callers to use __secure_computing(NULL).

Fixes: 8cf8dfceebda ("seccomp: Stub for !HAVE_ARCH_SECCOMP_FILTER")
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20250128150307.GA15325@redhat.com
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/seccomp.h |  8 ++------
 kernel/seccomp.c        | 14 ++++++++++----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index e45531455d3bb..d55949071c30e 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -22,8 +22,9 @@
 #include <linux/atomic.h>
 #include <asm/seccomp.h>
 
-#ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
 extern int __secure_computing(const struct seccomp_data *sd);
+
+#ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
 static inline int secure_computing(void)
 {
 	if (unlikely(test_syscall_work(SECCOMP)))
@@ -32,11 +33,6 @@ static inline int secure_computing(void)
 }
 #else
 extern void secure_computing_strict(int this_syscall);
-static inline int __secure_computing(const struct seccomp_data *sd)
-{
-	secure_computing_strict(sd->nr);
-	return 0;
-}
 #endif
 
 extern long prctl_get_seccomp(void);
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 7bbb408431ebc..3231f63d93d89 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -29,13 +29,11 @@
 #include <linux/syscalls.h>
 #include <linux/sysctl.h>
 
+#include <asm/syscall.h>
+
 /* Not exposed in headers: strictly internal use only. */
 #define SECCOMP_MODE_DEAD	(SECCOMP_MODE_FILTER + 1)
 
-#ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
-#include <asm/syscall.h>
-#endif
-
 #ifdef CONFIG_SECCOMP_FILTER
 #include <linux/file.h>
 #include <linux/filter.h>
@@ -1074,6 +1072,14 @@ void secure_computing_strict(int this_syscall)
 	else
 		BUG();
 }
+int __secure_computing(const struct seccomp_data *sd)
+{
+	int this_syscall = sd ? sd->nr :
+		syscall_get_nr(current, current_pt_regs());
+
+	secure_computing_strict(this_syscall);
+	return 0;
+}
 #else
 
 #ifdef CONFIG_SECCOMP_FILTER
-- 
2.39.5




