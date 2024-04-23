Return-Path: <stable+bounces-41301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0267E8AFB16
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346EE1C23739
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E6514C5B3;
	Tue, 23 Apr 2024 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0u1kfAFi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D6614C5AA;
	Tue, 23 Apr 2024 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908814; cv=none; b=NGcNIdwnAyL0QQh+LeFz9cT85qiGs5b1WDbyLXHrv3CFyzod8WZWqaOGCwpeN6v7iqQN2p84MhK45K8hQLp/2z0hHmUFOHJDdAZOTB2NGvacxusMZHVxy/s5L0NDrNcsRcRIRS1zEPM3jwr6kVtMxXeHhCXfunVECTjhSEqSGBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908814; c=relaxed/simple;
	bh=tezGWYAQLcoMrZZB2FZuSWxBixrvG7PXy0TlPbRBGec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDMyxRzOpWFerXe4Y1XnS264EJ2+dxTzsIfhkteeYD3QBsqjqNvIP8BaOOHMf4zjNHgBAuGoGc75GIHhfWTxkMZpOpBPotAO3iB7rcS97FqxTvLlxzpSl1+mTEU9x/cmQ7Dn2ajgvGIMrlXpbutSmZ8nHxPwAohv3n1agKkPW00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0u1kfAFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FDCC116B1;
	Tue, 23 Apr 2024 21:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908814;
	bh=tezGWYAQLcoMrZZB2FZuSWxBixrvG7PXy0TlPbRBGec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0u1kfAFi8IbvsN5A6ZgZVbBW93LzUsCttUHFjXcCLCfUBvKXGSkBem444KP/n0+Xz
	 2lMlFHurOv2nw+Dh0kWyh6wnUcy5GokcgJpfhz2SowrUATPleiRWU3kuebSZP25xY8
	 BVlJf3b/VR/M81dCODsFlERPPZAeptZB+ja0sZ8k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sandipan Das <sandipan.das@amd.com>,
	Jim Mattson <jmattson@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.15 60/71] KVM: x86/pmu: Do not mask LVTPC when handling a PMI on AMD platforms
Date: Tue, 23 Apr 2024 14:40:13 -0700
Message-ID: <20240423213846.253049654@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213844.122920086@linuxfoundation.org>
References: <20240423213844.122920086@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sandipan Das <sandipan.das@amd.com>

commit 49ff3b4aec51e3abfc9369997cc603319b02af9a upstream.

On AMD and Hygon platforms, the local APIC does not automatically set
the mask bit of the LVTPC register when handling a PMI and there is
no need to clear it in the kernel's PMI handler.

For guests, the mask bit is currently set by kvm_apic_local_deliver()
and unless it is cleared by the guest kernel's PMI handler, PMIs stop
arriving and break use-cases like sampling with perf record.

This does not affect non-PerfMonV2 guests because PMIs are handled in
the guest kernel by x86_pmu_handle_irq() which always clears the LVTPC
mask bit irrespective of the vendor.

Before:

  $ perf record -e cycles:u true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.001 MB perf.data (1 samples) ]

After:

  $ perf record -e cycles:u true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.002 MB perf.data (19 samples) ]

Fixes: a16eb25b09c0 ("KVM: x86: Mask LVTPC when handling a PMI")
Cc: stable@vger.kernel.org
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
[sean: use is_intel_compatible instead of !is_amd_or_hygon()]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20240405235603.1173076-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/lapic.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2419,7 +2419,8 @@ int kvm_apic_local_deliver(struct kvm_la
 		trig_mode = reg & APIC_LVT_LEVEL_TRIGGER;
 
 		r = __apic_accept_irq(apic, mode, vector, 1, trig_mode, NULL);
-		if (r && lvt_type == APIC_LVTPC)
+		if (r && lvt_type == APIC_LVTPC &&
+		    guest_cpuid_is_intel_compatible(apic->vcpu))
 			kvm_lapic_set_reg(apic, APIC_LVTPC, reg | APIC_LVT_MASKED);
 		return r;
 	}



