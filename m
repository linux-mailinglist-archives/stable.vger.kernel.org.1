Return-Path: <stable+bounces-138910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB9BAA1A45
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D6318851E6
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE4E24E01F;
	Tue, 29 Apr 2025 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M04m4ub2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9105219A63;
	Tue, 29 Apr 2025 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950743; cv=none; b=fN6ip76ChanHi2OqC4DfQjwmISAqrsWW3n7CR4XJpyfW5nP+ZgJyEnpqwYA+buelOeKt07cVEAV+6D47sWVEmWfpyCqCiry1VgOBm8cij/5/GnXQZAFNqQWJ7aR0d9alShZebibLLauFSyEuO+ByTXjr99s+/pXvbSHElLBm1RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950743; c=relaxed/simple;
	bh=8DVz515NtWxBPvpn+9XUS6Tbf4RB850uaMedIwx4/Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V22CsM91zrpBGBrAAG0ROb4k/xeSUg5Yz2zY9h2D7U01bR/dngrXoR2UURHAqhxc2AOlojBZT9uJ5vXHj3+qgbEkpgPrCBwCyakFoepve0N8eFo1laRStUjMomFko+elPKO80ml4cANqEWFcHbbyY8fHHWSfgpC1GXFUd76BMXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M04m4ub2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BB2C4CEE3;
	Tue, 29 Apr 2025 18:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745950743;
	bh=8DVz515NtWxBPvpn+9XUS6Tbf4RB850uaMedIwx4/Kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M04m4ub2mZvQAzhJd/nsckyAOmDUZz+kGHoi4hYBIvc9KIV/d490tEmC26YK+iI8m
	 3BBeVI9Xu3AqaaPUTXwArFXbRce/aPI18JQFFDLVIW0RL0d2TCmZGyNIKdQWV5Emjv
	 XviHFoeIoM5LOfp1/pZWGclh2ds20CrlPoi9Exys=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Andryuk <jason.andryuk@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH 6.6 189/204] x86/pvh: Call C code via the kernel virtual mapping
Date: Tue, 29 Apr 2025 18:44:37 +0200
Message-ID: <20250429161107.115398187@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161059.396852607@linuxfoundation.org>
References: <20250429161059.396852607@linuxfoundation.org>
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

From: Ard Biesheuvel <ardb@kernel.org>

commit e8fbc0d9cab6c1ee6403f42c0991b0c1d5dbc092 upstream.

Calling C code via a different mapping than it was linked at is
problematic, because the compiler assumes that RIP-relative and absolute
symbol references are interchangeable. GCC in particular may use
RIP-relative per-CPU variable references even when not using -fpic.

So call xen_prepare_pvh() via its kernel virtual mapping on x86_64, so
that those RIP-relative references produce the correct values. This
matches the pre-existing behavior for i386, which also invokes
xen_prepare_pvh() via the kernel virtual mapping before invoking
startup_32 with paging disabled again.

Fixes: 7243b93345f7 ("xen/pvh: Bootstrap PVH guest")
Tested-by: Jason Andryuk <jason.andryuk@amd.com>
Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Message-ID: <20241009160438.3884381-8-ardb+git@google.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
[ Stable context update ]
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/platform/pvh/head.S |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -100,7 +100,12 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	xor %edx, %edx
 	wrmsr
 
-	call xen_prepare_pvh
+	/* Call xen_prepare_pvh() via the kernel virtual mapping */
+	leaq xen_prepare_pvh(%rip), %rax
+	subq phys_base(%rip), %rax
+	addq $__START_KERNEL_map, %rax
+	ANNOTATE_RETPOLINE_SAFE
+	call *%rax
 
 	/* startup_64 expects boot_params in %rsi. */
 	mov $_pa(pvh_bootparams), %rsi



