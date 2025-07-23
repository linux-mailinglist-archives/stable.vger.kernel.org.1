Return-Path: <stable+bounces-164475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F214B0F6CE
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 17:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C17016BE73
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EEB2951D5;
	Wed, 23 Jul 2025 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEtCb5/q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873612E7636
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283668; cv=none; b=d8rJnvAeqvL9VbTjQYEzB+hXHpIojW4N+IZaHmiiu0hVjF6F0ZrxdqsZwiHUQGT7OfyTmVJTNxRrSHPIDrxNILlMghXRblNkarzIawfYbEDJih+T0voMCbYRP0DycS5Yo63MQXHGtLZyHbCU+DD4+T7FOQzkKQqeCsXvvMF5Vew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283668; c=relaxed/simple;
	bh=wPrXmrMDEcZ/dz9mOESf1placlL6h6i4+SXmAZ+0fl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DcbSfz67GAe9S0Qn7p8vqdD5PquY6Meyfh6ST58BDYdbbx5dRi6G9NW2dpbkSQ2lkgk4NsIGf314DZo02oPM7gROoz+oeC/a+pJKN9XJCwEH0rEYBiEsrffxZGXibNjYznuqUphCUOELq2gT24nw1omAxN0tyQG8tIh/ZG6XKlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEtCb5/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E793DC4CEEF;
	Wed, 23 Jul 2025 15:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753283668;
	bh=wPrXmrMDEcZ/dz9mOESf1placlL6h6i4+SXmAZ+0fl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TEtCb5/qji3V/JcJ+9VUUykbJc5W8m6R4IluDfkALHxf2NgvXNfYn5fjgCefCH/mM
	 PSdhwl7E2DE+IHehkrguk2juq9whdj9ZDgOOHKCQ/bL1dixKzcLxUv1t/i+0cCXrNL
	 hiedSXNmeBZaX1WQl9iYq1/aYr69Cur8C1GqdKBGz9ncIn4QO6IIp/ezgOES2aQvgc
	 SwonZKNyX/AiKcQa6VT+pS479qxsWNigdD+MCXGWvCw54alcV6bHzqsfkOGRbzy6Li
	 OtV0ZsafizMnfRZ9RrRdK+hLjUF8k76UK2kbrYYpDB+nXljGFF0l5ktbYReEK8Gw+d
	 QskFR3qI+tDkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Manuel Andreas <manuel.andreas@tum.de>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/5] KVM: x86/hyper-v: Skip non-canonical addresses during PV TLB flush
Date: Wed, 23 Jul 2025 11:14:16 -0400
Message-Id: <20250723151416.1092631-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250723151416.1092631-1-sashal@kernel.org>
References: <2025071240-phoney-deniable-545a@gregkh>
 <20250723151416.1092631-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Manuel Andreas <manuel.andreas@tum.de>

[ Upstream commit fa787ac07b3ceb56dd88a62d1866038498e96230 ]

In KVM guests with Hyper-V hypercalls enabled, the hypercalls
HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST and HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX
allow a guest to request invalidation of portions of a virtual TLB.
For this, the hypercall parameter includes a list of GVAs that are supposed
to be invalidated.

However, when non-canonical GVAs are passed, there is currently no
filtering in place and they are eventually passed to checked invocations of
INVVPID on Intel / INVLPGA on AMD.  While AMD's INVLPGA silently ignores
non-canonical addresses (effectively a no-op), Intel's INVVPID explicitly
signals VM-Fail and ultimately triggers the WARN_ONCE in invvpid_error():

  invvpid failed: ext=0x0 vpid=1 gva=0xaaaaaaaaaaaaa000
  WARNING: CPU: 6 PID: 326 at arch/x86/kvm/vmx/vmx.c:482
  invvpid_error+0x91/0xa0 [kvm_intel]
  Modules linked in: kvm_intel kvm 9pnet_virtio irqbypass fuse
  CPU: 6 UID: 0 PID: 326 Comm: kvm-vm Not tainted 6.15.0 #14 PREEMPT(voluntary)
  RIP: 0010:invvpid_error+0x91/0xa0 [kvm_intel]
  Call Trace:
    vmx_flush_tlb_gva+0x320/0x490 [kvm_intel]
    kvm_hv_vcpu_flush_tlb+0x24f/0x4f0 [kvm]
    kvm_arch_vcpu_ioctl_run+0x3013/0x5810 [kvm]

Hyper-V documents that invalid GVAs (those that are beyond a partition's
GVA space) are to be ignored.  While not completely clear whether this
ruling also applies to non-canonical GVAs, it is likely fine to make that
assumption, and manual testing on Azure confirms "real" Hyper-V interprets
the specification in the same way.

Skip non-canonical GVAs when processing the list of address to avoid
tripping the INVVPID failure.  Alternatively, KVM could filter out "bad"
GVAs before inserting into the FIFO, but practically speaking the only
downside of pushing validation to the final processing is that doing so
is suboptimal for the guest, and no well-behaved guest will request TLB
flushes for non-canonical addresses.

Fixes: 260970862c88 ("KVM: x86: hyper-v: Handle HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls gently")
Cc: stable@vger.kernel.org
Signed-off-by: Manuel Andreas <manuel.andreas@tum.de>
Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/c090efb3-ef82-499f-a5e0-360fc8420fb7@tum.de
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/hyperv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 44c88537448c7..79d06a8a5b7d8 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1980,6 +1980,9 @@ int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
 		if (entries[i] == KVM_HV_TLB_FLUSHALL_ENTRY)
 			goto out_flush_all;
 
+		if (is_noncanonical_invlpg_address(entries[i], vcpu))
+			continue;
+
 		/*
 		 * Lower 12 bits of 'address' encode the number of additional
 		 * pages to flush.
-- 
2.39.5


