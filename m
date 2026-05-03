Return-Path: <stable+bounces-242818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBuAFGur92mUkgIAu9opvQ
	(envelope-from <stable+bounces-242818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 22:09:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB5B4B7366
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 22:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2359C3003354
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 20:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1526387378;
	Sun,  3 May 2026 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1qXc8xX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jf+5DocZ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8659B2C0294
	for <stable@vger.kernel.org>; Sun,  3 May 2026 20:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777838952; cv=none; b=uVADFupOGqj8PY5n8XkF3zDnVloFjJcnRKfXahKmzmZ0fBzZtIK0SSgpGv8TPG1RYuK9h3r6P+X95V7QipPig2UAbIvzZIVeguBmE8fTha6EFSl1u6eoTjYOlRB8KDIP/hQHZW/wNBRjMvYZq1n9m9LVDi/0Cl0iiEJCrQuP5+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777838952; c=relaxed/simple;
	bh=oOi3H+m0S3nG3y+tRC2W4XyeP4p8ekL5EgzM1Dix+vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ti5zKwpFLAnqiqgPA/2KdVmnZqXprWuGqt9xjW5c1Rvrumt1ZcelB5OezOrqeMdWc/0QiXOB4Nh5pLxOttBJTJGLoIX0yurtY7IV2EH930mMdwq4SoI68KUCCyMuijVHPyN22kALf4QgP2tbUfLo5bvRtw29Xv/n4z1RK6f8haw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1qXc8xX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jf+5DocZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777838949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2r5G2c1iaCHwo5jhUQua5IUe/K7Qy+faxKLRNRyePd4=;
	b=d1qXc8xXVPgpQwAHJQdt6Fc70UYdXzAHGysMKJs8Lp7TrUnvSO1y8IwXEcWa4WrTp68eTC
	0ye2BE3TuIXAL3rBodHnjWdOC08yur3lwJLUotRBrop40zWk6Wyzvc4ubVBW0OtzkXFfpB
	uV+TllAow5wNdRw/GMOwsa70kazUfeo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-tcE-qQzvOeatLDdLHMWo_g-1; Sun, 03 May 2026 16:09:08 -0400
X-MC-Unique: tcE-qQzvOeatLDdLHMWo_g-1
X-Mimecast-MFC-AGG-ID: tcE-qQzvOeatLDdLHMWo_g_1777838947
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4891f97aef0so20684585e9.2
        for <stable@vger.kernel.org>; Sun, 03 May 2026 13:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777838947; x=1778443747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2r5G2c1iaCHwo5jhUQua5IUe/K7Qy+faxKLRNRyePd4=;
        b=Jf+5DocZBKir2W67Mx4kvwn4uUheFsan1OOJ0Z4c6CKUYYRLNMC3O7vXgkamyXoQht
         Mj+36oi4gkaUpe1vy9yaPKCmZOBZFiEpfimeBoX8Jgk8tk0+THNBOSb5nO14ezL/xZ9f
         w5VQjHtIJuVM6Aky+B7SrVZd+TxRvkvEvqxd8Taf8cbL0aQF/k5lCqjhvEtGyP1+zdb1
         dUGaQgVS59g3gEIHFhiOBWE66QPOLa9qGwF8EhrwwpfKrYsmfLcoAvr1/PlUit4pERK7
         FW1lDKdVb6DV7ACPqglRo8LjC7aM5YqYe5y4MK+V5l0hck3iA+HcRoYRheUPyp+GIOuL
         lZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777838947; x=1778443747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2r5G2c1iaCHwo5jhUQua5IUe/K7Qy+faxKLRNRyePd4=;
        b=D5nQaH/WJJn8mNeesSXuDuDbMRyA3cIxXp5h3z6HcASpzpWFaWcm+uHH3RMqR2gAfm
         5KrGqUcKEYVlRjTA+0Wl0M+XRODuKD8je0WnBse7VXLYtM3RZSj6CKg8taqmlFo0UcJa
         IT4Q0Zsh8aSz0n6xV8roiU/0FWm1SY1QFc8PLbq6AAnyI4/aSOg/aqasg1Hwwqvqhpvm
         t44QZP98YuEnr+TKvU+klqa+g2Zj8VGA9WQHqEUReXOPKeaW4uIZt9RboV4HWO1hcbNp
         xl6zGvGZSCo05ha4kWi1FcAkHYBEBCqIQvuHxeh20v6HrxWmgy4d7Gnm6N/1DjmCBWqf
         I5fQ==
X-Gm-Message-State: AOJu0Ywd06wAmpS9ygpQIFUqvEQew4NAfWfOzQ/rmWA6+GLnhBRXdalE
	yMjYwgMJl4Wq3PvBMM7KYrqFMNNgm9/AWHk3d+Ctxt/id31Aig9R8WyPWfUUC6WLUe4OC+6TzVp
	T6GA4AkVJMy6tP/IujbhElTYSFcuRzSgjaGyYILDc9KS4shKJDPNF6sKKBw==
X-Gm-Gg: AeBDiev1fWDWR7XRvhtKGKhV0Y4bB8V8FWrftIUlXz+X2FvZOgxLla2Sc8hzwKWK5i6
	ifmw3vEk+j7jEmRyzyhZz6ithzpoHPCchbT4WvUYChzjj9ABOzrSuS8uRlbyt3duG8CrvDAySv7
	DRfhU9SnkBWcaj88cLFxMinMsZSuz3O4F0PTUjARFxx49WdSz/A561yIJEQb/Tqmp9DNbwYg3jd
	AxX6wGGqfOY5dZj5YzHdOipRL0W6X99GAIqrG/UTwFCPV/WNdRJd9/Hd/LOsRkbQnar31t51szM
	CgarKB2GL0V3CyXgzOeQOCSQ6Xk19+aFCGJPgCCPw51Rre/0eCl8xw2WYI3TY/EEAWGMPAfbvjB
	yR7YREM7Y7XrdVWbJl3xF5wrmF+Dy7D0lppTcwieM+fdFBfpzqxubs2ODi+Ha3EVFzOoADokSXR
	xHTaIsXtgtueWan8erTNiZDjyBXQTN7cu6Jic=
X-Received: by 2002:a05:600c:348a:b0:488:c744:49b with SMTP id 5b1f17b1804b1-48a98637f79mr114920685e9.7.1777838947136;
        Sun, 03 May 2026 13:09:07 -0700 (PDT)
X-Received: by 2002:a05:600c:348a:b0:488:c744:49b with SMTP id 5b1f17b1804b1-48a98637f79mr114920505e9.7.1777838946767;
        Sun, 03 May 2026 13:09:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fef2a67sm86407655e9.5.2026.05.03.13.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 13:09:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: stable@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH] KVM: x86: check for nEPT/nNPT in slow flush hypercalls
Date: Sun,  3 May 2026 22:09:05 +0200
Message-ID: <20260503200905.106077-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DBB5B4B7366
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-242818-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Checking is_guest_mode(vcpu) is incorrect, because translate_nested_gpa()
is only valid if an L2 guest is running *with nested EPT/NPT enabled*.
Instead use the same condition as translate_nested_gpa() itself.

Cc: stable@vger.kernel.org
Reviewed-by: Sean Christopherson <seanjc@google.com>
Fixed: 3e300570b42a ("KVM: x86: check for nEPT/nNPT in slow flush hypercalls", 2026-05-03)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 9b140bbdc1d8..4438ecac9a89 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2040,7 +2040,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 * flush).  Translate the address here so the memory can be uniformly
 	 * read with kvm_read_guest().
 	 */
-	if (!hc->fast && is_guest_mode(vcpu)) {
+	if (!hc->fast && mmu_is_nested(vcpu)) {
 		hc->ingpa = translate_nested_gpa(vcpu, hc->ingpa, 0, NULL);
 		if (unlikely(hc->ingpa == INVALID_GPA))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
-- 
2.54.0


