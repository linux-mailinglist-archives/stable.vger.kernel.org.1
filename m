Return-Path: <stable+bounces-256723-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBMTKeLeGWpmzggAu9opvQ
	(envelope-from <stable+bounces-256723-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:45:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41641607766
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85769304C4C3
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0154611F4;
	Fri, 29 May 2026 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUEE2exu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXEG7KX/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7527044D031
	for <stable@vger.kernel.org>; Fri, 29 May 2026 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079806; cv=none; b=cSlAsgfwq0YjphUISy9JgsIhTK0UEvzHYZ3L1jn/8Z1r70s/fTUb9XuconxN/pKWjoeVSio3clvOtZOdDbzpW5r05v7FRmB91STAgwljR/m9jKd2sxJLB1+B3w3TWWGj3vT+RVyfcuRjXgdk/+Q9AWHUA9En2jJ/jfJhoeG04IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079806; c=relaxed/simple;
	bh=qhNRXPjJiLrNoLYnZFebbOWX1YrMRfkvrSsBcG3U8go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6qHeABxB0tEq2atmak0e99Zpf+9RPJDDh7QaLcONt8wbBotB+onbFDS34H3Szg5qf9JfWJEJrL5xgq9TrV66HQNEZ44M7sNqxYTds07Leom5aulB+V730be6B0nj+sxLE6xFScmKO102WUVnVv3PauzCmLQXT7CSUVIBm/mKPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QUEE2exu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FXEG7KX/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+1XJAuHtEwSrf2OyC4wSiD7WDpcF6b/VSFdi0YQ2gfw=;
	b=QUEE2exuqbF/Rb5maPz9hGt6tCUrm4mrqeuC5JsuFCJeCqmmNuTDhqpWxTfu3llAn0aIN4
	t9QJZV1MLhk74vrFfmPRu5Dxn+RR2h6EmxT7QCdPWOiF17HPLsg8KEakdgg/rakpTbn/HI
	ehCV25m4n0uGK9cvkN5AReGrrbuXLtE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-eGH4G4PhPrOWUShNuQGsqw-1; Fri, 29 May 2026 14:36:41 -0400
X-MC-Unique: eGH4G4PhPrOWUShNuQGsqw-1
X-Mimecast-MFC-AGG-ID: eGH4G4PhPrOWUShNuQGsqw_1780079800
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48fd396daedso78500565e9.0
        for <stable@vger.kernel.org>; Fri, 29 May 2026 11:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079800; x=1780684600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1XJAuHtEwSrf2OyC4wSiD7WDpcF6b/VSFdi0YQ2gfw=;
        b=FXEG7KX/dCeQdfM8fDrgMQMqAQTjx+aTJFMux/gQ193edRiRQEknx2gTeZsYUza353
         MK0qoy4SeAUSK9PE9Fy2xXgSY4YOjmGU7Zx/TfyW4n+mU5r3lEO5hLa/Q3hmxNOcI/te
         n49EMDbfPPfsJb9sdNDjttnWcSvL/ioefdBMGJKqvoqFZZvIvrAHjQGSVQpcspFlw4qq
         LDBgOBl5LR7AB8K4fz0HzlJQPRKOjfjJ6QvtXDvX0KGUL4lfFF5apslua32OQRxf1SNg
         IZR/MtHiLTDV2yTmkCHRTKS59xIkADpHXBQx9SkGk3NmgPNfYOg2dzI8teqDWAKGVsUR
         iWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079800; x=1780684600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+1XJAuHtEwSrf2OyC4wSiD7WDpcF6b/VSFdi0YQ2gfw=;
        b=ZIgCbhOPsTRnLsweZx6QKZtz2wNCkZhvPy214JgkroliHBbwYAHBwps+i7VHIAdi/z
         0lY8e56FOzBifXrqIZOM/iWUpLw8aYwd7L/J6rEm7eoneSmyOoDMwOHjSebwSi4sTkxE
         BpACuHWvkE8SQpCbfh2bEN0OoC2CNQ5tA9U3sdkbcTzlIgOfuXO8kj32Kk/4l3SXbSW9
         BaAAJmOuTMpTTUQNKFcG5X1gmN/ej4uk09dnO+0I45s2h0S8iswDVovrcwcPlL8hO/fo
         i3kVPdc/K3wXUH2I7eAQdN9nqBwsJPboIiNUavFjwEl1okU5m0651EdxNj3dm/pLIlKX
         F1Mg==
X-Forwarded-Encrypted: i=1; AFNElJ9aWSqVJqBsijf0z11JXiE0zPkm9dgqatrqNUyXfv4sPKLMVzHc9Dh/b8xjk8kgdVABicqVMDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJt84V3GfjOksoP1SCiqeNIzwb1wKBJEf29bdT1ZwC5hnwfdld
	BvTAlwygDjW+oYvFVEW2EEfvqIqbZRZ8yfE+Ywive95fcjPvTRA902PTgfDkO6pi/j0NHNwOboo
	Mf3yLH/Q5EiY0Q2yp9iErknM8iib7dWnMQM7IMRWNVxFjAFBT0OeyJ5t0Jg==
X-Gm-Gg: Acq92OH3sFtdXw9JWmgm//dsBtN9CR10gBbPDp/leRWIKsgVHTPeCLFBgvAAXH79WHR
	IFokR6+iZmcmVVuwIkkpvGXR72E4RwDpDCnUrV1OLdaIqp3yWJKbs/OeUeF3z0RYhIrVepNZOD/
	YVR68TLDsmYzoad9sps+hbKrALC0xtHhhkuw3qrAOdaByVnVkiFRWXc4efVwTRT1AenZuq2ffKy
	3hcTafgDnzo/JZb6Zxha06PnrzAnp3IMSl/6ueXmJm9/Q0qqRPGhCie2rIUf8zcc/2q8Qcoh6ce
	8ZjMeRb/7d2N9Bpz1hACemKmebYsRUvYu4L75xRr37zznxnSFNth0svQnLuX2+XgSGktFejaI/q
	fE7UarxnNX/auQcTXQcknN7+bzeYUuS2SzKPXO3hlBp2Zfcuzyk5s60xkHeOurt/2xVIgGKzrRB
	swZ8JiiO7LJHFfnoW+bvmSPf7xJ0VjWLsh7gzrxQ==
X-Received: by 2002:a05:600d:8492:b0:490:51e2:d992 with SMTP id 5b1f17b1804b1-490a293fa59mr7911295e9.13.1780079799934;
        Fri, 29 May 2026 11:36:39 -0700 (PDT)
X-Received: by 2002:a05:600d:8492:b0:490:51e2:d992 with SMTP id 5b1f17b1804b1-490a293fa59mr7911005e9.13.1780079799550;
        Fri, 29 May 2026 11:36:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354b5bdsm4989755f8f.21.2026.05.29.11.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 18/24] KVM: SEV: Don't terminate SNP VMs on #VMGEXIT without a registered GHCB
Date: Fri, 29 May 2026 20:35:43 +0200
Message-ID: <20260529183549.1104619-19-pbonzini@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256723-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Queue-Id: 41641607766
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

If the guest attempts a non-MSR #VMGEXIT without the registered GHCB,
return a GHCB_HV_RESP_MALFORMED_INPUT+GHCB_ERR_NOT_REGISTERED error to the
guest instead of exiting KVM_RUN with -EINVAL (and in likelihood killing
the VM).  KVM has already mapped the requested GHCB, i.e. can cleanly
report an error, and so exiting with -EINVAL is completely unjustified.

Fixes: 0c76b1d08280 ("KVM: SEV: Add support to handle GHCB GPA register VMGEXIT")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-19-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6c6a6d663e29..7c2ebc81306f 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4520,9 +4520,12 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	sev_es_sync_from_ghcb(svm);
 
 	/* SEV-SNP guest requires that the GHCB GPA must be registered */
-	if (is_sev_snp_guest(vcpu) && !ghcb_gpa_is_registered(svm, ghcb_gpa)) {
-		vcpu_unimpl(&svm->vcpu, "vmgexit: GHCB GPA [%#llx] is not registered.\n", ghcb_gpa);
-		return -EINVAL;
+	if (is_sev_snp_guest(vcpu) &&
+	    !ghcb_gpa_is_registered(svm, control->ghcb_gpa)) {
+		vcpu_unimpl(vcpu, "vmgexit: GHCB GPA [%#llx] is not registered.\n",
+			    control->ghcb_gpa);
+		svm_vmgexit_bad_input(svm, GHCB_ERR_NOT_REGISTERED);
+		return 1;
 	}
 
 	ret = sev_es_validate_vmgexit(svm);
-- 
2.54.0


