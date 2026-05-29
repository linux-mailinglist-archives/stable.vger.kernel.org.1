Return-Path: <stable+bounces-256719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBO1AN7eGWpmzggAu9opvQ
	(envelope-from <stable+bounces-256719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:45:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB710607757
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E75F130DE236
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA05344DB9D;
	Fri, 29 May 2026 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpMYdvI1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XT41YxNM"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DD943D50D
	for <stable@vger.kernel.org>; Fri, 29 May 2026 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079798; cv=none; b=MJFy2xszJ6u7m3Fopspk5leAkA+GWBCk+V+mXpvFqITq//Pc3OF4v161cnfRC0Z7fsiBBGX9Ci50fDUQ5K0oLYDbScMWCoj7jXp6PkfILv2u1RNr/q1vr9toLJc0tlvPk3QHz2EX/yDGkbUHQ8C6WLWiJCRZOjtAxi0l8Y/BP+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079798; c=relaxed/simple;
	bh=ulXu0NlgwaVVwx3zWk7XuRF/3f9bu/79QRsDBDGWEjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbXQwfTlF60W4wD9/p5RyKzcxe5oo1jHlvtOUQa0LtStTIAu83lNxm8789FYl5tIgu3cFbAeGDIfMeEyBbo4QB0Z1eaDsuMqFbiYO2xdOwT6C5nYDnh1of71CTUwcK559tkFSKkuYO0R/qMz1Mh/F/1sp5jV3X0lSvfabPYQ5QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpMYdvI1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XT41YxNM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+/A1VY1s6jcVoa3c05BPgiOhjQWKntgd+9grtxQ/UaE=;
	b=hpMYdvI1rd1LAhmvjOV0+PMxQukzbBtd1AYuQ1fu+C9k4vjLsX8tZcMSKSAHTKqIwX6xJl
	Z9uEa1WrNKJZ6lvpTEiSL1F2SkyaxJ/FgJfouR+dlhAZ2zX3ozRc4PAalh2sIRW/UQ0ugc
	vR7x/vkrUyuI6epBqrCPwIaSvkwSyIA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-308Rol_kPkiRyS1_axkR3g-1; Fri, 29 May 2026 14:36:29 -0400
X-MC-Unique: 308Rol_kPkiRyS1_axkR3g-1
X-Mimecast-MFC-AGG-ID: 308Rol_kPkiRyS1_axkR3g_1780079788
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45eec27f5a5so1146588f8f.2
        for <stable@vger.kernel.org>; Fri, 29 May 2026 11:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079788; x=1780684588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/A1VY1s6jcVoa3c05BPgiOhjQWKntgd+9grtxQ/UaE=;
        b=XT41YxNMUCIAu7hgtAXY7IT66gfTWDAbjEbeSqaIADMqFcV08Awt5YUyfl8apmCNZA
         wRcGK6jQiAWeGH9XC3bGYwgDzWaHumTivIvjASA/C9X8ebEWBlaErnszrHGn3Ukp0vSu
         qMEEA3tTVnJ3+fWnRr4gTg4ysDVUl3bu2OdsuLCkefIYUZj6q95mkTLqK+0FfX2UoDMX
         YS7vkR8Pt/O0jbJ0K9bNTkE+hKn9Siel7/ggsrvnrdSh6tn1bEEUxAf7M+Lx6eNQqHGz
         nxRI0Y6ZwPXIhAcJYV/G9uH0cBQ1byEttzdw1AG1DQbVxBWEB99kmo+1UkOX+8ALxM5T
         m5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079788; x=1780684588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+/A1VY1s6jcVoa3c05BPgiOhjQWKntgd+9grtxQ/UaE=;
        b=flIcIvWU0qniEaImKh2esP2TXJv0ZtpHxbWtMelaxGVwznbXMnziJHtWM+az8vZtub
         KqFbyZvErBM0kQC3PdS6oPEq99HJzPAytHa3r8igGGtrGemfH8MyGkWzXqekvz79hnpD
         q2yF0HWW/zT5xkwMvkP/0uP28o0ACRPMUqAhmR5mw0cJL2e/sJry4ayDZUP1r5NoCaf9
         yd1pDVMsFEt3FXdlL7hIc5/+aR//RMQOT1/TzOl8uYiSORKr8SRv8ZaW3mTTBkLmGdWu
         v0iHckKPsxyh8Bc9U6mbgX+lYgSZ9us7Y3bCi8ANXBESPkZ7sCdw9RjAvJtI6tvKuEKA
         XsEQ==
X-Forwarded-Encrypted: i=1; AFNElJ8wRJy1fCCS4wDwR2Zgh6LCEWsNzyUxzncwNxa8BdkeV8apgm8GiQrdq2WKEfGO5a/FflYtkNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7/VgE+Xl+nWbN8ry21tlpqFMZt0wicvpJGN67HELV6gHkGCqS
	azYQbhhPcFNPRSuslo5wVpywNOLZK0z1q+C+V0nLpak0hDK24UlD9za1ONZTmvouSgzsRuliXeF
	m4DT46dJoQioJUvcP33Rg3dki5/0v6+wdo6Bg8l6VQT8pfQHljyrEjqsf+A==
X-Gm-Gg: Acq92OF+M4zM5+zFgJh3XuxuIdrxeLovjH/To8Y5uEB897f/uCSqLsdNp2dccCXMXFd
	FtGf4zZRchZLaWRMwQ/Qb56oB2R06S+AD/84NoiI7WtxtkqZITP2I7GAZTYgPwhpjwbCFvQPckf
	wZu9JI8+fqsI6ovHwdA3ZB+uwoyFu6na2DmOLA/+PXYS9Zrv3z9a7z4okpoJ6FHlrJOH9XOKLG3
	GB/KxOqodP/fAR7BqLS2yDxSbjYBWOajk3vvWZuKhdxCygMmj7vxjFyRGjXhp9C+JeGOLiNZC2T
	fdqDd3rK2Rb6Nb4BTD5VAxCFPww9aZd/wrTZW6Kt2dZOd8t1CA9Cpm0ByUMb/IN4ORPaGvuBCIt
	ruawPDD1hC209hgvipYtu6pK7lr8BpjPcJpDOFGEfWMHC0I6jFAjxyIDC7NhS7rNZRfarPG97vl
	BqBzcf+NHAHE/izSwNM5JbsTLoDhOPTBxOy+QnLQ==
X-Received: by 2002:a05:6000:1376:b0:45e:f52b:f4b7 with SMTP id ffacd0b85a97d-45ef6b20038mr1460686f8f.17.1780079787899;
        Fri, 29 May 2026 11:36:27 -0700 (PDT)
X-Received: by 2002:a05:6000:1376:b0:45e:f52b:f4b7 with SMTP id ffacd0b85a97d-45ef6b20038mr1460639f8f.17.1780079787478;
        Fri, 29 May 2026 11:36:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef356b129sm6889251f8f.32.2026.05.29.11.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 14/24] KVM: Don't WARN if memory is dirtied without a vCPU when the VM is dying
Date: Fri, 29 May 2026 20:35:39 +0200
Message-ID: <20260529183549.1104619-15-pbonzini@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-256719-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: AB710607757
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

When marking a page dirty, complain about not having a running/loaded vCPU
if and only if the VM is still alive, i.e. its refcount is non-zero.  This
will allow fixing a memory leak for x86 SEV-ES guests without hitting what
is effectively a false positive on the WARN.

For some SEV-ES VM-Exits, KVM keeps a writable mapping of a guest page
across an exit to userspace, and typically unmaps the page on the next
KVM_RUN.  But if userspace never calls KVM_RUN after such an exit, then KVM
needs to unmap the page when the vCPU is destroyed, which in turn triggers
the WARN about not having a running vCPU.

Alternatively, SEV-ES could temporarily load the vCPU to suppress the WARN,
as is done in nested_vmx_free_vcpu() (but for completely unrelated reasons;
suppressing WARN from nested_put_vmcs12_pages() is pure happenstance).  But
loading a vCPU during destruction is gross (ideally nVMX code would be
cleaned up), risks complicating the SEV-ES code (KVM would need to ensure
the temporarily load()+put() only runs when the vCPU isn't already loaded),
and is ultimately pointless.

The motivation for the WARN is to guard against KVM dirtying guest memory
without pushing the corresponding GFN to the active vCPU's dirty ring, e.g.
to ensure userspace doesn't miss a dirty page.  But for the VM's refcount
to reach zero, there can't be _any_ userspace mappings to the dirty ring,
as mapping the dirty ring requires doing mmap() on the vCPU FD.  I.e. if
userspace had a valid mapping for the dirty ring, then the vCPU file and
thus the owning VM would still be alive.  And so since userspace can't
possibly reach the dirty ring, whether or not KVM technically "misses" a
push to the dirty ring is irrelevant.

Reported-by: Michael Roth <michael.roth@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-15-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/kvm_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 89489996fbc1..881f92d7a469 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3520,7 +3520,8 @@ void mark_page_dirty_in_slot(struct kvm *kvm,
 	if (WARN_ON_ONCE(vcpu && vcpu->kvm != kvm))
 		return;
 
-	WARN_ON_ONCE(!vcpu && !kvm_arch_allow_write_without_running_vcpu(kvm));
+	WARN_ON_ONCE(!vcpu && refcount_read(&kvm->users_count) &&
+		     !kvm_arch_allow_write_without_running_vcpu(kvm));
 #endif
 
 	if (memslot && kvm_slot_dirty_track_enabled(memslot)) {
-- 
2.54.0


