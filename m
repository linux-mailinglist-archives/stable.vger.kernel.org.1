Return-Path: <stable+bounces-32363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0AE88CB97
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 19:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0441F2D044
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 18:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051D51272AB;
	Tue, 26 Mar 2024 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="r3PzG+9f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A1884D0D;
	Tue, 26 Mar 2024 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476507; cv=none; b=iDDCP3x+HqU/WzFARt/t7Ott5tKz1fm5VEjj3ymHE87lubqE5x00Xqc9S803/N6dfJUqmbUFY5LcaoFKqot8shdtC1NgrsM3mSQlIgRuN0Cy74oJtFBjSCT5fGZt0CjXHw21b8ewPLoYjf6J1DrhjGLwV/bIfhQZF60iEijzF20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476507; c=relaxed/simple;
	bh=pZZsbNjYGqlQwzv/JJMHLtuOQBUbNP7DGXfNhNgRgus=;
	h=Date:To:From:Subject:Message-Id; b=XdTT6TA+mTzzFv3VG818PXXqbj5fLwiWTRKyURYY1rRyJjkjbj7J7hZu2uWklXA3axk8chepdpgxl4iMNW7RvUV7d4UUG4hKSZpPQr9rujDVyrhGTj9DCVHhs9w7bWu76KtGSetrTtVV8SF/NVVFx6jpZP4QFtIQaplHhUrnDPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=r3PzG+9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B344C43390;
	Tue, 26 Mar 2024 18:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711476507;
	bh=pZZsbNjYGqlQwzv/JJMHLtuOQBUbNP7DGXfNhNgRgus=;
	h=Date:To:From:Subject:From;
	b=r3PzG+9fJpRNgY+TmPqibow+u6yhpSHrDv3+0+ljAjU6FMpHudcnpLeqpy7HZn05o
	 +tlryj2QOaRfyIYZwmEyxC3+xJmcvbStk1MTtwznbOPxkcKMHrEtJMqSzcrLKVjNPJ
	 PvUUaAHHkab8Zp2z4i3QznQGkQU4JRrNCC23ijK4=
Date: Tue, 26 Mar 2024 11:08:27 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,ndesaulniers@google.com,morbo@google.com,justinstitt@google.com,bcain@quicinc.com,nathan@kernel.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] hexagon-vmlinuxldss-handle-attributes-section.patch removed from -mm tree
Message-Id: <20240326180827.8B344C43390@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: hexagon: vmlinux.lds.S: handle attributes section
has been removed from the -mm tree.  Its filename was
     hexagon-vmlinuxldss-handle-attributes-section.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Nathan Chancellor <nathan@kernel.org>
Subject: hexagon: vmlinux.lds.S: handle attributes section
Date: Tue, 19 Mar 2024 17:37:46 -0700

After the linked LLVM change, the build fails with
CONFIG_LD_ORPHAN_WARN_LEVEL="error", which happens with allmodconfig:

  ld.lld: error: vmlinux.a(init/main.o):(.hexagon.attributes) is being placed in '.hexagon.attributes'

Handle the attributes section in a similar manner as arm and riscv by
adding it after the primary ELF_DETAILS grouping in vmlinux.lds.S, which
fixes the error.

Link: https://lkml.kernel.org/r/20240319-hexagon-handle-attributes-section-vmlinux-lds-s-v1-1-59855dab8872@kernel.org
Fixes: 113616ec5b64 ("hexagon: select ARCH_WANT_LD_ORPHAN_WARN")
Link: https://github.com/llvm/llvm-project/commit/31f4b329c8234fab9afa59494d7f8bdaeaefeaad
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Brian Cain <bcain@quicinc.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/hexagon/kernel/vmlinux.lds.S |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/hexagon/kernel/vmlinux.lds.S~hexagon-vmlinuxldss-handle-attributes-section
+++ a/arch/hexagon/kernel/vmlinux.lds.S
@@ -63,6 +63,7 @@ SECTIONS
 	STABS_DEBUG
 	DWARF_DEBUG
 	ELF_DETAILS
+	.hexagon.attributes 0 : { *(.hexagon.attributes) }
 
 	DISCARDS
 }
_

Patches currently in -mm which might be from nathan@kernel.org are



