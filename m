Return-Path: <stable+bounces-231036-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA7AMPgtymkA6AUAu9opvQ
	(envelope-from <stable+bounces-231036-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 10:02:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DF9356D1E
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 10:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2827030078AE
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 08:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB293AA519;
	Mon, 30 Mar 2026 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2FbehJZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKL8TGw9"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683FC37EFF5
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857712; cv=none; b=HFbgjHO+TpPygPjcecNHPaVAW83BfUL4k9JYRRC4S539iHoIa4mM/uRcPHoSr0pTvKqZlv7aHo1xE0BGvm1Gs6kRxQz3xBA/dtS4KZyPjWk3dPUeOnI4Pm5Dn41SAJHK4d/u1YxiRmac+MkvtexR433vZjIBpj79/SXBRjQ1RTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857712; c=relaxed/simple;
	bh=woHof7wfkrzWjNOrAi7nzaTttmXDmDaMclAa0u+1qkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jbqF7PTTsbxodHj1WeuzFWmVoQ17O/NpXRfAAUT6ACqpkqFCSsAl8Zf6xYdDuHt7k2YsIZzX+TwwxPb3AAvMfcKT+I7zgr23VC+MCjT18iULAEpUAfzzNMJ1254/KulkWbdWErmaT1AVhgQ+BArnbBrYiZWZsznRCzJSGt5rL9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G2FbehJZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKL8TGw9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774857710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZMEDTog/V2EbiuJTJRgUNGd1J4MxLV+lIo/zs81mrgs=;
	b=G2FbehJZjs2EqJNJ191uU4m1jZPX8E/JJGn6uutdga4yWMw0kZvjzxd5ZKXFOCjY7TaBGg
	4cA+Xdc/wjVHuYBzEwvjQNcjrtbQQZ6FGgPdZpaWrjnFCkDIcUB6LDa9WuOIk62WFi+PQl
	PcqyovUShOpy+22mQ909MX+ooyaIqks=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94--8K_2tOpM5Ku8b4pGykQYA-1; Mon, 30 Mar 2026 04:01:48 -0400
X-MC-Unique: -8K_2tOpM5Ku8b4pGykQYA-1
X-Mimecast-MFC-AGG-ID: -8K_2tOpM5Ku8b4pGykQYA_1774857707
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-485397788b3so40206495e9.2
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 01:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774857707; x=1775462507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMEDTog/V2EbiuJTJRgUNGd1J4MxLV+lIo/zs81mrgs=;
        b=cKL8TGw9JS13WZEJGUXPN2Sxu4TfZMBm+1JOZIjSMPvRd/2uYVirj3QeDh79TkD4tz
         sKfyH2b8lt6/4bBV54aTmXeNp0XIPEhx/fKl9yFK3+cTRiD63FV2Lxg1y02cmfVeNnxC
         IGqJ1g0jEXVrBYgm20sf5VDOp0TPih6u3LFOl/EX6rZoCipKLQ3h4oaIcXgCpBl8ktob
         kz4sPq2AoSfcYdaEjVeIU9mHqe1sEC55hq/qytxZ5yj1Zj3JDg19MZiFbgL0uI7+p7S+
         HGMwgvhFixbZDlqxZOGmq4ZPWh20BkxaNMojGlDFTVL2S7IsCLbbCF8wRyZfSg8SqSMv
         P0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774857707; x=1775462507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMEDTog/V2EbiuJTJRgUNGd1J4MxLV+lIo/zs81mrgs=;
        b=lOlTQ3ElW6ZmFPbrMq1ba5QBvI+7qoxwik+gCnttxChCxrbiMD6QtDESG/rgLHmC4+
         Xtlf1R0NaFLhsqru4G82eXC0PYjS1GkbBHtuQ+XZYAPrlxmHCpUPG6J5vlkGJkBiXWce
         W9aWHTe1CH/Ud6nG7fdSDBh41K/F66ZzdWx+XCf6x6erbCyTzRZ/8E9u48tqxcixUjK+
         aKN7qF7txXxbemhfv33ytiazdkh985dRgPc6S27R0+RM8ztY4EUP/xyYcDX1bQPOf8Ty
         AWBVqhk52OXaBQIrq8THRDXo8aEdulqylhJZOl3eLsY++yxOBFjC5nuMD7yT90O4+KGr
         BHdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZET++0R9ThHmqRIRjp0Mr8tt4w0BjJe3GIxHSwKqS55HDeuXW4py6gKFJDnGuYaQVQtamxSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP7b/kAFC7tOMJgbyvdUT422aUW0DFXLiXS0fZgmrJuddk+f/Y
	vir/jlD4N/wPuO6NcpAZfE3goIrsrIn6cxHc5hv0OT2Dx4zdmwtYJisoCdK8jCqUZDTjSTCMZ23
	ZR91xz0fvKE0fLTAXJpYr0eBIZSIhXO4eusvG6c6w9DCt2PrkdNlKwjHZ5A==
X-Gm-Gg: ATEYQzy4Bg+ChgNhAbBu9+X9eptwRLGU6u+ZFBjBizbNrwkE+uAflvQGrw26KLbJ6Cb
	ODWXP6U3E+eezG2OI2KUn1ZL4KBhE1soyab822kXqQ892ZFJXRbIl+xICUPr9f5xFaUu/rU3dGH
	qgDHgEaGFy7NuCFEqY5eeCzw+f0dm4R/wSTD89FVq6esTP+rkvrSlypuNf+plLTpaYhuPIg5k8g
	rf0hOz3vgJUxdsAqYgGM3ecG9HHWj5kBqTgM920IK2xEzEocP+xykcFCDpnuEy8E+HCiUehUlqx
	uKBg8Ua6KjcBrLL42i/3B7guJvnhM5FQdvJuMntZ/l63NEO4EYrv2x2XSxTCQZOYh7ikYTrrpQn
	7nxCtTuOjy5DUQtgXBcNgZ0QAbmySE8qCw+H69alC0SPJ0R+QQfYooeRiGKNCGToCzfZsz3pGM6
	KdVOpoIFgWRjFHaDuoyiBqJ2Em
X-Received: by 2002:a05:600c:529b:b0:485:3ec6:e634 with SMTP id 5b1f17b1804b1-48727d84100mr178013595e9.15.1774857706983;
        Mon, 30 Mar 2026 01:01:46 -0700 (PDT)
X-Received: by 2002:a05:600c:529b:b0:485:3ec6:e634 with SMTP id 5b1f17b1804b1-48727d84100mr178013245e9.15.1774857706436;
        Mon, 30 Mar 2026 01:01:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873069d469sm150150745e9.14.2026.03.30.01.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:01:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH for-5.15] KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE
Date: Mon, 30 Mar 2026 10:01:44 +0200
Message-ID: <20260330080144.158592-1-pbonzini@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231036-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.105.105.114:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amazon.co.uk:email]
X-Rspamd-Queue-Id: 89DF9356D1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

commit aad885e774966e97b675dfe928da164214a71605 upstream.

When installing an emulated MMIO SPTE, do so *after* dropping/zapping the
existing SPTE (if it's shadow-present).  While commit a54aa15c6bda3 was
right about it being impossible to convert a shadow-present SPTE to an
MMIO SPTE due to a _guest_ write, it failed to account for writes to guest
memory that are outside the scope of KVM.

E.g. if host userspace modifies a shadowed gPTE to switch from a memslot
to emulted MMIO and then the guest hits a relevant page fault, KVM will
install the MMIO SPTE without first zapping the shadow-present SPTE.

  ------------[ cut here ]------------
  is_shadow_present_pte(*sptep)
  WARNING: arch/x86/kvm/mmu/mmu.c:484 at mark_mmio_spte+0xb2/0xc0 [kvm], CPU#0: vmx_ept_stale_r/4292
  Modules linked in: kvm_intel kvm irqbypass
  CPU: 0 UID: 1000 PID: 4292 Comm: vmx_ept_stale_r Not tainted 7.0.0-rc2-eafebd2d2ab0-sink-vm #319 PREEMPT
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:mark_mmio_spte+0xb2/0xc0 [kvm]
  Call Trace:
   <TASK>
   mmu_set_spte+0x237/0x440 [kvm]
   ept_page_fault+0x535/0x7f0 [kvm]
   kvm_mmu_do_page_fault+0xee/0x1f0 [kvm]
   kvm_mmu_page_fault+0x8d/0x620 [kvm]
   vmx_handle_exit+0x18c/0x5a0 [kvm_intel]
   kvm_arch_vcpu_ioctl_run+0xc55/0x1c20 [kvm]
   kvm_vcpu_ioctl+0x2d5/0x980 [kvm]
   __x64_sys_ioctl+0x8a/0xd0
   do_syscall_64+0xb5/0x730
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x47fa3f
   </TASK>
  ---[ end trace 0000000000000000 ]---

Reported-by: Alexander Bulekov <bkov@amazon.com>
Debugged-by: Alexander Bulekov <bkov@amazon.com>
Suggested-by: Fred Griffoul <fgriffo@amazon.co.uk>
Fixes: a54aa15c6bda3 ("KVM: x86/mmu: Handle MMIO SPTEs directly in mmu_set_spte()")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index acb9193fc06a..3a705aebb52b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2717,11 +2717,6 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 	pgprintk("%s: spte %llx write_fault %d gfn %llx\n", __func__,
 		 *sptep, write_fault, gfn);
 
-	if (unlikely(is_noslot_pfn(pfn))) {
-		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
-		return RET_PF_EMULATE;
-	}
-
 	if (is_shadow_present_pte(*sptep)) {
 		/*
 		 * If we overwrite a PTE page pointer with a 2MB PMD, unlink
@@ -2743,6 +2738,14 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 			was_rmapped = 1;
 	}
 
+	if (unlikely(is_noslot_pfn(pfn))) {
+		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
+		if (flush)
+			kvm_flush_remote_tlbs_with_address(vcpu->kvm, gfn,
+						   	   KVM_PAGES_PER_HPAGE(level));
+		return RET_PF_EMULATE;
+	}
+
 	set_spte_ret = set_spte(vcpu, sptep, pte_access, level, gfn, pfn,
 				speculative, true, host_writable);
 	if (set_spte_ret & SET_SPTE_WRITE_PROTECTED_PT) {
-- 
2.53.0


