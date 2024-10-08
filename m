Return-Path: <stable+bounces-81930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F352994A32
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AA31C24C09
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F881DACBE;
	Tue,  8 Oct 2024 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mv5OfBoh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68483190663;
	Tue,  8 Oct 2024 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390617; cv=none; b=NWS7S+Ys3Ho510IaSVooIQNK+/oe+kyk+ehW2LA+QkxECS9SUGq3GR+vrpVn5O654jCiVLFoscJWgOEEJjD5XNRVdAzp8Kqu6TcPy+I3Xm76qVudtRO5MeEXDfAK52IBCQ6zGxPiAui6iILyiMi9ij14AXXYDZ1m+ZaGHwhqH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390617; c=relaxed/simple;
	bh=iLWVpuh7ZDLJF8mciL5Xzxk1+bUt+UjulFw4klEHgV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaH6a8ealVgXmzFhjjyER9uggiFY07DjOs0wna0Uky7AYNhHPIw/ajz+FH70YOBSQS1JtElJ8k8QPp5mv9WQnit0oTQEWM/hLCvPqJaERKqfTCHIQ0eF0fqth1nqQDqt8dHKbzfOgA11WmeOH4qwwShPs3oXRtQUDwtbGl7n2pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mv5OfBoh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7837DC4CEC7;
	Tue,  8 Oct 2024 12:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728390617;
	bh=iLWVpuh7ZDLJF8mciL5Xzxk1+bUt+UjulFw4klEHgV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mv5OfBohBF5VnSttgMgsdKrizDH9TvVoqYxM7sf9COU1fQLY3SWZpnwKo4vPPgIbm
	 6/IeYFZTmb6MU6m+4V58ppboDixg5LAreg597NMGfm95LhC2zOVKLAwir+g+tC8I4B
	 AwAzNH2KHPHTJ9ITOgzs9R7KY8I2hYHFH4vAtWcs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.10 341/482] parisc: Fix 64-bit userspace syscall path
Date: Tue,  8 Oct 2024 14:06:44 +0200
Message-ID: <20241008115701.843106513@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@kernel.org>

commit d24449864da5838936669618356b0e30ca2999c3 upstream.

Currently the glibc isn't yet ported to 64-bit for hppa, so
there is no usable userspace available yet.
But it's possible to manually build a static 64-bit binary
and run that for testing. One such 64-bit test program is
available at http://ftp.parisc-linux.org/src/64bit.tar.gz
and it shows various issues with the existing 64-bit syscall
path in the kernel.
This patch fixes those issues.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org      # v4.19+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/kernel/syscall.S |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/arch/parisc/kernel/syscall.S
+++ b/arch/parisc/kernel/syscall.S
@@ -243,10 +243,10 @@ linux_gateway_entry:
 
 #ifdef CONFIG_64BIT
 	ldil	L%sys_call_table, %r1
-	or,=	%r2,%r2,%r2
-	addil	L%(sys_call_table64-sys_call_table), %r1
+	or,ev	%r2,%r2,%r2
+	ldil	L%sys_call_table64, %r1
 	ldo	R%sys_call_table(%r1), %r19
-	or,=	%r2,%r2,%r2
+	or,ev	%r2,%r2,%r2
 	ldo	R%sys_call_table64(%r1), %r19
 #else
 	load32	sys_call_table, %r19
@@ -379,10 +379,10 @@ tracesys_next:
 	extrd,u	%r19,63,1,%r2			/* W hidden in bottom bit */
 
 	ldil	L%sys_call_table, %r1
-	or,=	%r2,%r2,%r2
-	addil	L%(sys_call_table64-sys_call_table), %r1
+	or,ev	%r2,%r2,%r2
+	ldil	L%sys_call_table64, %r1
 	ldo	R%sys_call_table(%r1), %r19
-	or,=	%r2,%r2,%r2
+	or,ev	%r2,%r2,%r2
 	ldo	R%sys_call_table64(%r1), %r19
 #else
 	load32	sys_call_table, %r19
@@ -1327,6 +1327,8 @@ ENTRY(sys_call_table)
 END(sys_call_table)
 
 #ifdef CONFIG_64BIT
+#undef __SYSCALL_WITH_COMPAT
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
 	.align 8
 ENTRY(sys_call_table64)
 #include <asm/syscall_table_64.h>    /* 64-bit syscalls */



