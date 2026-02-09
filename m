Return-Path: <stable+bounces-215498-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N8KOZr2iWmuFAAAu9opvQ
	(envelope-from <stable+bounces-215498-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:00:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5798D1115ED
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C2B03013DFE
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B620C2750E6;
	Mon,  9 Feb 2026 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sQyHhsko"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795003033D2;
	Mon,  9 Feb 2026 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648994; cv=none; b=GZ4EZZuehgb2ZW/ZIGP+R2HQXQGF5A+PuvZwjfbpJB3za+nmlwMPu9BF/X4wF1fNuG3fPVBm6QkIN1/3vmn5H9ZTsoNzJKYng2stpyicfBlF/agkOPhGTksczrJ67IzngCHPrScZ6CQI7eNuBwoa3TS0PywF88xCE/WbaWPeFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648994; c=relaxed/simple;
	bh=M1OklRuXXj45WCJhUFGOJfHJDt233UfVORyw70YYTF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNlgiNrZRsJ6YW/shy9zwesAW1yT+OGdgEwhNXVIh++VEUYTcPk224bgUoHYulD0qYWcA/z60VtsFxu+Guc5n3wEl+GnLcPDU8SIwRQPf5IBVTBzSsyvFpjzWhCr1eMk7+CkpPY9CR1DoLbBMeRxvweal34bN43j5V0+AHLE/gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sQyHhsko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E48C16AAE;
	Mon,  9 Feb 2026 14:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648994;
	bh=M1OklRuXXj45WCJhUFGOJfHJDt233UfVORyw70YYTF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sQyHhsko7n78g+9c/1qYNpoy4U3gnhPhBOzVU799vxWofldLOKCRwPmftEe5CUwJp
	 0zaduExpOqRiuCJ1ZoidZ598g8pcYCvqKfUFaFHsNdYnizZ7iEIKmU65s6jrDoQiSg
	 V6No0TAhLzfJZqTUZmxJMZ2z13SvHmEeadR7dVYY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guo Ren <guoren@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 5.15 61/75] riscv: uprobes: Add missing fence.i after building the XOL buffer
Date: Mon,  9 Feb 2026 15:24:58 +0100
Message-ID: <20260209142304.041269485@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142301.830618238@linuxfoundation.org>
References: <20260209142301.830618238@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215498-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,rivosinc.com,163.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RSPAMD_EMAILBL_FAIL(0.00)[black.hawk.163.com:query timed out,palmer.rivosinc.com:query timed out,gregkh.linuxfoundation.org:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,rivosinc.com:email]
X-Rspamd-Queue-Id: 5798D1115ED
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Björn Töpel <bjorn@rivosinc.com>

commit 7d1d19a11cfbfd8bae1d89cc010b2cc397cd0c48 upstream.

The XOL (execute out-of-line) buffer is used to single-step the
replaced instruction(s) for uprobes. The RISC-V port was missing a
proper fence.i (i$ flushing) after constructing the XOL buffer, which
can result in incorrect execution of stale/broken instructions.

This was found running the BPF selftests "test_progs:
uprobe_autoattach, attach_probe" on the Spacemit K1/X60, where the
uprobes tests randomly blew up.

Reviewed-by: Guo Ren <guoren@kernel.org>
Fixes: 74784081aac8 ("riscv: Add uprobes supported")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Link: https://lore.kernel.org/r/20250419111402.1660267-2-bjorn@kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Rahul Sharma <black.hawk@163.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/kernel/probes/uprobes.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -161,6 +161,7 @@ void arch_uprobe_copy_ixol(struct page *
 	/* Initialize the slot */
 	void *kaddr = kmap_atomic(page);
 	void *dst = kaddr + (vaddr & ~PAGE_MASK);
+	unsigned long start = (unsigned long)dst;
 
 	memcpy(dst, src, len);
 
@@ -170,13 +171,6 @@ void arch_uprobe_copy_ixol(struct page *
 		*(uprobe_opcode_t *)dst = __BUG_INSN_32;
 	}
 
+	flush_icache_range(start, start + len);
 	kunmap_atomic(kaddr);
-
-	/*
-	 * We probably need flush_icache_user_page() but it needs vma.
-	 * This should work on most of architectures by default. If
-	 * architecture needs to do something different it can define
-	 * its own version of the function.
-	 */
-	flush_dcache_page(page);
 }



