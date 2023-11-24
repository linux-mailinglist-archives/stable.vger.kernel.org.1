Return-Path: <stable+bounces-776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 580EB7F7C82
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6C02811AA
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BF539FEA;
	Fri, 24 Nov 2023 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vmtgBRY4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C27C2511F;
	Fri, 24 Nov 2023 18:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF63C433C8;
	Fri, 24 Nov 2023 18:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849748;
	bh=p+Agqv6N6Bz8m/Gh+V4+jbgJd9xXumcsyhFGIVLiRkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vmtgBRY4P4dr8YldVzUieSP9c+uz8CIL9ogKUUU381y59zE+7PrTCaoNTiRgTmqeO
	 GSXIb9KVOTmx5eVN8M5JOyAuBv9zDOIMbVPeHktP+W8Kjsn6Q1bpomChyIce+vjVda
	 /dYS0f8tLqasELSMw0e1v6ss9Xpf1ev21OEX1SQE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.6 305/530] arm64: Restrict CPU_BIG_ENDIAN to GNU as or LLVM IAS 15.x or newer
Date: Fri, 24 Nov 2023 17:47:51 +0000
Message-ID: <20231124172037.322505372@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

commit 146a15b873353f8ac28dc281c139ff611a3c4848 upstream.

Prior to LLVM 15.0.0, LLVM's integrated assembler would incorrectly
byte-swap NOP when compiling for big-endian, and the resulting series of
bytes happened to match the encoding of FNMADD S21, S30, S0, S0.

This went unnoticed until commit:

  34f66c4c4d5518c1 ("arm64: Use a positive cpucap for FP/SIMD")

Prior to that commit, the kernel would always enable the use of FPSIMD
early in boot when __cpu_setup() initialized CPACR_EL1, and so usage of
FNMADD within the kernel was not detected, but could result in the
corruption of user or kernel FPSIMD state.

After that commit, the instructions happen to trap during boot prior to
FPSIMD being detected and enabled, e.g.

| Unhandled 64-bit el1h sync exception on CPU0, ESR 0x000000001fe00000 -- ASIMD
| CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc3-00013-g34f66c4c4d55 #1
| Hardware name: linux,dummy-virt (DT)
| pstate: 400000c9 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
| pc : __pi_strcmp+0x1c/0x150
| lr : populate_properties+0xe4/0x254
| sp : ffffd014173d3ad0
| x29: ffffd014173d3af0 x28: fffffbfffddffcb8 x27: 0000000000000000
| x26: 0000000000000058 x25: fffffbfffddfe054 x24: 0000000000000008
| x23: fffffbfffddfe000 x22: fffffbfffddfe000 x21: fffffbfffddfe044
| x20: ffffd014173d3b70 x19: 0000000000000001 x18: 0000000000000005
| x17: 0000000000000010 x16: 0000000000000000 x15: 00000000413e7000
| x14: 0000000000000000 x13: 0000000000001bcc x12: 0000000000000000
| x11: 00000000d00dfeed x10: ffffd414193f2cd0 x9 : 0000000000000000
| x8 : 0101010101010101 x7 : ffffffffffffffc0 x6 : 0000000000000000
| x5 : 0000000000000000 x4 : 0101010101010101 x3 : 000000000000002a
| x2 : 0000000000000001 x1 : ffffd014171f2988 x0 : fffffbfffddffcb8
| Kernel panic - not syncing: Unhandled exception
| CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc3-00013-g34f66c4c4d55 #1
| Hardware name: linux,dummy-virt (DT)
| Call trace:
|  dump_backtrace+0xec/0x108
|  show_stack+0x18/0x2c
|  dump_stack_lvl+0x50/0x68
|  dump_stack+0x18/0x24
|  panic+0x13c/0x340
|  el1t_64_irq_handler+0x0/0x1c
|  el1_abort+0x0/0x5c
|  el1h_64_sync+0x64/0x68
|  __pi_strcmp+0x1c/0x150
|  unflatten_dt_nodes+0x1e8/0x2d8
|  __unflatten_device_tree+0x5c/0x15c
|  unflatten_device_tree+0x38/0x50
|  setup_arch+0x164/0x1e0
|  start_kernel+0x64/0x38c
|  __primary_switched+0xbc/0xc4

Restrict CONFIG_CPU_BIG_ENDIAN to a known good assembler, which is
either GNU as or LLVM's IAS 15.0.0 and newer, which contains the linked
commit.

Closes: https://github.com/ClangBuiltLinux/linux/issues/1948
Link: https://github.com/llvm/llvm-project/commit/1379b150991f70a5782e9a143c2ba5308da1161c
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Cc: stable@vger.kernel.org
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20231025-disable-arm64-be-ias-b4-llvm-15-v1-1-b25263ed8b23@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1368,6 +1368,8 @@ choice
 config CPU_BIG_ENDIAN
 	bool "Build big-endian kernel"
 	depends on !LD_IS_LLD || LLD_VERSION >= 130000
+	# https://github.com/llvm/llvm-project/commit/1379b150991f70a5782e9a143c2ba5308da1161c
+	depends on AS_IS_GNU || AS_VERSION >= 150000
 	help
 	  Say Y if you plan on running a kernel with a big-endian userspace.
 



