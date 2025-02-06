Return-Path: <stable+bounces-114147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0C5A2AEC9
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 18:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169E41889EC7
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D747176AC5;
	Thu,  6 Feb 2025 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYBURifi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03209239572;
	Thu,  6 Feb 2025 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738862841; cv=none; b=lJxoNLuvIYaBCQwgQCagQSoiJU4ql9yEhV2m9qYyX2S7Zl/YBpn3Mtk1Ga235KpLb6XcA8v2oxvrF8RFz+UvV0Cx2+DGO/wTPW1M8KQloXMP4pM1WCv78xQSZtNPaB5z8Zcg40asLq2LnPmHn8OdHb6Lq+IULGW1HN1VIJDwQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738862841; c=relaxed/simple;
	bh=pPmLZssZVb0h1amjrYDb6Gwl7U84SRos3SRqFBYvoCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=C0y0j8QgijPVDDz5q6YOawjctygh/QNNUS2gl0bIV6iB4UF4rcU9sVvOVdUED3algNEm5dzkkMoIAN5CyiiIe5z+u9up6NNrXwPw+vg9QGTaCOl1NxChgQs9EFNKIl/f9xCD1l7nj6R+i0DsWI2DBqkVIiD3Q/MiyU2/g5m9zik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYBURifi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCF6C4CEDD;
	Thu,  6 Feb 2025 17:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738862839;
	bh=pPmLZssZVb0h1amjrYDb6Gwl7U84SRos3SRqFBYvoCo=;
	h=From:Date:Subject:To:Cc:From;
	b=bYBURifiYdmqDU+oTvDryxlGF6HdiUW+WvteWC1oxTFN+XGfdL1BNVaER58x8OtIE
	 IdKrOpUoXHVeykjblCZ4ptC6a04lDIVjqsrj9c5rgGpj1bK6NXA0U48B+lFnoMObIE
	 gYtgFeBqOog5L317/SLiPgBPKKtoESVsFBhkXYcuXNoky9w8UByRZ/8OYrrDiep3EV
	 rsOfHBP2MyesRJroDTO5kPFpjUUbcWcgJB3B1P/o1hcvnu1j0WbBsPjCUsRnh47IDI
	 aeTapHdfhAakZ39fwHXZ3BXCGThmljkoP7u8sr3XS+w6qzw4wzXor+jPiNTFNwYiPl
	 IVNkCU6/AqYKg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 06 Feb 2025 10:21:38 -0700
Subject: [PATCH v3] arm64: Handle .ARM.attributes section in linker scripts
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-arm64-handle-arm-attributes-in-linker-script-v3-1-d53d169913eb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKHvpGcC/5WNyw6CMBBFf4V07Rj6QnTlfxgXBQadiIVMK9EQ/
 t1CYoxLl+fe5JxJBGTCIA7ZJBhHCtT7BHqTifrq/AWBmsRC5crmUmlwfC8MpKvpcAFwMTJVj4g
 ByENH/oYMoWYaIpTKISqrpXa1SMqBsaXnmjudE18pxJ5fa32Uy/oJmf9CowQJOyO1rYq61WZ/T
 KfHbtvzRSylUX3tKv/XrpK9KUqT73ettdb82Od5fgPktuqQRwEAAA==
X-Change-ID: 20250123-arm64-handle-arm-attributes-in-linker-script-82aee25313ac
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2841; i=nathan@kernel.org;
 h=from:subject:message-id; bh=pPmLZssZVb0h1amjrYDb6Gwl7U84SRos3SRqFBYvoCo=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOlLPnxV+6A67+IFds/l3b5sU1/8niS54G3eHR6XVy03n
 H2kn4fJdZSyMIhxMciKKbJUP1Y9bmg45yzjjVOTYOawMoEMYeDiFICJKB1jZNhiENbys+tSl9w+
 rkVL94q4npbStW/y+bFusfHsh8rWLf8ZGVr7NlVukIz0WbhMdH7u8hsfLriuOKzteLeT/7rQas3
 FScwA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

A recent LLVM commit [1] started generating an .ARM.attributes section
similar to the one that exists for 32-bit, which results in orphan
section warnings (or errors if CONFIG_WERROR is enabled) from the linker
because it is not handled in the arm64 linker scripts.

  ld.lld: error: arch/arm64/kernel/vdso/vgettimeofday.o:(.ARM.attributes) is being placed in '.ARM.attributes'
  ld.lld: error: arch/arm64/kernel/vdso/vgetrandom.o:(.ARM.attributes) is being placed in '.ARM.attributes'

  ld.lld: error: vmlinux.a(lib/vsprintf.o):(.ARM.attributes) is being placed in '.ARM.attributes'
  ld.lld: error: vmlinux.a(lib/win_minmax.o):(.ARM.attributes) is being placed in '.ARM.attributes'
  ld.lld: error: vmlinux.a(lib/xarray.o):(.ARM.attributes) is being placed in '.ARM.attributes'

Discard the new sections in the necessary linker scripts to resolve the
warnings, as the kernel and vDSO do not need to retain it, similar to
the .note.gnu.property section.

Cc: stable@vger.kernel.org
Fixes: b3e5d80d0c48 ("arm64/build: Warn on orphan section placement")
Link: https://github.com/llvm/llvm-project/commit/ee99c4d4845db66c4daa2373352133f4b237c942 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Changes in v3:
- Update location of section discard in vDSO to align with
  .note.gnu.property discard since the sectionss are similar in
  nature (Will).
- Link to v2: https://lore.kernel.org/r/20250204-arm64-handle-arm-attributes-in-linker-script-v2-1-d684097f5554@kernel.org

Changes in v2:
- Discard the section instead of adding it to the final artifacts to
  mirror the .note.gnu.property section handling (Will).
- Link to v1: https://lore.kernel.org/r/20250124-arm64-handle-arm-attributes-in-linker-script-v1-1-74135b6cf349@kernel.org
---
 arch/arm64/kernel/vdso/vdso.lds.S | 1 +
 arch/arm64/kernel/vmlinux.lds.S   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index 4ec32e86a8da..47ad6944f9f0 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -41,6 +41,7 @@ SECTIONS
 	 */
 	/DISCARD/	: {
 		*(.note.GNU-stack .note.gnu.property)
+		*(.ARM.attributes)
 	}
 	.note		: { *(.note.*) }		:text	:note
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index f84c71f04d9e..e73326bd3ff7 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -162,6 +162,7 @@ SECTIONS
 	/DISCARD/ : {
 		*(.interp .dynamic)
 		*(.dynsym .dynstr .hash .gnu.hash)
+		*(.ARM.attributes)
 	}
 
 	. = KIMAGE_VADDR;

---
base-commit: 1dd3393696efba1598aa7692939bba99d0cffae3
change-id: 20250123-arm64-handle-arm-attributes-in-linker-script-82aee25313ac

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


