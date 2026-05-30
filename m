Return-Path: <stable+bounces-258581-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCGFCjYpG2rg/ggAu9opvQ
	(envelope-from <stable+bounces-258581-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:15:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1706115A1
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE2A930309AB
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5238831F98D;
	Sat, 30 May 2026 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lVydT2Hb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DAB223DC6;
	Sat, 30 May 2026 18:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164829; cv=none; b=LQ3oZKbWvhKuQPKe6Y9SFZ1qnOKBxlvD2odu9sbhVs7vtijzwNfdqzzA3vbV7MaYhC7otATLlwOpcrXyedmfCCmRDeDgCEiVdpKNAkPgTe6XMqeNQlht7v803jDVVmJ2lFdm9F2mzi7jc4fpSOhyC/3IqDDRmcqExgkk7Ijo/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164829; c=relaxed/simple;
	bh=QBsv9wtkW6bU0c0uB8ht6r8JcOVDW7U1jKP6LZrkRwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEEA04fHzg6jUIn1+iiCJBUDFLHGs2++gTl6YhWThJJ/eUjvJ84Jwm45AHZsO2R5iSC8/HWCF+GW2D+3sf7JYlvP9c0uISwbCwZmnqQu8BGbwHN0BLICy4LoXgzPJ+tQ7eeaPT+sN9ouTA3a1P++4o2KdD4ky2V62vW1ZRlQZCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lVydT2Hb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6836D1F00893;
	Sat, 30 May 2026 18:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164828;
	bh=YR4/qBRxGM7wwX8FXcpzRIh9Gukr7QD9ZUiHEw4j2lU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lVydT2Hbplqhn1v6+TPP84StSqnXDLsRI/e2CBoYX4zE8w9y6U0pRas1zD5Cp1i3/
	 bJq9Z/FtuOwMN7MDUEoZNzoaggM3rSoHXlZ5+A4gWjGAlY3LdAhVH5DHUIekxehGxA
	 FpRiYqJUmLGpdsVzULTPHEP5SkJ9QQWzyvgK1gSA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 671/776] Revert "x86/vdso: Fix output operand size of RDPID"
Date: Sat, 30 May 2026 18:06:25 +0200
Message-ID: <20260530160257.218073240@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258581-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AB1706115A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit 64f14b1ab6f39a704b62bf9b3fa28803cf2b3ebe.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/segment.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 879be4ffa06c7..8dd8e8ec9fa55 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -242,7 +242,7 @@ static inline unsigned long vdso_encode_cpunode(int cpu, unsigned long node)
 
 static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node)
 {
-	unsigned long p;
+	unsigned int p;
 
 	/*
 	 * Load CPU and node number from the GDT.  LSL is faster than RDTSCP
@@ -252,10 +252,10 @@ static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node)
 	 *
 	 * If RDPID is available, use it.
 	 */
-	alternative_io ("lsl %[seg],%k[p]",
-			"rdpid %[p]",
+	alternative_io ("lsl %[seg],%[p]",
+			".byte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/rax */
 			X86_FEATURE_RDPID,
-			[p] "=r" (p), [seg] "r" (__CPUNODE_SEG));
+			[p] "=a" (p), [seg] "r" (__CPUNODE_SEG));
 
 	if (cpu)
 		*cpu = (p & VDSO_CPUNODE_MASK);
-- 
2.53.0




