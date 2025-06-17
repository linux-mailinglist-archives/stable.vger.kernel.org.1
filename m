Return-Path: <stable+bounces-153147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 913A9ADD2A0
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A82317E29F
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A592ECD3C;
	Tue, 17 Jun 2025 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eM/tr5Qm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE882ECD0B;
	Tue, 17 Jun 2025 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175029; cv=none; b=XiGkUuDs44LeN8b30XFIXOKukmi/9rji6a7psLemV+3QcVwaJKAlXAKJ4LCmr8G5iml7eEhBd5cjx/r4oj5BmHInRTWmPRpgX3qBeU4V8st4T05tCVPRBMxey9gZ+CJOWNs5NCLZc9wHx9hHH8+3eAUIoIfMecZFW2Jpy2vrirY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175029; c=relaxed/simple;
	bh=S1buKTg+c82KBegJWduDlFiR2djH9wuoivhZR01rthY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEo7OXU8u5m4yNxtVAz5XqGuUkToi4+14a7HAqIP3zr3jKMeGsFVJcPNqHgQMGVLsJObTVa2shvj+H27QHtUr3qtwISVWNw/79RqROuU+J/QGEcfyeQ9YLfwxizZMSXUZxyBd2GmlCUzYIlXKTZLMEDFuoEeKxBV3Q7IIVfp4pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eM/tr5Qm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF210C4CEF1;
	Tue, 17 Jun 2025 15:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175029;
	bh=S1buKTg+c82KBegJWduDlFiR2djH9wuoivhZR01rthY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eM/tr5QmsJlEYI+UWL9XRG6+DeDV7mUhd/mhrSkXDjs9FGc+IL6sc1t7tb2JJpYGl
	 yRMFpiE3U4FpR00vGGXYCmmCQchSeZClmteXOwRziQ1e/q/llg4oIvBCCnWKKvPp7e
	 wBwHIrjE19+cEgOfcNrPE95RtX+MbeeuBOaiphZ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 085/512] arm64/fpsimd: Avoid warning when sve_to_fpsimd() is unused
Date: Tue, 17 Jun 2025 17:20:51 +0200
Message-ID: <20250617152423.017032462@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit f699c66691fb7e08a5a631c5baf5f2a19b7a6468 ]

Historically fpsimd_to_sve() and sve_to_fpsimd() were (conditionally)
called by functions which were defined regardless of CONFIG_ARM64_SVE.
Hence it was necessary that both fpsimd_to_sve() and sve_to_fpsimd()
were always defined and not guarded by ifdeffery.

As a result of the removal of fpsimd_signal_preserve_current_state() in
commit:

  929fa99b1215966f ("arm64/fpsimd: signal: Always save+flush state early")

... sve_to_fpsimd() has no callers when CONFIG_ARM64_SVE=n, resulting in
a build-time warnign that it is unused:

| arch/arm64/kernel/fpsimd.c:676:13: warning: unused function 'sve_to_fpsimd' [-Wunused-function]
|   676 | static void sve_to_fpsimd(struct task_struct *task)
|       |             ^~~~~~~~~~~~~
| 1 warning generated.

In contrast, fpsimd_to_sve() still has callers which are defined when
CONFIG_ARM64_SVE=n, and it would be awkward to hide this behind
ifdeffery and/or to use stub functions.

For now, suppress the warning by marking both fpsimd_to_sve() and
sve_to_fpsimd() as 'static inline', as we usually do for stub functions.
The compiler will no longer warn if either function is unused.

Aside from suppressing the warning, there should be no functional change
as a result of this patch.

Link: https://lore.kernel.org/linux-arm-kernel/20250429194600.GA26883@willie-the-truck/
Reported-by: Will Deacon <will@kernel.org>
Fixes: 929fa99b1215 ("arm64/fpsimd: signal: Always save+flush state early")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20250430173240.4023627-1-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 9f4f3d54c2207..c5285ee55bfb0 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -651,7 +651,7 @@ static void __fpsimd_to_sve(void *sst, struct user_fpsimd_state const *fst,
  * task->thread.uw.fpsimd_state must be up to date before calling this
  * function.
  */
-static void fpsimd_to_sve(struct task_struct *task)
+static inline void fpsimd_to_sve(struct task_struct *task)
 {
 	unsigned int vq;
 	void *sst = task->thread.sve_state;
@@ -675,7 +675,7 @@ static void fpsimd_to_sve(struct task_struct *task)
  * bytes of allocated kernel memory.
  * task->thread.sve_state must be up to date before calling this function.
  */
-static void sve_to_fpsimd(struct task_struct *task)
+static inline void sve_to_fpsimd(struct task_struct *task)
 {
 	unsigned int vq, vl;
 	void const *sst = task->thread.sve_state;
-- 
2.39.5




