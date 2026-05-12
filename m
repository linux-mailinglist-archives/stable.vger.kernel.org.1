Return-Path: <stable+bounces-246023-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFppBx5rA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246023-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:02:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17142526904
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6941230975A2
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7C33E5A2B;
	Tue, 12 May 2026 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vboIhCb6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAA53E5A28;
	Tue, 12 May 2026 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608160; cv=none; b=MitG2kQVJXfuBNX1SMy/EvW50c594rd/Am91DcVh01qS9kv/j42LG17SAEJdNDlh8521puYNu/WQFgCW9kcDENfv+loFfFAS2qxCCJwSO/tfSie/2yPZdc5YbB90lLsiiHJLhrNCN7NLGIaKtekIs/ikUQheGaH2rLO7pEoDnNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608160; c=relaxed/simple;
	bh=T+hutaSDD8PYRhfrq3CdM6/7ni4qytKP3vpYug8ztsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+weYSMeqtMP5D4U014qi84xuoMuzPzqPR2FDltG9XCAvUHrrMgVhZY8zJZS6gL6S1QnVlkK2Z/RkZd2o3NBuOf1L47klqCLBGPU4ZjN4t2LYHxNTN8zeQs1kzTcNnyGY7by7rlglHLWZSVP/cGpYgNsVp7Ym+GowVSrdNKrVk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vboIhCb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF6DC2BCB0;
	Tue, 12 May 2026 17:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608160;
	bh=T+hutaSDD8PYRhfrq3CdM6/7ni4qytKP3vpYug8ztsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vboIhCb6lIOr2bdKtzj/doF/O263ZTVvef24V2MedoxGufOUf0ZGFDM5Ed274hE9g
	 YLoyzZUUkxZRG0Hb39TpX1W26W7/6axHy9I4NGCzHB8/vC51oFQZQXYb6Q/7kfjPxr
	 zt4MssJCv3YJKkSPi2e+6gj6hfrlw9F4k7+14ZEM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 6.12 178/206] bpf: Fix use-after-free in arena_vm_close on fork
Date: Tue, 12 May 2026 19:40:30 +0200
Message-ID: <20260512173936.630017533@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 17142526904
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,asu.edu,etsalapatis.com,kernel.org];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-246023-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[linuxfoundation.org:s=korg];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.497];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,etsalapatis.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexei Starovoitov <ast@kernel.org>

commit 4fddde2a732de60bb97e3307d4eb69ac5f1d2b74 upstream.

arena_vm_open() only bumps vml->mmap_count but never registers the
child VMA in arena->vma_list. The vml->vma always points at the
parent VMA, so after parent munmap the pointer dangles. If the child
then calls bpf_arena_free_pages(), zap_pages() reads the stale
vml->vma triggering use-after-free.

Fix this by preventing the arena VMA from being inherited across
fork with VM_DONTCOPY, and preventing VMA splits via the may_split
callback.

Also reject mremap with a .mremap callback returning -EINVAL. A
same-size mremap(MREMAP_FIXED) on the full arena VMA reaches
copy_vma() through the following path:

  check_prep_vma()       - returns 0 early: new_len == old_len
                           skips VM_DONTEXPAND check
  prep_move_vma()        - vm_start == old_addr and
                           vm_end == old_addr + old_len
                           so may_split is never called
  move_vma()
    copy_vma_and_data()
      copy_vma()
        vm_area_dup()    - copies vm_private_data (vml pointer)
        vm_ops->open()   - bumps vml->mmap_count
      vm_ops->mremap()   - returns -EINVAL, rollback unmaps new VMA

The refcount ensures the rollback's arena_vm_close does not free
the vml shared with the original VMA.

Reported-by: Weiming Shi <bestswngs@gmail.com>
Reported-by: Xiang Mei <xmei5@asu.edu>
Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Link: https://lore.kernel.org/r/20260413194245.21449-1-alexei.starovoitov@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/arena.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -236,6 +236,16 @@ static void arena_vm_open(struct vm_area
 	refcount_inc(&vml->mmap_count);
 }
 
+static int arena_vm_may_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	return -EINVAL;
+}
+
+static int arena_vm_mremap(struct vm_area_struct *vma)
+{
+	return -EINVAL;
+}
+
 static void arena_vm_close(struct vm_area_struct *vma)
 {
 	struct bpf_map *map = vma->vm_file->private_data;
@@ -299,6 +309,8 @@ out:
 
 static const struct vm_operations_struct arena_vm_ops = {
 	.open		= arena_vm_open,
+	.may_split	= arena_vm_may_split,
+	.mremap		= arena_vm_mremap,
 	.close		= arena_vm_close,
 	.fault          = arena_vm_fault,
 };
@@ -368,10 +380,11 @@ static int arena_map_mmap(struct bpf_map
 	arena->user_vm_end = vma->vm_end;
 	/*
 	 * bpf_map_mmap() checks that it's being mmaped as VM_SHARED and
-	 * clears VM_MAYEXEC. Set VM_DONTEXPAND as well to avoid
-	 * potential change of user_vm_start.
+	 * clears VM_MAYEXEC. Set VM_DONTEXPAND to avoid potential change
+	 * of user_vm_start. Set VM_DONTCOPY to prevent arena VMA from
+	 * being copied into the child process on fork.
 	 */
-	vm_flags_set(vma, VM_DONTEXPAND);
+	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY);
 	vma->vm_ops = &arena_vm_ops;
 	return 0;
 }



