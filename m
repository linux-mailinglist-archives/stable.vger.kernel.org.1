Return-Path: <stable+bounces-224572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDY4IfN+sGmwjwIAu9opvQ
	(envelope-from <stable+bounces-224572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 21:28:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E04257D9C
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 21:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0699830B1F4F
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 20:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CDF28BA95;
	Tue, 10 Mar 2026 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cn1AjjU2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdzuRbb8"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E7D3E9F75
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174267; cv=none; b=JA/4tnhvaSH4mpAm6h57Hg6ounkwRiVX+YcnV1VdT4s/1qA4C9xyMVfSZFUZax/HUnGmXQHA0LHqDvonp9mWPAvWIIiT27kZbApQp2cOcT0IMscFoHgQDLsXzgRiLGeskY3qQHhOU5ago9auLb/uhQF67+X6FtqPp1jkIs0B9Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174267; c=relaxed/simple;
	bh=XzfjV0NwKwYFZsCPkm9GQbhIVKJ1rr5+J23oLRZx2CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtOEKLjdjW6BjD2Jj46TXr9yyhq3u44esBJPLBACTgJjRId2VHDAvHhGZ4sA8wiNh+ibYavi5/bJ9I8V2461j3alnPyduNwJXOXj7vG+e8R9kYDc/9yaxjl2KX/eb1vll96YSjVP2VEfXAzNrgfUokfSQtQDqOgUi7U5y66Q8f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cn1AjjU2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LdzuRbb8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773174264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TGyObaOA+0rXaSG+XOwiWbo5MYOrwO/NaEY5gkjsyg=;
	b=cn1AjjU2nLIH6KVFkAjtpPpY5wBwHVs1RDF8z4mJyFnmstxT+5S3+e6kMAPLdWli88ojxc
	8kJGIWR4wH/rmf62Gp0xAySZHkUXQnfqYLkgzQKDTv5aNMYPUe6y5nhHAnkBn3B6YA6UXT
	h47AIG02hXHnlgBRjVQWkB72FjUdWXk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-XBtTCAMqMA6rTSLaHg1hTg-1; Tue, 10 Mar 2026 16:24:22 -0400
X-MC-Unique: XBtTCAMqMA6rTSLaHg1hTg-1
X-Mimecast-MFC-AGG-ID: XBtTCAMqMA6rTSLaHg1hTg_1773174262
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so105958965e9.3
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 13:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773174262; x=1773779062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TGyObaOA+0rXaSG+XOwiWbo5MYOrwO/NaEY5gkjsyg=;
        b=LdzuRbb8MobO9rreTqNhgtujUtTvdKApvNz5U6dOahThNtXueTsMHKOKI+9dYa5Bwy
         LBWW5msVfzBvQs/31I1OGkV7Hhbt4eBigX38SGzau5/kzQ5iQfdSLFfGgyO/ByFKBXYq
         ugi8SuTRq6q0jeA7O+DdgTaMeYRuJ5UyLa6up+SR6yI6ZkoUpRzob0DlP95ANFPR28tu
         LneNS+S+ArcIz3fdD847WPEg9+uxXj+IW83q+eeUJuYoQsDhKEutgtqi+w/JnehX5ofq
         lFAg0kXNl9/vbgspixVvfQv5GK/pnozkdllyJyKXLMkrmCU3/eJZkhKClTop/hk3AJFm
         exUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773174262; x=1773779062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8TGyObaOA+0rXaSG+XOwiWbo5MYOrwO/NaEY5gkjsyg=;
        b=b9XUVPNAb3TlxQTMXSa2k6W7br1iA6iCURV0gPB7cYl/2IGFppWRKcUEPmkm5lYlQB
         noTBSytH8QEAoLiKSmMrS/gBVzaEQQABPuRoGuJuNXWhUA/hf1UC9H3lHjzFDMv4DN0c
         mf0oMXOOfatAtoR+/IHKjdRY73AFT66og3qeYRYi6dGYdKlLpwaUZ72R5XMbnahWx4sm
         LrcuxJ0HbQWo8CIf2pYAhvfo79yNsWMe3iBnkE78jnfRbfzgaoBYhIpNCBabD7kTVKpu
         4QbYI4e5Aq0putq1s0Rhxkm6pQfNdHeKTyv0x/0yWd1GKqkticqvWgLde2dPChWWsx6V
         W8lg==
X-Forwarded-Encrypted: i=1; AJvYcCVlfWNdax8uq3f+CoZdAtaT5+gyb31pi0amsz8Zk6uANfDelKK1BmOYYvFmZ9of5dguGp3S3qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaSCviyTDw2TVkLNBnBSPtPDvDKMlATJeFjnbTDEjBOD69WFXo
	Hw9xwjQc0AOzqLvk/AJiSDnpYobmQK0FEU0qfTrU3G3LFqD2oKnn64VcVE14J/UDERz03MaSZj7
	GAKyQiBuBlQbeAXc4OxWq3D8+9OjpxYLWfiJxubZGVaYgkrnI0YSa3kHeiQ==
X-Gm-Gg: ATEYQzxRt5xPGtCxbUlQWgcjxmGcmrU9hjGzoI9jj9BVR8Eu8KAeSZ9ytk8ri4pCPVo
	/Hia/AhGgHYl0zPaDoh2mS5z8tHu48UXf42hpvweFFntiVhJFpExOvo8lFKEpeTH96HaSpCWJ9t
	B95PBVNaDe9lhnKXeq1xTjLfK/tq6CHNOEot7+Vg4UEppXghGKo4Zxm5TlzYBdUoKb3EU9HG1Q7
	D9aRsc7MBmp1fIGmpZhpjzHrJlDh9GdlUdMqfxnnPDSnpg/Z4C0sU8+U5NPjGRunxPrJkkhfidX
	Ky1AHKavrwoaEFyshJ/K5gXzZ6WcY9gv3JyOlffh2LiCgq3Vx/3hRD4dFuY8kVU1XXoC97HogBo
	wdaMnZHQa3ZGJtXjO8JkBzhjDicTfAydeE4AfAVyB5RrXNK6PNXvRLMvG/gttJwtkGJdAkRrwUa
	eC9b7oQXwznzjTTEJtaxBSE9NA/hI=
X-Received: by 2002:a05:600c:1d16:b0:483:1403:c47f with SMTP id 5b1f17b1804b1-4854b0a6fcamr2153825e9.6.1773174261640;
        Tue, 10 Mar 2026 13:24:21 -0700 (PDT)
X-Received: by 2002:a05:600c:1d16:b0:483:1403:c47f with SMTP id 5b1f17b1804b1-4854b0a6fcamr2153445e9.6.1773174261198;
        Tue, 10 Mar 2026 13:24:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0cc00asm1231095e9.7.2026.03.10.13.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:24:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	xinyang@anthropic.com,
	stable@vger.kernel.org
Subject: [PATCH 2/5] KVM: SVM: check validity of VMCB when returning from SMM
Date: Tue, 10 Mar 2026 21:24:11 +0100
Message-ID: <20260310202414.406078-3-pbonzini@redhat.com>
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
X-Rspamd-Queue-Id: 01E04257D9C
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
	TAGGED_FROM(0.00)[bounces-224572-lists,stable=lfdr.de];
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

The VMCB12 is stored in guest memory and can be mangled while in SMM; it
is then reloaded by svm_leave_smm(), but it is not checked again for
validity.

Move the check code out of vmx_set_nested_state()
(the other "not a VMLAUNCH/VMRESUME" path that emulates a nested vmentry)
and reuse it in svm_leave_smm().

Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 12 ++++++++++--
 arch/x86/kvm/svm/svm.c    |  4 ++++
 arch/x86/kvm/svm/svm.h    |  1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 7b61124051a7..de9906adb73b 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -419,6 +419,15 @@ static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu)
 	return __nested_vmcb_check_controls(vcpu, ctl);
 }
 
+int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
+{
+	if (!nested_vmcb_check_save(vcpu) ||
+	    !nested_vmcb_check_controls(vcpu))
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * If a feature is not advertised to L1, clear the corresponding vmcb12
  * intercept.
@@ -1034,8 +1043,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	nested_copy_vmcb_control_to_cache(svm, &vmcb12->control);
 	nested_copy_vmcb_save_to_cache(svm, &vmcb12->save);
 
-	if (!nested_vmcb_check_save(vcpu) ||
-	    !nested_vmcb_check_controls(vcpu)) {
+	if (nested_svm_check_cached_vmcb12(vcpu) < 0) {
 		vmcb12->control.exit_code    = SVM_EXIT_ERR;
 		vmcb12->control.exit_info_1  = 0;
 		vmcb12->control.exit_info_2  = 0;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 477fda63653b..95495048902c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4890,6 +4890,10 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 	vmcb12 = map.hva;
 	nested_copy_vmcb_control_to_cache(svm, &vmcb12->control);
 	nested_copy_vmcb_save_to_cache(svm, &vmcb12->save);
+
+	if (nested_svm_check_cached_vmcb12(vcpu) < 0)
+		goto unmap_save;
+
 	ret = enter_svm_guest_mode(vcpu, smram64->svm_guest_vmcb_gpa, vmcb12, false);
 
 	if (ret)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index ebd7b36b1ceb..6942e6b0eda6 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -797,6 +797,7 @@ static inline int nested_svm_simple_vmexit(struct vcpu_svm *svm, u32 exit_code)
 
 int nested_svm_exit_handled(struct vcpu_svm *svm);
 int nested_svm_check_permissions(struct kvm_vcpu *vcpu);
+int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu);
 int nested_svm_check_exception(struct vcpu_svm *svm, unsigned nr,
 			       bool has_error_code, u32 error_code);
 int nested_svm_exit_special(struct vcpu_svm *svm);
-- 
2.53.0


