Return-Path: <stable+bounces-231027-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8K46IR4rymmQ5wUAu9opvQ
	(envelope-from <stable+bounces-231027-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:49:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3454356A4B
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CD4E3044B87
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C403A7F4E;
	Mon, 30 Mar 2026 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/R9MFF0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lWhdLLEt"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248543A8738
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774856883; cv=none; b=q/wi9vM5KEGjTpeY6tsvgPQfi6elwtQEzCuCmekMJOws+tlTTomLibAEUSOdYLKd9g+2b5c7hhXZFaj6OcCX7Gb+GuvzDb9rnaD85M4bXdLvBV8wiFPv+BdinXmRhWyaKU3aJWgIN8gU3cGVwzwhvA3hq9geZkZl/38TqjqPOws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774856883; c=relaxed/simple;
	bh=7GMzw0oRiafV0eMb7x9aC5ZHTmc/GWR5ESfda8BEsAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZAZ6x+kCTUMwm/JU3F2v/arPHqgnf+S7UznZJEYqhlZX2QOAHcz7Sq0OIxbjq/+GknF+fjyY1nyTij6rA00d3Ty7ZOFRmgX8e3NrGsyRG2N8nQvFY3N8ywAKQl1pouYANuiKVh1XrfcTiUbBkHFsWGzEh9Z3NFzZimBt61QtAqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/R9MFF0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lWhdLLEt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774856881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qg0u0qRIxbfnVPhgM3unvPlEH448ub4jA5OeQ5LRf0k=;
	b=O/R9MFF0E4l1BsrMUc78/4PoShDEnTMg8JZMPJW6PLlQsQSlyqPr+fwDLdFWurwizE2GlX
	yyXd6SUQta/X9Kqw0cAM4i0cY6dVpcPojy8jjmaVwh73NO2v4T7lPVodaWkbd4mX2g8ybD
	fjT91pRbaIotfArJAxXU6sh6YiRdUSU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-oaeOJSjCOmaS46mtCNTHzw-1; Mon, 30 Mar 2026 03:47:58 -0400
X-MC-Unique: oaeOJSjCOmaS46mtCNTHzw-1
X-Mimecast-MFC-AGG-ID: oaeOJSjCOmaS46mtCNTHzw_1774856877
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-487219e0800so29358325e9.2
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 00:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774856877; x=1775461677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qg0u0qRIxbfnVPhgM3unvPlEH448ub4jA5OeQ5LRf0k=;
        b=lWhdLLEtOc51DcthOQqW66KiGMwCfPEnh1otj1+EBE9XAtdKPF4dc8XOZGbNhtLALR
         rmgCBjfKc1OL50Mo2yKnVAg7wQ136pV86wABGpbquiimWM5jxlEJZcVJXoIAKby+w4Xm
         bJFD3gipgVMYNPBqzT2IaQ8G8NIFxnfr8t3R3npNU8MiG+fX33mIpyMTxtjQWPZhnpln
         n7uW2+Uk/4oxo7cOE96t0IhiAdpWFlbPuthpjC0TzpCPtuQ+DRHJYbhc5tHao0OyPWuP
         Ia7bruZOQKeh9KrK84OjnD0gj8ZN29jG8OG8RxZEKsW/UM6n1bbBUyq/bnZEj1Tbfdu4
         dtlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774856877; x=1775461677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qg0u0qRIxbfnVPhgM3unvPlEH448ub4jA5OeQ5LRf0k=;
        b=G/I0Qvd3mXbI2Ap/jPQehAezkfGViywdNGiMcdDR6CGxxz4JeqHGBZquhPP3/loKRu
         plTvbs1ueh9Wpav25p+NN2PoVggqCer06Rr45wPy0anf/0wKmmbhLzWIr0fe8zmvdlff
         qd4SfObkdVSsicm1J3ireIst1cqC9fnzv7HDUakcVD7NhktiCyGaCbROZaArYa+ZPefb
         S4B/L4ujSGiZ4xq/fvFOKPjfaFHG2iwEnneqQGRJsD4k6qrP0dLlRLLC5mZa+96nqJc+
         milUbK6i5u78Ol5Rf8SKjYYo9yjMPbgq70dyOqhoUDaHB0G0z2TCee427ZED+l837alM
         Lwww==
X-Forwarded-Encrypted: i=1; AJvYcCWxDwC1pqsqpSd+o5Oli1xUxi/b/HcJ+21+/q6OJlirTjKAaB2C/ne16m0rZzRMDKZV5BfKzFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT9hlxFXIB597T9wt8w1bedh72ISdHlfMzksU+XQePpyfR37cK
	iCZpE0Thct3h6AGY2FIubUOrC9gkDoCCbWRjg76XtDXtXbz/sVucNRVtY8jMeklqvkd49m8UQnJ
	heIqWNtrqhk75I32VZaUPtET5Qi9V/GyYlmYBUMtsuHxFaCsQFnfqOmofbg==
X-Gm-Gg: ATEYQzzHJIrzAxJxerLq5VpvhuuGJ6N2etOAwRuLpgXKGSpjrrHO2wJm68dX5ojTRXe
	vGmmwuDiXPf7+CpwUAZy5ToSn9bgmWPi9t0rh5q750yJ2Ts2OQUG1191fpw8XTFp2NgPgqYPNkF
	+EqH9Doy4vnovI7DTu/bsQz9vbnuoqaSr3e1epW4Day7sskGgzP8P7wP+7aZ7MEsJH7F7UOoaHE
	jbARBosssvdTe28Jez5Ku5rwgwt2Sj5BknnHm8vrVJVKdxWWzM0OPam2U0BOsYltqQiLRbfrluI
	McEVNZkxtun/UevoMfnT4KbIgAQEtuCegMdEa4XwGROaBMAZjHvrb7U7mLzoNvkFYj+WnTEq1UG
	a7o478WlaHK2zmfMgd9XtaKxJf9dzqyss9S+A94jkec5m9uYQDWQP4G5fVSwSwY39PC67iIsXl8
	ZPxJiH3Xoi1zarHGGd1S965D9V
X-Received: by 2002:a05:600c:4f53:b0:486:de04:5906 with SMTP id 5b1f17b1804b1-48727eda749mr187072345e9.19.1774856877187;
        Mon, 30 Mar 2026 00:47:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4f53:b0:486:de04:5906 with SMTP id 5b1f17b1804b1-48727eda749mr187071945e9.19.1774856876706;
        Mon, 30 Mar 2026 00:47:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9506dsm251858425e9.7.2026.03.30.00.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 00:47:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH for-6.19] KVM: x86/mmu: Only WARN in direct MMUs when overwriting shadow-present SPTE
Date: Mon, 30 Mar 2026 09:47:52 +0200
Message-ID: <20260330074752.136232-2-pbonzini@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231027-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3454356A4B
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
index 01e159941434..440e3d9fc689 100644
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


