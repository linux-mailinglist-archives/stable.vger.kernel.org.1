Return-Path: <stable+bounces-115561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D787A34468
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056F8171A2F
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F258F19882B;
	Thu, 13 Feb 2025 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SpkURg7K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA44156237;
	Thu, 13 Feb 2025 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458478; cv=none; b=mVW379/NYhRyYYh/713pexuHcR9RA3et5wkukMDBeC20sSdGUOYGT02C9MenG4WOjQk9+LnDA8Ts6L3OuSSoReBl8oyu1q1WLRZ9tMcsGk8xN9aL/pj7Srkg+WYrbPzmXGQZy+t9Z48+CRm4Me3nG0o5GWKKP+Vb3Qyx1qQxU14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458478; c=relaxed/simple;
	bh=BpmDVBO4I+EgS+qiK1gtUhPev4+HN1e8PPkWN344LJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O43ZA6dd9HG43bBu1P+zBFDteO+MyRwbltWAMSpHxh5B7pby+vwBx86jYUQXQWev7uRcSRWnTFwxQxh4l8VhIq0jRLJz9SZko+DQjBPinEyh1ipUnyqMg1Rl1z0PWMpoy9thGL8FPL/3K8Ezs7CYpIVTMzZP/GHJ4FAqFUaHOA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SpkURg7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359F1C4CED1;
	Thu, 13 Feb 2025 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739458478;
	bh=BpmDVBO4I+EgS+qiK1gtUhPev4+HN1e8PPkWN344LJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SpkURg7KCbxcjJmDZeD59IXKJbvQEVcwm+PohZquw35o9UuIkGiSfskUeXGK6dV6W
	 41m9mb0eIee0p+k+5rFEAQ2DhRuezc9ktlaQbJWugfC5eKXxtgGKcv4AthBKb1tEDm
	 w0eK0spPXCO//q63Wmv2basFD/EiMetAJbeU3CDE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 6.12 412/422] x86/mm: Convert unreachable() to BUG()
Date: Thu, 13 Feb 2025 15:29:21 +0100
Message-ID: <20250213142452.463015248@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
References: <20250213142436.408121546@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 41a1e976623eb430f7b5a8619d3810b44e6235ad upstream.

Commit 2190966fbc14 ("x86: Convert unreachable() to BUG()") missed
one.

And after commit 06e24745985c ("objtool: Remove
annotate_{,un}reachable()") the invalid use of unreachable()
(rightfully) triggers warnings:

  vmlinux.o: warning: objtool: page_fault_oops() falls through to next function is_prefetch()

Fixes: 2190966fbc14 ("x86: Convert unreachable() to BUG()")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241216093215.GD12338@noisy.programming.kicks-ass.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/fault.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -678,7 +678,7 @@ page_fault_oops(struct pt_regs *regs, un
 			      ASM_CALL_ARG3,
 			      , [arg1] "r" (regs), [arg2] "r" (address), [arg3] "r" (&info));
 
-		unreachable();
+		BUG();
 	}
 #endif
 



