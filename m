Return-Path: <stable+bounces-160738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB91EAFD19D
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84D35415E8
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211232E5412;
	Tue,  8 Jul 2025 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nUYlGsV+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDBF2DCC02;
	Tue,  8 Jul 2025 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992541; cv=none; b=PDEV1vUcA5K+CIV1cFucjnq3nAY/d9o3rgbZ+n/CuX0za81DlcSQfCTteaM/6zNtEajESVQ/zCes6OIBDCspczI7UP78S7+WjT0t7jXS9sFzWJPT0+temCF3iR3Xjem7jDabEfPAcBvolKil/Jwt5AZBmGVuxz9GMkRktxyjpUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992541; c=relaxed/simple;
	bh=CRiNpyOBWvlfs9Zq7cF8ZpquTyHCfCxLhkC+I9XTQ2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6SYInFGbIBhwJBlgCzFbY+rd/VjXzCUnsXOAFEE6b3tWlOXfy92eNDqeTgtM+3ixSu05c4A5co9iA/R+genWlEhtGH+9klkAvIwxMJYpv8cfpSYyk/EjiWDIcoUaQqxoJFPj+Gjg0tAcEPSNeYvieFIrThkaabGwoO88KCbV4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nUYlGsV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A5DC4CEF5;
	Tue,  8 Jul 2025 16:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992541;
	bh=CRiNpyOBWvlfs9Zq7cF8ZpquTyHCfCxLhkC+I9XTQ2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nUYlGsV+tl9khGhlw/g9ae0ehKyB3OcUXfRaEBJcq0OH1Ag+uJsa7i0C1u2BQgLYP
	 TDIa5Axu6ePFfA7NOlHfRT6oh4MkB3kAXRX0koxmkTg9K5ZluT8VkXr6XAPQ9YUN49
	 gOnAR2ry4bqImwTC8s1nzOS0OS5yOQWz45YNAxQY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.6 127/132] powerpc/kernel: Fix ppc_save_regs inclusion in build
Date: Tue,  8 Jul 2025 18:23:58 +0200
Message-ID: <20250708162234.241580121@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162230.765762963@linuxfoundation.org>
References: <20250708162230.765762963@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Madhavan Srinivasan <maddy@linux.ibm.com>

commit 93bd4a80efeb521314485a06d8c21157240497bb upstream.

Recent patch fixed an old commit
'fc2a5a6161a2 ("powerpc/64s: ppc_save_regs is now needed for all 64s builds")'
which is to include building of ppc_save_reg.c only when XMON
and KEXEC_CORE and PPC_BOOK3S are enabled. This was valid, since
ppc_save_regs was called only in replay_system_reset() of old
irq.c which was under BOOK3S.

But there has been multiple refactoring of irq.c and have
added call to ppc_save_regs() from __replay_soft_interrupts
-> replay_soft_interrupts which is part of irq_64.c included
under CONFIG_PPC64. And since ppc_save_regs is called in
CRASH_DUMP path as part of crash_setup_regs in kexec.h,
CONFIG_PPC32 also needs it.

So with this recent patch which enabled the building of
ppc_save_regs.c caused a build break when none of these
(XMON, KEXEC_CORE, BOOK3S) where enabled as part of config.
Patch to enable building of ppc_save_regs.c by defaults.

Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20250511041111.841158-1-maddy@linux.ibm.com
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/Makefile |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -165,9 +165,7 @@ endif
 
 obj64-$(CONFIG_PPC_TRANSACTIONAL_MEM)	+= tm.o
 
-ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC_CORE)$(CONFIG_PPC_BOOK3S),)
 obj-y				+= ppc_save_regs.o
-endif
 
 obj-$(CONFIG_EPAPR_PARAVIRT)	+= epapr_paravirt.o epapr_hcalls.o
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o



