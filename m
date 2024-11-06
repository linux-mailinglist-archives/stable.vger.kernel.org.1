Return-Path: <stable+bounces-90656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 642CE9BE965
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A63A1F239CD
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73FC1DF98C;
	Wed,  6 Nov 2024 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fsVpLzhg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742141DF756;
	Wed,  6 Nov 2024 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896421; cv=none; b=Y/XEPWSrVpZ0OqW/kSPjcJ3+QGiik83XrGLOlo+Yu2O+P5AjAuoORf2XDkpXE8eCNS7y50qKsMAlUJ+Tm8ziRnMRbzPE0yxRgEx/1LRS7JbGFC2OSWdUo9306zPfhgsDm2OSgUidvS9aNAZWPrZ4Ij/iVlqJJnFJlQLUdU0repQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896421; c=relaxed/simple;
	bh=Nid6pHlK9Vi5s906oE4pvXufUUGNTaXQs9Yu8cpbBHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsFWEGcT2nSTm2ejjY/HpKFHRavwy4LLMg1FoD1rO91yu872CNr6DwYCumtHHgfS+SLU9a9u/JTkdrmZbbdvJ+ghb8Qcuxy7R6gMKhqzQcKuCW4722hyF09djzwEtb8Q9tdtj6maBq0LJ3tW2aSfulIazILjU4SuglpR2jmPNpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fsVpLzhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBB3C4CECD;
	Wed,  6 Nov 2024 12:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730896421;
	bh=Nid6pHlK9Vi5s906oE4pvXufUUGNTaXQs9Yu8cpbBHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fsVpLzhgBAflRgNYooVq6cbv8lMkqM0plq5rJGgAUEvnp4NrpkSflXELVjDzQSe9Z
	 cIU9CxIJRJlQBKmEP2DXFd5+xet2HHdHeFfAMLgPa+FHHeTqhdMSvTho7jtUQNhiWV
	 QLoCJZ2IJlf0MJf4hFMOL7/qWEpNGLjaY52BXX5k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 159/245] riscv: Remove unused GENERATING_ASM_OFFSETS
Date: Wed,  6 Nov 2024 13:03:32 +0100
Message-ID: <20241106120323.147028574@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120319.234238499@linuxfoundation.org>
References: <20241106120319.234238499@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

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
index b09ca5f944f77..cb09f0c4f62c7 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -4,8 +4,6 @@
  * Copyright (C) 2017 SiFive
  */
 
-#define GENERATING_ASM_OFFSETS
-
 #include <linux/kbuild.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
-- 
2.43.0




