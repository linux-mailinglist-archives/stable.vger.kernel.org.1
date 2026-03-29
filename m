Return-Path: <stable+bounces-230961-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC6pMeBSyWnrxQUAu9opvQ
	(envelope-from <stable+bounces-230961-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 18:27:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC8C352E65
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 18:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E1863060ADC
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 16:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF243803E2;
	Sun, 29 Mar 2026 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjZEap/Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/LU+rDn"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD9537F747
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801389; cv=none; b=T2HBJEuhx7SZAXNMMjlSXYHC+V5AgtS/JmTbtGmSAnnYojMwrSfhk8tAA9fIuxJ8JwFKEvF0CDGG024GZ5Ga8QBMEiPDeHJ5/EmCBHwIzCrKc9anWI/4nTLyN1cwLbvhFxu9mZG1nOnPAcah0xlW93D8uwkdJQ2OvJWLdCVzEWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801389; c=relaxed/simple;
	bh=N76Yozl72V4IJoegMuT3rhC4pUQJktWCtGKNdXGSMxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oQI/eg14cHEd6JRpNWYHSEBSsF1Q4gMk20AYusYKATFX3xonGsmHAtDueAIqbJ0D0r8K5+DPNPuM4Cj3LFW7sUp29Bh7zOg/9+/r2J9giSBlcdTT+vzgISwHncAGdcba6TxQcFays/0p5OXTT8l236gbTT/PLtFOFdwMHYTjIYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjZEap/Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P/LU+rDn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774801386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q3gvOI5QoEtskbIIavChNH8cgoYnb8U7P/1W7Nu+WAE=;
	b=fjZEap/YiF2hxgPXypOYiA5nL8sYbwqLk/tWpHrZemgdr+4tsFjZzNqmU734Sqjp6dFPLF
	yHt2z+ZHDkJH+Vee2plqU5wYlo7I/4uuEUS6M0qn/A37lAYQCOVTRXpcO40zMksD3lC89K
	KK0f6O4yo/1gGDMoHYVfoXms3N/3T4M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-ccBrM3AiNdOEt9aHoWZUsQ-1; Sun, 29 Mar 2026 12:23:04 -0400
X-MC-Unique: ccBrM3AiNdOEt9aHoWZUsQ-1
X-Mimecast-MFC-AGG-ID: ccBrM3AiNdOEt9aHoWZUsQ_1774801383
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4853466655dso21060595e9.3
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 09:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774801383; x=1775406183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q3gvOI5QoEtskbIIavChNH8cgoYnb8U7P/1W7Nu+WAE=;
        b=P/LU+rDnLPFMnx5Nc3IEsWmR/71wJXJdt3Q2dNuNnGz+r2slnWbdnDLlj/pj2zU88Z
         +SBNcjsmb9SVuVT1noIM6h4HtFwuvThqNaubAOGSLERkEnzkxxCk7PSnBpFKG0LRfcgs
         fWBVcuQW1QC5O/z515vyYoA8G/bS3lodCzE32cVv3yk3g4vg532r3ZuEC9C6eoKuYdBy
         WDj1xSmpvqmEzt9qSvUfAYXiF+oAtjjVuelQcRHVNcgmIiXIfEmT6TAV2BDXEDjTBs8d
         6BGl2TwG3Kq33IbAnpzyvD9JQa34DlvHsExACBZ4nuvNT//mkWhkDriSiQPs9i2suSwc
         FCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774801383; x=1775406183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3gvOI5QoEtskbIIavChNH8cgoYnb8U7P/1W7Nu+WAE=;
        b=kjhZQx+Ym4kXsQeYRjKMqeycvZMfcTzZ390QjacyEKZ28ZuFKj7jcciAq35SmjBbmk
         1PCty4wAeoHqa/RCn2ZllnJvO+lgA1QpMlSNmPNS0KB7KrZJOc3alOz1OCELbAF5zCIf
         ZlfFrUtg4OxtZ5AlnGTB29SUU0LMevm+mguRYRSKIy1ciWyJ2bI05C5WhJmEy9P35vJI
         SMoBGlo8NmMsqi0OM3LRQZvShukRFUa4LIN5bdzCutzbd+XOE7vQZEOHzttwqahaQf8e
         mICzPWPBFjDfkQE7VGrAYhERjoLGZjGV4617FRL2mG1tPe6hQQpj7pkuz9uxxE6Ml3id
         ArYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBsPXGFSO0F6ZiTSN3bZWjXU9I13lwIbrpAnyOs9r1cOnTwdkXe5c7KrtS/HWO2wwOW+8tY0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAlY5Gj8R2lYnqmGbcLCSLY+ro2monahwXZ5Azj2rBnopl87os
	VVAeIutLociysQ7EW4dLDcclsnRbDdV1MraY4Os7QRJE3Msijc3i9JuXX+Q2e1PdpdYxFuoi+6A
	qxEIEc8FXPILHaDzYdorfGc/xT9iU1WCeZffBGTUIB7SmLOGHc0XCbbg0pw==
X-Gm-Gg: ATEYQzym4sVDZMsuY3HRoWlwWLguYQNro5NRFcdlVnovOG9ZzkxmZYAwOdsJUPh22E+
	6GEL73Y+Sgq0yV19oRlHSAMGsjRBZiyfD/GQQRMeuRnnxyK+2hjK8Pz2SOswqNtyK+mAbVpjmTK
	1t48vzpDevZwZXunuENDUaIQlefMasuOpPyqtBdU0TyrYOiEbDeH9rdQImy+VlBkkXWh9r3zlCZ
	wFqfvMlLf2PVZ8OZeqJTV6HKU7ricIPNPbgkZsUl3K68uY4wwMiCbHsqNOrQdYM+0PTdzAXe2f1
	KQZAzUKqecuNdH6ppanSeNbrEcSvBjZj1M5HwLZw7KS6oWIW3m3Q9OkvMEK3vH+rAy+WFT1foiF
	dK02hzCTWsoGo2HUASGu1JPd+L+/CuiL6hkXrgirIAlGOgSh3rzw5tFBCu+iqBFZVl5y12T9+eo
	VjScQ+aTcGekP/e9sLhdF5PDKtDexJA/PVSzDq4y1/Ra2zKB+cWJ5sYEGi
X-Received: by 2002:a05:600c:41d1:b0:485:364e:934e with SMTP id 5b1f17b1804b1-48727eda4a4mr95959545e9.21.1774801383293;
        Sun, 29 Mar 2026 09:23:03 -0700 (PDT)
X-Received: by 2002:a05:600c:41d1:b0:485:364e:934e with SMTP id 5b1f17b1804b1-48727eda4a4mr95959255e9.21.1774801382780;
        Sun, 29 Mar 2026 09:23:02 -0700 (PDT)
Received: from [10.242.181.123] (93-44-53-42.ip95.fastwebnet.it. [93.44.53.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487270ea64esm77961935e9.5.2026.03.29.09.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:23:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: x86/mmu: Only WARN in direct MMUs when overwriting shadow-present SPTE
Date: Sun, 29 Mar 2026 18:22:57 +0200
Message-ID: <20260329162258.106549-2-pbonzini@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-230961-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 6FC8C352E65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

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
---
 arch/x86/kvm/mmu/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 98406d6aa2d6..dd06453d5b72 100644
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


