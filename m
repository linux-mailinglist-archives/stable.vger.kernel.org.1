Return-Path: <stable+bounces-231030-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B7gDsgrymmQ5wUAu9opvQ
	(envelope-from <stable+bounces-231030-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:52:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4C0356B0A
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A4203002299
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2191F3A8738;
	Mon, 30 Mar 2026 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9irUEt9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAixxqL1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7063A6EE7
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857157; cv=none; b=R6Cafwn45yoFY5AqZjtGCo9qqglZhVGR/lLhz3feBEm/cQsotl6cHw/vBEem0lOhC8HU8ufhb8G9r/nVWGOfLuedvY3FKafhCxjIXF66uqEaqhzc2i/5m2BcSrR7dYGMHtxM9q18MQfQcGsEljQp4D6vGCRJ+Fm2EJ7TOxAI2kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857157; c=relaxed/simple;
	bh=R0ypQUt8X6yI8jZha/45XYs67nBEar1Fy126hFI54mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HvH3y98m05jf9orey7YVgs39bV5GYCoqnbVjIFN/aevTmLLNfYWtSBbr78vr22mse0lFHeiqDPpb1RCf8sCYj7mWhjvuxj1NqcsFsxugdERzvLVTzLIZNC3Ofq7Y3o1wGwzti+KogqhXf3iiJrdDHmN5vSMhGH4ZXnxjzOukHgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M9irUEt9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BAixxqL1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774857155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qsY8xAjV+avJ8ATdoTJ48MQgua7vE0epI6pVU69UaJs=;
	b=M9irUEt9ec7ffydIA1w01lf1fpjtdKJVerOes/RaW+2L2yEY7aJM3qmXMfK3D/6Y0pApLn
	pLMqX964IYXX55CZK/AkBSFR3lIfCHzxeS9JpnKVxEiKH6KdqRFY+ax0REqBmqB8+JHAEU
	ThOpZiruie22L6hfm3ObFbamPqFTroA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-2QsaN_YAPlWyAyqWldlBFw-1; Mon, 30 Mar 2026 03:52:33 -0400
X-MC-Unique: 2QsaN_YAPlWyAyqWldlBFw-1
X-Mimecast-MFC-AGG-ID: 2QsaN_YAPlWyAyqWldlBFw_1774857152
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b8f9374dfso3102765f8f.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 00:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774857152; x=1775461952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qsY8xAjV+avJ8ATdoTJ48MQgua7vE0epI6pVU69UaJs=;
        b=BAixxqL1AYerB1nmQVXGP806S28a6y4tJHTJhka4XUz1CM/IcsrnhjH9aVrTzjElK2
         6H5lqi8BGONL3Dwnow9pNCvIGHbQ/Ca760A4i7EYmZW0dK+AHCr8qQcTXxka3fsbk/Qf
         TjQfZT1FS6mTm7yylJyRvlEe+YcLSbBg2Q2ozRuvmMq9pvFd27NXyGE1P447DqfLOQuX
         BLVTVcz6LRwSV1NavkvxDNCgPoAvi2ALU8guR7gOJq5ULTJdoQr3aQa7qCEz/+r5ejzP
         LAGRP7BykaVA5K1C7HRYZvkn4mfi3WoBAkzNGtPN//LMl71nyRfSzB+ZzsUWyIEO+OIV
         zOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774857152; x=1775461952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsY8xAjV+avJ8ATdoTJ48MQgua7vE0epI6pVU69UaJs=;
        b=NTbCbxrWsTiPqZMpIxLoggtPZisnWXNXY0x7OFFL973rAN+1H1V8znd/ln/6jFO8au
         NM8JZG3+QYR+pQzFPjxGVJHbAY3qvccl1W1QxZhDkecnr+u028Hitk6Py7QlF63ISR1K
         eQM1tCGPISfrxjQDMgAURmD6ShTVAqZlOtbnW1Uk3Mj3eK8cIXXfwPIdbkZMkk7MtHkH
         1eOUUMn0Xz/8B2EWg99cTM0tgoVdqNSsw/+73JZFfISAayjqdt2fS8uM5UL5Bv7ayzpq
         GzISG57CpQKiDQctnqkGHFX2aXkJsga8pN/U3+tAouAZhLXZipKagK3s1No8fFt6Aewc
         gLdA==
X-Forwarded-Encrypted: i=1; AJvYcCWrdY4h7jAh55zkjR6myOHx9owZelFWhOF1jCU2unikgvmSTfsDBLUFXjVkfgBCAhKEYEU8FBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcNnu0MK/7CskAd+GzLW5Yrv5evcwq+VukeCZgkDoJfoyCCuHO
	B0Pyhnt+eVd+p/0MzZa13ZqWT+SmO+i7tEiAkvU010k6gnGTVbSwvsajqGUv/OobYY6Xdgo0K1J
	LoorQbGNhDXER7fqok1ysawSh2LD/o9/RG4r30T4nWNTyvyps+AOJC7XGNA==
X-Gm-Gg: ATEYQzz113Bkd7kdQU8ks866ttrkpruFRfSwiiVWM251oH8RE9IC0IyBIQAjGBhCqFT
	WQZFwzicMnFr0vxH+F5mXsBM0WKgGdOkdqcMv0SuRHWgZfR5Q5H6WF9Y68iuiD/TXT2wod8lvBr
	BEUrNC3C9bedgHkSXd7r1S0/AEjfjYserqucZT2FYsIe2SJDH77Z6X8Y/Jk4nW1TqyiURo7x7zT
	1CVjNycKps5CdLPPyNUpWVhK1Lhp4GsHYpMJtcVsTHg4YdArnAlvK9VQ7JoeN6BOHrEU8vh1m6D
	s7dx3rncPKswNhsKbFM6lhn/PQuyoTtJsJQkXFtuvozMrGtnGmteahEqR8f1d+GSMBchHSKojKT
	SkxcBUaiiGFndqo+W3q8q2+55zaXvsxCovNr3eeg7XpiZwRsdfY4QH6Sdhk3CDINx7TvUiwW7QL
	T0zOsbA5ws+WJnnml9wMSVK8HA
X-Received: by 2002:a05:6000:4312:b0:43c:f67a:5b50 with SMTP id ffacd0b85a97d-43cf67a5d78mr9610877f8f.10.1774857152135;
        Mon, 30 Mar 2026 00:52:32 -0700 (PDT)
X-Received: by 2002:a05:6000:4312:b0:43c:f67a:5b50 with SMTP id ffacd0b85a97d-43cf67a5d78mr9610834f8f.10.1774857151639;
        Mon, 30 Mar 2026 00:52:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf24707f2sm17673863f8f.26.2026.03.30.00.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 00:52:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH for-6.12] KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE
Date: Mon, 30 Mar 2026 09:52:29 +0200
Message-ID: <20260330075229.143726-1-pbonzini@redhat.com>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231030-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amazon.co.uk:email]
X-Rspamd-Queue-Id: 9F4C0356B0A
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
 arch/x86/kvm/mmu/mmu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 31921b6658dd..2c11819bd216 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2919,12 +2919,6 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 	bool prefetch = !fault || fault->prefetch;
 	bool write_fault = fault && fault->write;
 
-	if (unlikely(is_noslot_pfn(pfn))) {
-		vcpu->stat.pf_mmio_spte_created++;
-		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
-		return RET_PF_EMULATE;
-	}
-
 	if (is_shadow_present_pte(*sptep)) {
 		/*
 		 * If we overwrite a PTE page pointer with a 2MB PMD, unlink
@@ -2944,6 +2938,14 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 			was_rmapped = 1;
 	}
 
+	if (unlikely(is_noslot_pfn(pfn))) {
+		vcpu->stat.pf_mmio_spte_created++;
+		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
+		if (flush)
+			kvm_flush_remote_tlbs_gfn(vcpu->kvm, gfn, level);
+		return RET_PF_EMULATE;
+	}
+
 	wrprot = make_spte(vcpu, sp, slot, pte_access, gfn, pfn, *sptep, prefetch,
 			   true, host_writable, &spte);
 
-- 
2.53.0


