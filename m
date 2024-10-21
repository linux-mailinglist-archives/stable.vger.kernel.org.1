Return-Path: <stable+bounces-87526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F8C9A6572
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E851C22404
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614841E6311;
	Mon, 21 Oct 2024 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OlOziXKb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176761E3784;
	Mon, 21 Oct 2024 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507867; cv=none; b=m+ZBWX8c/u4kBNnZKwE+rHl2G40YFeNg3ZXxPaqdACMKuTvSw6DW6CiVDsbLpyFu9kfC/nelkcokBYgS1GPUNsBxArJpTrokH4+6NrZ/e7OCfMSUA+y+Obfkt1RMasUkBvsKa2h+kogyiSvRAupkfuk7KwM+y+m3VHjYFTni9Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507867; c=relaxed/simple;
	bh=Bf1sJA68YpLM6brPp6TUu0/bEzoGYZr64QsjMaolO2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFTn8u9H1RGcvZC28GZCcy3dvqZq/7ds1NqSgjmdH2eiMbhwpZBYbRVCPSV6VLSr8NigfTOanCWbygi69hFa3PG+P5gn2meWQOeUCUErLQfMToFJZ+h5ceAsAvpceLroY9/IKKu+cMiSATGkIRPipS2wgSV8yFiFW3B8L+MB/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OlOziXKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B75DC4CEC3;
	Mon, 21 Oct 2024 10:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729507866;
	bh=Bf1sJA68YpLM6brPp6TUu0/bEzoGYZr64QsjMaolO2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OlOziXKbLqLrgsXUrGd/9evdW0BZXlC8V32Inon3RDGJNQpYomFpXwfzK8K+M2fPG
	 vIEtM4jRXpYFrInrpRKRZDfVM2RoSlYnlsZCzHWIudwnPMgx5ql0jjgYa0wKKWqDD4
	 t3lVRq5nJ8zgCY3R9ilullRld6XqEsLpFiWbM1dY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH 5.10 45/52] x86/entry_32: Clear CPU buffers after register restore in NMI return
Date: Mon, 21 Oct 2024 12:26:06 +0200
Message-ID: <20241021102243.390249954@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102241.624153108@linuxfoundation.org>
References: <20241021102241.624153108@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

commit 48a2440d0f20c826b884e04377ccc1e4696c84e9 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/entry/entry_32.S |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1222,7 +1222,6 @@ SYM_CODE_START(asm_exc_nmi)
 
 	/* Not on SYSENTER stack. */
 	call	exc_nmi
-	CLEAR_CPU_BUFFERS
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:
@@ -1243,6 +1242,7 @@ SYM_CODE_START(asm_exc_nmi)
 
 	CHECK_AND_APPLY_ESPFIX
 	RESTORE_ALL_NMI cr3_reg=%edi pop=4
+	CLEAR_CPU_BUFFERS
 	jmp	.Lirq_return
 
 #ifdef CONFIG_X86_ESPFIX32
@@ -1284,6 +1284,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 *  1 - orig_ax
 	 */
 	lss	(1+5+6)*4(%esp), %esp			# back to espfix stack
+	CLEAR_CPU_BUFFERS
 	jmp	.Lirq_return
 #endif
 SYM_CODE_END(asm_exc_nmi)



