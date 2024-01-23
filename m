Return-Path: <stable+bounces-13841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574BC837E56
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10A51F259DC
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D6A5FB93;
	Tue, 23 Jan 2024 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OzRrEvZw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9995FB83;
	Tue, 23 Jan 2024 00:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970522; cv=none; b=PxAJGefEJkJdc2if6JZqnBp5DHZqSnd0nFSdMnIQMyoSE1yHgTIqDNSfL31qoRWBJOzUaijnOKOhwpE5LXRJpSmlD05aSGKn4zjJ4C+lgI5JzsP66DXbVbQht9/MBce71jBvIIfAgdhKHI03DkxwBy9AeKomMyvsqu+nsjfrDp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970522; c=relaxed/simple;
	bh=d52TbtdH78GZdSKh8DVgIWskwZM2FCFKoPKksAh/FUk=;
	h=Date:To:From:Subject:Message-Id; b=ViWz+HjPznPa9vQcTZPlxf5i2MJRpAzo270iy+0S1bIA/eVhGAJnhytYpNIggVlAte5lnS2/kfoMQbZxRdmE2NVF71b9asUUaG6V7W82zbLMLrGocOyqJ90K63Jr0ErT6sOv/swXkzrdfNRcPS9RR/bNeyOekjwNh6dOomHEOV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OzRrEvZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE11C433F1;
	Tue, 23 Jan 2024 00:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705970521;
	bh=d52TbtdH78GZdSKh8DVgIWskwZM2FCFKoPKksAh/FUk=;
	h=Date:To:From:Subject:From;
	b=OzRrEvZwyWnvG9/3tg/sY+L81SyVYK/9QjJztC7nKluFpfZLyLK6BfP/gtHiNj7jN
	 Ot9sfr9ofQpZEWTlzQLqCChiu+pOo1hTWU0HsBJtFGSFWeUKU/U2vrDbFMCNgt5ESx
	 H5Ob4aMhPukdHvszxd5gZSm6hsmqzH+Q+FXK0JGM=
Date: Mon, 22 Jan 2024 16:41:58 -0800
To: mm-commits@vger.kernel.org,will@kernel.org,stable@vger.kernel.org,samitolvanen@google.com,samuel.holland@sifive.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + scs-add-config_mmu-dependency-for-vfree_atomic.patch added to mm-hotfixes-unstable branch
Message-Id: <20240123004201.4EE11C433F1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: scs: add CONFIG_MMU dependency for vfree_atomic()
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     scs-add-config_mmu-dependency-for-vfree_atomic.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/scs-add-config_mmu-dependency-for-vfree_atomic.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Samuel Holland <samuel.holland@sifive.com>
Subject: scs: add CONFIG_MMU dependency for vfree_atomic()
Date: Mon, 22 Jan 2024 09:52:01 -0800

The shadow call stack implementation fails to build without CONFIG_MMU:

  ld.lld: error: undefined symbol: vfree_atomic
  >>> referenced by scs.c
  >>>               kernel/scs.o:(scs_free) in archive vmlinux.a

Link: https://lkml.kernel.org/r/20240122175204.2371009-1-samuel.holland@sifive.com
Fixes: a2abe7cbd8fe ("scs: switch to vmapped shadow stacks")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/Kconfig~scs-add-config_mmu-dependency-for-vfree_atomic
+++ a/arch/Kconfig
@@ -668,6 +668,7 @@ config SHADOW_CALL_STACK
 	bool "Shadow Call Stack"
 	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
 	depends on DYNAMIC_FTRACE_WITH_ARGS || DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
+	depends on MMU
 	help
 	  This option enables the compiler's Shadow Call Stack, which
 	  uses a shadow stack to protect function return addresses from
_

Patches currently in -mm which might be from samuel.holland@sifive.com are

scs-add-config_mmu-dependency-for-vfree_atomic.patch


