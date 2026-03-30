Return-Path: <stable+bounces-231033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKiEKkIvymkA6AUAu9opvQ
	(envelope-from <stable+bounces-231033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 10:07:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1B9356DF9
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 10:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95FEE30097CB
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E435C24E4B4;
	Mon, 30 Mar 2026 07:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCERkdnM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="snK2Ns/c"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAFD39099F
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857519; cv=none; b=iKoIZ0IkYr58G1pz2fwwh/lSAm/246uJivpT3GN3F5Oye4euOYBIJo33pLZ0krve072TcPza4ad/9hHc44NpUJB5P9TlM9b9zr9CQpXEqMv9NpDRCuBDRSn+Lpn6K+mhkm8Qv4fEb6TT9wRpWQACD1pVwLNWZcMHe6PlnWVJfKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857519; c=relaxed/simple;
	bh=zEZGwGF3sKc0G9zq1ffG0PV9TQ4YaNhIAp7e0h+68pU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hXiBsdgCK803NjEyWQ3V3lZVaoDom5Ul5UrvaNa5QH89l/bwM0XTVdnfGbKFtaiz+k31WZqMTcOibXWHPCpM+vLmuDDTf6DuAbJb02x0MIvAd9Y1sUNarzpllQ7V/AIwOptdMDZbqruWt1/3b9iKpIW5PEsXU2tdI5xmPmOYRqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UCERkdnM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=snK2Ns/c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774857517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I9UHxN7TKiM+B8XGIaW8UV2fs43HChjHFnISdi8ej/0=;
	b=UCERkdnMA9+/GzNCBeQz/Tk98ds3+v50ytTDAWCkGdT5pXao0rfuX3oEy0nHpFBKGRUzTZ
	5T10y5oSr2xYS1wwVdBBJYFXHtNCOYZ8RWe2iHi/+GYRcP4SF+kKcLW9curKowflKd4fWv
	qh8CYi8K7UQaNW5rAXm8t6js8zYhYiU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-bnAbui5NMEClwwSKwn6eaA-1; Mon, 30 Mar 2026 03:58:35 -0400
X-MC-Unique: bnAbui5NMEClwwSKwn6eaA-1
X-Mimecast-MFC-AGG-ID: bnAbui5NMEClwwSKwn6eaA_1774857514
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43cffbe261eso460668f8f.2
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774857514; x=1775462314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I9UHxN7TKiM+B8XGIaW8UV2fs43HChjHFnISdi8ej/0=;
        b=snK2Ns/cMIQbzd3fAvTfGWy2J1uhkaxgwxvE+sZxNsCSwKrWvaKoos3+SSnueadsGE
         n8xh9SUUw7cSNOVbP1Pc7hFzGI0u/4NukHXkE/IutV+nn27UOI7rhgJP97Hxc2MsAg5N
         jovKvIfxX207ao8z7IllRfAq46ddajgwBAHJqd5If9Tx1czy9cQoikx37s40Dht+oQr5
         mxbcXfJy/9V4a/YgWHjCZJi3fjnAI0m9n0lMGGpTXfh9SMEkA6gjlqnEdIOmerqT/elN
         4FUttZ5wMvYxkjh5B08CU5s74FvbLuXjWPmNHH57O5aekRCocI8QkTNlThf0o/50FgiP
         kUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774857514; x=1775462314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9UHxN7TKiM+B8XGIaW8UV2fs43HChjHFnISdi8ej/0=;
        b=InvVWwUVrXAk0z4sVrZ89M4Y59R54Fxov8vY+ACsEEgtE+nw+byMW1HUgwbu6DJHhv
         9jS+/xUyFcV80/ZQcIFRhcE5zdi1QstDxVuALvEUc+qjKvdIt8m5Gb13Z0sAADslxtrx
         iEiML/bVd/YmbWwbjZY6tkkFvskYFbCzVpKat+115iBM5ZKTqyMMrkeIIP9Q9DvhS73Q
         DYogFYb6JqTv+6KmFJTdRGF3pTAtyI990nzTklM6oGk3tnqXsTjyZ27TnMrt2KPLONQ7
         pg+cYZF+H+ws1W7tMeik7epwHHvlyMLHKnuVtenqX7KddoeZh7VaBe2UiegrDjVGFvSx
         t12Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjdwCQv41svhAk1bUC6nVXh0X2XTMqUl2sOXandwkRX0qPhde6fTWLQg0ETjW3F1t0yEMFQiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAN+e3I53wjxeM5kbGto8NgIVD1RIyjsi0whdb3DeYiSVt138Q
	kwKokeM7rwtOVEvng7O8ChDpQvgjX/DuWnRenf6Eoy8d+9WM22x0jawk4n0Nd9biJo5mrSorB4m
	Q7w32U1xoAwQtLkZ5qsqCiV8igS6xgnAfd3nivJVjXTYEtptmPYiYrjM03w==
X-Gm-Gg: ATEYQzwjVKAuC+Q9Qkl2kLQbnkzNnbCkgc6zBNhw9wjnMyW4vWzDClCSeN5zLxwyoVe
	xoASDEiQzPqZlyP8Q8/BmgoQlM1VZd2TcIhGuM+LOe30icgxYD2q64vgv7uvbYYr5M2x9iN4+ax
	mY2Qu2ck79Lw1HzP1k/yZ9kWGx4MiN/Aq4GWbfHoeNU8oXPSnwE5hziFiKlhfF/HJPtfVt8c9Nt
	JhD0vkwxNQiL/271CElTw4A2im0/+PAeN+u2Zqa1d2ZeRzrkNnApw2ThjEuBmp60+3zqGiAxYtU
	Vs3YRbofz5EmPqAJuZR6HM7Rvx9ufrZtWIHHrWhoFPs/jvCGi8W1Z4D/xWwTgmXGtrnHubvncWV
	TnTkA9eOuAVcpIrzeKF8veQSJgxvChMwOq8/k5PfWvZkzLQKJOiftCB3IRH3VBK6su1vueaeUZG
	ivo9vTCIrnpL0pNoQ00LRO9eRg
X-Received: by 2002:a05:6000:2307:b0:43b:3d02:7806 with SMTP id ffacd0b85a97d-43b9ea4a457mr18934810f8f.28.1774857514329;
        Mon, 30 Mar 2026 00:58:34 -0700 (PDT)
X-Received: by 2002:a05:6000:2307:b0:43b:3d02:7806 with SMTP id ffacd0b85a97d-43b9ea4a457mr18934767f8f.28.1774857513811;
        Mon, 30 Mar 2026 00:58:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf24739easm17845984f8f.30.2026.03.30.00.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 00:58:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH for-6.1] KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE
Date: Mon, 30 Mar 2026 09:58:31 +0200
Message-ID: <20260330075831.153407-1-pbonzini@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-231033-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:query timed out];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B1B9356DF9
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
 arch/x86/kvm/mmu/mmu.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 04d060f37053..a9f24eeb4477 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2814,12 +2814,6 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 	pgprintk("%s: spte %llx write_fault %d gfn %llx\n", __func__,
 		 *sptep, write_fault, gfn);
 
-	if (unlikely(is_noslot_pfn(pfn))) {
-		vcpu->stat.pf_mmio_spte_created++;
-		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
-		return RET_PF_EMULATE;
-	}
-
 	if (is_shadow_present_pte(*sptep)) {
 		/*
 		 * If we overwrite a PTE page pointer with a 2MB PMD, unlink
@@ -2841,6 +2835,15 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 			was_rmapped = 1;
 	}
 
+	if (unlikely(is_noslot_pfn(pfn))) {
+		vcpu->stat.pf_mmio_spte_created++;
+		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
+		if (flush)
+			kvm_flush_remote_tlbs_with_address(vcpu->kvm, gfn,
+						   	   KVM_PAGES_PER_HPAGE(level));
+		return RET_PF_EMULATE;
+	}
+
 	wrprot = make_spte(vcpu, sp, slot, pte_access, gfn, pfn, *sptep, prefetch,
 			   true, host_writable, &spte);
 
-- 
2.53.0


