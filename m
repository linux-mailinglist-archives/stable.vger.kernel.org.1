Return-Path: <stable+bounces-256713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOrcDkzdGWo4zggAu9opvQ
	(envelope-from <stable+bounces-256713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:39:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E68356075FE
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DF0E309DC90
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AD4436355;
	Fri, 29 May 2026 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCQrC/2q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d14oMkgE"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBD942668E
	for <stable@vger.kernel.org>; Fri, 29 May 2026 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079773; cv=none; b=O6/Y5P6j1pm5GVC0mUFKPeq0IqTQs85ZyfhM5cW1oUZbaaTNS4V2bJj20pGT45yMhdDR1D5QTpqxhiiqbk56UcGVzr/ryHrUUrkle0Uc8/BbJD/ZDdmT7OdQhMueVpiodH5pJ9rmqhHh8S7E5Nkh+/sTDMlGmxDVpcZ6qnCxv/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079773; c=relaxed/simple;
	bh=kCJYzqXTAo2sSN8mAzbW86qeCbAgWhHaLeZkmv0/cPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tivlT+oRN4EXuSRacvYxIZh9BxSG28qzTQq61fbO6p50aTfcO/BwpX98OLjtIoo1ThMp0405NL1xfKWGoJnwm3xDUmcn2mnX51GhL2WWviphUClFAZ9YtUqnw9DxbsoU6VGDMPissftdfjPZFmCINx8RkDSSN/qozwg4bcCrfcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCQrC/2q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d14oMkgE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yqaeQPheI7We5TEAetxbjBel6Xe0oWr5Lp01EOcbc/I=;
	b=XCQrC/2qHDPeAqHnBcgAsSzdBRlwC1DYKa5YJYjGhaQUi5ex2jopO6A8avU1zypsVzYIiT
	kEGFiXAyrcdEqLAzUqh67kf1sBZciymBRJEV7UOFh4WZzEoakrWnUIBuUCriJ+0aYJAfr1
	zhND6odHce7fvgeecONPKB8DEV72EkY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-h0DzcwLwMDanjTMu0LPk_Q-1; Fri, 29 May 2026 14:36:07 -0400
X-MC-Unique: h0DzcwLwMDanjTMu0LPk_Q-1
X-Mimecast-MFC-AGG-ID: h0DzcwLwMDanjTMu0LPk_Q_1780079766
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4909c0f0ba2so7786065e9.3
        for <stable@vger.kernel.org>; Fri, 29 May 2026 11:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079766; x=1780684566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqaeQPheI7We5TEAetxbjBel6Xe0oWr5Lp01EOcbc/I=;
        b=d14oMkgEicC91GzBTA3BJGipjZaVOMh3Zytx7RoIE4UWVkxrHbNaRchzLJ/n53OzgP
         CCsaaw3jxTnJO3eELDpJlFjvx2AHa+wGFz8zac+VyWeeVyTDIEPeGFBwNEguo1tM6evQ
         l3NuBmmzUcpf55dVkIuZvqJfTpoNV0BKkj81C2Hhz9dz1qU8aH3HVwJBsfE69Nvj+Sck
         72RZnIvzkZ+s6lZWUG6ykgPTp2dKxrc5I2tHv0/YNyT/3joWh7DI8RPCph6hw0+WZhCP
         +rEla6Gu9d34WedPSp0yCUwbi8h6PflfmQqAQFh21YQpqk0xJzl9zfjVLX/3VFYZIyJi
         cxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079766; x=1780684566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yqaeQPheI7We5TEAetxbjBel6Xe0oWr5Lp01EOcbc/I=;
        b=etJ8BGMDILXYqw0NR7KxaH74YPpDkydC/9yH9NEA3i/+U+U3rCaO47ImmSg997/uAT
         eqVbGY7aFarcQ4tWdMfEnqeVgh4NEl1ff+qU8wu+yRmme14dbx1XzfcoMZAFqjHBJZZi
         X96p43fDi62Ta4HAVWZQdjjPfV7zMvny/nWMljU8HEJ3mGP3PLRvJQ8Y9Omiepym0iIX
         wPyy+U9KPIqMGe2xLEs1JXOtC/+kyCPrRrNPSMb+Pxpzrw2AUbkxPJXb4PhOmazb8qsz
         km+Gy61qqa20GTu7SuWVxiwuGNzQefD4mjgCh7mebnFFocAJzcS0xpq5QSoXIiokWjnz
         Wwdw==
X-Forwarded-Encrypted: i=1; AFNElJ9X+MHfb7olSu99HOuQKIqOpw9E0M7HCpHlZEYekhT0nXrfHXSFUizHfF8NK+AfoiPDI+T98r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiJmytsn9PANXPPprX/vOXChXwqgXKoUE/QnYGCjKDbMkIDKrd
	VVE0OehFlPhATmy1Y+NeHy6pmkQWgPLmBpkE1NkxtMs8Qjak/WxylA1mIi6meAq+hLKadw2V7Tx
	Mp62zMIcGWZ7Oi0UBz9eMHgYrsGDF7riGlYyc6ukshrKKwoQQfqaUCTnLIA==
X-Gm-Gg: Acq92OE/OwHTHWGky4KjTOC3kgCxOIq7P+cY/5ynlIKr6h21fBRP8cjtfSDmjeRXnYH
	Z1VhQPoJ8o8yLcJ4kdHbX3/aBOl6nbScsrRAWGSdreLayPHCppFXkfI6fP6lbBot/w11VnNdJqj
	uhF+oBWYPqBmxvpZmUPDTsRen9s6CyxqUSFacqCkI72YGNa7OeL4/EpoxCxVmP5IIbKRTr0Oe/u
	LZI9B9Pb8hG04+9taLPw4RX12U6imv3fG9Vp1bP1b+74eZLgLOONZdVp3tTJ7W/4+EmZk5dGirx
	BS96PurGNoHIOudA8coS+iAiuwG1bbolB0s9e4/Th3YVSclf/lIT7tm74LwguTTF9MUsi3yGREb
	MpcStYQNjZ8tpAFxmCIidPF+y4KfyIGVEQdaAfVzzKSqEoVulBnIR3AyUAPyEQQMaN2335G9ewt
	I6E34RezocG1Hm6Aw9jCu13vY7Uj0QhbAKUBko5A==
X-Received: by 2002:a05:600d:6446:10b0:48f:eb8b:997a with SMTP id 5b1f17b1804b1-490a2965784mr10246975e9.31.1780079766147;
        Fri, 29 May 2026 11:36:06 -0700 (PDT)
X-Received: by 2002:a05:600d:6446:10b0:48f:eb8b:997a with SMTP id 5b1f17b1804b1-490a2965784mr10246445e9.31.1780079765370;
        Fri, 29 May 2026 11:36:05 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0a4dc0sm30754325e9.2.2026.05.29.11.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 06/24] KVM: SEV: Compute the correct max length of the in-GHCB scratch area
Date: Fri, 29 May 2026 20:35:31 +0200
Message-ID: <20260529183549.1104619-7-pbonzini@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256713-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: E68356075FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

When setting the length of the GHCB scratch area, and the area is in the
GHCB shared buffer, set the effective length of the scratch area to the max
possible size given the start of the guest-provided pointer, and the end of
the shared buffer.

The code was "fine" when first introduced, as KVM doesn't consult the
length of the buffer when emulating MMIO, because the passed in @len always
specifies the *max* size required.  But for PSC requests, the incoming @len
is just the minimum length (to process the header), and KVM needs to know
the full size of the scratch area to avoid buffer overflows (spoiler alert).

Opportunistically rename @len => @min_len to better reflect its role.

Fixes: 9b54e248d264 ("KVM: SEV: Add support to handle Page State Change VMGEXIT")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-7-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index cbb3040e0778..6072fecfe994 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3662,7 +3662,7 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
 }
 
 #define GHCB_SCRATCH_AREA_LIMIT		(16ULL * PAGE_SIZE)
-static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 len)
+static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 min_len)
 {
 	struct vmcb_control_area *control = &svm->vmcb->control;
 	u64 ghcb_scratch_beg, ghcb_scratch_end;
@@ -3675,10 +3675,10 @@ static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 len)
 		goto e_scratch;
 	}
 
-	scratch_gpa_end = scratch_gpa_beg + len;
+	scratch_gpa_end = scratch_gpa_beg + min_len;
 	if (scratch_gpa_end < scratch_gpa_beg) {
 		pr_err("vmgexit: scratch length (%#llx) not valid for scratch address (%#llx)\n",
-		       len, scratch_gpa_beg);
+		       min_len, scratch_gpa_beg);
 		goto e_scratch;
 	}
 
@@ -3702,6 +3702,8 @@ static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 len)
 
 		scratch_va = (void *)svm->sev_es.ghcb;
 		scratch_va += (scratch_gpa_beg - control->ghcb_gpa);
+
+		svm->sev_es.ghcb_sa_len = ghcb_scratch_end - scratch_gpa_beg;
 	} else {
 		/* GHCB v2 requires the scratch area to be within the GHCB. */
 		if (to_kvm_sev_info(svm->vcpu.kvm)->ghcb_version >= 2)
@@ -3711,16 +3713,16 @@ static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 len)
 		 * The guest memory must be read into a kernel buffer, so
 		 * limit the size
 		 */
-		if (len > GHCB_SCRATCH_AREA_LIMIT) {
+		if (min_len > GHCB_SCRATCH_AREA_LIMIT) {
 			pr_err("vmgexit: scratch area exceeds KVM limits (%#llx requested, %#llx limit)\n",
-			       len, GHCB_SCRATCH_AREA_LIMIT);
+			       min_len, GHCB_SCRATCH_AREA_LIMIT);
 			goto e_scratch;
 		}
-		scratch_va = kvzalloc(len, GFP_KERNEL_ACCOUNT);
+		scratch_va = kvzalloc(min_len, GFP_KERNEL_ACCOUNT);
 		if (!scratch_va)
 			return -ENOMEM;
 
-		if (kvm_read_guest(svm->vcpu.kvm, scratch_gpa_beg, scratch_va, len)) {
+		if (kvm_read_guest(svm->vcpu.kvm, scratch_gpa_beg, scratch_va, min_len)) {
 			/* Unable to copy scratch area from guest */
 			pr_err("vmgexit: kvm_read_guest for scratch area failed\n");
 
@@ -3736,11 +3738,10 @@ static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 len)
 		 */
 		svm->sev_es.ghcb_sa_sync = sync;
 		svm->sev_es.ghcb_sa_free = true;
+		svm->sev_es.ghcb_sa_len = min_len;
 	}
 
 	svm->sev_es.ghcb_sa = scratch_va;
-	svm->sev_es.ghcb_sa_len = len;
-
 	return 0;
 
 e_scratch:
-- 
2.54.0


