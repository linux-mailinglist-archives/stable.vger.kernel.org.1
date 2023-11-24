Return-Path: <stable+bounces-941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA517F7D3B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589B7282130
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2E039FC2;
	Fri, 24 Nov 2023 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IfoFOwsC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A883939FE7;
	Fri, 24 Nov 2023 18:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331AAC433C8;
	Fri, 24 Nov 2023 18:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850162;
	bh=gcrab3FxRZUE1bMXbxOOG7Q4PsStyY3p6Es5V0Oqxe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IfoFOwsCLin8iFgql+BVrvZMbGkZTwoONQyvFuKDfQSJpsaYfHSxA75H8uvcMvAW/
	 EWtA8UO6ADe9X6YILnK+BBWsDVhat+uwypGaLrj7OHERFoimECxCjaahm0N/dFSQ8o
	 uWXVjIrNHnvE8Hy+z3AHlIYYGN78fbwRej9BlR7k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Minda Chen <minda.chen@starfivetech.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.6 470/530] riscv: Using TOOLCHAIN_HAS_ZIHINTPAUSE marco replace zihintpause
Date: Fri, 24 Nov 2023 17:50:36 +0000
Message-ID: <20231124172042.379041665@linuxfoundation.org>
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

From: Minda Chen <minda.chen@starfivetech.com>

commit dd16ac404a685cce07e67261a94c6225d90ea7ba upstream.

Actually it is a part of Conor's
commit aae538cd03bc ("riscv: fix detection of toolchain
Zihintpause support").
It is looks like a merge issue. Samuel's
commit 0b1d60d6dd9e ("riscv: Fix build with
CONFIG_CC_OPTIMIZE_FOR_SIZE=y") do not base on Conor's commit and
revert to __riscv_zihintpause. So this patch can fix it.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Fixes: 3c349eacc559 ("Merge patch "riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y"")
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20230802064215.31111-1-minda.chen@starfivetech.com
Cc: stable@vger.kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/include/asm/vdso/processor.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/riscv/include/asm/vdso/processor.h
+++ b/arch/riscv/include/asm/vdso/processor.h
@@ -14,7 +14,7 @@ static inline void cpu_relax(void)
 	__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
 #endif
 
-#ifdef __riscv_zihintpause
+#ifdef CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE
 	/*
 	 * Reduce instruction retirement.
 	 * This assumes the PC changes.



