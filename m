Return-Path: <stable+bounces-248089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD1CG9RGB2r6wAIAu9opvQ
	(envelope-from <stable+bounces-248089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:16:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E74552E96
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1948C30D3F40
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA5B3B1029;
	Fri, 15 May 2026 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zFWmj+uS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409C1355049;
	Fri, 15 May 2026 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860844; cv=none; b=C3Yx+Hip6A1MlFpfHxeEZ7puMDyzc2bY0t+atyYtsU/aTBm88wjVGY84KjivsfnGHXYZgmsuWElTJHY1SXbX/vkc7nEAb3+RkMgSDnhAwG7XoHhdomiesSsnQEjH2qCTo42qszRP80zK1NmvpNVKP65i+42cj2Pb82t6psgI6pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860844; c=relaxed/simple;
	bh=ib1VID1n5lv79pdI1Yiff/FE3wSr9MOcsJ3hg3pB8L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmLQ8p+/evt90NJTf0UJaeIhVp6Lj0/3Z8F6J1A6q1pd4eAc81C07DRAeCCJHFhJ5zU4+vOSKnDhT9fvnLvTN9dox9JhiNkwzqK66vErW/WWPks5pQV11IQgr3d8hpEl3jYM38x3v2BHpKSocRCo+f5dB3P18OtZPhSQc4x9M5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zFWmj+uS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C97C2BCB0;
	Fri, 15 May 2026 16:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860843;
	bh=ib1VID1n5lv79pdI1Yiff/FE3wSr9MOcsJ3hg3pB8L8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zFWmj+uS3ezH61i0WpzLfSy8qHMCMxkAtUlxfnqYqhxmQmlvuQIJajE4DCnWjjc5a
	 vQ4ZCj0YkANR26PMuaP6mJC0Lc7YXlomjLwq53vhMnKHVbh5niKVOTE9Ms2zgKHgwl
	 BTM60N2jlY362czyTgALpX4vAR9PMTMN4+TwpAQQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.6 099/474] KVM: SVM: Explicitly mark vmcb01 dirty after modifying VMCB intercepts
Date: Fri, 15 May 2026 17:43:28 +0200
Message-ID: <20260515154717.180690598@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 12E74552E96
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248089-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linux.dev:email]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit d5bde6113aed8315a2bfe708730b721be9c2f48b upstream.

When reacting to an intercept update, explicitly mark vmcb01's intercepts
dirty, as KVM always initially operates on vmcb01, and nested_svm_vmexit()
isn't guaranteed to mark VMCB_INTERCEPTS as dirty.  I.e. if L2 is active,
KVM will modify the intercepts for L1, but might not mark them as dirty
before the next VMRUN of L1.

Fixes: 116a0a23676e ("KVM: SVM: Add clean-bit for intercetps, tsc-offset and pause filter count")
Cc: stable@vger.kernel.org
Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Link: https://patch.msgid.link/20260218230958.2877682-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/nested.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -129,11 +129,13 @@ void recalc_intercepts(struct vcpu_svm *
 	struct vmcb_ctrl_area_cached *g;
 	unsigned int i;
 
-	vmcb_mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
+	vmcb_mark_dirty(svm->vmcb01.ptr, VMCB_INTERCEPTS);
 
 	if (!is_guest_mode(&svm->vcpu))
 		return;
 
+	vmcb_mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
+
 	c = &svm->vmcb->control;
 	h = &svm->vmcb01.ptr->control;
 	g = &svm->nested.ctl;



