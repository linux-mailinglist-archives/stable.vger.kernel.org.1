Return-Path: <stable+bounces-153408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E889ADD4C2
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9FC1946AD2
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCFA2ED865;
	Tue, 17 Jun 2025 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Po5vNCL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDB72ECEA4;
	Tue, 17 Jun 2025 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175863; cv=none; b=iadhSX9+Tgd/Z4ZwpuMbvhDFXH04kQTka0ucn8Aewc/rMa2rKppZnvH3Y6k7hcCgMzpiWV6ZnbV7KkUc0T6QFUM1nDqP0JdvTF6gcrDRoogoMwZcRrKZpiv7+jYgc4CaAfb767zN6ytLJhB1dTte+NKcgd5JMe3oHH7NGXGGmrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175863; c=relaxed/simple;
	bh=5J//UH2IgV3dh2L5tou6k0ocE7tIHz4nS/ef1UhxV+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXa7eSE/+xIz9JC6YqoESglM7kJd2jqdZBw6pPR8K4B8e08c30gpZQgXtj8TkTwhyx+Y+wWAHtu/7NYyDDpV2n40H7T7kw4QLRGb+G9Scq3JsUuOfnMYLmtjEWoAdYEkdszy5TqZyFCSeWu+UQ7y4ukI9zdjtlgeAs0ExZTS67w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Po5vNCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99766C4CEE3;
	Tue, 17 Jun 2025 15:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175863;
	bh=5J//UH2IgV3dh2L5tou6k0ocE7tIHz4nS/ef1UhxV+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2Po5vNCLKOSenJJJ7Gnf3kNd1aDu9f2dc/PnGdeumPEGvkDV0qXj8ShBrb0gU1dDc
	 GxHiLpPOIV7JGSeOQCbLEGSohnaX6fWwG+DL7niz1Khs9oSdemUSzSvzw2ApK36Vjo
	 oz1NGoq0Kkt2nkb+D1+cWFmoWh2O98/fRf64QYTg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 170/512] s390/bpf: Store backchain even for leaf progs
Date: Tue, 17 Jun 2025 17:22:16 +0200
Message-ID: <20250617152426.509234236@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

[ Upstream commit 5f55f2168432298f5a55294831ab6a76a10cb3c3 ]

Currently a crash in a leaf prog (caused by a bug) produces the
following call trace:

     [<000003ff600ebf00>] bpf_prog_6df0139e1fbf2789_fentry+0x20/0x78
     [<0000000000000000>] 0x0

This is because leaf progs do not store backchain. Fix by making all
progs do it. This is what GCC and Clang-generated code does as well.
Now the call trace looks like this:

     [<000003ff600eb0f2>] bpf_prog_6df0139e1fbf2789_fentry+0x2a/0x80
     [<000003ff600ed096>] bpf_trampoline_201863462940+0x96/0xf4
     [<000003ff600e3a40>] bpf_prog_05f379658fdd72f2_classifier_0+0x58/0xc0
     [<000003ffe0aef070>] bpf_test_run+0x210/0x390
     [<000003ffe0af0dc2>] bpf_prog_test_run_skb+0x25a/0x668
     [<000003ffe038a90e>] __sys_bpf+0xa46/0xdb0
     [<000003ffe038ad0c>] __s390x_sys_bpf+0x44/0x50
     [<000003ffe0defea8>] __do_syscall+0x150/0x280
     [<000003ffe0e01d5c>] system_call+0x74/0x98

Fixes: 054623105728 ("s390/bpf: Add s390x eBPF JIT compiler backend")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Link: https://lore.kernel.org/r/20250512122717.54878-1-iii@linux.ibm.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/net/bpf_jit_comp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 9d440a0b729eb..64bb8b71013ae 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -605,17 +605,15 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
 	}
 	/* Setup stack and backchain */
 	if (is_first_pass(jit) || (jit->seen & SEEN_STACK)) {
-		if (is_first_pass(jit) || (jit->seen & SEEN_FUNC))
-			/* lgr %w1,%r15 (backchain) */
-			EMIT4(0xb9040000, REG_W1, REG_15);
+		/* lgr %w1,%r15 (backchain) */
+		EMIT4(0xb9040000, REG_W1, REG_15);
 		/* la %bfp,STK_160_UNUSED(%r15) (BPF frame pointer) */
 		EMIT4_DISP(0x41000000, BPF_REG_FP, REG_15, STK_160_UNUSED);
 		/* aghi %r15,-STK_OFF */
 		EMIT4_IMM(0xa70b0000, REG_15, -(STK_OFF + stack_depth));
-		if (is_first_pass(jit) || (jit->seen & SEEN_FUNC))
-			/* stg %w1,152(%r15) (backchain) */
-			EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W1, REG_0,
-				      REG_15, 152);
+		/* stg %w1,152(%r15) (backchain) */
+		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W1, REG_0,
+			      REG_15, 152);
 	}
 }
 
-- 
2.39.5




