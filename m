Return-Path: <stable+bounces-139833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DC9AAA094
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823EC17D433
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA80293459;
	Mon,  5 May 2025 22:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qth46h5v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932127CB0F;
	Mon,  5 May 2025 22:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483509; cv=none; b=CefPSROChjWN1wb01Swi0lBxVjz4WY/dwbqMhTwA6pxaYfsGMUX88Anh6AvaRIikx6YKwurCdjWSXaEVerbTLOMlaIiaU9htwhch6IdtfYW6O4vDKzcmmCSu8pfx4cRaEN3+qOQytYP9R9UOmb//dykBlpI773bK7XJblIAubio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483509; c=relaxed/simple;
	bh=zU9qTb4Y9XZ0VN6iUH6BJ4TyDMZZLb6olqi5CLDBgko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s9qxiEYPbAAdKvBaBngvLNKo71LqKCYIMuBDiy5UY7Zy/1jLWamAbWmopUsDXK5SHevrMcQUZATpGeWmCq3PzKodEBn8rkaU4vFtXZ+Y0466ETB7MeAE489AT8MvOPtTTcTPrfuYq05hZXPhpAHswIIn2eq12vsk7sBN2Q9qFXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qth46h5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41100C4CEE4;
	Mon,  5 May 2025 22:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483508;
	bh=zU9qTb4Y9XZ0VN6iUH6BJ4TyDMZZLb6olqi5CLDBgko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qth46h5vmiPj2Yv5bocc3kF/k7GUMKd8oObotoYoy7SQJwXmOZy8ES4oxvvqpcOnq
	 w6/VKDd1ZIxs61XoyYWZJ5fSid7l2uRpeuVeR0h3dfMsjW5Ye/K24eSvBFol5v8sfO
	 x9tGPbL+/s0hVdJGa/HlCwM4Xhg7Ehh3UcSD55yHP/tGljDtrTbxcbCCt8Ks2TEhuK
	 jvzpv55e0OgSsAzmrxhY7zg90gWevb2KS6ayd+lpXWVUh2O94rERAQAy3fZuBs0HhY
	 mtpLC1ca01uu281MlkTfcrMoBZaWFiHwxdfdU4YakCEC0fv1X1Qs/MBdiF96KBJGyf
	 lENpv2zNiZBEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sohil Mehta <sohil.mehta@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	peterz@infradead.org,
	gautham.shenoy@amd.com,
	artem.bityutskiy@linux.intel.com,
	patryk.wlazlyn@linux.intel.com,
	brgerst@gmail.com,
	kprateek.nayak@amd.com
Subject: [PATCH AUTOSEL 6.14 086/642] x86/smpboot: Fix INIT delay assignment for extended Intel Families
Date: Mon,  5 May 2025 18:05:02 -0400
Message-Id: <20250505221419.2672473-86-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Sohil Mehta <sohil.mehta@intel.com>

[ Upstream commit 7a2ad752746bfb13e89a83984ecc52a48bae4969 ]

Some old crusty CPUs need an extra delay that slows down booting. See
the comment above 'init_udelay' for details. Newer CPUs don't need the
delay.

Right now, for Intel, Family 6 and only Family 6 skips the delay. That
leaves out both the Family 15 (Pentium 4s) and brand new Family 18/19
models.

The omission of Family 15 (Pentium 4s) seems like an oversight and 18/19
do not need the delay.

Skip the delay on all Intel processors Family 6 and beyond.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250219184133.816753-11-sohil.mehta@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/smpboot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c10850ae6f094..3d5069ee297bf 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -676,9 +676,9 @@ static void __init smp_quirk_init_udelay(void)
 		return;
 
 	/* if modern processor, use no delay */
-	if (((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 == 6)) ||
-	    ((boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) && (boot_cpu_data.x86 >= 0x18)) ||
-	    ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) && (boot_cpu_data.x86 >= 0xF))) {
+	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && boot_cpu_data.x86_vfm >= INTEL_PENTIUM_PRO) ||
+	    (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON && boot_cpu_data.x86 >= 0x18) ||
+	    (boot_cpu_data.x86_vendor == X86_VENDOR_AMD   && boot_cpu_data.x86 >= 0xF)) {
 		init_udelay = 0;
 		return;
 	}
-- 
2.39.5


