Return-Path: <stable+bounces-254566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LqsCe3eFmphugcAu9opvQ
	(envelope-from <stable+bounces-254566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:09:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D105E3DBD
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90F653033D6D
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F494014B2;
	Wed, 27 May 2026 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffRiJDq9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD902F7F12;
	Wed, 27 May 2026 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883573; cv=none; b=n7b4Y9bEYm0Huvl7lDuQ7PbWHeplGyOHwSeRGca9REfUcI9DyeKmkSWRczpVjv2ZEIWcMz/7mmonD2Myu+IMY2xAswnHiPBH26Cge0TnhcPgtEWbaIcXwPpYkrrr8QC16b7d2IxGT8PV6RqfFiX/AlT1iNzVsF3nqb0dugaaDAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883573; c=relaxed/simple;
	bh=aF0h8kQ9uMPETYt1a8ckP41P49YvE8igulEOCImHDsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9vnzTFPrsp/fIz7ZHbSv0yCxfZ9eO/lJjJX+KjnqVeJv1FUmZElpYQeL7MUxSYFUdIPLnf8CtLKlJkMgjDNYJRQuXD2pBrBYZ4ehJUr36uMBufc/ep18xaHv9niHMVtZLxMmdI0XCGN08zNo2JR6GvFdG4KRVYU+Op/B36/QUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffRiJDq9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9911F00A3D;
	Wed, 27 May 2026 12:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779883572;
	bh=vBlUsD0hHthgF360A8DY/Gk0Y0irC42OCpMGO8T7fdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ffRiJDq9USTau7HZ9R44yi6HQVLXKBoFzxkogQnZDXP11cFkbe95QlxAApZXrfD7y
	 O/Y+G/qjRSh49sl1CwnU1Q+VnoV+DSmAYkBN6OgCyMRP1vrdQqhyLIcY3haPcMCHFD
	 u2fWN/qBIMs8dKLxCvATgEtSeOZCkqfGhs6gQZbu9c0uIZ/q8VG0XKyj7N9WtERxwM
	 uFzuixwGiRfzRSs0+rpjvNXC58Yg7LeySctP74WzzI1jG1IxWPU2aKVd/fDFFuiDUw
	 P50FsjahUGlmVmifdXZQN4lBscDD3nvifreHxT1s0tapOK+ROPcPvBUBCYuL3bVrbV
	 Ggxv4C4Kro25w==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id EABFCF40085;
	Wed, 27 May 2026 08:06:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 27 May 2026 08:06:10 -0400
X-ME-Sender: <xms:Mt4WaopDBNbE0BZ8mMWc_T9SkBWGzOC5fLAZiz8NxoAzvzl4eGDz7A>
    <xme:Mt4WapXDY8LBtF_Mu4yDTNAlawJVgQct5d_Z952l5CODxF8FDwCvc3q1hEgLVQWzr
    F-taWZ54sGC-ftkvWs-0frML3DK_QwSnnuvFPr5AWamqqRQxGTHV3I>
X-ME-Received: <xmr:Mt4Wal7uD5fRCI8TCLH6QJoKTfw-YdWc0CpxJDSJlNq3WxEREjjNcuivYXL1sA>
X-ME-Proxy-Cause: dmFkZTGqAdtnwb61wYan5C4OJsoWLkQNYl2+q5bhbZ8696FiUgmZzm685bBBUbynyEgwk9
    LCDvc8MDP6PRosY/0LosT3Qdb0dk7uwQzgHaQellK3fcQWXXqX07suu6SzIMUDibK4jWkW
    iOAnXeDPHCbZrTopbRqvNqcS8TJoPKroKLjoTh0vQcgBEa67F2kTYv2fZUhOC9BS3QxCde
    qrmrfeOswU9Av2XVPIeZlRLWQ/r8fxk5RD4wN5ziq7iwXH+fBtu+wn+B2xVy9yCrzPuhAm
    W46wVvBf0oF9Jh2+ecSuLnfJtZOU6eoHRXFan8ENohXk0lRn/Dg/NXlu0lNK26nvI9MPnx
    8gWQGEu+TZWo/OqSOyKq745PLDp4WCL9eoQ9MQFXxiXM9Jwk+Lqg+YnTB5jBafYvdYPVwF
    MmcYwBysIbqLmXUhUm/gKifsk3D6WXOaTpug9HwGXLTEzdMPjlbnCEPMl9b/lNcYgxW71w
    njgasKrJlhA2+kgPMjZCJ7xB7qja+uORE6dsQqiR5hoO2j5uaDzxrb1AylfB7WCiL/3TF+
    +IGUtgTG561UuC0I6LVD22DefHkJiA9zIV/5pFThYNsyBuE+LxMYutYOxTIjsEL/itGYOz
    cfIJJkWroTCRv33XJv4e0vCFvcc6vUIicjrWTuckm03ED9OYVjIc0z2LgVbA
X-ME-Proxy: <xmx:Mt4WanCUjp5ZDFoJH0foOjV9iCu7QXtXgDiku0-fMrRUPiisNAWyuw>
    <xmx:Mt4WapeSltybY3Xl1mjHLm6VfJHpIKlWXY2hTgPdKHZ4xjYjU_q8Kg>
    <xmx:Mt4Waouw5Qt9nSk0FbWfvjyBDkqK4U6dYz1YCvHuF518rmxPbeX3EQ>
    <xmx:Mt4WagLmMtrSTUGKdnrBFFX6J-sQi9w7ZeEwaO75mNw8nSoqDsVfUw>
    <xmx:Mt4WaqZt6XRc1GZgTaOxGif9RXTzVghvEmlJAGbusZpsl3LKpYDxdsDp>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 08:06:09 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H . Peter Anvin" <hpa@zytor.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	stable@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v3 2/2] x86/tdx: Fix zero-extension for 32-bit port I/O
Date: Wed, 27 May 2026 13:05:44 +0100
Message-ID: <20260527120544.2903923-3-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527120544.2903923-1-kas@kernel.org>
References: <20260527120544.2903923-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[zytor.com,intel.com,linux.intel.com,google.com,gmail.com,vger.kernel.org,lists.linux.dev,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254566-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 24D105E3DBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

According to x86 architecture rules, 32-bit operations zero-extend the
result to 64 bits. The current implementation of handle_in() only masks
the lower 32 bits, which preserves the upper 32 bits of RAX when a
32-bit port IN instruction is emulated.

Update handle_in() to zero out the entire RAX register when the I/O size
is 4 bytes to ensure correct zero-extension. For smaller sizes (1 or 2
bytes), continue to preserve the unaffected upper bits.

Fixes: 03149948832a ("x86/tdx: Port I/O: Add runtime hypercalls")
Reported-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=bxowfZwxrATCBRg@mail.gmail.com/
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/coco/tdx/tdx.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 65119362f9a2..58feca419326 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -703,8 +703,25 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 	 */
 	success = !__tdx_hypercall(&args);
 
-	/* Update part of the register affected by the emulated instruction */
-	regs->ax &= ~mask;
+	/*
+	 * IN writes the result into a sub-register of RAX. Only the
+	 * 32-bit form zero-extends; the smaller forms leave the upper
+	 * bits untouched:
+	 *
+	 *   insn  dest  size  bits written     bits preserved
+	 *   inb   AL    1     RAX[ 7: 0]       RAX[63: 8]
+	 *   inw   AX    2     RAX[15: 0]       RAX[63:16]
+	 *   inl   EAX   4     RAX[63: 0]       (none, zero-extended)
+	 *
+	 * 'mask' only covers the low 'size' bytes, which is exactly the
+	 * range affected for size 1 and 2. For size 4 the write also
+	 * clears RAX[63:32], so widen the clear-mask.
+	 */
+	if (size == 4)
+		regs->ax = 0;
+	else
+		regs->ax &= ~mask;
+
 	if (success)
 		regs->ax |= args.r11 & mask;
 
-- 
2.54.0


