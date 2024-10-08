Return-Path: <stable+bounces-83112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28037995B14
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 00:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F622B2510D
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 22:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E84521A6E3;
	Tue,  8 Oct 2024 22:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N5aTpS6v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vfcOuQ1s"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34151CACDC;
	Tue,  8 Oct 2024 22:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427542; cv=none; b=EAUNSTAzG/KZagrhK1GcAEvP/N0HBFY6ZwhAP8W9Q1PARcwhDk6a1XVQO27DCDfcIXHrv8j5myKmephdqGpzbTpyoI5HhdxyrQDjVgfwBBFruqJ1JFaCdrBWXFz4cgstlxrbOmHYxFAdaAqsh7MpGhlvO/uPNIxTFTrLUQIuV9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427542; c=relaxed/simple;
	bh=DXnBOtCEQnmdNNqLrINkkdPxmGEjLw+YknMc0Kv0wyA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=nu/r2QOIzuPbxvbtyCivoP966hUtcfSJejGS9t2HA9kieBTMUfGRtQjOtJW00tiBSE+ijYW/GxvUxTcFzlyhSs4CeZmLwKrnH5DK7vavxb8SiLCacqMaHEHP/UzkVZFCXTWHaNkzOAonvN0emKiqAK/1cie2caVO4Puo3d5GGRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N5aTpS6v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vfcOuQ1s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 22:45:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728427538;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=oi65unuKLUIrRb5PpilifhVCNF0CpOI1LIz29bZkgiQ=;
	b=N5aTpS6vm/kZBSBlCcQuLUQrujXJR2EDHoAujTupGUyRBCexoHTipH4WuYxoK38Mb1LUmt
	CgC8ekT48RY+O28zXqjROHkpsB44DWmoLi00tPG1ESKEydyWbdt9GW+uHXLa9/iEGBVINq
	YRfxI1M2SPfwZchh4HSi7xUZP2I5SRWUfXst+l6mHhQyLKI/PhhXepCQzG9LVhus3+p++a
	cdy1mk5zgW2D74r3SvdTZjRQpzQmdApQ/UNL9uwW+TXCINTePzD0UCwGNhXpN+czPiegNI
	TPwpVhM83MN1xte8tF5Im9+4aODa9lONpt0+0p9J7b3Mj1jiZotREJwXbAqZ0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728427538;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=oi65unuKLUIrRb5PpilifhVCNF0CpOI1LIz29bZkgiQ=;
	b=vfcOuQ1s+xAbP2MEzKf7RIoj71yM6KCFhqKcnfsj8ufgEy037F8x2uqO45NspsraQ1CLYa
	rFTjz3MhpP7pZCAw==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry_32: Clear CPU buffers after register
 restore in NMI return
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172842753735.1442.14012154580012611501.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     48a2440d0f20c826b884e04377ccc1e4696c84e9
Gitweb:        https://git.kernel.org/tip/48a2440d0f20c826b884e04377ccc1e4696c84e9
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Wed, 25 Sep 2024 15:25:44 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 08 Oct 2024 15:16:28 -07:00

x86/entry_32: Clear CPU buffers after register restore in NMI return

CPU buffers are currently cleared after call to exc_nmi, but before
register state is restored. This may be okay for MDS mitigation but not for
RDFS. Because RDFS mitigation requires CPU buffers to be cleared when
registers don't have any sensitive data.

Move CLEAR_CPU_BUFFERS after RESTORE_ALL_NMI.

Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240925-fix-dosemu-vm86-v7-2-1de0daca2d42%40linux.intel.com
---
 arch/x86/entry/entry_32.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 9ad6cd8..20be575 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1145,7 +1145,6 @@ SYM_CODE_START(asm_exc_nmi)
 
 	/* Not on SYSENTER stack. */
 	call	exc_nmi
-	CLEAR_CPU_BUFFERS
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:
@@ -1166,6 +1165,7 @@ SYM_CODE_START(asm_exc_nmi)
 
 	CHECK_AND_APPLY_ESPFIX
 	RESTORE_ALL_NMI cr3_reg=%edi pop=4
+	CLEAR_CPU_BUFFERS
 	jmp	.Lirq_return
 
 #ifdef CONFIG_X86_ESPFIX32
@@ -1207,6 +1207,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 *  1 - orig_ax
 	 */
 	lss	(1+5+6)*4(%esp), %esp			# back to espfix stack
+	CLEAR_CPU_BUFFERS
 	jmp	.Lirq_return
 #endif
 SYM_CODE_END(asm_exc_nmi)

