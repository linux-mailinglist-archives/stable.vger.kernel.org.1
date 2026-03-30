Return-Path: <stable+bounces-231029-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KOEBhssymmQ5wUAu9opvQ
	(envelope-from <stable+bounces-231029-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:54:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8133F356B73
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DBFE3077415
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C994214D719;
	Mon, 30 Mar 2026 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtscpV1n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDJxOLAU"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1B63A2559
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774856959; cv=none; b=edKvjANloIgqfyveiegp1w2QyQB5poFDrVCs9Ntc099XqjB+ZTvtrKzpomU/oG3Qzpdi2LQXwQwRbbW6actWE/Pid7T/1Dc+191vleOop3BeeExYpQqNMa3Q0aK1beFArFob9/J9qA449Pq67qUVV//S5/GrFZf60F0/8PU8MEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774856959; c=relaxed/simple;
	bh=PgD3o0jwMp6kDXwgJ79jkjmidrEPYUAbk5Dd5GJ6mE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cwR7cNGmp4MUgcka77RmxVTUBudSgajGLFqgEV8+OWh9bnxnTGpliKWzgZOQaQRpGPyj4v0J9FpHjIeSVhleF0JpBPdSzwvhl+DzN+5Z62bmUJE4GYDS3LQQXi38yjtr8pH6RmdR4rkUKdGaZXgONkRFsTOJq9T+sOEhQOfzw+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZtscpV1n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VDJxOLAU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774856957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JVY6xwa07Prh7BoAXHjyZRtVv7vEWGmZ2sCIyoIQnwc=;
	b=ZtscpV1nTMNtvG/BBLiyCDkNNfDVLZW9IO7BGqSmbmI28Lf3rImwio0FBVYpM0UOdAifAZ
	g7pq1jWYe8141WiYsZmAaILj2H4WhPPqr61gYwZWE2S8wM4DY4hp4GEXvqVy6R1oApOv0x
	+xnbAginK7wk1QmJV08e76L6zNpymRw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-tAtmQ6ftPnG-e2AbEGONuA-1; Mon, 30 Mar 2026 03:49:15 -0400
X-MC-Unique: tAtmQ6ftPnG-e2AbEGONuA-1
X-Mimecast-MFC-AGG-ID: tAtmQ6ftPnG-e2AbEGONuA_1774856954
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4836abfc742so35628725e9.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 00:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774856954; x=1775461754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JVY6xwa07Prh7BoAXHjyZRtVv7vEWGmZ2sCIyoIQnwc=;
        b=VDJxOLAUdFVmZFfJcUrJWCELk0XJmPkp8bKsuKEbcJyvNu8t7Owda2G6dnY1N53giN
         BSQpEdKK+o5ytG7//vGF3mM5yMYkJcF5gOuTeqTRtRNYCRee003LooiocV5xhN0/lYep
         7lPT2P1i2Wavzaa2q/Bu3z5lyOpXznOWb2XHRC5A7mP5L/yp0jlpcROkfR/TpFOlku9X
         Pgm/oL2/0jn8C4yl+3EfXmrCF1X8q0f7vU74XstaMkYWdFqFDMl3+URj5cugwGAUnAUD
         eoOJPYBoP+CCASHBvcILSRVWyUkVxknFJvi7BBhAfK0KRkho+tPn3PtiZRd0JZVWs37s
         iZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774856954; x=1775461754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVY6xwa07Prh7BoAXHjyZRtVv7vEWGmZ2sCIyoIQnwc=;
        b=YWDUnpsghUHaCizgDa714/7DKvSRwBHsvh/BwNzijiUFwzYsrGT8RNd6bbMEkC3oaf
         Q5gDZfMOOO69zhX9aWk4apMzc982MpjY81CdXA4HmU+k/ZGXtgJv194Ga49dUgpK+Ixx
         Yf+eRyHTX4ZENpAfbcimrRjtxzIC/HBFQ0alT0h598+Wb2SeyR7qgsNQEmSXI6Me4LvV
         9HPpiGKg+rmvXvPVKDK2IP9J8nKd3Q4ZiGuAQFcgFWnQejCwk92+2x0eHUueMU4w13kU
         0yFl9P66iTvrMq/WrFhm1J78pP4RDKCBPFTIJ9GzR9U0ta1XzxE41qb55uVnfhX8Qtcq
         zIiw==
X-Forwarded-Encrypted: i=1; AJvYcCVqwko/GO3eRtO2Rz+rZgJc6aWdfvSiDAyduOGytjT+mczC4ck94PPnaWls1BJA3BUS0PBB0hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4/QEAqsAHdKH5GnX99uedQoAC5N//0nmmENKmrcxzVAWadnL2
	gJ3hMae8dpquTL4e8VFdJxRXd3InbYq1TYviz96SpuhmjEG3zsR69+Pe3YZybjVKfDjhF496F/Z
	Agbx0IJbz94A0aIAAakTiCTDGA1xqCaYSGi720SLCGMpqLaH3fGrTSQLwyA==
X-Gm-Gg: ATEYQzwEX5QG68k8ANLYumiobs2g3NmUXc5YzX+HB2DVEGVIJKRc5lGSpIRF/imhxcn
	8w5jh/g1gSNJqP3BiaUian6CuW9TzRfJimgUZwtt4N6sM4wKy5tuqf+3l/QUMTce+mB8YQQwJoB
	rFlvQbJGBneuTw1XMB06iRrR+7WVSt88QbArPZQPxTfaVMD0jWABOihJ4/o2utPFwM6ISRy7+o7
	qUANvTul5MwNOSnHcmKbaNQUBdJ9FQv9O+baHtctDCd8aGl/VHl2aAGgPDZE4TeWGci2/kejIC4
	REPBwzhRKlPm2w2CEKx7U020rG9zBnahhp2z0hSKJyDnc0eaUdbYkIGEXwk8URPBHdGMPbaSNvv
	5jzavF8RCXtJgq76Mo+hvjzx6yX5zpnhCkq4vbvOaeRsZ1+PndLEv8y1QFrgP3uLpfvMDqKVI5f
	Ezw/KsfOymS0cSUsVWVH0h86ug
X-Received: by 2002:a05:600c:c493:b0:487:575:5e1 with SMTP id 5b1f17b1804b1-48727ef5571mr181061395e9.24.1774856954313;
        Mon, 30 Mar 2026 00:49:14 -0700 (PDT)
X-Received: by 2002:a05:600c:c493:b0:487:575:5e1 with SMTP id 5b1f17b1804b1-48727ef5571mr181061045e9.24.1774856953875;
        Mon, 30 Mar 2026 00:49:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d23679sm489316315e9.9.2026.03.30.00.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 00:49:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH for-6.18] KVM: x86/mmu: Only WARN in direct MMUs when overwriting shadow-present SPTE
Date: Mon, 30 Mar 2026 09:49:09 +0200
Message-ID: <20260330074909.140480-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231029-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8133F356B73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

commit df83746075778958954aa0460cca55f4b3fc9c02 upstream.

Adjust KVM's sanity check against overwriting a shadow-present SPTE with a
another SPTE with a different target PFN to only apply to direct MMUs,
i.e. only to MMUs without shadowed gPTEs.  While it's impossible for KVM
to overwrite a shadow-present SPTE in response to a guest write, writes
from outside the scope of KVM, e.g. from host userspace, aren't detected
by KVM's write tracking and so can break KVM's shadow paging rules.

  ------------[ cut here ]------------
  pfn != spte_to_pfn(*sptep)
  WARNING: arch/x86/kvm/mmu/mmu.c:3069 at mmu_set_spte+0x1e4/0x440 [kvm], CPU#0: vmx_ept_stale_r/872
  Modules linked in: kvm_intel kvm irqbypass
  CPU: 0 UID: 1000 PID: 872 Comm: vmx_ept_stale_r Not tainted 7.0.0-rc2-eafebd2d2ab0-sink-vm #319 PREEMPT
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:mmu_set_spte+0x1e4/0x440 [kvm]
  Call Trace:
   <TASK>
   ept_page_fault+0x535/0x7f0 [kvm]
   kvm_mmu_do_page_fault+0xee/0x1f0 [kvm]
   kvm_mmu_page_fault+0x8d/0x620 [kvm]
   vmx_handle_exit+0x18c/0x5a0 [kvm_intel]
   kvm_arch_vcpu_ioctl_run+0xc55/0x1c20 [kvm]
   kvm_vcpu_ioctl+0x2d5/0x980 [kvm]
   __x64_sys_ioctl+0x8a/0xd0
   do_syscall_64+0xb5/0x730
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
   </TASK>
  ---[ end trace 0000000000000000 ]---

Fixes: 11d45175111d ("KVM: x86/mmu: Warn if PFN changes on shadow-present SPTE in shadow MMU")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a8fe777ba274..dad7abb1112b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3060,7 +3060,8 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 			child = spte_to_child_sp(pte);
 			drop_parent_pte(vcpu->kvm, child, sptep);
 			flush = true;
-		} else if (WARN_ON_ONCE(pfn != spte_to_pfn(*sptep))) {
+		} else if (pfn != spte_to_pfn(*sptep)) {
+			WARN_ON_ONCE(vcpu->arch.mmu->root_role.direct);
 			drop_spte(vcpu->kvm, sptep);
 			flush = true;
 		} else
-- 
2.53.0


