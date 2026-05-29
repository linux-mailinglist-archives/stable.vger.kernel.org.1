Return-Path: <stable+bounces-256721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKZOGu3eGWpmzggAu9opvQ
	(envelope-from <stable+bounces-256721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:46:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AD8607775
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9AAE304AB0B
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F152A44DB64;
	Fri, 29 May 2026 18:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXGGkklJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/qGFlu/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FF744CAC2
	for <stable@vger.kernel.org>; Fri, 29 May 2026 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079801; cv=none; b=nH18hhp7LmQxC+vjNFXZB/UJJvBm9L6bj1F/mxhGIq7Zc0tnI7YNLDq5clwX16sOzW+KOEl4hVn9N3Hx77qcHVMou/qv6HPAafA3l84iKjhnlyzdDSig4v1C6J9Ig4Fow/ODHcOr/tmq4kyQJQE9GAeqYh2+Jo7o8B4Pe41Ravk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079801; c=relaxed/simple;
	bh=HFan/JApmEWnmTSuXMk9cfG+lv/KHWfT+K+r0sq3rN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMViu1q0bg2TOZcKBUEOgH61QHKe12RnXqBxjH4d+puZRv9Iz+6bFcbqPXxgkqggROmGGv/3gKho83rjgTHh2Ftc69Wd64EFoDluuClkJj06O1HYrhRRW3+35HgXK6CMMeXMQYqGiBtfHl7f8WxbAV265HJ5ZsDs0zv+fJP4Vtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXGGkklJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/qGFlu/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JgVglsrid7Bemu25RQaHLDDenSgALocYZBi9heN+Y3M=;
	b=WXGGkklJacmAJy7kaqkoU72tx8MiHf57WEkuCiLyvDBupys6JyS9Rna2A+ewyttHN8ZGZK
	tHXlDM1tdFoNiS7tcHCk9EGgmTIQsbKvZXEilKUGqlqt5k29MbTnZPr43Em1i4s2+FylPf
	MwYOXRmwCjZZ/jgzzU35hTEcFOCu1+4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-vHoG8w9uPrazrt_UhCF1BA-1; Fri, 29 May 2026 14:36:35 -0400
X-MC-Unique: vHoG8w9uPrazrt_UhCF1BA-1
X-Mimecast-MFC-AGG-ID: vHoG8w9uPrazrt_UhCF1BA_1780079794
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ea38c03a1so7665832f8f.1
        for <stable@vger.kernel.org>; Fri, 29 May 2026 11:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079794; x=1780684594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgVglsrid7Bemu25RQaHLDDenSgALocYZBi9heN+Y3M=;
        b=U/qGFlu/GNXkfTSuhY7P6KYkCDcvglHTPmhF5Z3ANAfSCTfVL+gP4Lh4Kyx7bAReM9
         ElLpHWc+4f7Ghsda6UFXFa3IV2gnotG7EnDNXtTD0BGc7umwjZbGEBOdMKGrx84UvMv3
         tb3QrOSb8VndAGitzUcwnYbW5xWXHt54uwRcWh+WFdPeFxJs2+AwEOTPLABZipSOgOc+
         AjT+tBk2SJf7/7GsHSu+RZHcsHuNIhSFxeDTnfIpRdRGiRF6RjcaTwYdcXRsUzdC4TbI
         kKPAjabXrQg7IEcC9dVjCkPuEehysplSQrmOy33KJRr+H1yPQEiO5UND/TPl8aovp0FM
         9wIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079794; x=1780684594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JgVglsrid7Bemu25RQaHLDDenSgALocYZBi9heN+Y3M=;
        b=XmWVI1RaCOUXnQOGtR3KWKKzZVL/s6A4OSy+cqaGnHLb13CYPVO0CvxZzjGl9/INFE
         T0poe+jPAyVUCdexmV+p/LtweSJ4qPa6LrD8XDvJDYN5rQzmaFX2SVTZyO/yornSjdbv
         OUsN5fB0dm9M4eIFepNsqW6XdUCQQeMR8PxRb3+6ZYRuZVO/6QS47LluZrR706u/9h2f
         kWALgdfutXC8YbQ9dzTmKPN93C2dL6Jhwide+gCmuK/HGnf1i+PnUAX2yZSsvE9kEusS
         sggsFpzXWQc2mNqBT/bdmXFymz28lyXnz1AZBn6zB6Z6tyLsV/aIEUYk126ehCortwx8
         Qlsw==
X-Forwarded-Encrypted: i=1; AFNElJ+Qu8rGe4oGxSUv+8ed41xqVpnRrLEgmZUnWvhJRl+yfB5ZkagNSZhMpToDLRURfOUTKpjO7oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbISVrWaa8nnF/T+GXDRY13zvPeSzUKq6/ocMfJ24WVwExIfZR
	JrRE6li8SHmdfn+FxnNwcq5iIiI8GR5WK1hsqEO35qGtJGJ8rmpc42kEDoXIQpeRMqnf3jxte+D
	EruSj4+1Wycr3NzjPttml87B5YVMt5YK7b6ITtLT43RQVkIiK6io8J0n9e+V6l06ChA==
X-Gm-Gg: Acq92OHoNMaH7xCUDhmJBtaByNbi6hMZ5DmafjBYCAdPhFeu4+RfRrXQ+hxRX4SPmlm
	tG5U/xKvIvBr8Fv94sfDyyJ6skCHCW0EpxG6wqoITDmAY+5qQBaiHTYlxDDXCodUtuv/NT/LKEj
	AbHwSWkycG/aefK/yvS79zDDW/7wxhhOfFBum5YWWNg3k0wuSmTVg1tUiqrQ+88V0eFsoH6WyIV
	GvOHd4nUEbBq1y4ZZFfYSXun3EPIbWxuWf0/9uVTqRfXCkLeRhW/YenBXcBbYDCg8B/jSZW9cNq
	VQyClNQKJep07ciq1mdbyXHbzNqIlsHUEaOOpEpObWtKDiWB/rdHF4yY67LKB2uZOqNVm1VlFXl
	WooglBz5zxDS7ATt8+C+NdbtiOSa8kDXAwLeNvx2lRdQtB6QhJr/geeoM6iYVs6BTHEEEE/p3rg
	eXoE5SMOjTfH1fU36MyWSR6npBErpH+lUIugD5Sw==
X-Received: by 2002:a05:600c:a111:b0:490:469c:556b with SMTP id 5b1f17b1804b1-490a2933355mr11002565e9.12.1780079793688;
        Fri, 29 May 2026 11:36:33 -0700 (PDT)
X-Received: by 2002:a05:600c:a111:b0:490:469c:556b with SMTP id 5b1f17b1804b1-490a2933355mr11002175e9.12.1780079793305;
        Fri, 29 May 2026 11:36:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c116e2bsm20236265e9.28.2026.05.29.11.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 16/24] KVM: SEV: Decouple the need to sync the GHCB SA from the need to free the SA
Date: Fri, 29 May 2026 20:35:41 +0200
Message-ID: <20260529183549.1104619-17-pbonzini@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-256721-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 16AD8607775
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

Decouple synchronizing the GHCB SA from freeing/unpinning the SA, so that
the free/unpin path can be reused when freeing a vCPU.

Opportunistically add a WARN to harden KVM against stomping over (and thus
leaking) an already-allocated scratch area.

Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-17-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 437282f0ea94..11d46600cbdc 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3560,20 +3560,17 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 	if (!svm->sev_es.ghcb)
 		return;
 
-	if (svm->sev_es.ghcb_sa_free) {
-		/*
-		 * The scratch area lives outside the GHCB, so there is a
-		 * buffer that, depending on the operation performed, may
-		 * need to be synced, then freed.
-		 */
-		if (svm->sev_es.ghcb_sa_sync) {
-			kvm_write_guest(svm->vcpu.kvm,
-					svm->sev_es.sw_scratch,
-					svm->sev_es.ghcb_sa,
-					svm->sev_es.ghcb_sa_len);
-			svm->sev_es.ghcb_sa_sync = false;
-		}
+	/*
+	 * If the scratch area lives outside the GHCB, there's a buffer that,
+	 * depending on the operation performed, may need to be synced.
+	 */
+	if (svm->sev_es.ghcb_sa_sync) {
+		kvm_write_guest(svm->vcpu.kvm, svm->sev_es.sw_scratch,
+				svm->sev_es.ghcb_sa, svm->sev_es.ghcb_sa_len);
+		svm->sev_es.ghcb_sa_sync = false;
+	}
 
+	if (svm->sev_es.ghcb_sa_free) {
 		kvfree(svm->sev_es.ghcb_sa);
 		svm->sev_es.ghcb_sa = NULL;
 		svm->sev_es.ghcb_sa_free = false;
@@ -3685,6 +3682,8 @@ static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 min_len)
 		goto e_scratch;
 	}
 
+	WARN_ON_ONCE(svm->sev_es.ghcb_sa_sync || svm->sev_es.ghcb_sa_free);
+
 	if ((scratch_gpa_beg & PAGE_MASK) == control->ghcb_gpa) {
 		/* Scratch area begins within GHCB */
 		ghcb_scratch_beg = control->ghcb_gpa +
@@ -3706,6 +3705,8 @@ static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 min_len)
 		scratch_va = (void *)svm->sev_es.ghcb;
 		scratch_va += (scratch_gpa_beg - control->ghcb_gpa);
 
+		svm->sev_es.ghcb_sa_sync = false;
+		svm->sev_es.ghcb_sa_free = false;
 		svm->sev_es.ghcb_sa_len = ghcb_scratch_end - scratch_gpa_beg;
 	} else {
 		/* GHCB v2 requires the scratch area to be within the GHCB. */
-- 
2.54.0


