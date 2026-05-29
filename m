Return-Path: <stable+bounces-256722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6APyKwPfGWpmzggAu9opvQ
	(envelope-from <stable+bounces-256722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:46:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A636607799
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7E9F3042512
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC59A45BD5F;
	Fri, 29 May 2026 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1FP7LZe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="axP4LoCi"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F125426690
	for <stable@vger.kernel.org>; Fri, 29 May 2026 18:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079805; cv=none; b=RKhllmRlh4kcMq9iNn42V3XoJtgrTAhbwJMF/2dvd/6TBnbV17RiPAYToIdjT3vVfr+vZFNLZnjbsHZ62aPdEAEfnTMowa4hchKGwjBQrj3L4Rf212PCKnmnoobcJ53LZZhZLXpckVlgOX23G+jntOTL9uuWVnv2walcRphKxx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079805; c=relaxed/simple;
	bh=DW2PUzvZkPeDxrXgPu51jPm/Jji/jDPOTkA5AbO8VMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBKdpE/kPQJdQFkCmlQWBjEzg2DTv0CYQGCFOkMerdrSh5HhdJUXKzlz5qvArz9n7D2fGQ97slsYsoDlBjcEX0moZVdU+YOk6E+gmYRJZ8w3cyw332Lmrb9wBzaVQryv4gnrdhIy3CNSHm+Fx+zBiBrZ1gh7hrxdMNEBdvEfxsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1FP7LZe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=axP4LoCi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYkh8jiq7SEyEfVyi04hmQY3u+cvHZraHKSEMFmK1TQ=;
	b=F1FP7LZeflTjDd/iWLtpPfdxWut26Mgh5asz0oSXaI7CchJKdpXeK+tVul3f5XszTnPPnN
	17jJWiNim0hekzV913jaySmJ1dBMqjHJBJjz0MuUgw1S3lUrKP1pJNzvIlNpWcDZeqf0IR
	AbiXF7FbIo9aq0PJbFAziEVN6VvRo0g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-CmnLlE70Phe__v16VkIMrA-1; Fri, 29 May 2026 14:36:39 -0400
X-MC-Unique: CmnLlE70Phe__v16VkIMrA-1
X-Mimecast-MFC-AGG-ID: CmnLlE70Phe__v16VkIMrA_1780079798
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef5ba50aeso371106f8f.0
        for <stable@vger.kernel.org>; Fri, 29 May 2026 11:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079798; x=1780684598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYkh8jiq7SEyEfVyi04hmQY3u+cvHZraHKSEMFmK1TQ=;
        b=axP4LoCifqBoHeS36wfwxevGyK0R4eL6iHCZRh9F0iyeibQBAE6F09u4Go0/NviPfT
         x55aAtwKMOlh5A5HXGXzqMrUw4tArfu3JaO9aVdWKtou13vADQvDhN3tKjOhChLZnXGZ
         I0WexmIA4cS7U10n3X2Q0XIYZZk5qNdHRXlAjJj3FDL+ztjc0uuRh1gI2Izh2Q2g29SH
         yiz5PbDZdOpJZ28su7DLiWlRWe+QsBM9igfdlE0W4vV3kQfpKpuuVedu3kkbyGDHssrE
         k+33yQvpSo1Q/6za2NkjG4kBXnmAzbjagUSA4Vn5DOPA0pdKkAt4YBXQKyy4tg4M+20J
         0djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079798; x=1780684598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RYkh8jiq7SEyEfVyi04hmQY3u+cvHZraHKSEMFmK1TQ=;
        b=MPTgicuFWqyQHaCvVoYlxJOjUCpIvxBT0D/tfOPQozPlI0LxDlc2OSWOZyj4z/DUMz
         ZdkFRvP73/f5alvx0oj3GnTfohTXGp5c7KyKCiOuPuppm/BMxVFnU6SdqwZSlX28hY3c
         w7yuDk3xSGqgduSuffz/VKL5uOc1rF7C/dOSgQIuMKLsjAx/vJA/YOfdv8RC0way36S4
         udy+XIkZ5VruPAKMXROcpsptDsAuz1/vQqK8ryeg4wSir2b76dNMXOMjllCSMihJl5sE
         DdX++66ErhfaxNV2IfFr3FcK8w6DKuNmMAldU9i3AYlEV2PNiYI9jzfAfJou2i/Ucsv3
         EyXg==
X-Forwarded-Encrypted: i=1; AFNElJ+vJGaapM22Xr8CNxPtKWib/m4PFHhapg/vSu1yyC9OfR/bUCo6JGmdzXZm3fgnoGgkX/74jKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcTo77DlqEfYWnrr+CxPovdm5ktTAZ4SYJQHA5PYEmcvNcilPa
	zjiqrGTjTJE/N+VMqRkwEw9x9vif6DYgoApeb5GNdnGT9NiD82Q0btdlVC0PFRgXU01dXafmZot
	VYlGvxtNFHS+0D7GJAMSeodoppYIfmuu49MeFl8knTE4By1QZ/rok6dVk/3ltYk6qEQ==
X-Gm-Gg: Acq92OHdv7oJANpO2obhE1jrnTh5jXB0x3jBqit0pfTYSRlfKoRg2r1WIYCJ39rGO45
	QVxhJq9S6+sDm6nh1Prm+5RuZhAieKRYdw8qHJs85j1vYEXKkb3+VTPsUecYLPuoHLpYT4evoht
	vzDGfJeT0PHA1EhPllsZNo7PQhfP6cT/lvONe8mR+fDD2ia888Gs+g5n7Rt+iabqvKVWw99caAI
	/J1lUq/7HuWalvduWsXFE88FCTPw++xiB93DIbdYVAiPLJ8XYiq+Viqdn5qNy2FFM47o6S+W3Qb
	sFohlPiJUJRD0FjH2nfN4nmSMbQ90cQf6U4U04YBq7RN8Kyz+yF8mvSHhasGxWj3rorkMuW4Sbu
	9qOlxfOE6S7FJ3HxYtxuETDJdDBzjGwnXnnaeJRAgtHrTlZ1ElNP8nfCQL/7AVSeliItYmcZ+rB
	UTt11pEkxE/fPYgZJtyXzjzdkIJYZ207RpmV1V6A==
X-Received: by 2002:a05:600c:818c:b0:490:48df:2793 with SMTP id 5b1f17b1804b1-490a296df9amr12285225e9.26.1780079798401;
        Fri, 29 May 2026 11:36:38 -0700 (PDT)
X-Received: by 2002:a05:600c:818c:b0:490:48df:2793 with SMTP id 5b1f17b1804b1-490a296df9amr12284925e9.26.1780079797965;
        Fri, 29 May 2026 11:36:37 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3587072sm5633245f8f.34.2026.05.29.11.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 17/24] KVM: SEV: Unmap and unpin the GHCB as needed on vCPU free
Date: Fri, 29 May 2026 20:35:42 +0200
Message-ID: <20260529183549.1104619-18-pbonzini@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256722-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5A636607799
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

Unmap and unpin the GHCB as needed when freeing a vCPU.  If the VM is
destroyed after mapping+pinning the GHCB on #VMGEXIT, without re-running
the vCPU, KVM will effectively leak the GHCB and any mappings created for
the GHCB.

Fixes: 291bd20d5d88 ("KVM: SVM: Add initial support for a VMGEXIT VMEXIT")
Cc: stable@vger.kernel.org
Tested-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-18-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 11d46600cbdc..6c6a6d663e29 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3552,6 +3552,20 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 	return 1;
 }
 
+static void __sev_es_unmap_ghcb(struct vcpu_svm *svm)
+{
+	if (svm->sev_es.ghcb_sa_free) {
+		kvfree(svm->sev_es.ghcb_sa);
+		svm->sev_es.ghcb_sa = NULL;
+		svm->sev_es.ghcb_sa_free = false;
+	}
+
+	if (svm->sev_es.ghcb) {
+		kvm_vcpu_unmap(&svm->vcpu, &svm->sev_es.ghcb_map);
+		svm->sev_es.ghcb = NULL;
+	}
+}
+
 void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 {
 	/* Clear any indication that the vCPU is in a type of AP Reset Hold */
@@ -3570,18 +3584,11 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 		svm->sev_es.ghcb_sa_sync = false;
 	}
 
-	if (svm->sev_es.ghcb_sa_free) {
-		kvfree(svm->sev_es.ghcb_sa);
-		svm->sev_es.ghcb_sa = NULL;
-		svm->sev_es.ghcb_sa_free = false;
-	}
-
 	trace_kvm_vmgexit_exit(svm->vcpu.vcpu_id, svm->sev_es.ghcb);
 
 	sev_es_sync_to_ghcb(svm);
 
-	kvm_vcpu_unmap(&svm->vcpu, &svm->sev_es.ghcb_map);
-	svm->sev_es.ghcb = NULL;
+	__sev_es_unmap_ghcb(svm);
 }
 
 void sev_free_vcpu(struct kvm_vcpu *vcpu)
@@ -3611,8 +3618,7 @@ void sev_free_vcpu(struct kvm_vcpu *vcpu)
 	__free_page(virt_to_page(svm->sev_es.vmsa));
 
 skip_vmsa_free:
-	if (svm->sev_es.ghcb_sa_free)
-		kvfree(svm->sev_es.ghcb_sa);
+	__sev_es_unmap_ghcb(svm);
 }
 
 int pre_sev_run(struct vcpu_svm *svm, int cpu)
-- 
2.54.0


