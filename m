Return-Path: <stable+bounces-152404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C06AD4FD1
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 11:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41C01762F9
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 09:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23445263C91;
	Wed, 11 Jun 2025 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2wjYwiF4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aKEK1uRQ"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AA8262FCD;
	Wed, 11 Jun 2025 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634234; cv=none; b=uwd0+axpmr+WF6hkNGD7AVHTL06Z86WFXR+YKpZcyeqf9v//15JFlEPk5fwJdnyzYlcC1Yc7RisRtRWeuNUZRJ2Nj2Y5F6f4QktCntpElJ5nh3eXtngwj+TopC2YmPgczLSeeiMYxbN+pGRmAw4lN7JqlUfvHJ7C/WT/sBhHIpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634234; c=relaxed/simple;
	bh=Xre9OZhBxx5BetyOhfceFKvhgAfD3KiBR1ESaWvFtoQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HIBlUE/S2yadon1Q/dvfgF0r1ZUXdlUcAz8uS5eC2Hex2+R7dTQSQVQk+EtwM4DgEWcPRqOKx85DJCrp9EM1NYY9r69Rcoq2zlLC5g97Lb3K4c0rJzeH4QV1BFqAaQo+f8X6LB0gU8edzEqsLEZ4s6YVpGmc6n+Ny8L8OuEEnEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2wjYwiF4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aKEK1uRQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 09:30:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749634231;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aagKQoBFYjQx/KdEhgTRbCfWhXD8RseT1Qk4Se5raYY=;
	b=2wjYwiF4vZ6TKDSb+e75bLeCByyVN7UIQ91VHAuu+rAAq6ZNwL7Jt49EKk5IaFJuoXdIWo
	GZLhSvnkA4ZmelykLe4GjgJvupuFlv5yLw0iwEIB0npWvNlGLoLxo1QieIgDIruZ73T7Tc
	Al/8dRAKFFj6ANodpgS0OKlCH6hjqlRLLguZoBrvy1PSUaIpXh3NMp6U+seqcjJGd/otpa
	YVSvFkwKoknKBe0kE9FI8X40ZUXKByl9t/v0x6DXSKFFJgx0POmBpN4PdnEtSyNrDRo6DF
	J3uoS5X6vNlwEZD6eGg8DzGUuZ6f6QhSf8rGVXpO/Q9Z8Qh7ZYFJVWiS2H6eOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749634231;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aagKQoBFYjQx/KdEhgTRbCfWhXD8RseT1Qk4Se5raYY=;
	b=aKEK1uRQM2iem/CuOXC1S7tiUR8Z/lkJfgZ932HI8gMBg4WHsmr5Df7qyXt3Dc8hrDbTEH
	kK30rSX3A5oMJhDQ==
From: "tip-bot2 for Mike Rapoport (Microsoft)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/Kconfig: only enable ROX cache in execmem when
 STRICT_MODULE_RWX is set
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250603111446.2609381-3-rppt@kernel.org>
References: <20250603111446.2609381-3-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174963423090.406.10621053265956044642.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     47410d839fcda6890cb82828f874f97710982f24
Gitweb:        https://git.kernel.org/tip/47410d839fcda6890cb82828f874f97710982f24
Author:        Mike Rapoport (Microsoft) <rppt@kernel.org>
AuthorDate:    Tue, 03 Jun 2025 14:14:42 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 Jun 2025 11:20:51 +02:00

x86/Kconfig: only enable ROX cache in execmem when STRICT_MODULE_RWX is set

Currently ROX cache in execmem is enabled regardless of
STRICT_MODULE_RWX setting. This breaks an assumption that module memory
is writable when STRICT_MODULE_RWX is disabled, for instance for kernel
debuggin.

Only enable ROX cache in execmem when STRICT_MODULE_RWX is set to
restore the original behaviour of module text permissions.

Fixes: 64f6a4e10c05 ("x86: re-enable EXECMEM_ROX support")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20250603111446.2609381-3-rppt@kernel.org
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 340e546..71019b3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -89,7 +89,7 @@ config X86
 	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
 	select ARCH_HAS_EARLY_DEBUG		if KGDB
 	select ARCH_HAS_ELF_RANDOMIZE
-	select ARCH_HAS_EXECMEM_ROX		if X86_64
+	select ARCH_HAS_EXECMEM_ROX		if X86_64 && STRICT_MODULE_RWX
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL

