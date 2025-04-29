Return-Path: <stable+bounces-137760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F419AA14CC
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8AD4C2D9D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7B7253329;
	Tue, 29 Apr 2025 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lS0+WqCL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E1724466C;
	Tue, 29 Apr 2025 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947045; cv=none; b=F+jK8J8mvfqFlehVDewxRJb1Nnp9id40tCRslknk5BJWNrczaJaP/GHTvA5uKCltV/bYYwAISsddeFk6SAbJHiLcL77DkNueVsPn5zv3Rwrrlz/9rs2OAkb4oo0JkKFdo/ffQF+IlSCzmcBBAXq1l3si6JvQp+5qNQDKJFsCP0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947045; c=relaxed/simple;
	bh=BIIWGJgQ2ZZ1dPO3m2d+RJSmB90nVucH7ZZaIVPZTtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=br90f2G0E0Pt5cJ32WsAOJkEDz0ev4XN0ZQ2Zbr2XMjgzXUHBBAnvrjI8kjEtWW7wkehZ61/bZ8EA0UmKYbI9Pjwi0BE0kZtdLWTwgdzQg9LJ0/Rmm5KdOPE/0RqpcQCQ30ZBMeLZQ2R6JlcVmNHo1oRd3l0cs4+WoXmMZGbF0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lS0+WqCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FA8C4CEE3;
	Tue, 29 Apr 2025 17:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947045;
	bh=BIIWGJgQ2ZZ1dPO3m2d+RJSmB90nVucH7ZZaIVPZTtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lS0+WqCLP/tbkryiWqVUDoOQ5wT0SlVS4J8HHr9BKkyHc41vC+bIHObaVNSUw+xzx
	 e0cTMfd4oIqA6wvC3VxCHSt8jwwZULe2zmHwvqaiGmjeKBJRf0VDA1wdsojzddwWYC
	 GZN2KKWNvrzHJPsfPQvFR0rbscOeF1jh5quO1wcI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Andryuk <jason.andryuk@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH 5.10 153/286] x86/pvh: Call C code via the kernel virtual mapping
Date: Tue, 29 Apr 2025 18:40:57 +0200
Message-ID: <20250429161114.177813719@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -99,7 +99,12 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
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



