Return-Path: <stable+bounces-97184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D195F9E233A
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D70D16A8DD
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375E71F75BB;
	Tue,  3 Dec 2024 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z1D3ltvl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA03E1F473A;
	Tue,  3 Dec 2024 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239756; cv=none; b=cXxLsZJBxn/hkd26/mWPy73dRarm3SlncQSvT2lgsJk3iFcq+IIBdkhnEGOrtEUEAmKV8U40uzPGmAX/xUMFPlEdSgIMoysIcG8kSAjJjgx9ZTINyxBzR71vxO6vhNz+dEHwOnOjhH7JRJn9LL9ELnuQ1VdiRjd68z2AV9shDi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239756; c=relaxed/simple;
	bh=2L2RCxkNZ3R4iO0LOB7r2WWgBtCzSLXwm0+5/61Uq3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXCdoi4U87J1m3pvlGtGXiWJ6GL2WBPlDGUzpbUdOaAJTnJCwp2Ntny7+OZi8uha6nOgJ0IsMTXwPRI8lY9T1miWvthIjrA2xRg7ntDBpQr4D2UylnJOshk/e/XeOSE2gf6GeFplzSSIOAw37yiYXZ3akAW30h2+26IcEVj4a6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z1D3ltvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33268C4CECF;
	Tue,  3 Dec 2024 15:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239756;
	bh=2L2RCxkNZ3R4iO0LOB7r2WWgBtCzSLXwm0+5/61Uq3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z1D3ltvlVpiJsIEC5XN0u5O5+d77b4jK/bGfjTZRXzDb1z6ZiHUk/3ClM1BQkU6MG
	 30w+hmuqjeZmC8kbk8dhuIkWWjTIiV2rCOUVNJGVkBGtw++iBinY6FTCxJQxBvg+ok
	 f+f4uhv/mTlycrLakwj6dT4leQCSs/GCIDcvPW7k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.11 724/817] arm64: tls: Fix context-switching of tpidrro_el0 when kpti is enabled
Date: Tue,  3 Dec 2024 15:44:56 +0100
Message-ID: <20241203144024.255536324@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

From: Will Deacon <will@kernel.org>

commit 67ab51cbdfee02ef07fb9d7d14cc0bf6cb5a5e5c upstream.

Commit 18011eac28c7 ("arm64: tls: Avoid unconditional zeroing of
tpidrro_el0 for native tasks") tried to optimise the context switching
of tpidrro_el0 by eliding the clearing of the register when switching
to a native task with kpti enabled, on the erroneous assumption that
the kpti trampoline entry code would already have taken care of the
write.

Although the kpti trampoline does zero the register on entry from a
native task, the check in tls_thread_switch() is on the *next* task and
so we can end up leaving a stale, non-zero value in the register if the
previous task was 32-bit.

Drop the broken optimisation and zero tpidrro_el0 unconditionally when
switching to a native 64-bit task.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: stable@vger.kernel.org
Fixes: 18011eac28c7 ("arm64: tls: Avoid unconditional zeroing of tpidrro_el0 for native tasks")
Signed-off-by: Will Deacon <will@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20241114095332.23391-1-will@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/process.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -426,7 +426,7 @@ static void tls_thread_switch(struct tas
 
 	if (is_compat_thread(task_thread_info(next)))
 		write_sysreg(next->thread.uw.tp_value, tpidrro_el0);
-	else if (!arm64_kernel_unmapped_at_el0())
+	else
 		write_sysreg(0, tpidrro_el0);
 
 	write_sysreg(*task_user_tls(next), tpidr_el0);



