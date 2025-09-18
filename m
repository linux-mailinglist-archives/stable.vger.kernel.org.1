Return-Path: <stable+bounces-170870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12800B2A739
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2376E1B630ED
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46262322A33;
	Mon, 18 Aug 2025 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I44D63wn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F0A1DDA14;
	Mon, 18 Aug 2025 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524067; cv=none; b=T3gARjIJsDNqoUe5VbRnrTg3XkmSqYJpkEU0jp/pCjTn+fSL1SroKKJAYBSnrTJfOzZw3f3AuK0J7vq+uKTFOmVOWf97zcJNpXXxbstMP/4PdUXu9YAdlabDYafu88M1qn2J1GxK66N/0iZcDJfjKbFAXXiMldFqxHK4YPlFnP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524067; c=relaxed/simple;
	bh=zQcvlS2FTBGXuAc3b2LMAQ1t1eQumyNuTdk4wIzs0iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nM1w0/gitDnTl7/M0prylFlG9vr4NISBa8gmx5KyOLFD/hkWgor6lgRNUMH+EmL+YMGrGpaa+TtVEyOdqzAG51axyR2TyqaSL6y80TsomtFL1ItJGK5PHmsEQH4hzBUqUqlgLAIPx9m4CHQJouVOh3iAq0FI3tskbAhHncH59j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I44D63wn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DCCC4CEEB;
	Mon, 18 Aug 2025 13:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755524066;
	bh=zQcvlS2FTBGXuAc3b2LMAQ1t1eQumyNuTdk4wIzs0iY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I44D63wn/yJRca2ofAx6PNOaGe5WDiBiB++gTL9ToCXsvkR8ham4tgqtJU93MzPME
	 PtBFPJxuC79NE/ck9Dt4jpc/77ZhD71Wt5Voj7HTPhiKV3liL2EGjE8tBpTFV2GB+C
	 +mkITGAjeqEvtbthVBZBXk4WK1Px2Gi//9ZQu4Zw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	David Gow <davidgow@google.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 356/515] MIPS: Dont crash in stack_top() for tasks without ABI or vDSO
Date: Mon, 18 Aug 2025 14:45:42 +0200
Message-ID: <20250818124512.119820285@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
References: <20250818124458.334548733@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

[ Upstream commit e9f4a6b3421e936c3ee9d74710243897d74dbaa2 ]

Not all tasks have an ABI associated or vDSO mapped,
for example kthreads never do.
If such a task ever ends up calling stack_top(), it will derefence the
NULL ABI pointer and crash.

This can for example happen when using kunit:

    mips_stack_top+0x28/0xc0
    arch_pick_mmap_layout+0x190/0x220
    kunit_vm_mmap_init+0xf8/0x138
    __kunit_add_resource+0x40/0xa8
    kunit_vm_mmap+0x88/0xd8
    usercopy_test_init+0xb8/0x240
    kunit_try_run_case+0x5c/0x1a8
    kunit_generic_run_threadfn_adapter+0x28/0x50
    kthread+0x118/0x240
    ret_from_kernel_thread+0x14/0x1c

Only dereference the ABI point if it is set.

The GIC page is also included as it is specific to the vDSO.
Also move the randomization adjustment into the same conditional.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/process.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index b630604c577f..02aa6a04a21d 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -690,18 +690,20 @@ unsigned long mips_stack_top(void)
 	}
 
 	/* Space for the VDSO, data page & GIC user page */
-	top -= PAGE_ALIGN(current->thread.abi->vdso->size);
-	top -= PAGE_SIZE;
-	top -= mips_gic_present() ? PAGE_SIZE : 0;
+	if (current->thread.abi) {
+		top -= PAGE_ALIGN(current->thread.abi->vdso->size);
+		top -= PAGE_SIZE;
+		top -= mips_gic_present() ? PAGE_SIZE : 0;
+
+		/* Space to randomize the VDSO base */
+		if (current->flags & PF_RANDOMIZE)
+			top -= VDSO_RANDOMIZE_SIZE;
+	}
 
 	/* Space for cache colour alignment */
 	if (cpu_has_dc_aliases)
 		top -= shm_align_mask + 1;
 
-	/* Space to randomize the VDSO base */
-	if (current->flags & PF_RANDOMIZE)
-		top -= VDSO_RANDOMIZE_SIZE;
-
 	return top;
 }
 
-- 
2.39.5




