Return-Path: <stable+bounces-90020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B6D9BDCA0
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06BAA1C20A0C
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0663D215F4E;
	Wed,  6 Nov 2024 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc9lS44H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B692F18FDB9;
	Wed,  6 Nov 2024 02:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859208; cv=none; b=YY3bkVXE2YkdLYN5XQbsqBU7FaNle9iQzZZtFNfZzJ1Be6tumpgdojabOaE7L/EUxjlKhr519scyRMAhuFeCJkpepnjn+Q+rKRpokKa6JQCRsNCVqx+06T4DARfFxtL0Ax5ua+e+Z4zVoSnNynt9fn+V721+UAvrIQwnd5Y3ChA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859208; c=relaxed/simple;
	bh=Iya6cx9gftMjLiot4YGn/cbRbjuzRahotfTH2ArRiQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PVSzQJ7vgrwrYynqWrveKmn6QyTYWMNQVQlg9jbw/ymif4xuLjOI0Gfa9bLpS8pxrWsVGS0bGuD6aJC7qnfji0CN4SvxXs21meC/TU38vNEDS23Yo3RPvo6EjO4V7smX59bmpNI6+09B5BNLcvkI0GP7jt0YNbPcamso2wUw5RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lc9lS44H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605AAC4CED1;
	Wed,  6 Nov 2024 02:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859206;
	bh=Iya6cx9gftMjLiot4YGn/cbRbjuzRahotfTH2ArRiQI=;
	h=From:To:Cc:Subject:Date:From;
	b=Lc9lS44H0ACxY1ZjleaNpu32d45zJ1r3IVxmLtH9GTAEtDwzSkJwhj+CiHJThiUj5
	 uIDmysjIB/9EV27Fd4Ll9ojKVj5jRVFxx3QtAKToIgzoXpQE0cqZbPj+KltvUe/SYw
	 CBJiFaX466VEK9AOc/BqqC8T0Oj967YrDwqq7KPi1cUHc6X5jq9MVlbez0CBnIiB5g
	 tvUx44BH4C8dJDjOxPs4andDUCcz5vfIDn+Mo6tngkLzX9WYRTdkBRLE0r5RI/Gtts
	 6T21Jn9X3sEiC9zLOeVBIbl1CT4QvVJhZQQ0RrnUs52VvmLjcRTuDQjSqi0Z5PemXi
	 /qlWhillcjxYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	alexghiti@rivosinc.com
Cc: Guo Ren <guoren@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "riscv: vdso: Prevent the compiler from inserting calls to memset()" failed to apply to v5.4-stable tree
Date: Tue,  5 Nov 2024 21:13:23 -0500
Message-ID: <20241106021323.183560-1-sashal@kernel.org>
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

The patch below does not apply to the v5.4-stable tree.
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





