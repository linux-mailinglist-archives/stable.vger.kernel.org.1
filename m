Return-Path: <stable+bounces-123511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD2BA5C5F1
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17485189AC70
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D677E110;
	Tue, 11 Mar 2025 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nWtPTfeg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7020615820C;
	Tue, 11 Mar 2025 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706167; cv=none; b=SvX8NduJ+Xn7NZi//2tE9jzVzWlIjJ83vpFxVILoMvInqmkZorZriAf8AYgT1kIR7IfkCGUQNQyRpmFKQjuGBE3zXioZ7Sb3XT+WWNTaxk0RY6XdvelnHOONsrDVEzvH+UP3sExiSAae64NeI9iHJ3jFZBzHiFS3YuYRDvp+CvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706167; c=relaxed/simple;
	bh=Uu2d0PRXgfrfJkc7k31+cJl7/F4D5kqMhrGol/0/zgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LI8Kmbk7feMw7dpS6HFy/RZtyqaNUCe15eBSnHRFB7ebaOgeUvboRhTxv0WiiBx1/S+eN61v44txi7HdDKwE3T/B4RyldYeu2Ji6c2tDcNwpEyUlkMUD+LZO67gFZ4LdhOHGXn9yLn5D23yMOH+4vUZFtS5JZx7QCo+AKAVQZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nWtPTfeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60FDC4CEE9;
	Tue, 11 Mar 2025 15:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741706167;
	bh=Uu2d0PRXgfrfJkc7k31+cJl7/F4D5kqMhrGol/0/zgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nWtPTfeg6DH1VxSE8oKz9BOmFgAyhMMGW8sPzVr2aY5f1NteuITQq9LbQe/DSqa2B
	 H6WYuRyKNuhdH5YUw+xTPxdQRXF/pOnve0/fhSCC2Aa6VL9Sm159xWTQovoQqh05OJ
	 DptRvbazUv1lTfGPAT20L+9avghlgPkE4v70X2/s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.4 285/328] x86/cacheinfo: Validate CPUID leaf 0x2 EDX output
Date: Tue, 11 Mar 2025 16:00:55 +0100
Message-ID: <20250311145726.237340588@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145714.865727435@linuxfoundation.org>
References: <20250311145714.865727435@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -795,7 +795,7 @@ void init_intel_cacheinfo(struct cpuinfo
 			cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
 
 			/* If bit 31 is set, this is an unknown format */
-			for (j = 0 ; j < 3 ; j++)
+			for (j = 0 ; j < 4 ; j++)
 				if (regs[j] & (1 << 31))
 					regs[j] = 0;
 



