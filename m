Return-Path: <stable+bounces-139832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B794BAAA090
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2BE3B0991
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD8027CB26;
	Mon,  5 May 2025 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0Ka/4Pz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB96F27CB0F;
	Mon,  5 May 2025 22:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483505; cv=none; b=GbA2aUgzWKoH/lklNJc+cGouKoKb+DZekTIxwOuMi0BUtJNJSmOlRXdrOO3fFAyI2vghCIBIo7o/KNDt3Wr6PhllJ3X54tIcanBmkBcH3UR0IWAS7nYDDhBPR+7gVEz5xfc2ldBYpcKRA1SGBo6l99P8/szvKMHRZzHEZyIeAiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483505; c=relaxed/simple;
	bh=rP2E7j9BQsnxmYSaw8OJ99Rw70hzDTlkL6FK8+TOsFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hEIF4/shADUydNOrBOOgShiuu8osxRPLe9q9E5B5eZrtLeZbqzCFuPa6LRf0ifwm+KZdKIUb48l09nlwMPkTIGNw+QnPZ7KoSgAcpx8TKOk8gjkBFV9oH9/4Ho8o7AviTXQMb3QO2vEki34Y/6l23KKqRHCSLnTOK5ACFihH70Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0Ka/4Pz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A8BC4CEF1;
	Mon,  5 May 2025 22:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483505;
	bh=rP2E7j9BQsnxmYSaw8OJ99Rw70hzDTlkL6FK8+TOsFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G0Ka/4Pz1Oau61K2SrrBgUVqyP00XRLutI6fomDMyTxj2bPXDilrKjrmuYm85KbYu
	 rjtKJ9DubTnXr2g4FNB9EeDYm0UacKUS0/20TCOGxNOp9U6o1FF5PXH/o3BRuRahYq
	 XFV8/SWT8psNzjfWlwvygzgsBLst31FnHDRyp16MYjj6q/nwKOrT4CTp3XqevO6x0h
	 IVrbEB+WhWioU04x89B0GyIvQahvik72saeNleSaOJ6uFlDcEEtfgItPyx0PX0tFir
	 tqmVtDscdZeuaGd3s+fdXJmXPPTjDJ07h/oumblTwDGC7usiXh48wOswN4MYuK/cOM
	 xHulcEty40RSg==
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
Subject: [PATCH AUTOSEL 6.14 085/642] x86/stackprotector/64: Only export __ref_stack_chk_guard on CONFIG_SMP
Date: Mon,  5 May 2025 18:05:01 -0400
Message-Id: <20250505221419.2672473-85-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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


