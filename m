Return-Path: <stable+bounces-231601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJF0A8j5y2lENAYAu9opvQ
	(envelope-from <stable+bounces-231601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:43:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3804E36D08E
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9815305F7B7
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CAF3E316C;
	Tue, 31 Mar 2026 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z9ZRwCTn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B314536AB47;
	Tue, 31 Mar 2026 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974591; cv=none; b=gjSxrGzza2pWQb387CehFn7TTagdkYI81OlF2lZiCo5oUgYl4x/3XrfdenvuMxYfLO6Ku+x234NMzr4KYRfeA4FiRA8FkHfLdnrZjNSh2ZEIfbGEYpa2inIDEVNI0ODP2E2HMvVaOYzT0FXyuL+i6bD7VMwieC/3TQ8gaM+G8qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974591; c=relaxed/simple;
	bh=SLquIfnDsClu5AWwBr6yU+rJUejgNgUgQjJ9weGDvuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1z67lg9PW2ngG2j00Q2rYcTWzeaWIMUKaQJ8KDzKaCwyaGkAyQhOeuYl60ASvGypTQjQESMmQFoOoi+YHeDo0LbXjh+Cf0GIOTwfB6FgOc5ECz7u1Yajf56cZaAZWa6fnlx9/VukzVKqgIHZSmxKhAAUCejmM48GSL4gIyBR0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z9ZRwCTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489A4C19423;
	Tue, 31 Mar 2026 16:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974591;
	bh=SLquIfnDsClu5AWwBr6yU+rJUejgNgUgQjJ9weGDvuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z9ZRwCTndmI4sySNyZG9uTQLHOXFs3PnxZQrAUEo8ZfQa+aiLxCdzf+CygoAnhRBZ
	 h5O3Zp6/oLmEimDHvO7lTuOhFPpy07OiKwkwhk2OFK+2xHCAcNnZaxkm0RSSOi5UZI
	 BI1RDJQGld1TNa8WWSTeaWtPS0qwCvntmMUvpw+0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH 6.6 143/175] powerpc64/bpf: do not increment tailcall count when prog is NULL
Date: Tue, 31 Mar 2026 18:22:07 +0200
Message-ID: <20260331161735.037960863@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161729.779738837@linuxfoundation.org>
References: <20260331161729.779738837@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231601-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 3804E36D08E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hari Bathini <hbathini@linux.ibm.com>

commit 521bd39d9d28ce54cbfec7f9b89c94ad4fdb8350 upstream.

Do not increment tailcall count, if tailcall did not succeed due to
missing BPF program.

Fixes: ce0761419fae ("powerpc/bpf: Implement support for tail calls")
Cc: stable@vger.kernel.org
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20260303181031.390073-2-hbathini@linux.ibm.com
[ Conflict due to missing feature commit 2ed2d8f6fb38 ("powerpc64/bpf:
  Support tailcalls with subprogs") resolved accordingly. ]
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/net/bpf_jit_comp64.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -307,27 +307,32 @@ static int bpf_jit_emit_tail_call(u32 *i
 
 	/*
 	 * tail_call_cnt++;
+	 * Writeback this updated value only if tailcall succeeds.
 	 */
 	EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1), 1));
-	EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), _R1, bpf_jit_stack_tailcallcnt(ctx)));
 
 	/* prog = array->ptrs[index]; */
-	EMIT(PPC_RAW_MULI(bpf_to_ppc(TMP_REG_1), b2p_index, 8));
-	EMIT(PPC_RAW_ADD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1), b2p_bpf_array));
-	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1), offsetof(struct bpf_array, ptrs)));
+	EMIT(PPC_RAW_MULI(bpf_to_ppc(TMP_REG_2), b2p_index, 8));
+	EMIT(PPC_RAW_ADD(bpf_to_ppc(TMP_REG_2), bpf_to_ppc(TMP_REG_2), b2p_bpf_array));
+	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), bpf_to_ppc(TMP_REG_2),
+			offsetof(struct bpf_array, ptrs)));
 
 	/*
 	 * if (prog == NULL)
 	 *   goto out;
 	 */
-	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), 0));
+	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_2), 0));
 	PPC_BCC_SHORT(COND_EQ, out);
 
 	/* goto *(prog->bpf_func + prologue_size); */
-	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1), offsetof(struct bpf_prog, bpf_func)));
-	EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1),
-			FUNCTION_DESCR_SIZE + bpf_tailcall_prologue_size));
-	EMIT(PPC_RAW_MTCTR(bpf_to_ppc(TMP_REG_1)));
+	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), bpf_to_ppc(TMP_REG_2),
+			offsetof(struct bpf_prog, bpf_func)));
+	EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_2), bpf_to_ppc(TMP_REG_2),
+			  FUNCTION_DESCR_SIZE + bpf_tailcall_prologue_size));
+	EMIT(PPC_RAW_MTCTR(bpf_to_ppc(TMP_REG_2)));
+
+	/* Writeback updated tailcall count */
+	EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), _R1, bpf_jit_stack_tailcallcnt(ctx)));
 
 	/* tear down stack, restore NVRs, ... */
 	bpf_jit_emit_common_epilogue(image, ctx);



