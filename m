Return-Path: <stable+bounces-86527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27F19A10F3
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 19:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F381B234F1
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 17:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5568F210C25;
	Wed, 16 Oct 2024 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joOpKlSd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F35318BC23;
	Wed, 16 Oct 2024 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101056; cv=none; b=pk2C0z1rcutZWLwWy/uDziVzbaLVN8hbnHeoD2Niv+7DvDsuLGoOLIVSCQdeayCP0lEYvHTr70PEcVR6UiKeMeCgg5smIqMK1zMFN1L1sMvfisMEcg21it+DPH1vPtvcmHpJpZ/Htkh/BEylB6N4/HXAQhCQF2BCgMl7sHRmEQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101056; c=relaxed/simple;
	bh=hoU5DGRfSi0AM7CKet0iYo9j9GdgPMDGPjGhM0wKSno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Gz5smxALhdCygY8Zabn9rfi8nj0Rpjq3gBpavdlecjyyo5G/d2ycLn9LCelegf6B1zOJNpNAD4KfYLxDJHJ5G4dkv68rtpc/hGxphWJVS+daY7d2KyFKUXI1CBCgm8ENKd10jHoXlum76FGobJq4xedsCSPpe0rQzGPL+BqSG34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joOpKlSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABC9DC4CEC5;
	Wed, 16 Oct 2024 17:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729101055;
	bh=hoU5DGRfSi0AM7CKet0iYo9j9GdgPMDGPjGhM0wKSno=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=joOpKlSdtlsK+cPFx91M0RfLr0zarS7AmroBAKCdc8Q0ejrq0O/uRX2Mu9NC69TJb
	 90m/iOJ7ngKXjE2R3rVK14kxb2xf/jX+804QGx5HtIz8ekCC6OcEMeL57nGtBeMQ+l
	 uXJY/BIcUov2zz9PloLHWdp1t8eOJaV/H6+m36YFc+C9ha0hMKMGhU4p02/TdMLgpW
	 aHiSQ3SEWNrl2yLA8NHES50JcGH5DUZSz7jBO8l9/nJh/hNnh0Pj7mABKTouS7pL8Q
	 5ihxkPJcb4XwKMhV7jBOzA/EFFhEilcwOjjhNM2Kej/J61y3LsSASiwrHgpIvTxvy+
	 Frer/KfZFs/tA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97252D2A53B;
	Wed, 16 Oct 2024 17:50:55 +0000 (UTC)
From: Celeste Liu via B4 Relay <devnull+CoelacanthusHex.gmail.com@kernel.org>
Date: Thu, 17 Oct 2024 01:49:49 +0800
Subject: [PATCH] riscv/entry: get correct syscall number from
 syscall_get_nr()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-fix-riscv-syscall-nr-v1-1-4edb4ca07f07@gmail.com>
X-B4-Tracking: v=1; b=H4sIALz8D2cC/x2MSQqAMAwAvyI5G7AuFf2KeNCaakCqJFAU8e8Wj
 wMz84CSMCn02QNCkZWPkMDkGbhtCishL4mhLMraFMai5wuF1UXUW9207xgEO9POjbW+a30FKT2
 Fkvdvh/F9P1Mix5BmAAAA
X-Change-ID: 20241016-fix-riscv-syscall-nr-917b566f97f3
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 Celeste Liu <coelacanthushex@gmail.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 "Dmitry V. Levin" <ldv@strace.io>, Andrea Bolognani <abologna@redhat.com>, 
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>, 
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>, 
 Yao Zi <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2366;
 i=CoelacanthusHex@gmail.com; h=from:subject:message-id;
 bh=lQHWH4mdPxR6fSPtGuLhEmZBLbEpDpJ9XVmyzF+kIjU=;
 b=owJ4nJvAy8zAJfY4pvNJRPo6U8bTakkM6fx//rDbHWUTjFeQ1lxc+evTyrQnVWz7ZnMl5gXGN
 bKeX89itrCjlIVBjItBVkyRRWzn09fLSh99WMZrMgNmDisTyBAGLk4BmIiTFyPDhFnn9dIvunfM
 ezeRcxLDm791Uyo+aE9KqdXql5lxwCePn5HhUrLiJuNJhmd61+wIi3naMVdOfk7c5X/cwk3Xt4c
 4mnjxAQABV0jh
X-Developer-Key: i=CoelacanthusHex@gmail.com; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863
X-Endpoint-Received: by B4 Relay for CoelacanthusHex@gmail.com/default with
 auth_id=84
X-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Reply-To: CoelacanthusHex@gmail.com

From: Celeste Liu <CoelacanthusHex@gmail.com>

The return value of syscall_enter_from_user_mode() is always -1 when the
syscall was filtered. We can't know whether syscall_nr is -1 when we get -1
from syscall_enter_from_user_mode(). And the old syscall variable is
unusable because syscall_enter_from_user_mode() may change a7 register.
So get correct syscall number from syscall_get_nr().

So syscall number part of return value of syscall_enter_from_user_mode()
is completely useless. We can remove it from API and require caller to
get syscall number from syscall_get_nr(). But this change affect more
architectures and will block more time. So we split it into another
patchset to avoid block this fix. (Other architectures can works
without this change but riscv need it, see Link: tag below)

Fixes: 61119394631f ("riscv: entry: always initialize regs->a0 to -ENOSYS")
Reported-by: Andrea Bolognani <abologna@redhat.com>
Closes: https://github.com/strace/strace/issues/315
Link: https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/
Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
---
 arch/riscv/kernel/traps.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 51ebfd23e0076447518081d137102a9a11ff2e45..3125fab8ee4af468ace9f692dd34e1797555cce3 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -316,18 +316,25 @@ void do_trap_ecall_u(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		long syscall = regs->a7;
+		long res;
 
 		regs->epc += 4;
 		regs->orig_a0 = regs->a0;
-		regs->a0 = -ENOSYS;
 
 		riscv_v_vstate_discard(regs);
 
-		syscall = syscall_enter_from_user_mode(regs, syscall);
+		res = syscall_enter_from_user_mode(regs, syscall);
+		/*
+		 * Call syscall_get_nr() again because syscall_enter_from_user_mode()
+		 * may change a7 register.
+		 */
+		syscall = syscall_get_nr(current, regs);
 
 		add_random_kstack_offset();
 
-		if (syscall >= 0 && syscall < NR_syscalls)
+		if (syscall < 0 || syscall >= NR_syscalls)
+			regs->a0 = -ENOSYS;
+		else if (res != -1)
 			syscall_handler(regs, syscall);
 
 		/*

---
base-commit: 2f87d0916ce0d2925cedbc9e8f5d6291ba2ac7b2
change-id: 20241016-fix-riscv-syscall-nr-917b566f97f3

Best regards,
-- 
Celeste Liu <CoelacanthusHex@gmail.com>



