Return-Path: <stable+bounces-103588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD4F9EF7CC
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1C528B85E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73439222D7C;
	Thu, 12 Dec 2024 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e98KE+qE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDB315696E;
	Thu, 12 Dec 2024 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025018; cv=none; b=vGHnyCmCgpGlellJtdYrvBCHzAI3lqupA8EiuI/i1vjWK+BufSi7fX8nDGRIEZj/35p7VfKWkcrJ+A4zk/xpu4nhuVpORv2OIEfGPEyfTyUdKSo2DQDx3+h9BBkPwu6sz8mkH0dk0j77Az33EPtnZ+xks1cQA9s0D5BcGq94Ghk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025018; c=relaxed/simple;
	bh=XpaH0DW6U8G7/pOFoocJ8v0cF6yOTdVTeIOdI07S07E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1nwO0KYiPr1GJbkAaKLkz7Qk0KjqgKuqUb7h2kvVblCQ2wI/SO9aAVCnuKVqfCGDqUQojvzR6FXUSa46thcLiCglSj37teNfd0AbvtW/51zkiDIw61yNTw9En3FCp98/PszG+R74+WswoyxlP77s0rITQzT4V+EcBzgBeyh6po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e98KE+qE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA137C4CECE;
	Thu, 12 Dec 2024 17:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025018;
	bh=XpaH0DW6U8G7/pOFoocJ8v0cF6yOTdVTeIOdI07S07E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e98KE+qEaqBssQm2eKKK8m2zi0zd8IFPXF/x7qtRiKMv3b8Hu86dvA66v+5oGpxPd
	 QVzt0z/UV5JubYE4xyrCzntL60wZNh/4Vb5XISngfjkaXfQ85u4MPFRCHyaLW7F/eq
	 NoMPKHRopkOoiyqNIzMS4gbDfo+IcHFeQK4shpds=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 028/321] x86/xen/pvh: Annotate indirect branch as safe
Date: Thu, 12 Dec 2024 15:59:06 +0100
Message-ID: <20241212144231.115210392@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

[ Upstream commit 82694854caa8badab7c5d3a19c0139e8b471b1d3 ]

This indirect jump is harmless; annotate it to keep objtool's retpoline
validation happy.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/4797c72a258b26e06741c58ccd4a75c42db39c1d.1611263462.git.jpoimboe@redhat.com
Stable-dep-of: e8fbc0d9cab6 ("x86/pvh: Call C code via the kernel virtual mapping")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/platform/pvh/head.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 1f8825bbaffbf..efd615d397d22 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -16,6 +16,7 @@
 #include <asm/boot.h>
 #include <asm/processor-flags.h>
 #include <asm/msr.h>
+#include <asm/nospec-branch.h>
 #include <xen/interface/elfnote.h>
 
 	__HEAD
@@ -105,6 +106,7 @@ ENTRY(pvh_start_xen)
 	/* startup_64 expects boot_params in %rsi. */
 	mov $_pa(pvh_bootparams), %rsi
 	mov $_pa(startup_64), %rax
+	ANNOTATE_RETPOLINE_SAFE
 	jmp *%rax
 
 #else /* CONFIG_X86_64 */
-- 
2.43.0




