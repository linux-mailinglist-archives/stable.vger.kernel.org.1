Return-Path: <stable+bounces-91428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C516A9BEDED
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1CE2865DD
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F941E048E;
	Wed,  6 Nov 2024 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oA3GyQCv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B096D1E0491
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898705; cv=none; b=ild82vfKBi3k7BPzaEtFovxBvsXOvsCIhMqlEfh4H03PWOz5bl8vtDB11cZceue1IwiUWTKy8LIwGX4oGPtZWxsqNJ7OAtLE7RkUSunb6xTZiXscdUQCU2XOgZKt6wesjtTx1ToVIaQLItewkUobx3RDyQwWFMdQcAdk+onBbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898705; c=relaxed/simple;
	bh=o8NUUAROuMdB5iMmGq2XtJYBOqpHtSMA1C8K+hzraOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c02VhmEOhL7x1dgMvp9iX3ViSE1Kx4hj+szFrI8NPidBE0myAdlRTMbJ/Mx3vWmyFYNDDfQ/uyMkLDQkrpDOkyetH6DqDKFajOd1ycAji7pSRszkHs4wXvVxDey/4vTwnCr7uvTN5TSOZ1s3Ow98J3x7wMLTwo6Jrdt9skvuN3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oA3GyQCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADBEC4CED5;
	Wed,  6 Nov 2024 13:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730898705;
	bh=o8NUUAROuMdB5iMmGq2XtJYBOqpHtSMA1C8K+hzraOA=;
	h=From:To:Cc:Subject:Date:From;
	b=oA3GyQCvjEAS3StYeFDZ0cbFsh4iorfp7OS+tfZOIxZDDdoKgU53wTxlz1pkq6UhD
	 X9B0dYsIvubDmd8fj8URBpkgAbsEzRkNc9AmYlb03CKx0LsgfgrdCm1XrYcGX+tFEJ
	 JqttBdWtv5T2/CEE2BpKSLose8m/DebXsoBkyyc7iWaHmwEDyZDXubJzv/UZL/OAY4
	 IIt4hRY2nWXO88oYttGzNCI/gax2zBMHo2FgN+UOBQTbmTh8SOuI+bqAap33O1DDD5
	 YC0XAQOjfsP8H1gKsr0pNiEwai/OLHpngnl8DiH9QWBvrNczNDBQ+TtRX/Oc/lKg5w
	 LVipCVCoCJZcw==
From: Conor Dooley <conor@kernel.org>
To: stable@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	Jason Montleon <jmontleo@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [for 6.11 PATCH] RISC-V: disallow gcc + rust builds
Date: Wed,  6 Nov 2024 13:11:29 +0000
Message-ID: <20241106-happily-unknotted-9984b07a414e@spud>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2704; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=SfxwdshweJyyHwN/yk+AuvRIn3dVc1kElFVGb9Tevp8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOna2QwT42fXMVs1Kmb/6m7b6dFdNV3HwmRLhg3DA86pF TbpBk86SlkYxDgYZMUUWRJv97VIrf/jssO55y3MHFYmkCEMXJwCMBG/AEaGZ780C97ZfEj/+frL /M08+7hjupaueH/i9Jy94UrxP9PWNzH8z54vtWW+wdS7J+decX63NHPtKxl+Xr+PgStMO4S17zy pYQUA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

commit 33549fcf37ec461f398f0a41e1c9948be2e5aca4 upstream

During the discussion before supporting rust on riscv, it was decided
not to support gcc yet, due to differences in extension handling
compared to llvm (only the version of libclang matching the c compiler
is supported). Recently Jason Montleon reported [1] that building with
gcc caused build issues, due to unsupported arguments being passed to
libclang. After some discussion between myself and Miguel, it is better
to disable gcc + rust builds to match the original intent, and
subsequently support it when an appropriate set of extensions can be
deduced from the version of libclang.

Closes: https://lore.kernel.org/all/20240917000848.720765-2-jmontleo@redhat.com/ [1]
Link: https://lore.kernel.org/all/20240926-battering-revolt-6c6a7827413e@spud/ [2]
Fixes: 70a57b247251a ("RISC-V: enable building 64-bit kernels with rust support")
Cc: stable@vger.kernel.org
Reported-by: Jason Montleon <jmontleo@redhat.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20241001-playlist-deceiving-16ece2f440f5@spud
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/rust/arch-support.rst | 2 +-
 arch/riscv/Kconfig                  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
index 750ff371570a..54be7ddf3e57 100644
--- a/Documentation/rust/arch-support.rst
+++ b/Documentation/rust/arch-support.rst
@@ -17,7 +17,7 @@ Architecture   Level of support  Constraints
 =============  ================  ==============================================
 ``arm64``      Maintained        Little Endian only.
 ``loongarch``  Maintained        \-
-``riscv``      Maintained        ``riscv64`` only.
+``riscv``      Maintained        ``riscv64`` and LLVM/Clang only.
 ``um``         Maintained        \-
 ``x86``        Maintained        ``x86_64`` only.
 =============  ================  ==============================================
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d11c2479d8e1..6651a5cbdc27 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -172,7 +172,7 @@ config RISCV
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RETHOOK if !XIP_KERNEL
 	select HAVE_RSEQ
-	select HAVE_RUST if 64BIT
+	select HAVE_RUST if 64BIT && CC_IS_CLANG
 	select HAVE_SAMPLE_FTRACE_DIRECT
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_STACKPROTECTOR
-- 
2.45.2


