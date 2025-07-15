Return-Path: <stable+bounces-162993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA2AB06384
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 17:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001E95805A1
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B9424BBEE;
	Tue, 15 Jul 2025 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="m3HV9td4"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188CE247DF9;
	Tue, 15 Jul 2025 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594798; cv=none; b=OXuZxz6FOxJT8Q+N0W0+ZEs1W+KoMlT4B23yDEjeYM8tYULuhesggVd3AXaXR5ak1tJBY7AMkIC/EedIdriol29MxmrJ6pN2rg/Py8cwUB5XPTFRVQtOKc0amqRqSOYTM4jDNaECLy6YG5HMoGzDeIWmIHfX6Z51Aark4bV817w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594798; c=relaxed/simple;
	bh=wU3e9HJeH/DY7sTOVhInQNEvtGjh+kj5oo/xKVxRTfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ahzh7U75ceZQQ66QLs4h6Au+pRXurGHaotZKymEqTlpH4msHd9+xITTOgB+5bkYYqNbAkEx+HhdGLTa1i7VXkLeayir1uxZpT/u+Yof2iN9xU64iWpe7D9VTu4unbwTeDUn4WQToDXA4YsCrCApYKbUF+JT5tsPhUJ2760j0xew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=m3HV9td4; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56FFqgiW1035906
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 15 Jul 2025 08:52:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56FFqgiW1035906
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752594766;
	bh=SEcCsOO82E/DNVVnYdIJVwGaG0aOw/9Zah1U8zubMuc=;
	h=From:To:Cc:Subject:Date:From;
	b=m3HV9td4PvA3VbMqe5VpDebvtgVYxf93FH1D9Ot/x3sxdkoWp3hEONsWsvzyFsSQA
	 hcC8uV1mZDzn1A9uiciZf24GTfe46DuOQDXJnq+KyJjN4oWn7FkxhiGgAjE6Enb9ii
	 rT3vaX9kKRBR4K/9jH3yGIClQa3xydfYFV273pVh8NmsJjffCrJZ2NfE7XVSZLfgBz
	 lV5rU8H4TlpqP/CWRHSdpCAeMsSotw88JK4QeJXBqm6OZdzjgQ5YPRGC1tAnPfYd/c
	 wpqmpyVvJMShVaBgVwHPK3l9FQEdaDkuRiyad9Rz7q9cuDlf+PnhG3Dip/XWAwkydQ
	 ofB/cJQDla3qQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        jmill@asu.edu, peterz@infradead.org, andrew.cooper3@citrix.com,
        stable@vger.kernel.org
Subject: [PATCH v2 1/1] x86/fred: Remove ENDBR64 from FRED entry points
Date: Tue, 15 Jul 2025 08:52:42 -0700
Message-ID: <20250715155242.1035896-1-xin@zytor.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FRED specification v9.0 states that there is no need for FRED
event handlers to begin with ENDBR64, because in the presence of
supervisor indirect branch tracking, FRED event delivery does not
enter the WAIT_FOR_ENDBRANCH state.

As a result, remove ENDBR64 from FRED entry points.

Then add ANNOTATE_NOENDBR to indicate that FRED entry points will
never be used for indirect calls to suppress an objtool warning.

This change implies that any indirect CALL/JMP to FRED entry points
causes #CP in the presence of supervisor indirect branch tracking.

Credit goes to Jennifer Miller <jmill@asu.edu> and other contributors
from Arizona State University whose work led to this change.

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Link: https://lore.kernel.org/linux-hardening/Z60NwR4w%2F28Z7XUa@ubun/
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Cc: Jennifer Miller <jmill@asu.edu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: stable@vger.kernel.org # v6.9+
---

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


