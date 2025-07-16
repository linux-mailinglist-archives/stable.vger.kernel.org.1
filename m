Return-Path: <stable+bounces-163067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FE5B06E08
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 08:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EE647A4849
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 06:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D118D28643D;
	Wed, 16 Jul 2025 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="NLwMhF2I"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0531A41;
	Wed, 16 Jul 2025 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752647662; cv=none; b=louEAmUrVXdTTxZUTn35wawkzhof6fxbd2g0/bBKIUamBPSzwJX9krajgd/1wP/qsL0YPkvQ2x56MJ0ysVBtkLjmK5OHVgC6G9WGi9smTD/zbsNG0Vnqugqsk6MUX4awBfI8Evol1MTlvVGE/y6vQuHxvuC4QOx9C648fvNHGlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752647662; c=relaxed/simple;
	bh=OxOUjL36KooPOlebQ5aLFJcXtMF6ouqlVT5i/00JjOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SEmPErLxr3kMxnqzNp8/WcBBRGKG/T0PX7SuUo9O8E4q694CyauhExyLippUf7AYkJfy0Z9gAY/riCLkWgq4+6dp/DxwmPyCV4gd7ZK7bREMUyZZ3o0BVBQa2nW7rTEBTmu5vcILqbMdsD4EHNmiCjLxf+5DtLBu+Q/ACSLwSHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=NLwMhF2I; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56G6XKWX1337832
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 15 Jul 2025 23:33:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56G6XKWX1337832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752647605;
	bh=Ra8HC1Elze8Vj0sR+bXUcquC1DB89fJqqUeWCN0AoHA=;
	h=From:To:Cc:Subject:Date:From;
	b=NLwMhF2I1gpT1RcLWAs8s0GsI9gA31u7ZXg6XHdf9LPrzXc+4xOC/Ztnz5xg/98gQ
	 FVDGQi3Lpy3aknFM5O0CG5KNfQq3gV7LFM0qhAf+na98Wyd0uOCRdqKtrI+MDQd4lB
	 fBL5t2cMQca3az5hiIIU8nenp9oK9U/x2ndMhw5dzUKUeN9sssZ63Eyanj/WvWk7aj
	 IosMAcQuWhxoc10LYki8wEh1RL/RSmZH4sCykLg7pUh6Gtfu5Zc5qPvfRiauNg+DRR
	 ms2gb8pVo7SDS/4YRMt51SeO+fVEw17TybAFsyqKVMlT4C8kPMNCYIrpMc1pTvmmpI
	 oZkbo5ND9ATTw==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        jmill@asu.edu, peterz@infradead.org, andrew.cooper3@citrix.com,
        stable@vger.kernel.org
Subject: [PATCH v3 1/1] x86/fred: Remove ENDBR64 from FRED entry points
Date: Tue, 15 Jul 2025 23:33:20 -0700
Message-ID: <20250716063320.1337818-1-xin@zytor.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Link: https://lore.kernel.org/linux-hardening/Z60NwR4w%2F28Z7XUa@ubun/
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Cc: Jennifer Miller <jmill@asu.edu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: stable@vger.kernel.org # v6.9+
---

Change in v3:
*) Revise the FRED spec change description to clearly indicate that it
   deviates from previous versions and is based on new research showing
   that placing ENDBR at entry points has negative value (Andrew Cooper).

Change in v2:
*) CC stable and add a fixes tag (PeterZ).
---
 arch/x86/entry/entry_64_fred.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
index 29c5c32c16c3..907bd233c6c1 100644
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -16,7 +16,7 @@
 
 .macro FRED_ENTER
 	UNWIND_HINT_END_OF_STACK
-	ENDBR
+	ANNOTATE_NOENDBR
 	PUSH_AND_CLEAR_REGS
 	movq	%rsp, %rdi	/* %rdi -> pt_regs */
 .endm
-- 
2.50.1


