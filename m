Return-Path: <stable+bounces-163059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B94BB06C10
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 05:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 930517A9570
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 03:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355D12798EA;
	Wed, 16 Jul 2025 03:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXwWm7pK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E319F405F7;
	Wed, 16 Jul 2025 03:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635990; cv=none; b=nC/TZ1Tdwau41gWqJl1zUsNxMcVviONMyUdM3M3sl4U1Ss/6gZQg7Ut0EXPJaH/A1PnsVMSk7xH4inT+qvDD9fTnCdWOSzKvJdxQ4QNvGtAayqmUs94oUyqJNI5PXIWtHtZwAfzdHLlnvsdw8LOKoi2vbmNyRpqelZrE/GyFMrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635990; c=relaxed/simple;
	bh=z3+q/jd0pMC0eYsWmeJoczn7uJmKr6jtay+VZgTgrq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CaNKlu2VPgjBBTV82tLRbUuqFJWFEfjCA39EfPubFogs/KucZDnSGGxqvH68B8jdfI1puxWp0s97wntaNiASiLmsPr8y4t9wevbAeThUb/icovzf4Bs+ya5glfZCKENP4KpcpuX3waHn5qDAg6+h5YkucZqwpSFIwHDBQpGjfIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXwWm7pK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5A5C4CEF0;
	Wed, 16 Jul 2025 03:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752635989;
	bh=z3+q/jd0pMC0eYsWmeJoczn7uJmKr6jtay+VZgTgrq8=;
	h=From:Date:Subject:To:Cc:From;
	b=dXwWm7pKM9QMX+g1Qpsmd5GS+EIDH6gnf9hhdhVi7D7nbPCC0cMFnTxL4GaN7xmVZ
	 JduPmgbS5ckAuLmaDftz4++yNyL53RvmxrmkRenPJkvyWw96K4VVZ4KMIPlYIFTLcg
	 4CiIDdPAYQppVc/nCC4lqN/h/IWZYe5YuHiuO6/znquNsdEVCs2loxfzVsdaSIzf2N
	 4XDZKR7FS5JQV99pWJI90GFn5spDPuPrUjnMhu5TRj7cgqeFSOScK2fWTdyGiiHUxT
	 M8a9P/QtyfzKe4+pBT/diVzmXKooDPpG5AMuogPZccLW1/lXOc8Y5jQ3WeSbXAV/CR
	 Ygr9nPg0hItFg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 15 Jul 2025 20:19:44 -0700
Subject: [PATCH] tracing/probes: Avoid using params uninitialized in
 parse_btf_arg()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-trace_probe-fix-const-uninit-warning-v1-1-98960f91dd04@kernel.org>
X-B4-Tracking: v=1; b=H4sIAE8ad2gC/x2NywqDQAxFf0WybmBURNpfKVLGmNpsMpIZHyD+u
 6G7c+Bw7wmZTTjDqzrBeJMsSV3qRwX0izozyuQOTWi60NcdFovEn8XSyPiVAylpLriqqBTcozn
 M2E/URiLiZ2jBpxZjb/837+G6bp4jlY12AAAA
X-Change-ID: 20250715-trace_probe-fix-const-uninit-warning-7dc3accce903
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1557; i=nathan@kernel.org;
 h=from:subject:message-id; bh=z3+q/jd0pMC0eYsWmeJoczn7uJmKr6jtay+VZgTgrq8=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBnlUsFTm838lK8sa2Q+YfPZnT3/XGJN1WNO4dPHC16wG
 /2f7vKho5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAEzk8zWG/+U+2to1RzocipU3
 JJXbB73PPhTiWLYw9sUktbpNFzhOSDH8j/7x/Ef4Sj3375ti5FVmsH3896PO7MfqR++qb2b84VF
 8xggA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After a recent change in clang to strengthen uninitialized warnings [1],
it points out that in one of the error paths in parse_btf_arg(), params
is used uninitialized:

  kernel/trace/trace_probe.c:660:19: warning: variable 'params' is uninitialized when used here [-Wuninitialized]
    660 |                         return PTR_ERR(params);
        |                                        ^~~~~~

Match many other NO_BTF_ENTRY error cases and return -ENOENT, clearing
up the warning.

Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/2110
Fixes: d157d7694460 ("tracing/probes: Support BTF field access from $retval")
Link: https://github.com/llvm/llvm-project/commit/2464313eef01c5b1edf0eccf57a32cdee01472c7 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 kernel/trace/trace_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 424751cdf31f..40830a3ecd96 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -657,7 +657,7 @@ static int parse_btf_arg(char *varname,
 		ret = query_btf_context(ctx);
 		if (ret < 0 || ctx->nr_params == 0) {
 			trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);
-			return PTR_ERR(params);
+			return -ENOENT;
 		}
 	}
 	params = ctx->params;

---
base-commit: 6921d1e07cb5eddec830801087b419194fde0803
change-id: 20250715-trace_probe-fix-const-uninit-warning-7dc3accce903

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


