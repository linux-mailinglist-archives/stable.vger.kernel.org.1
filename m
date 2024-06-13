Return-Path: <stable+bounces-52031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 868D49072C0
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D62B1F21845
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1E82A1DC;
	Thu, 13 Jun 2024 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oj7sXmIZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF61C32;
	Thu, 13 Jun 2024 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718283031; cv=none; b=cN69qXHoGIvd0hsxZMncEeuZ3DznS7nqoOx7B1PeZUNWdOH/FCmIJYo1YAIeAJmz51epsZSf1F0Xp/ux2HDFUWQzVSBkwmIFYiwKY4VH8GwdbHxr5GUjkaAKP2mkJduExdyYaQqcpcTmwZVEQW/Dr3l4ataZ3AYJMGVndSlRs2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718283031; c=relaxed/simple;
	bh=PgFWK3FdAIsZ/Ess6L4KIwCPORBYhvUayJhoorn5hy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAyFPYUJnVKwGSAimLu/uOeJhGFOp6WZ4/cRETlJK+uGJf6CR7aozMzQ2rtnNPDW0IbzT13CJHqHG850aUQaQoXv4edoku+xKfLU7krW9jht6tZBUO4y+HIcP22EumwRhgtgOp5AZOqZzziiOFJbdh5a0kFtgHCTwk4YYW/5nlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oj7sXmIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAFAC2BBFC;
	Thu, 13 Jun 2024 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718283031;
	bh=PgFWK3FdAIsZ/Ess6L4KIwCPORBYhvUayJhoorn5hy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oj7sXmIZv5JWq+8yIkk2coUjdO1LwaJyhT40Ni2Hk11p2mk6L6W6CY/6SelgT0kCj
	 nna3BKhUImJEgldzhXRJdKCHS+Zd1excyrTNhlV+MsJlT1gdqRTL6xYQqTLc3kZySM
	 cqaDUvcqOuijOJO7Jl9vEcHeG3IRcgD7Zlv4jtQY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.1 75/85] parisc: Define sigset_t in parisc uapi header
Date: Thu, 13 Jun 2024 13:36:13 +0200
Message-ID: <20240613113217.030905818@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113214.134806994@linuxfoundation.org>
References: <20240613113214.134806994@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@kernel.org>

commit 487fa28fa8b60417642ac58e8beda6e2509d18f9 upstream.

The util-linux debian package fails to build on parisc, because
sigset_t isn't defined in asm/signal.h when included from userspace.
Move the sigset_t type from internal header to the uapi header to fix the
build.

Link: https://buildd.debian.org/status/fetch.php?pkg=util-linux&arch=hppa&ver=2.40-7&stamp=1714163443&raw=0
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v6.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/include/asm/signal.h      |   12 ------------
 arch/parisc/include/uapi/asm/signal.h |   10 ++++++++++
 2 files changed, 10 insertions(+), 12 deletions(-)

--- a/arch/parisc/include/asm/signal.h
+++ b/arch/parisc/include/asm/signal.h
@@ -4,23 +4,11 @@
 
 #include <uapi/asm/signal.h>
 
-#define _NSIG		64
-/* bits-per-word, where word apparently means 'long' not 'int' */
-#define _NSIG_BPW	BITS_PER_LONG
-#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
-
 # ifndef __ASSEMBLY__
 
 /* Most things should be clean enough to redefine this at will, if care
    is taken to make libc match.  */
 
-typedef unsigned long old_sigset_t;		/* at least 32 bits */
-
-typedef struct {
-	/* next_signal() assumes this is a long - no choice */
-	unsigned long sig[_NSIG_WORDS];
-} sigset_t;
-
 #include <asm/sigcontext.h>
 
 #endif /* !__ASSEMBLY */
--- a/arch/parisc/include/uapi/asm/signal.h
+++ b/arch/parisc/include/uapi/asm/signal.h
@@ -57,10 +57,20 @@
 
 #include <asm-generic/signal-defs.h>
 
+#define _NSIG		64
+#define _NSIG_BPW	(sizeof(unsigned long) * 8)
+#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
+
 # ifndef __ASSEMBLY__
 
 #  include <linux/types.h>
 
+typedef unsigned long old_sigset_t;	/* at least 32 bits */
+
+typedef struct {
+	unsigned long sig[_NSIG_WORDS];
+} sigset_t;
+
 /* Avoid too many header ordering problems.  */
 struct siginfo;
 



