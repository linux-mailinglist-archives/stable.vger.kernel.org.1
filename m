Return-Path: <stable+bounces-215576-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGnzMm+DimmfLQAAu9opvQ
	(envelope-from <stable+bounces-215576-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 02:01:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDD4115E2E
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 02:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C9553069749
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 00:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63E9272E63;
	Tue, 10 Feb 2026 00:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u9QMHXYj"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA20C26ED3F
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 00:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684922; cv=none; b=ot6aH+JUgbP4dMaEFvKVK0gtVBtYgxhplsPjSjA8CHe8tttBFn4+NooFbTDAy4cFqHf9D1jWlqKzkCT4OPQsLiVg+YBDsMWItRCPdD1ndMIEkAKeCG7x5nnEbkxOhpOci48OmJzCiUveHBTN078zg8nHoyQFagkmpv+tMR603B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684922; c=relaxed/simple;
	bh=8qdbIjRxa9nJLV9evrdN17b0sf2bnxg2AJ97er+o+Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bydKFfLxG5sf2gEzNJlvpO71o+9O5Y9en87/b7ZoWl1l87T1LMznx1lVZgacVBcWnROb51CIIIpvd9Ii9stQJwzzfYnd7trzOthVecHb53xprDgL+tKNeh6l96QfNGCg8E2BpR7IguKE5n/f1Yhl9QuwqDe0omNks+B42j5ZwwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u9QMHXYj; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770684919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2J5PouiLGGC2lSaBelHHWIjarzEiNNlCjAXNBFFbCqM=;
	b=u9QMHXYjgL7ULBxfZcR5DWb5xZeuBRaKuH5LatfmAO9CB4tsnF+oUZokxdj3QTnv9pw6yi
	G3zph5tjf3bSQ577QAzG+eUFUnLT+1Ue+zga+eCaywn4KIFStYJFCAb2Qz6HYV78J6hmh4
	yRhU/uS1PoXsodxACXLV9FlHwZDavoI=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] KVM: nSVM: Sync int_state to cached vmcb12 after VMRUN of L2
Date: Tue, 10 Feb 2026 00:54:47 +0000
Message-ID: <20260210005449.3125133-3-yosry.ahmed@linux.dev>
In-Reply-To: <20260210005449.3125133-1-yosry.ahmed@linux.dev>
References: <20260210005449.3125133-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215576-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[yosry.ahmed@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FDD4115E2E
X-Rspamd-Action: no action

After VMRUN in guest mode, nested_sync_control_from_vmcb02() syncs
fields written by the CPU from vmcb02 to the cached vmcb12. This is
because the cached vmcb12 is used as the authoritative copy of some of
the controls, and is the payload when saving/restoring nested state.

int_state is also written by the CPU, specifically bit 0 (i.e.
SVM_INTERRUPT_SHADOW_MASK) for nested VMs, but it is not sync'd to
cached vmcb12. This does not cause a problem if KVM_SET_NESTED_STATE
preceeds KVM_SET_VCPU_EVENTS in the restore path, as an interrupt shadow
would be correctly restored to vmcb02 (KVM_SET_VCPU_EVENTS overwrites
what KVM_SET_NESTED_STATE restored in int_state).

However, if KVM_SET_VCPU_EVENTS preceeds KVM_SET_NESTED_STATE, an
interrupt shadow would be restored into vmcb01 instead of vmcb02. This
would mostly be benign for L1 (delays an interrupt), but not for L2. For
L2, the vCPU could hang (e.g. if a wakeup interrupt is delivered before
a HLT that should have been in an interrupt shadow).

Sync int_state to the cached vmcb12 in nested_sync_control_from_vmcb02()
to avoid this problem. With that, KVM_SET_NESTED_STATE restores the
correct interrupt shadow state, and if KVM_SET_VCPU_EVENTS follows it
would overwrite it with the same value.

Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE")
CC: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 70086ba6497f..ff24a5748c7d 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -523,6 +523,7 @@ void nested_sync_control_from_vmcb02(struct vcpu_svm *svm)
 	svm->nested.ctl.event_inj	= svm->vmcb->control.event_inj;
 	svm->nested.ctl.event_inj_err	= svm->vmcb->control.event_inj_err;
 	svm->nested.ctl.next_rip	= svm->vmcb->control.next_rip;
+	svm->nested.ctl.int_state	= svm->vmcb->control.int_state;
 
 	/* Only a few fields of int_ctl are written by the processor.  */
 	mask = V_IRQ_MASK | V_TPR_MASK;
-- 
2.53.0.rc2.204.g2597b5adb4-goog


