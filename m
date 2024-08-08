Return-Path: <stable+bounces-66062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBECB94C0B4
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 17:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2A9286E6F
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 15:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD04D18F2FD;
	Thu,  8 Aug 2024 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nKqw7KU1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h/uyTAWH"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC97C18EFC8;
	Thu,  8 Aug 2024 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130043; cv=none; b=s7JyZR3qyAtesubCYPCOX522sTRES95qodqzYZaXUq8HGtrI5dJrcA3RPJi473t2cYV75a0qXKwhSPdOZZExcfRLUW7c27OdrKTsb/GY6DJer8BaLcCQsMu5pbm25wl3yYgjWHiUK11VXqgBuiwwJuHde4zo7gaixe6ACUaJysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130043; c=relaxed/simple;
	bh=cTpCsyPJ4hFjVH2XAjBl0UpnWxc2JOnEK+AxCFHtWZU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Cvc+k8V+xlZNsUPksOFTKskR9cOY6vuegSWOEC8cLvLvjJ5FZh0ySMWeYha8o5mMalPkxbTNSTiKdL59JhoCsZJfSFa19rt/2/thCVhobjenkzwhkWpVBXOA83OojwRtOuLPDHPlqLvjbMh71a+dltqz7pz2Y8VG/1osR9ME6uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nKqw7KU1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h/uyTAWH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 15:13:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723130040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5v+mVeSFLEeJZNFpUajBpfv5cPDXB1lVLT9xWoVzqU0=;
	b=nKqw7KU1/6BaYSz5qHyJmun0h3rgVmPtHl1/MLNxXluGrm4kwVs6ZZLDKKsPlf3RNUmSu5
	sAc6jChJq0bvhYDPKZGZbRJC7gR/5ggNJHUijQ1yJvX4e3n1oQ6zc8RgdMrrsKSPkujmsT
	RhRqOSvropCZ4UYiSHeMvGNtohaxQ6QLeX9K48gday6a4bRCuXe9cigZnE4CHZ17y18vYx
	K69YykTxjDdLF37knVMYEQQWz7r3IO3+F7fjvBVg/T3ED0/wPChvERIQ6J6SaGdi3sjCkx
	goqUb1gjLt8dhzisHcrGneuWP1qzfkCJpatfkiK5sk+HJXYjFsKJYbjucABeuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723130040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5v+mVeSFLEeJZNFpUajBpfv5cPDXB1lVLT9xWoVzqU0=;
	b=h/uyTAWHusFXakfaQqg+oPaL5hMXF/QxkxO1e6iMrcLKyopLWX6+9foT7g/1CbgPjWfXnd
	igq8hXJ7H7JdkUCg==
From: "tip-bot2 for Andi Kleen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/mtrr: Check if fixed MTRRs exist before saving them
Cc: Andi Kleen <ak@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240808000244.946864-1-ak@linux.intel.com>
References: <20240808000244.946864-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313003942.2215.6934578007639618525.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     919f18f961c03d6694aa726c514184f2311a4614
Gitweb:        https://git.kernel.org/tip/919f18f961c03d6694aa726c514184f2311a4614
Author:        Andi Kleen <ak@linux.intel.com>
AuthorDate:    Wed, 07 Aug 2024 17:02:44 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 17:03:12 +02:00

x86/mtrr: Check if fixed MTRRs exist before saving them

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
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 767bf1c..2a2fc14 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -609,7 +609,7 @@ void mtrr_save_state(void)
 {
 	int first_cpu;
 
-	if (!mtrr_enabled())
+	if (!mtrr_enabled() || !mtrr_state.have_fixed)
 		return;
 
 	first_cpu = cpumask_first(cpu_online_mask);

