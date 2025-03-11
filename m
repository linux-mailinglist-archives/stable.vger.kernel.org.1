Return-Path: <stable+bounces-123941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6DBA5C795
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAD217AB946
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0DF25E47F;
	Tue, 11 Mar 2025 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lfka57KP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA16B255E37;
	Tue, 11 Mar 2025 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707404; cv=none; b=cN+EmLaCNuDGnFkusfKTuNTAnF5obZSStqA2nC+FTnZslcNmOD+sPIj2T6lm3YJaByxz3Bp8fJBLzN1f19M1/OVeW5LD2GBp7aaSVAuZL+yVDtEEMXuTFgpzetOnGqCAIOazlVa7S2EG22T1nbW7W9LMM1xsSY3cigWDtLMiOCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707404; c=relaxed/simple;
	bh=HOYUXKlGmqfldw1U9ZC1Se6HZMm2ztyIVSlT8ALSvTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbvlbwHhBNrN9zKBHA/VXsYOpCX8kpF8hi2fRFWtQdxGQaH6PnAJepbh+E37AJXYlp5lcTyLAasyTVgGdluyblYTDhgA3RUE67I2VkQTLmmFrFooAcfLoOXVywJCkoNjavAWG0kkt/HiZNnkrxscwwXiWja9MJFuSztctoAuASM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lfka57KP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E07DC4CEEA;
	Tue, 11 Mar 2025 15:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741707403;
	bh=HOYUXKlGmqfldw1U9ZC1Se6HZMm2ztyIVSlT8ALSvTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lfka57KPampeUXXKXxPDbDvO4o9m6JS6xy550hvmjYTlJi6NVLF+gTXrEhdAvtfj4
	 c4lN/TBBOuZnZuJbMn7AAFDt5if3vwZVYVDmpxSaMIIInu+flsqtjJoSlZT0mQTKsO
	 Tma42HglXg8EEMDf66CNvq03i/2lQ9L9xm7uMdZg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 5.10 376/462] vmlinux.lds: Ensure that const vars with relocations are mapped R/O
Date: Tue, 11 Mar 2025 16:00:42 +0100
Message-ID: <20250311145813.205511680@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145758.343076290@linuxfoundation.org>
References: <20250311145758.343076290@linuxfoundation.org>
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

commit 68f3ea7ee199ef77551e090dfef5a49046ea8443 upstream.

In the kernel, there are architectures (x86, arm64) that perform
boot-time relocation (for KASLR) without relying on PIE codegen. In this
case, all const global objects are emitted into .rodata, including const
objects with fields that will be fixed up by the boot-time relocation
code.  This implies that .rodata (and .text in some cases) need to be
writable at boot, but they will usually be mapped read-only as soon as
the boot completes.

When using PIE codegen, the compiler will emit const global objects into
.data.rel.ro rather than .rodata if the object contains fields that need
such fixups at boot-time. This permits the linker to annotate such
regions as requiring read-write access only at load time, but not at
execution time (in user space), while keeping .rodata truly const (in
user space, this is important for reducing the CoW footprint of dynamic
executables).

This distinction does not matter for the kernel, but it does imply that
const data will end up in writable memory if the .data.rel.ro sections
are not treated in a special way, as they will end up in the writable
.data segment by default.

So emit .data.rel.ro into the .rodata segment.

Cc: stable@vger.kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20250221135704.431269-5-ardb+git@google.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/asm-generic/vmlinux.lds.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -420,7 +420,7 @@
 	. = ALIGN((align));						\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		__start_rodata = .;					\
-		*(.rodata) *(.rodata.*)					\
+		*(.rodata) *(.rodata.*) *(.data.rel.ro*)		\
 		SCHED_DATA						\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
 		. = ALIGN(8);						\



