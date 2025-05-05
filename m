Return-Path: <stable+bounces-140671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C77AAAA79
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A4F4C03B9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B602E689A;
	Mon,  5 May 2025 23:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf8OMrkp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FDF2D9DD3;
	Mon,  5 May 2025 22:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485876; cv=none; b=AJpKaKA8h7j6TaNLMktcaRxkZxRywRXw0FqmdWbmAljNszmqTrLuml7oBquSrh7n72cva1LtA4CQQXVdpwko608l9LT9HSA3BL0MQXy1JXlnc4PTPoarpgejdcpER+SiaQCBMnlnZW8mzVK9EtSEQ9ufNgUVJzDWBo7yyebGfKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485876; c=relaxed/simple;
	bh=/wRpfdb8f64LWxRrXl6sy8hWxPUIDCvYrcgp1georkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BD9yX3cXIWjBJQLN6e1I3Qrxk/5tnDKjKw/QV2JHQUUP6EkZ96vg3ptH0jucckuXi6MjwO0fi8+dfQ3Pwdki8HiB01RSxUZsdXRmUJjs6UTcmgmzUZms7ZPmN54+4vziC5XuhHAY+CrOwIPV086VybGa85hlnNuEfrnz/Y2Pnbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf8OMrkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F36C4CEE4;
	Mon,  5 May 2025 22:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485875;
	bh=/wRpfdb8f64LWxRrXl6sy8hWxPUIDCvYrcgp1georkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nf8OMrkp4742DHfzgcX2tMEY9FRfDlXscGg815s7WzVamy+FNc2553tbGnfctD7Si
	 YjuBky6RRLI7u+v1GW8M0XVr4WfaEYpT5ergjCN4T8bNxhzjigFHyNysG8lK+JrUUA
	 J8HNL8JnxHccysMSO55c/82gL1ABCSNQOOlKeLB0wrCkieYm6SmGCEDb/LlWB2ETF3
	 cNz9bsy/+rvCqIYAD3e1hs04r/2YD7jRcbT4SGj4xx1URargXICKTwKPwoXbrsxfx3
	 HU4aoWzhO/EnQwHNN0LNDmsbWWqdXJucIaqmcbxE8FR5BhTEyQR1ard5e05EKT81SN
	 DCo8LQ1cUh+mA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Subject: [PATCH AUTOSEL 6.6 040/294] x86/stackprotector/64: Only export __ref_stack_chk_guard on CONFIG_SMP
Date: Mon,  5 May 2025 18:52:20 -0400
Message-Id: <20250505225634.2688578-40-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Ingo Molnar <mingo@kernel.org>

[ Upstream commit 91d5451d97ce35cbd510277fa3b7abf9caa4e34d ]

The __ref_stack_chk_guard symbol doesn't exist on UP:

  <stdin>:4:15: error: ‘__ref_stack_chk_guard’ undeclared here (not in a function)

Fix the #ifdef around the entry.S export.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/r/20250123190747.745588-8-brgerst@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/entry/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index 78fd2442b49dc..ad292c0d971a3 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -59,7 +59,7 @@ EXPORT_SYMBOL_GPL(mds_verw_sel);
  * entirely in the C code, and use an alias emitted by the linker script
  * instead.
  */
-#ifdef CONFIG_STACKPROTECTOR
+#if defined(CONFIG_STACKPROTECTOR) && defined(CONFIG_SMP)
 EXPORT_SYMBOL(__ref_stack_chk_guard);
 #endif
 #endif
-- 
2.39.5


