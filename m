Return-Path: <stable+bounces-90034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15D49BDCC5
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6431C23097
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDB91D619F;
	Wed,  6 Nov 2024 02:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raF+4XJN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE6F217F5E;
	Wed,  6 Nov 2024 02:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859255; cv=none; b=S8C2wbxhAZrVm3HrvDEJhYeDPB7dm3VTYjwaoYVEFdSN67so5W+DGlRhvuZYFW/w+9X2RuX0HKGvhlhvKXInuSRqWqsdvsiBvMrj+7+O7FKHFplAPWc+t4Fy5yg7xlN5hRGwnifJyk7qBQnUxjYtIKGfAz5AZSIpqITV5vuCKrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859255; c=relaxed/simple;
	bh=YXSyDlwK9Sog4/ATEus8Z8onq95/SaRQ4um+jmLNl80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KTdlKLcxX+47q3yqxbryww2pSE+BXuLqK6iHGGq9z8WVUMFlAoj4kDrEDNORbO3/uqe6n+zyDcgDublnVu+h9R3dDN0nWMw0LNzNgpixJM3mlm+iKPiJiQLCeq9Sm6Gg2KP+91rYJaiIEldPeaHQY24uLp+LTWPWH1eluT8UpoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raF+4XJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7B9C4CECF;
	Wed,  6 Nov 2024 02:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859255;
	bh=YXSyDlwK9Sog4/ATEus8Z8onq95/SaRQ4um+jmLNl80=;
	h=From:To:Cc:Subject:Date:From;
	b=raF+4XJNDCpHzgEp5rBYDcoGsP0u9HTlmYXCz9Za4dhz6/7DsZK1EU9vLQYr+/20Y
	 PXJWeR3zANutbA2n3/xPBqWbvvUBxPr4kahT2/JB3b2xcMFsc37EqCSzPaF8d+nig0
	 hVqls/dYiYNqnH040oVo6T+iHj8Lpg5/ucsy02UdsSOFwcdfwUCWPK1MNN3rMKkoWm
	 4hPwBINnyecqP9ZvaHPN118GSeWdpFoJeLmo9RXjra71DBTsEW1WyOpaqwEinsOoc1
	 vZw+MfztDSQRW2HFSDAaqE0p4n4jybm711Ir6ymoui6mzMyvJtnIEHCdl6nE367EWr
	 UkWDu2E1Q6HcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	alexghiti@rivosinc.com
Cc: Guo Ren <guoren@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "riscv: vdso: Prevent the compiler from inserting calls to memset()" failed to apply to v4.19-stable tree
Date: Tue,  5 Nov 2024 21:14:12 -0500
Message-ID: <20241106021412.184114-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From bf40167d54d55d4b54d0103713d86a8638fb9290 Mon Sep 17 00:00:00 2001
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 16 Oct 2024 10:36:24 +0200
Subject: [PATCH] riscv: vdso: Prevent the compiler from inserting calls to
 memset()

The compiler is smart enough to insert a call to memset() in
riscv_vdso_get_cpus(), which generates a dynamic relocation.

So prevent this by using -fno-builtin option.

Fixes: e2c0cdfba7f6 ("RISC-V: User-facing API")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Link: https://lore.kernel.org/r/20241016083625.136311-2-alexghiti@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/kernel/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 960feb1526caa..3f1c4b2d0b064 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -18,6 +18,7 @@ obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
 
 ccflags-y := -fno-stack-protector
 ccflags-y += -DDISABLE_BRANCH_PROFILING
+ccflags-y += -fno-builtin
 
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -fPIC -include $(c-gettimeofday-y)
-- 
2.43.0





