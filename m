Return-Path: <stable+bounces-5400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8EA80CBC4
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BCE81C21289
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F5847A41;
	Mon, 11 Dec 2023 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3xjA0mP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD174776B;
	Mon, 11 Dec 2023 13:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF81C433B7;
	Mon, 11 Dec 2023 13:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302840;
	bh=wdNJDgqHvDzQr6q3lTGtBsDgx/ijcaDTNNN6qwjaRC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L3xjA0mPON5y9hqfrcIgIc/MOZd1DVa6Z+3NRujO/rvhRp39mnwEw7iVmpquAjejI
	 H3xn6oQIsdRUevtkFNo9vcyT8cPC8UKyF91hU9DODbeYBJAVhkaCb1JufSm5xN5TLI
	 70JF6vDwQjfQ3ESCxvTeKjrcUtIHaXZrRw2s0B56n+i96DJwuYmelK7JDgaLYQk10+
	 lx458Ufq4gnd8IeVIFcEJK5jyp9X7UKxsuUoSN2YuRQJgl4CXXanZ3FIMRTu7CVWpJ
	 GlbSyuenluKSisDNOO2vvjhT4pKMExnIdZQmD1Uo0YHUKAAN3WjQ/aQZRnu+KFqJJe
	 yX0SA/+PuKNOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: WANG Rui <wangrui@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	nathan@kernel.org,
	loongarch@lists.linux.dev,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 45/47] LoongArch: Apply dynamic relocations for LLD
Date: Mon, 11 Dec 2023 08:50:46 -0500
Message-ID: <20231211135147.380223-45-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit

From: WANG Rui <wangrui@loongson.cn>

[ Upstream commit eea673e9d5ea994c60b550ffb684413d3759b3f4 ]

For the following assembly code:

     .text
     .global func
 func:
     nop

     .data
 var:
     .dword func

When linked with `-pie`, GNU LD populates the `var` variable with the
pre-relocated value of `func`. However, LLVM LLD does not exhibit the
same behavior. This issue also arises with the `kernel_entry` in arch/
loongarch/kernel/head.S:

 _head:
     .word   MZ_MAGIC                /* "MZ", MS-DOS header */
     .org    0x8
     .dword  kernel_entry            /* Kernel entry point */

The correct kernel entry from the MS-DOS header is crucial for jumping
to vmlinux from zboot. This necessity is why the compressed relocatable
kernel compiled by Clang encounters difficulties in booting.

To address this problem, it is proposed to apply dynamic relocations to
place with `--apply-dynamic-relocs`.

Link: https://github.com/ClangBuiltLinux/linux/issues/1962
Signed-off-by: WANG Rui <wangrui@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index fb0fada43197e..390867fc45b84 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -80,7 +80,7 @@ endif
 
 ifeq ($(CONFIG_RELOCATABLE),y)
 KBUILD_CFLAGS_KERNEL		+= -fPIE
-LDFLAGS_vmlinux			+= -static -pie --no-dynamic-linker -z notext
+LDFLAGS_vmlinux			+= -static -pie --no-dynamic-linker -z notext $(call ld-option, --apply-dynamic-relocs)
 endif
 
 cflags-y += $(call cc-option, -mno-check-zero-division)
-- 
2.42.0


