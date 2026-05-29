Return-Path: <stable+bounces-256720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIZrK+HeGWpmzggAu9opvQ
	(envelope-from <stable+bounces-256720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:45:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC3660775F
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFFA230E0A94
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26845441022;
	Fri, 29 May 2026 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDM7sKTC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lmuzDQVP"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCA544CF22
	for <stable@vger.kernel.org>; Fri, 29 May 2026 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079799; cv=none; b=L9htm127cIPdrvbO23aXm2wj0AD5Mw8Y2FG1ih/GF5cy8YWjFstMNErfQTohZCT9aC/JmFI0jQ8HWyJgF69OBP3LLvj/ARLsBEFWm67L7md8lq7aJ+OIKXRUI3YnHeDcmqaR7CsUEmQjYYCt71S75i2tDXO7LqP/Mc6K/zf0gVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079799; c=relaxed/simple;
	bh=uPrLLFpnM8Cq5g9SQ/Bg0EXnQw4Blqrquvukdubo07Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkyE4HIGwRDk3TLxJW6tN9qmzeFchbhwoD6gzkdYgdn5rteK6jYng9M+jm/IfEUiifRAuYCPvEUDcMv8S4iTQU8KQZqvxAVZW+Nuwd+tJb/pYTesMSvu3cZzdAFDA+EU0AhvwvliTrzKQzn67Ml1iKZ357DdYjs480ESI1yjVw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EDM7sKTC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lmuzDQVP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzdB3vH88hWItfqET6Kq/ww0ZBgTZnqEkBTrvkfNvAo=;
	b=EDM7sKTCs59xXR+jwsMmk7PiBn9mOkmfrdgQFaDOo5jpQ2W/Vts2Lx7N96CH3nT57eALCT
	T5VgSG7FAT4VUDY4U/1whXuI3k2nWmKJso4KWpTJEMz5jGNM7B45Uge4nOKPRs6TkIc8wR
	o7TpUh3fvAc/5GbVTwxF+hWmlP0Sam0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-mj3Iz6cBMaCNO3PKbutm1g-1; Fri, 29 May 2026 14:36:33 -0400
X-MC-Unique: mj3Iz6cBMaCNO3PKbutm1g-1
X-Mimecast-MFC-AGG-ID: mj3Iz6cBMaCNO3PKbutm1g_1780079792
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49043386b3fso72136675e9.3
        for <stable@vger.kernel.org>; Fri, 29 May 2026 11:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079792; x=1780684592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzdB3vH88hWItfqET6Kq/ww0ZBgTZnqEkBTrvkfNvAo=;
        b=lmuzDQVPfafPKGEnB1b1mwbVpBx6pfxrwhOlGMm3O9z5pse8kyQmz6BpbuLvVjle9/
         +8UoDQojRSE+YUPpCdeKowh8cx1HyaaiV0g3MDbT02Rip63bLbYOYzlxkba/BPn00axp
         XI8vs2b0C6LMzn/lmrGcz3UsN1EHP7cBElGlsRgL9giHPkLnFVxEnHvREJf+NCQtkSJR
         lpa11albLsruBEdEfRPA5mbkwuK+mr3bqOHVDje+WDjDD5IBn6B2mzQk0ENX/Gw9FNHd
         Jc19OyVAc9cjgoqmMNzRA6Ow9slYOdwd3tJwGX9+eCeMB48ZbZYaqsvetNtkTw3gHE/R
         bkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079792; x=1780684592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QzdB3vH88hWItfqET6Kq/ww0ZBgTZnqEkBTrvkfNvAo=;
        b=Gmvp2O2bM+IVxKu8qQRGSPcvr07ngFTy0y4DC7tKl5gWst5ccChCJXVKmEhR7/+ERr
         LqH6iYutAC8yrT1rJN5TJS7spV5COmV52w0pAOW1Xg5rxTQ57JnnFvtlpcSjkZ/Zw9ux
         Pde9MYucprvTjFvITGZEr5PF44sloGdfLJK4ptKJeofFBSZlqfxlWegs6DxkbEhnB/SW
         WTLBYzED+pYLEfoRqv9nrrFDYUVCdzraWguumfivM1dHf2AH+2dDDwi/OUPMDQf6kFLz
         Ya3i9Vk421VC5inmksapLWMtaFHUs2I6kB+d6Ku+YsWRCK8HRH5YS7bArg/rNYGoVzK0
         7Ayg==
X-Forwarded-Encrypted: i=1; AFNElJ8QkqhuzQtbSuUTsP5u9hw1wVz08xn41l4tdYTL7g3giiskueq83QgEpZPcnwMwWhHAV6HdDOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybHlhaE5Gsden/GBQI9vgexzmZlY6XK41kqZXnZR6gQ3H2BwjF
	Bu14syB5DiQdlWdliaIG7QbEm17pJyt1a/WIpsog0qsS/ZQ+di4xZWsRfjJR1JSOdWV+WyPxnpa
	uxeYpYppwyri5gmCKIjU1R6FN5DApavy7PK8yycYF6mU3PnKIQEb5X6hxVw==
X-Gm-Gg: Acq92OEJ61Obdu1DETkLH6AJj/tUUTsDe4pskM13aGHl75y+ih0Z6XydbQu11slQmlW
	gXiEgfzDFz1sotgQTK3PltqNPpq8QIf+kZFtKYomoN4virrawzXVmce3F5Ns8ejUFeAGiYAPBi3
	t1ROW/ryK5jBHk04muh+r5XVXjQNy3gpEWCBGLoqaZ/KD2qPRaylPyCP1c+hw1tNfJ3wZpbgy2e
	fdEs4g56ZVFgz16+/4yDWiLXLFzbf8Hnype2l8Bz1O61ueyZEaBnkh8UhlaJprTCiC222uJHqyS
	JKHYiw6P/nO0/959kIC38Q2zBY/RgAZNHh4skS2j+twZQvA7/xaXqdGh+OnPZFeTlB4gOzg5rRg
	jMd6vudSzArX80Xwm41/TDzRQJ7zLFfFBfjMt86L/n5Z/zolmtdPX0BOHPJlmUWSBBOpF5r1+v7
	GK2Wc+ASJ9jsvQn5dkMe7rGOq18fyhUkIX/E07eA==
X-Received: by 2002:a05:600c:e48a:b0:490:9804:afdc with SMTP id 5b1f17b1804b1-490a2939daamr8888755e9.23.1780079792067;
        Fri, 29 May 2026 11:36:32 -0700 (PDT)
X-Received: by 2002:a05:600c:e48a:b0:490:9804:afdc with SMTP id 5b1f17b1804b1-490a2939daamr8888545e9.23.1780079791719;
        Fri, 29 May 2026 11:36:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c967c77sm71199315e9.1.2026.05.29.11.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 15/24] KVM: SEV: Move sev_free_vcpu() down below sev_es_unmap_ghcb()
Date: Fri, 29 May 2026 20:35:40 +0200
Message-ID: <20260529183549.1104619-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529183549.1104619-1-pbonzini@redhat.com>
References: <20260529183549.1104619-1-pbonzini@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256720-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9BC3660775F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

Relocate sev_free_vcpu() down in sev.c so that it's definition comes after
sev_es_unmap_ghcb().  This will allow sharing unmap functionality between
the two functions without needing a forward declaration (or weird placement
of the common code).

No functional change intended.

Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-16-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 62 +++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 4ebe0d449789..437282f0ea94 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3313,37 +3313,6 @@ void sev_guest_memory_reclaimed(struct kvm *kvm)
 	sev_writeback_caches(kvm);
 }
 
-void sev_free_vcpu(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_svm *svm;
-
-	if (!is_sev_es_guest(vcpu))
-		return;
-
-	svm = to_svm(vcpu);
-
-	/*
-	 * If it's an SNP guest, then the VMSA was marked in the RMP table as
-	 * a guest-owned page. Transition the page to hypervisor state before
-	 * releasing it back to the system.
-	 */
-	if (is_sev_snp_guest(vcpu)) {
-		u64 pfn = __pa(svm->sev_es.vmsa) >> PAGE_SHIFT;
-
-		if (kvm_rmp_make_shared(vcpu->kvm, pfn, PG_LEVEL_4K))
-			goto skip_vmsa_free;
-	}
-
-	if (vcpu->arch.guest_state_protected)
-		sev_flush_encrypted_page(vcpu, svm->sev_es.vmsa);
-
-	__free_page(virt_to_page(svm->sev_es.vmsa));
-
-skip_vmsa_free:
-	if (svm->sev_es.ghcb_sa_free)
-		kvfree(svm->sev_es.ghcb_sa);
-}
-
 static void dump_ghcb(struct vcpu_svm *svm)
 {
 	struct vmcb_control_area *control = &svm->vmcb->control;
@@ -3618,6 +3587,37 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 	svm->sev_es.ghcb = NULL;
 }
 
+void sev_free_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm;
+
+	if (!is_sev_es_guest(vcpu))
+		return;
+
+	svm = to_svm(vcpu);
+
+	/*
+	 * If it's an SNP guest, then the VMSA was marked in the RMP table as
+	 * a guest-owned page. Transition the page to hypervisor state before
+	 * releasing it back to the system.
+	 */
+	if (is_sev_snp_guest(vcpu)) {
+		u64 pfn = __pa(svm->sev_es.vmsa) >> PAGE_SHIFT;
+
+		if (kvm_rmp_make_shared(vcpu->kvm, pfn, PG_LEVEL_4K))
+			goto skip_vmsa_free;
+	}
+
+	if (vcpu->arch.guest_state_protected)
+		sev_flush_encrypted_page(vcpu, svm->sev_es.vmsa);
+
+	__free_page(virt_to_page(svm->sev_es.vmsa));
+
+skip_vmsa_free:
+	if (svm->sev_es.ghcb_sa_free)
+		kvfree(svm->sev_es.ghcb_sa);
+}
+
 int pre_sev_run(struct vcpu_svm *svm, int cpu)
 {
 	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, cpu);
-- 
2.54.0


