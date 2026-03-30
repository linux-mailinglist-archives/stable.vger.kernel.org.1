Return-Path: <stable+bounces-231026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OBYD+cqymmQ5wUAu9opvQ
	(envelope-from <stable+bounces-231026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:48:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FA1356A10
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDE33300AB1E
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E41639E18F;
	Mon, 30 Mar 2026 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7ihK6d6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJd9BQ0i"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9FE38550E
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774856880; cv=none; b=uygCwiZ3lcQecPsDUwqFkkSXv/t4FmMVyWyeOU8JYHlVBXSuSDpqxYu/Ds+pjqqjslSCMa9+JSDLAAspe78edga3u+cYWFe2a0tFJWKUCjDdl9qD49zHUzoYWr8gOP5WkyrOnXq7R+c/cKxIUea32COMP4v9R+SRkmVIpyubOKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774856880; c=relaxed/simple;
	bh=k1bITzSqw1ZFJDT+lcziOHSVt+l678M6zhCmLGBLavM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SKGjkwczLTQNToj0qr/LheX+kBWR/jYbZeCtunsDUixCCzCWWZinIWWQK4DeC/G24S/NRTeHN78c69xuJIBQjh99bAy1eckYI0DHnaE681hOWtQjhnIjGiteqoRZIwzWEDp3iSfPsA4aedE9SFHZ0vHySjZOfFhfCRW1ETkx8ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7ihK6d6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJd9BQ0i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774856877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ee7WfC4ao1ITQjnVMBY/T1x8jIUaoFThw0bW/nGasZE=;
	b=W7ihK6d67OdNMjgIHcIVbSsTcCXGmOd0d8SKFcgxYhcLKGXCJcJs+IM837YTdvgUo1s7pX
	a8THJ8HyRssU+Zq1fquv+blKjnHT8WwNWRNhvQ5K6TVRQS2mE1gpfeWg2wLzSpevaAeFH8
	QU9bQaRrIEUsgO60vGHzfkhREeYDkY8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-_rYUox3NNg2c31jIbZwxIw-1; Mon, 30 Mar 2026 03:47:56 -0400
X-MC-Unique: _rYUox3NNg2c31jIbZwxIw-1
X-Mimecast-MFC-AGG-ID: _rYUox3NNg2c31jIbZwxIw_1774856875
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43cff5ef652so398496f8f.2
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 00:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774856875; x=1775461675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ee7WfC4ao1ITQjnVMBY/T1x8jIUaoFThw0bW/nGasZE=;
        b=JJd9BQ0irY5hmLXlCQCUfnbK7CaKGomBzrTipGgiOprZ5zmtHhXONcUFzhCu7fadV0
         TZUvjlA41ZwD3bQxrHIW/GI/KYTzQTlZPt9tATS+vacjKkEsvukDIdkwgl70u3+RSmry
         zIxtji2CKR229It7B0nwZvK1NIuB4g1ET4ylST/FykNHJ/zO6hT2XHSk+UAAQWLmMpmi
         9b49UuRP53VtSlIBeajgYiFC6oSSCizFJvqTs06GfLhe5fXnNKJJQx+4oLxbuJFeHfow
         zmuh7YcXGQ3jLeJnkOhPW/nRGQfpdZJh0XjdpaIZmFS3FK0gzgdImH/tyr2hG+1E6z7i
         FA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774856875; x=1775461675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ee7WfC4ao1ITQjnVMBY/T1x8jIUaoFThw0bW/nGasZE=;
        b=OvdhocH0oohY9NTcEdrv43AxSTLRvvNKchIxMkKT8c5Zfq6pobf9fQRkOOdbesb8oV
         dYDWWBbg9VJ5inv9wVSMDIyk8QO8pfIymjWoswu0XHahImkInDLvd70gS/vtelx7CexX
         QtzqHOOUlVcIId6acikDYvSwmTxNTbmAoMWId4jao1kNzEVKg0CGC09zsCGp+n4NcwVY
         Qt/rtK7a6S0DWpzzSyuGKNfCRfLp65JLdg5D3uIhLGBu17ZMcHjX6LZbEVe4I1WkQPcy
         8i5zlij1HSsCZZL5YLQnzSagoGDYtyA35NiQIFiC5/iMuRsoqsxYVVCGaYblJqCvEywP
         WEZw==
X-Forwarded-Encrypted: i=1; AJvYcCXMUVo0ZCAiInvPGgMTl8DgyLHPuYiX3KmnL2XFaGMD5MIR5EoE4tbhFG9CjiXhWIbUL2jB9Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1qY0QN1g4wa/HmyAyUvIoczcBX4sAoI3nBnQs3Ul7ekNDcYjw
	4xFFs0GtgXISGp9qTLGVSEVHlMC7URer0IUf8Y6wH4rcYgFhw59pZvMFPMhNf5uiuCfcaCHJzHZ
	Aig/MBz6bz4BeNH6LeFX7ip2aihrtlD6gSkFA93AF2cEfalDnz9ZEuyduIw==
X-Gm-Gg: ATEYQzxH5Gua1e+S6h4OcWgxAeU0p28o5xYK8bcaugBGEzP9gIZ/jKHMw9PPAbLLm38
	UBuO8q3iS/ujj1tAZ/whz3CO7GhFzgIu9FoR3QogRt50HKduolU8wYzozM6O1xvza+Ak96YetWV
	KLMq3AeEldzOVQXPhepaHRYWU2ZOlgqZhaCmRJ9Q0e6A0wurlCXvN3SgFIpJPtumGfR/FZF0Zsa
	4VfyrTakBmrxHOmAKTuEzWs6izQ7clcQgIhBAYwjmWs7WGgITBvJ27ub6knINwaJNE98sI4LHWa
	8IS+eLRCSBmYP432xMs4bmKxdIgTVgqr4wWJw/Q+ck65VkiGJfrI12Lfl3RQBcaGOuDGtY1ybXK
	xjwMYUsdeue3YgjESr+h37ipAHdhuiAE6NGC9tmlQ0+6gVWViMZfvwUeeorJ/17w/rPrQAOT5+3
	+zjHJjRC9NDkkarHihtqWnrnet
X-Received: by 2002:a5d:5d84:0:b0:43b:4d2e:a004 with SMTP id ffacd0b85a97d-43b9e981468mr20214700f8f.10.1774856874775;
        Mon, 30 Mar 2026 00:47:54 -0700 (PDT)
X-Received: by 2002:a5d:5d84:0:b0:43b:4d2e:a004 with SMTP id ffacd0b85a97d-43b9e981468mr20214656f8f.10.1774856874299;
        Mon, 30 Mar 2026 00:47:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245ebafsm15438543f8f.21.2026.03.30.00.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 00:47:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH for-6.19] KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE
Date: Mon, 30 Mar 2026 09:47:51 +0200
Message-ID: <20260330074752.136232-1-pbonzini@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-231026-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amazon.co.uk:email]
X-Rspamd-Queue-Id: 93FA1356A10
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
index 02c450686b4a..01e159941434 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3044,12 +3044,6 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 	bool prefetch = !fault || fault->prefetch;
 	bool write_fault = fault && fault->write;
 
-	if (unlikely(is_noslot_pfn(pfn))) {
-		vcpu->stat.pf_mmio_spte_created++;
-		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
-		return RET_PF_EMULATE;
-	}
-
 	if (is_shadow_present_pte(*sptep)) {
 		if (prefetch && is_last_spte(*sptep, level) &&
 		    pfn == spte_to_pfn(*sptep))
@@ -3073,6 +3067,14 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
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
 			   false, host_writable, &spte);
 
-- 
2.53.0


