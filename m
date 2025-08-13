Return-Path: <stable+bounces-169467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6490B25699
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 00:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733103B4D8C
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 22:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B1530275D;
	Wed, 13 Aug 2025 22:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3zLf7FNh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rxun207m"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E71302757;
	Wed, 13 Aug 2025 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755123965; cv=none; b=SH52luYu3Ty4jBDwL7174GnmegXqa1Hnqve4D8FONq3AcQGUwWepKpOu8OIm99p+I+ZuFRtn14G6LXo1rL+nVB8ZynjcC72FtXR0pN7uQ7RJFNA4OJohXXjCG3lHuCvGH+TzGjuvmR/tICgBO1AcHUKXtVsI9WcpNjtru72WVcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755123965; c=relaxed/simple;
	bh=BrPCcmjKhf8d9y1X9Ox1/DAv0yGeZsWKFoYHl6kSsuw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=J2Nnqv5BsyR32PTg/kEXp/vsMLvCJo9TKDE/dWBD2m/t58TH5JDpAYOaPIjQWCQi1oQMDIXNUfnFip8fB2gju9IZTk2KR3C2KZbzG5MlE444BR1BBlhcLOgYBOukHwwmatoydf0+LG2rzUw3Cfu2SgEhW2bK3gE9KwCxTZ2RF5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3zLf7FNh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rxun207m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Aug 2025 22:25:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755123960;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=OJK/j3+YiOOOgIkVonGCrljvtxPXA8dKqJzzDQRtHiU=;
	b=3zLf7FNhduzER9V0PDn8NMfGeD2+MplYmfqqjwzhpECPthKQ12XuJZrxLP53h6y13HCjdw
	zMkcm/BcRf/oUzg5zJ87vOdIH2MklAannfYZqNcqT61Mie0WlZ3W1SG7Z//qGV1boJgf6a
	41G5/TpT7UQ/ynGcXvnmKnfQDaohXH6lLxvo3Xl7kY/aN0+HIa0kIBAY0+sKMmGvw+AFg/
	c6/l9ZRGsuZdkmfO6rff03YHlTbPaxNp3KJlqcVpIkFA0Hz1I2e+hkqILByerM+eKUR1Ub
	4x40vtSD+j3y8rpwzOAuWQnizLtPRpGR97jr8jZbqHSx2ua5CfcDD2yJ8gdIag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755123960;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=OJK/j3+YiOOOgIkVonGCrljvtxPXA8dKqJzzDQRtHiU=;
	b=rxun207m8i1OYP55ihJfxcDdV1uAxVeO9eVAr4Uov8L982ICecaOiRZ5Na4HjEPEgQe090
	rlCCvkwVkSCAilBg==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/fred: Remove ENDBR64 from FRED entry points
Cc: "Xin Li (Intel)" <xin@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin (Intel)" <hpa@zytor.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175512395928.1420.9293489818194067558.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     3da01ffe1aeaa0d427ab5235ba735226670a80d9
Gitweb:        https://git.kernel.org/tip/3da01ffe1aeaa0d427ab5235ba735226670=
a80d9
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Tue, 15 Jul 2025 23:33:20 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 13 Aug 2025 15:05:32 -07:00

x86/fred: Remove ENDBR64 from FRED entry points

The FRED specification has been changed in v9.0 to state that there
is no need for FRED event handlers to begin with ENDBR64, because
in the presence of supervisor indirect branch tracking, FRED event
delivery does not enter the WAIT_FOR_ENDBRANCH state.

As a result, remove ENDBR64 from FRED entry points.

Then add ANNOTATE_NOENDBR to indicate that FRED entry points will
never be used for indirect calls to suppress an objtool warning.

This change implies that any indirect CALL/JMP to FRED entry points
causes #CP in the presence of supervisor indirect branch tracking.

Credit goes to Jennifer Miller <jmill@asu.edu> and other contributors
from Arizona State University whose research shows that placing ENDBR
at entry points has negative value thus led to this change.

Note: This is obviously an incompatible change to the FRED
architecture.  But, it's OK because there no FRED systems out in the
wild today. All production hardware and late pre-production hardware
will follow the FRED v9 spec and be compatible with this approach.

[ dhansen: add note to changelog about incompatibility ]

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
Link: https://lore.kernel.org/linux-hardening/Z60NwR4w%2F28Z7XUa@ubun/
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250716063320.1337818-1-xin%40zytor.com
---
 arch/x86/entry/entry_64_fred.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
index 29c5c32..907bd23 100644
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -16,7 +16,7 @@
=20
 .macro FRED_ENTER
 	UNWIND_HINT_END_OF_STACK
-	ENDBR
+	ANNOTATE_NOENDBR
 	PUSH_AND_CLEAR_REGS
 	movq	%rsp, %rdi	/* %rdi -> pt_regs */
 .endm

