Return-Path: <stable+bounces-255981-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPq2FDioGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255981-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:40:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F27E55F949E
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2297B303E11A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3514832AAA0;
	Thu, 28 May 2026 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="woumMTtO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A7223328;
	Thu, 28 May 2026 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000420; cv=none; b=Jwse9Ugee/g+qyqtyhjwZ9jgOMsBaX0DnJOARZQzp0n+HcoMW+S3dIpAM2rCVDg7mYFV8IpcNiGY8mKpV6WxDFaqdRf+zK8hX2lULsexUFOaKMBjLZJ1/305SpMjLjqb47qSKNGXy1zLEXAYfmF1mmTimlrm1sXwN9qcQ9ZBl7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000420; c=relaxed/simple;
	bh=Qn/pKnzv2NANRFvllLqfDZm5KywIpx/kO+bUOdwB0cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXu33XYIx+wTOQLVmvFlbxUDgA7ziLdRcldoBWNd3TuaL3vgTgNSU9U1yUTcd7Wkd5a3olvotXKzRgg06kMhZpA8b3wo1mYap7ac7wO3zTPOJojgQjaBJiEoAPEytZolsiAYWPZ1mewkA81sU+cltA3IqUevb8FNV606AJRtvyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=woumMTtO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFC81F000E9;
	Thu, 28 May 2026 20:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000418;
	bh=thRH03RkCNXBLuD9gVVA35VT+l2rTCU21JGuW+/y0Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=woumMTtO9NFofKBQLfXWMsBxLiqGtdhJcyHmqFRmfFi6LDVbaEze6IyF58llIP8+G
	 sPGwSxeCWHCLnA9Ih2dizBa7pUiTy8UHq8/Fs+Q0y/2wn0v+fseCo2bSn/4KRTl8dd
	 XO5Y6mLJPgZlVI2ZBvqJuakOXsNuUeeTHSSIQhGQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Pu Lehui <pulehui@huawei.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Gyokhan Kochmarla <gyokhan@amazon.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 037/272] riscv: fgraph: Select HAVE_FUNCTION_GRAPH_TRACER depends on HAVE_DYNAMIC_FTRACE_WITH_ARGS
Date: Thu, 28 May 2026 21:46:51 +0200
Message-ID: <20260528194630.423281596@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255981-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,rivosinc.com:email,amazon.de:email,huawei.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: F27E55F949E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pu Lehui <pulehui@huawei.com>

commit e8eb8e1bdae94b9e003f5909519fd311d0936890 upstream.

Currently, fgraph on riscv relies on the infrastructure of
DYNAMIC_FTRACE_WITH_ARGS. However, DYNAMIC_FTRACE_WITH_ARGS may be
turned off on riscv, which will cause the enabled fgraph to be abnormal.
Therefore, let's select HAVE_FUNCTION_GRAPH_TRACER depends on
HAVE_DYNAMIC_FTRACE_WITH_ARGS.

Fixes: a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with ftrace_regs")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503160820.dvqMpH0g-lkp@intel.com/
Signed-off-by: Pu Lehui <pulehui@huawei.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Link: https://lore.kernel.org/r/20250317031214.4138436-1-pulehui@huaweicloud.com
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Gyokhan Kochmarla <gyokhan@amazon.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 9e8667a523d55..1c75758167956 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -143,7 +143,7 @@ config RISCV
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
-	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_GRAPH_TRACER if HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_FUNCTION_GRAPH_FREGS
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
 	select HAVE_EBPF_JIT if MMU
-- 
2.53.0




