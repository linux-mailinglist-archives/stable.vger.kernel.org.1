Return-Path: <stable+bounces-224573-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAVaKxN/sGmwjwIAu9opvQ
	(envelope-from <stable+bounces-224573-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 21:29:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 664BE257DB4
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 21:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85A6531392C2
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 20:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF2F3E92BE;
	Tue, 10 Mar 2026 20:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UI9WcncQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ape8kHsL"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937543EB7E7
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 20:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174270; cv=none; b=CgbvlQew9tSHY0IhFZ3/65yLRlahNEuufBSFrcCBQDLR4bQMKVCCUVW/pRFpMC9UxAyAef0a/uQicYVO7ScS9u73cf7tksoYgjzPwwCA13bNCEzrT9d2SzFnwZXw6F4SyuH8ESL3N9Q/hKGWHHKJHybWLxeek9cj6V1Q2vUAl5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174270; c=relaxed/simple;
	bh=UVUiXt98QDeNvnqUrAq5eGxYRODlEkBstmozUC7w1fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P42jHfSfDovWCDIguXcy6B3PdWnXkipMvE+slJCVPumkPgs+exgy5fkr9ksLY6gQko/3VDIbu9zjQ6sRWS6RjbPneUdVwML2pH3vlXDtaq8+PcYZ/pwlIe0CXN8whL7gIF3H7Q7M30dUUMaOZ6QkaH5UGu2xoscGch9eOZoZKD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UI9WcncQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ape8kHsL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773174268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISzayfMc5PLVDoc63KqzP7tRn0dS/ZiGeioFlqaIWsk=;
	b=UI9WcncQ9t5m7IcPHD+U+LIDOHI2hpReu+zsQxjr5NE91k6jUUwo5subGLrzWPqP10AikT
	tlLhUqqsKEXlQ5pAE6sYLG0KVzDwqhK2qGLZXDiJMqDrl3IBiGZPlgIA4sR7EsMHWaZfLJ
	eSy0qL3X10nHXCAniUrq72Hk/s6wpak=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-qwLjTt1TNRu1bdtbH2386Q-1; Tue, 10 Mar 2026 16:24:25 -0400
X-MC-Unique: qwLjTt1TNRu1bdtbH2386Q-1
X-Mimecast-MFC-AGG-ID: qwLjTt1TNRu1bdtbH2386Q_1773174264
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4853553944fso2221965e9.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 13:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773174264; x=1773779064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISzayfMc5PLVDoc63KqzP7tRn0dS/ZiGeioFlqaIWsk=;
        b=Ape8kHsL5NrlH2lcGGrKTfiUO8seuo+9U0Qk6QPResoO66kIoJ7gBQkdigpKadRU0a
         sZjtq0hKZclWiJWZuXK3hiN3SnVmt3iNw673zuGliwbNBlrIK4bG1GsDlH4Hx/J82G4g
         w5084MCQUvchjYlWpFnLKYPZv5pUNXEc+rOhAKi3vFAumExQVJHxgDilTo7u6Nwy3AGt
         37hB65/pS2QVL2ClcFEvxnp2krFSBuc/ootfAt4usDcRUx1Q/bFTeEpdnJGCdN2uwXam
         OA68z6z0BMw7moQX/ileJVJwyJNJRdpDpSz29z8x9nnHzHsRTIoALwMS3ZCM3wqfsUr7
         H6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773174264; x=1773779064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ISzayfMc5PLVDoc63KqzP7tRn0dS/ZiGeioFlqaIWsk=;
        b=oeDwDKF9bm7B5GjVwaOOFb94fz4rvP8JurqVvJoHxC7ywZMmdIEOOy94l8v4SwpwVQ
         GrPGKL6PR29vcCESI7G1X4pD8qpG7OI9Lp+QVoe9d1ZwWSfpMvrWLI6OrXNpXHdQOEr9
         Rj+N63i3N9x1F8KEsNTZ2bHTMXYhYe3k1V9cfaccVfPdwB70CNLj3Nm8aRiPsItq54JS
         ByeC1rkKR/Cu7cnvT0MAWC4VrDkxjpJD0b1vrGCc/FribcVcg5l574L9Xhj2zYGV/4IK
         JklMbPO71wBiBhieIyLlyFMS13INVycqvusRIAkCVBPHy+GS742ZiH03dfEZoOn5RQ2K
         5p+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4jCPTXVqtJfIh7TmuJrVfQ3r2gfJiA73aau38Y/9f9sGcKcDgTBdAMyZHTFS+En5sL96sFP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV2DIUwOYPTFiDfvEXLoM15cz0nM7IOMNDqLKPam1P4MWAtlVG
	hBm5lDirUdv1STUswkSHIxpLY2/zqUQgg/Iq1im7io9Y1dOZGZXuLa204dJ9csppjWrLmX/Lzhg
	ch3qvIsrBLKMYoSm4MEM53tJqFGDtzKMtP+XbNduFV7ed/wjnIxiCRH9YGQ==
X-Gm-Gg: ATEYQzym9HW56cuZi2dOMdKToNfPOCbZQ9WgtQRkJ0c5JLn7aAfqhv6LFGBbDExqSVo
	Dhp6iqJSLiMgPFpCQSnuWeiCfU4pS1FznD+PADA1AB1gImulnUPQ+jKk1Z8NWvNxM6nFqT5hhmD
	SIgBwYGpL9fVWUt4UAW/H7TuJBDE+q0b8nc0xBDyTG7RH/Ri29nwTjZfmZElTSXpY1fKgORE47h
	+g7Y+mDE4mLnS/G27u8gj7shXJdfjvpw4fTaboovOOE1hVZlux+WclB+fKcoeixxhhTtr8gUXQR
	H8r4IGaV0N66p1brZeIV2U7GjALN8T1r/qajGkglgAni61qyvmeIOpSIZRPYcS2yPu9TkJo6p9x
	eqMaRCgztGmACoeX+7xZI8GtQI4XmNWa1AYFuZfS1RXgohzoJb60tmRl+qm3xsD4L4VP4S7WZzG
	ZgOT/EuZY1WgV6qpauUTn4STkbx38=
X-Received: by 2002:a05:600c:81c5:b0:485:3f58:da2 with SMTP id 5b1f17b1804b1-4854b291de0mr284225e9.16.1773174264285;
        Tue, 10 Mar 2026 13:24:24 -0700 (PDT)
X-Received: by 2002:a05:600c:81c5:b0:485:3f58:da2 with SMTP id 5b1f17b1804b1-4854b291de0mr283965e9.16.1773174263824;
        Tue, 10 Mar 2026 13:24:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a18bcf4sm6851425e9.0.2026.03.10.13.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:24:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	xinyang@anthropic.com,
	stable@vger.kernel.org
Subject: [PATCH 3/5] selftests: kvm: extract common functionality out of smm_test.c
Date: Tue, 10 Mar 2026 21:24:12 +0100
Message-ID: <20260310202414.406078-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310202414.406078-1-pbonzini@redhat.com>
References: <20260310202414.406078-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 664BE257DB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-224573-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/include/x86/smm.h | 17 ++++++++++++
 .../testing/selftests/kvm/lib/x86/processor.c | 26 ++++++++++++++++++
 tools/testing/selftests/kvm/x86/smm_test.c    | 27 ++-----------------
 3 files changed, 45 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86/smm.h

diff --git a/tools/testing/selftests/kvm/include/x86/smm.h b/tools/testing/selftests/kvm/include/x86/smm.h
new file mode 100644
index 000000000000..19337c34f13e
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/smm.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#ifndef SELFTEST_KVM_SMM_H
+#define SELFTEST_KVM_SMM_H
+
+#include "kvm_util.h"
+
+#define SMRAM_SIZE	65536
+#define SMRAM_MEMSLOT	((1 << 16) | 1)
+#define SMRAM_PAGES	(SMRAM_SIZE / PAGE_SIZE)
+
+void setup_smram(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
+		 uint64_t smram_gpa,
+		 const void *smi_handler, size_t handler_size);
+
+void inject_smi(struct kvm_vcpu *vcpu);
+
+#endif /* SELFTEST_KVM_SMM_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index fab18e9be66c..23a44941e283 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -8,6 +8,7 @@
 #include "kvm_util.h"
 #include "pmu.h"
 #include "processor.h"
+#include "smm.h"
 #include "svm_util.h"
 #include "sev.h"
 #include "vmx.h"
@@ -1444,3 +1445,28 @@ bool kvm_arch_has_default_irqchip(void)
 {
 	return true;
 }
+
+void setup_smram(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
+		 uint64_t smram_gpa,
+		 const void *smi_handler, size_t handler_size)
+{
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, smram_gpa,
+				    SMRAM_MEMSLOT, SMRAM_PAGES, 0);
+	TEST_ASSERT(vm_phy_pages_alloc(vm, SMRAM_PAGES, smram_gpa,
+				       SMRAM_MEMSLOT) == smram_gpa,
+		    "Could not allocate guest physical addresses for SMRAM");
+
+	memset(addr_gpa2hva(vm, smram_gpa), 0x0, SMRAM_SIZE);
+	memcpy(addr_gpa2hva(vm, smram_gpa) + 0x8000, smi_handler, handler_size);
+	vcpu_set_msr(vcpu, MSR_IA32_SMBASE, smram_gpa);
+}
+
+void inject_smi(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_events events;
+
+	vcpu_events_get(vcpu, &events);
+	events.smi.pending = 1;
+	events.flags |= KVM_VCPUEVENT_VALID_SMM;
+	vcpu_events_set(vcpu, &events);
+}
diff --git a/tools/testing/selftests/kvm/x86/smm_test.c b/tools/testing/selftests/kvm/x86/smm_test.c
index 55c88d664a94..ade8412bf94a 100644
--- a/tools/testing/selftests/kvm/x86/smm_test.c
+++ b/tools/testing/selftests/kvm/x86/smm_test.c
@@ -14,13 +14,11 @@
 #include "test_util.h"
 
 #include "kvm_util.h"
+#include "smm.h"
 
 #include "vmx.h"
 #include "svm_util.h"
 
-#define SMRAM_SIZE 65536
-#define SMRAM_MEMSLOT ((1 << 16) | 1)
-#define SMRAM_PAGES (SMRAM_SIZE / PAGE_SIZE)
 #define SMRAM_GPA 0x1000000
 #define SMRAM_STAGE 0xfe
 
@@ -113,18 +111,6 @@ static void guest_code(void *arg)
 	sync_with_host(DONE);
 }
 
-void inject_smi(struct kvm_vcpu *vcpu)
-{
-	struct kvm_vcpu_events events;
-
-	vcpu_events_get(vcpu, &events);
-
-	events.smi.pending = 1;
-	events.flags |= KVM_VCPUEVENT_VALID_SMM;
-
-	vcpu_events_set(vcpu, &events);
-}
-
 int main(int argc, char *argv[])
 {
 	vm_vaddr_t nested_gva = 0;
@@ -140,16 +126,7 @@ int main(int argc, char *argv[])
 	/* Create VM */
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, SMRAM_GPA,
-				    SMRAM_MEMSLOT, SMRAM_PAGES, 0);
-	TEST_ASSERT(vm_phy_pages_alloc(vm, SMRAM_PAGES, SMRAM_GPA, SMRAM_MEMSLOT)
-		    == SMRAM_GPA, "could not allocate guest physical addresses?");
-
-	memset(addr_gpa2hva(vm, SMRAM_GPA), 0x0, SMRAM_SIZE);
-	memcpy(addr_gpa2hva(vm, SMRAM_GPA) + 0x8000, smi_handler,
-	       sizeof(smi_handler));
-
-	vcpu_set_msr(vcpu, MSR_IA32_SMBASE, SMRAM_GPA);
+	setup_smram(vm, vcpu, SMRAM_GPA, smi_handler, sizeof(smi_handler));
 
 	if (kvm_has_cap(KVM_CAP_NESTED_STATE)) {
 		if (kvm_cpu_has(X86_FEATURE_SVM))
-- 
2.53.0


