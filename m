Return-Path: <stable+bounces-91646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4465A9BEEEF
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D406DB212D6
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED1B1DF747;
	Wed,  6 Nov 2024 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0FB9GRdZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE011DE2CF;
	Wed,  6 Nov 2024 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899345; cv=none; b=MUYFeFkYZnypEY8n0ZeWApuZHlYfnnECcGr9N42nAIjPlUU8DCL6O0RdGBNawuS/CJkuFMpsP3FZW6tspEG4dUIKG7Awaat2dKWzvo181xWkwD4gZmGk6mAO7G7AOC1GML/23SMwJH/jI57XiVwGa0SrRXamst8cuyyK3z4yIVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899345; c=relaxed/simple;
	bh=Tb8Jy14MhNlw3e/c2f1OGvZ3cTylskVaINh9/scClm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHLNrcBirzK6nce2tLiEI0dj2eDlY1qoy7xif5zXsd2PPQ4FKimsDpYxLMGawg8KTWXbaYxFmvMcx/baJPqui4sZKh41E279+3QCRJp2kmzzQ7kaQFTRTowO+fp6MG99HMdzBTZFwjEc6czyocPu43Qx2lWCjihT4Jbh8GckcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0FB9GRdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73354C4CECD;
	Wed,  6 Nov 2024 13:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730899344;
	bh=Tb8Jy14MhNlw3e/c2f1OGvZ3cTylskVaINh9/scClm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0FB9GRdZwwei+3HghEWPQL+iVFhKEaVw1ERygPaKkZaNQkIC5ssUr0Y/BOaUaFpnW
	 vk8+JOo82ev7Yq1Tv9h84/TR76cBpMuh8qKVyNRjQsEsXhOdX1ELdVRyeN7A0nsW6d
	 2xraYSKtOBw10Cics2OHDir8ykJopvEViCJlONPg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 54/73] riscv: Remove unused GENERATING_ASM_OFFSETS
Date: Wed,  6 Nov 2024 13:05:58 +0100
Message-ID: <20241106120301.576795706@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120259.955073160@linuxfoundation.org>
References: <20241106120259.955073160@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>

[ Upstream commit 46d4e5ac6f2f801f97bcd0ec82365969197dc9b1 ]

The macro is not used in the current version of kernel, it looks like
can be removed to avoid a build warning:

../arch/riscv/kernel/asm-offsets.c: At top level:
../arch/riscv/kernel/asm-offsets.c:7: warning: macro "GENERATING_ASM_OFFSETS" is not used [-Wunused-macros]
    7 | #define GENERATING_ASM_OFFSETS

Fixes: 9639a44394b9 ("RISC-V: Provide a cleaner raw_smp_processor_id()")
Cc: stable@vger.kernel.org
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Link: https://lore.kernel.org/r/20241008094141.549248-2-zhangchunyan@iscas.ac.cn
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/asm-offsets.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 90f8ce64fa6f1..0b6064fec9e07 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -4,8 +4,6 @@
  * Copyright (C) 2017 SiFive
  */
 
-#define GENERATING_ASM_OFFSETS
-
 #include <linux/kbuild.h>
 #include <linux/sched.h>
 #include <asm/thread_info.h>
-- 
2.43.0




