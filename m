Return-Path: <stable+bounces-67965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D09E953004
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B7A2B241B3
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23AA19F467;
	Thu, 15 Aug 2024 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FxF4FCWX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B118A198E78;
	Thu, 15 Aug 2024 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729074; cv=none; b=N+fxt5GkgGoscxhUjsh1gyEoS/Kl0nKJxLOZByzrZ+GtN8rBLId5xiofzJsYr3AlY8C2t9Q2EVaawASzkJHQFYFGfZBN9wpZbaFG4eJNM9bCMmYMfNwgsE6v9QZdiJ/2vXl6D9RfDdpM4CR9HW///h8KkOWP6b9zWYqk1ZbgGok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729074; c=relaxed/simple;
	bh=1onvOKeowLl+6R9ZRF0Oql2ZziK6EJlq+NDJdOBF7Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGhM6hnZs4eqVrkDGYjZWEI7pwWs2YE093hJxqw/S+F0OUyjpVM0ylwUKNEET/JFJDBOG3zrN3aO7fDU6nCtBxZj5VTqqFljrRg/JFKgOYisi1Q7p3hBd2PQLW7CaraxSgkuYePHLetr9jtSZm0Ud5+/zOVHSqPW/hvShbYQZA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FxF4FCWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D94C32786;
	Thu, 15 Aug 2024 13:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723729074;
	bh=1onvOKeowLl+6R9ZRF0Oql2ZziK6EJlq+NDJdOBF7Gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FxF4FCWXcWqzXRFoo2jMWXgSv7zFdcNM0aHvaQsAV2VlPHSrR1uP+b+2LGMi6547W
	 ZaNCpnyHuoxqbuKSlGlkoX0cndhj+5UL7E7dKxh0d944G3TlNOHiRSPUGBKChEW+fO
	 bhrW0ibLJJ9FYuiAQf/RsYZMV5d+/SmSjnb7pfdk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.19 185/196] x86/mtrr: Check if fixed MTRRs exist before saving them
Date: Thu, 15 Aug 2024 15:25:02 +0200
Message-ID: <20240815131859.148176794@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131852.063866671@linuxfoundation.org>
References: <20240815131852.063866671@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Kleen <ak@linux.intel.com>

commit 919f18f961c03d6694aa726c514184f2311a4614 upstream.

MTRRs have an obsolete fixed variant for fine grained caching control
of the 640K-1MB region that uses separate MSRs. This fixed variant has
a separate capability bit in the MTRR capability MSR.

So far all x86 CPUs which support MTRR have this separate bit set, so it
went unnoticed that mtrr_save_state() does not check the capability bit
before accessing the fixed MTRR MSRs.

Though on a CPU that does not support the fixed MTRR capability this
results in a #GP.  The #GP itself is harmless because the RDMSR fault is
handled gracefully, but results in a WARN_ON().

Add the missing capability check to prevent this.

Fixes: 2b1f6278d77c ("[PATCH] x86: Save the MTRRs of the BSP before booting an AP")
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240808000244.946864-1-ak@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/mtrr/mtrr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -819,7 +819,7 @@ void mtrr_save_state(void)
 {
 	int first_cpu;
 
-	if (!mtrr_enabled())
+	if (!mtrr_enabled() || !mtrr_state.have_fixed)
 		return;
 
 	first_cpu = cpumask_first(cpu_online_mask);



