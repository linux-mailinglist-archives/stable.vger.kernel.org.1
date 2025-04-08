Return-Path: <stable+bounces-131127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67185A807BE
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9579D1BA1433
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C40269B08;
	Tue,  8 Apr 2025 12:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iCDwOvA/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C2D224239;
	Tue,  8 Apr 2025 12:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115562; cv=none; b=ZrHDYI+04geqDUXM38mWvEwMLbd8ghKooBQH4DNsYZEMYApGH1a3FY86aNrdK28k9UShSJyipqxT+dt4FUhvyByi7mc4DeivSVhTmUBDsrfLj5VO31fKC8GgkTsrnf31Pk9jjWKFv1Y875ubvmdbMqEFtL3GX6tVcTy5SyJ/iZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115562; c=relaxed/simple;
	bh=0gOeyb2rDc0SXrj01hpESQ4vwTMxv9nRpR40SF3pvJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srRN9wRppHnVFVUdUMTdRHT5RuxUdPPqGXjNnATQPZ78M/8+h174F/GQEbzsElmL7JlNnZAMfL31b25m+fnEXWZtZyc6qOzxumNkbvjYI5Qsre6fxnzp2v6TOEZnJB53S4onH2vIylsCyk9pb6TR1g1ebU7wrdAZ9WAXLfCiNdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iCDwOvA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5B5C4CEEA;
	Tue,  8 Apr 2025 12:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115562;
	bh=0gOeyb2rDc0SXrj01hpESQ4vwTMxv9nRpR40SF3pvJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iCDwOvA/fHwSPY4PomevkrxUTX8vJbdFOZsqtyXbxXj8NLxp5nwhgrmnNZIgMkm3D
	 PsyDk/Yn3cAsm+CAJLju4InFafK2G7P8lIPLUMrspFRhVnHW4QGpU180IgZFkafsQD
	 /EArJZamjhFk64yj4X6JytyDoB4DdJwUDWAZsbUg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Chao Gao <chao.gao@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 020/204] x86/fpu/xstate: Fix inconsistencies in guest FPU xfeatures
Date: Tue,  8 Apr 2025 12:49:10 +0200
Message-ID: <20250408104820.913837994@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
References: <20250408104820.266892317@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Gao <chao.gao@intel.com>

[ Upstream commit dda366083e5ff307a4a728757db874bbfe7550be ]

Guest FPUs manage vCPU FPU states. They are allocated via
fpu_alloc_guest_fpstate() and are resized in fpstate_realloc() when XFD
features are enabled.

Since the introduction of guest FPUs, there have been inconsistencies in
the kernel buffer size and xfeatures:

 1. fpu_alloc_guest_fpstate() uses fpu_user_cfg since its introduction. See:

    69f6ed1d14c6 ("x86/fpu: Provide infrastructure for KVM FPU cleanup")
    36487e6228c4 ("x86/fpu: Prepare guest FPU for dynamically enabled FPU features")

 2. __fpstate_reset() references fpu_kernel_cfg to set storage attributes.

 3. fpu->guest_perm uses fpu_kernel_cfg, affecting fpstate_realloc().

A recent commit in the tip:x86/fpu tree partially addressed the inconsistency
between (1) and (3) by using fpu_kernel_cfg for size calculation in (1),
but left fpu_guest->xfeatures and fpu_guest->perm still referencing
fpu_user_cfg:

  https://lore.kernel.org/all/20250218141045.85201-1-stanspas@amazon.de/

  1937e18cc3cf ("x86/fpu: Fix guest FPU state buffer allocation size")

The inconsistencies within fpu_alloc_guest_fpstate() and across the
mentioned functions cause confusion.

Fix them by using fpu_kernel_cfg consistently in fpu_alloc_guest_fpstate(),
except for fields related to the UABI buffer. Referencing fpu_kernel_cfg
won't impact functionalities, as:

 1. fpu_guest->perm is overwritten shortly in fpu_init_guest_permissions()
    with fpstate->guest_perm, which already uses fpu_kernel_cfg.

 2. fpu_guest->xfeatures is solely used to check if XFD features are enabled.
    Including supervisor xfeatures doesn't affect the check.

Fixes: 36487e6228c4 ("x86/fpu: Prepare guest FPU for dynamically enabled FPU features")
Suggested-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Link: https://lore.kernel.org/r/20250317140613.1761633-1-chao.gao@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/fpu/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index cbaa3afdd223f..80ba0f81a44a6 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -232,8 +232,8 @@ bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
 	fpstate->is_guest	= true;
 
 	gfpu->fpstate		= fpstate;
-	gfpu->xfeatures		= fpu_user_cfg.default_features;
-	gfpu->perm		= fpu_user_cfg.default_features;
+	gfpu->xfeatures		= fpu_kernel_cfg.default_features;
+	gfpu->perm		= fpu_kernel_cfg.default_features;
 
 	/*
 	 * KVM sets the FP+SSE bits in the XSAVE header when copying FPU state
-- 
2.39.5




