Return-Path: <stable+bounces-49754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7EC8FEEB5
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D8C1C2485F
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7F11A0DEA;
	Thu,  6 Jun 2024 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X5fgK/D4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9331957EB;
	Thu,  6 Jun 2024 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683693; cv=none; b=csUNsXJTwDAEibflkqMb7ORHJZ26bAfUPVUCf0NV/ybmECtJh4vOCSiXy7OSlGFi0Jg9MF0atgAPjX0/S+fPZuc9CHvSleg7KHo1h1VvRn+tKF25bkHJzMpX235nqGD+HS9QbSNGUGtKmvbdsy3brMtN+gC4eQC/nbSRrDYuzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683693; c=relaxed/simple;
	bh=5KQ34ctUQQNzAeWdhZ7m/edVI/rCD85QGoRLvZR2mxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oe52oLIH+B84ddiZFok0G9uLsWqxdH3Juj+lYqbtOlm6E1xrOo75QUwCI2De7rLWgbrMRFqBLr/WsH0+qwoJhNuw7teTBCaunOb4f96oXqXTXZ/UyACusT3PcqlKsxDkvlTrs75U5wE5Chg7DNFnPE1hNYqFUPJKi64XYGnga/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X5fgK/D4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBD0C32781;
	Thu,  6 Jun 2024 14:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683692;
	bh=5KQ34ctUQQNzAeWdhZ7m/edVI/rCD85QGoRLvZR2mxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X5fgK/D4yhT+vj9Dp+NiLuFv0tdWNjPPtf3kqHDLg23pFMnvgg3M4wZmGsoYeC0N2
	 lYoGFFnhKElHYjMe/l59rs/yeLuHPSIVBb8/TnyOFMBkyKdpGtIqalCKmWaU4zwq5K
	 GV//Vzx1D68eq50jYlXsNvv/DQz04C2Wdf+cflXA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 603/744] um: Fix the declaration of kasan_map_memory
Date: Thu,  6 Jun 2024 16:04:35 +0200
Message-ID: <20240606131751.818721545@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiwei Bie <tiwei.btw@antgroup.com>

[ Upstream commit 6a85e34c4d07d2ec0c153067baff338ac0db55ca ]

Make it match its definition (size_t vs unsigned long). And declare
it in a shared header to fix the -Wmissing-prototypes warning, as it
is defined in the user code and called in the kernel code.

Fixes: 5b301409e8bc ("UML: add support for KASAN under x86_64")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/include/asm/kasan.h        | 1 -
 arch/um/include/shared/kern_util.h | 2 ++
 arch/um/os-Linux/mem.c             | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
index 0d6547f4ec85c..f97bb1f7b8514 100644
--- a/arch/um/include/asm/kasan.h
+++ b/arch/um/include/asm/kasan.h
@@ -24,7 +24,6 @@
 
 #ifdef CONFIG_KASAN
 void kasan_init(void);
-void kasan_map_memory(void *start, unsigned long len);
 extern int kasan_um_is_ready;
 
 #ifdef CONFIG_STATIC_LINK
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 444bae755b16a..7372746c16875 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -67,4 +67,6 @@ extern void fatal_sigsegv(void) __attribute__ ((noreturn));
 
 void um_idle_sleep(void);
 
+void kasan_map_memory(void *start, size_t len);
+
 #endif
diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index 8530b2e086049..c6c9495b14321 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -15,6 +15,7 @@
 #include <sys/vfs.h>
 #include <linux/magic.h>
 #include <init.h>
+#include <kern_util.h>
 #include <os.h>
 
 /*
-- 
2.43.0




