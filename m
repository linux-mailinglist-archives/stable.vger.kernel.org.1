Return-Path: <stable+bounces-121774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D77A59C5D
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891A83A71CB
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03603233D99;
	Mon, 10 Mar 2025 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UV6fQdkk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64B9233D89;
	Mon, 10 Mar 2025 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626590; cv=none; b=fZ0TknNwICwTeOG0Cn3a8e52ELOnRXPzsBuhkJ4a4iVk7VkYUG4dcb+mlX3CweRTG5L9g2SouMU4purL37cbwp9GE24DG9GO22UI+MGyreSw9uaq4K0Br1zqWi02tQOTk15E+YX+Gb185Rgm7hYD2sbk1k1RNx3ltLtJ6yCEMEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626590; c=relaxed/simple;
	bh=Nlq03bjq53vs0OL7DCzheApyoIkjooQREIVfxMFegEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5pdzscE0m1iXfwrxNc+Lw0zpAEUp5baucElO6GMCsT+MaW+v0ugV5yxg0WgjR3IseCn0FmDkqvPIrjNn2FYLLiLIJ1TiLt9mRHkgfTnQUESFuGKIzdZlu+HSESAr5RFy/NoTW010e1+r+47mdA/FIycu/14Amu6EJGI8miWKRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UV6fQdkk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBB7C4CEED;
	Mon, 10 Mar 2025 17:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741626590;
	bh=Nlq03bjq53vs0OL7DCzheApyoIkjooQREIVfxMFegEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UV6fQdkkguD3+ECYrlT7nL+5ekfUXg3bIg59kLtUYwfm0fLKoRuW5GM9/ZLmNiqQQ
	 ddHe/gRfaf76xx50smfecCxNkXFxaNw6huaKKSX0YJg8vIkFR8twfnWi7Jyf0i8BQH
	 8/XPyOPmAGwiNeAdjV1iMWoeUdgtIgPmqu+RkEgc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.13 045/207] x86/cacheinfo: Validate CPUID leaf 0x2 EDX output
Date: Mon, 10 Mar 2025 18:03:58 +0100
Message-ID: <20250310170449.558482153@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
References: <20250310170447.729440535@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ahmed S. Darwish <darwi@linutronix.de>

commit 8177c6bedb7013cf736137da586cf783922309dd upstream.

CPUID leaf 0x2 emits one-byte descriptors in its four output registers
EAX, EBX, ECX, and EDX.  For these descriptors to be valid, the most
significant bit (MSB) of each register must be clear.

The historical Git commit:

  019361a20f016 ("- pre6: Intel: start to add Pentium IV specific stuff (128-byte cacheline etc)...")

introduced leaf 0x2 output parsing.  It only validated the MSBs of EAX,
EBX, and ECX, but left EDX unchecked.

Validate EDX's most-significant bit.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250304085152.51092-2-darwi@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/cacheinfo.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -808,7 +808,7 @@ void init_intel_cacheinfo(struct cpuinfo
 			cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
 
 			/* If bit 31 is set, this is an unknown format */
-			for (j = 0 ; j < 3 ; j++)
+			for (j = 0 ; j < 4 ; j++)
 				if (regs[j] & (1 << 31))
 					regs[j] = 0;
 



