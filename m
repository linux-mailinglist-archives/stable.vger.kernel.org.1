Return-Path: <stable+bounces-140457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50706AAA8EC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BE316A40D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369B9356E79;
	Mon,  5 May 2025 22:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUkNYY5M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE307356E62;
	Mon,  5 May 2025 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484904; cv=none; b=cunhrKgvk8XGuEaBa3a1DTfly09exiFZYPvRrOitrRypxN6kiDbPmMfVJ5t4o4vz17Az+ow2hoWKXihQmvau0d7fBdeiMPmlaXi5J+GuvzWwuUJ8u+uZx85P3tedFA7rWWnStoi4Sq9zU7WFLe4re3NhXVZTFZNpMM7KZ2/GWGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484904; c=relaxed/simple;
	bh=rP2E7j9BQsnxmYSaw8OJ99Rw70hzDTlkL6FK8+TOsFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=io8Y0Yuxe9Rv1x4Vwajs/9sRXcfON2eU4NPntELIr7smmD5CCDmD8BohOv0N/O5pE9iqx4xZybBYqKZhKt6pg78sv4f1l/IknXRf4YL1PluIjs/yQ3pjRMFkqCj+nyFWeVqC3Jqm3cuXDNCjLW0myMnD123PFdPaUrm2pzvcQmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUkNYY5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4221C4CEED;
	Mon,  5 May 2025 22:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484903;
	bh=rP2E7j9BQsnxmYSaw8OJ99Rw70hzDTlkL6FK8+TOsFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUkNYY5MlAPdH+BpcBIC7uylUdIR+/AsBpJnK5XS8RyDYdGewuReXrgEyoIApc8aN
	 Cv4GWS8gONGjDw3RHJBSIONtLw2aQAeX+VmXnhnmt7P9ju916gMr+ph6Jop/TvuqQC
	 AmNfETLAW06b2BgnI1s9UsrR0OiabJaVpHCghOdmn71j5c9fVuTCTYR8zBW3tE0+OT
	 wJobMsjDPfAkJHkaqUa/qoSkKUwKzp8JiUSyk31Xnpy6K9AqC6XPIa7tWXAji/pcP5
	 /t3uKmsqzCM8mOw7DkeacGkURQs2phJ11kA93XhsIzGNQ68vrVCX+wvT6gXdEHP3sP
	 ebluw3bV3Mtpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Subject: [PATCH AUTOSEL 6.12 066/486] x86/stackprotector/64: Only export __ref_stack_chk_guard on CONFIG_SMP
Date: Mon,  5 May 2025 18:32:22 -0400
Message-Id: <20250505223922.2682012-66-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Ingo Molnar <mingo@kernel.org>

[ Upstream commit 91d5451d97ce35cbd510277fa3b7abf9caa4e34d ]

The __ref_stack_chk_guard symbol doesn't exist on UP:

  <stdin>:4:15: error: ‘__ref_stack_chk_guard’ undeclared here (not in a function)

Fix the #ifdef around the entry.S export.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/r/20250123190747.745588-8-brgerst@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/entry/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index 58e3124ee2b42..5b96249734ada 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -63,7 +63,7 @@ THUNK warn_thunk_thunk, __warn_thunk
  * entirely in the C code, and use an alias emitted by the linker script
  * instead.
  */
-#ifdef CONFIG_STACKPROTECTOR
+#if defined(CONFIG_STACKPROTECTOR) && defined(CONFIG_SMP)
 EXPORT_SYMBOL(__ref_stack_chk_guard);
 #endif
 #endif
-- 
2.39.5


