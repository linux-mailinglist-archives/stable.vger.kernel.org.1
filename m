Return-Path: <stable+bounces-256711-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNhtCvrdGWo4zggAu9opvQ
	(envelope-from <stable+bounces-256711-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:42:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AF760769D
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C37783003EAC
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D02403E8C;
	Fri, 29 May 2026 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKhe30fD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Odrs88SN"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1CA425CF7
	for <stable@vger.kernel.org>; Fri, 29 May 2026 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079766; cv=none; b=UJQUVLbv5dOUTSy2TBtXMBRxKti65xfXiI7BiMPLwR+T/FypxxEupNWHe7FscUKUWULTZEzveVv00RBJGx6mCvdcBR0+tzJlNA+FpdNV0HHyJoL0/d99ZuSGPI/hiwkTfniUmKr4Koov2o0MzMTwc5+goJhVErQ0Gj8p+CofYkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079766; c=relaxed/simple;
	bh=6zMHgUTz910HkRMjPhK2mmo0fhUkyV7gKB3rHBzUOyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elnMe9FoUO8P22Bv3PIy0X5aImDRleiqu2AeSjFmmFA/IXMeEyvcXVNbmD1gpnksKG02Wat77Tl8qBe7OLMpWfvBjtTxjYkd8QIAufXWoaIqCrw1eQvg5D3jidygXBQZX6PHwFRZGqvFyNxNThv8utH1tm8T+b6IM+qfCvAeiz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KKhe30fD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Odrs88SN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLsVryKtB+qjzmc5R5Imnpvup6JXosbAAkLD7ck1kGs=;
	b=KKhe30fDkcLH43ypUdQEMdph1D8OzXkjZ821+Zz7EBeRS1fJmxbXL2bQxai2LPrIXZXFLU
	m01OkeXZY9SnrB1WGE/llaZU7a/WUmQbeBCro2uuo76wwczwnpzXhTzzd3Vs8S1R31AcRt
	/LYBMXG9g/LAkpm2JOW+l17R8bUWRF8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-LNd4kRDBP8yg1GE6QBiA9w-1; Fri, 29 May 2026 14:35:58 -0400
X-MC-Unique: LNd4kRDBP8yg1GE6QBiA9w-1
X-Mimecast-MFC-AGG-ID: LNd4kRDBP8yg1GE6QBiA9w_1780079757
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45eee3f9f03so1507372f8f.1
        for <stable@vger.kernel.org>; Fri, 29 May 2026 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079757; x=1780684557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLsVryKtB+qjzmc5R5Imnpvup6JXosbAAkLD7ck1kGs=;
        b=Odrs88SNfevg2mv2ZMTP9n9aCtXvxx8mnFL/YAU/q6DwX3A8bf88LwDAgfWEtQwIlv
         /Tu3QzO4eelmRw8nIf5NdE7CYOposgPLmI3UctrLiGylsI/BG9MMAc6ynLIikYuG+Zk/
         e9P+2aWpWJq4fITpeaOEE0NAyI750CgbOitfJOGPvfoA0iph8CrVuZDyBJ0Ttbg/ozTJ
         6nF9RcdBS90EyKyVsriaoN9vpa2K3wNQJdDrCN4P5PuE5N0cHN4TQTGiOendv7AdzjLX
         5stkpe6vWIuvT0dRwh4X+Km87e2Tysi+PXcePPxtGVlItS1j+0i9wG32F6Il2UKvQoG9
         nn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079757; x=1780684557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TLsVryKtB+qjzmc5R5Imnpvup6JXosbAAkLD7ck1kGs=;
        b=U1/bHeZIVtq24gB3/Z8CZbcATZ6TjZ3DupitRs+nNMZC17aDodIxHSjBVmIRsqM/bW
         27la70mLdgqg8rU7vf+4Z4WgIAA58Qw9EDN6w7rX1i/w5uqO/ET9EkXZwkBv5y3VkMc0
         xfArwfDyhlTTfEdonJdYPbtSaJ8ZSpaM1/y2wnXit2epfKT6wKs5h9CrQdOnNgk6W3nA
         yeKGghu21LtLjy11juPy7qgEhLz4VRNSSYbgUfi7nAVJl82kXWt28tnsfoSmZT2sXbwP
         0PLA0Gs6iJyjDsOAR8oKvlP+ufAGONvnqlS3Coa0wx2H2NHY3JqrsWyECOgBP3D+kTse
         cQEA==
X-Forwarded-Encrypted: i=1; AFNElJ+4XxxVjtYrdw2iRa0iXDyw/AWHalHI1iTAqNlHIYJq7qAd0SUdJEIoE0BZ4I+MCABr9Qve/ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/zgPqDYmaDBGVqFzWI0I1CpUgvEVJJDGH/XB9XiSE8RJ6KEFz
	MCNhR1+Ba4lvMmVyngTs3mMtEeiNFd4X4FRhr11SP+i+cntTXMX5y93Gt8wVU+f+ckUsNNghcto
	HHkFF+gS1zYl7Ksm/mbtvH6Wf4xDLHp6zLYv7BEIkgJE39dum5cSoPogN1w==
X-Gm-Gg: Acq92OE+gOgCSUqDYSkKLQviqFn36fzbvzi4NCJ4NO/Eo2CQMHMtFfqsbnGBcZtb+7P
	7UJ0x+8std/SMp5OhEwbM19Ew8xluaIv8tJT78Ra+b9VV0i+DiO436Rqr+J63WksCZXT+4z++FT
	sXkSLU3yzJwh5ceainrPZ1DkmRlkp+yaWc/eYTjIFYJ4PAk5Wg8USpqfQw6wWlVgk0k91mSwDxU
	FP2qcyfJyeJwaEXqeMas5G/fiQjveQcHfFjizgPcEJfkOPpqm0Y433+ljrr1thfm++BmrcnmhyL
	Cg4IJ9735/beOh2Dqfy3Hmj2v1G8OEfBroMopNfW4Uuly5A/3dp7E1aOALE3XOvEw17M29ko4h7
	OvwXmJPeAkW0vnnbOcAmxI0lB0el1Oj1daVJLZVQ0u/ZzmovHJ2d2yJ6Dg55JBExMPXH6v0eVEq
	6v/0Y9TavOECfb+rvENebSz9y0IAk+TQzrgFan+A==
X-Received: by 2002:adf:fe90:0:b0:45e:ee20:b897 with SMTP id ffacd0b85a97d-45ef6aeccb9mr1198548f8f.6.1780079757119;
        Fri, 29 May 2026 11:35:57 -0700 (PDT)
X-Received: by 2002:adf:fe90:0:b0:45e:ee20:b897 with SMTP id ffacd0b85a97d-45ef6aeccb9mr1198515f8f.6.1780079756760;
        Fri, 29 May 2026 11:35:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354b7edsm5206450f8f.22.2026.05.29.11.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:35:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 02/24] KVM: SEV: Ignore MMIO requests of length '0'
Date: Fri, 29 May 2026 20:35:27 +0200
Message-ID: <20260529183549.1104619-3-pbonzini@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256711-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 80AF760769D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

Explicitly ignore MMIO requests of length '0', so that setting up the
software scratch area (and other code) doesn't have to worry about
underflowing the length, and to allow for special casing '0' in the
future.

Fixes: 8f423a80d299 ("KVM: SVM: Support MMIO for an SEV-ES guest")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 23170b64f4a3..fb2174b6d1ba 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4497,13 +4497,17 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	case SVM_VMGEXIT_MMIO_READ:
 	case SVM_VMGEXIT_MMIO_WRITE: {
 		bool is_write = control->exit_code == SVM_VMGEXIT_MMIO_WRITE;
+		u64 len = control->exit_info_2;
 
-		ret = setup_vmgexit_scratch(svm, !is_write, control->exit_info_2);
+		if (!len)
+			return 1;
+
+		ret = setup_vmgexit_scratch(svm, !is_write, len);
 		if (ret)
 			break;
 
-		ret = kvm_sev_es_mmio(vcpu, is_write, control->exit_info_1,
-				      control->exit_info_2, svm->sev_es.ghcb_sa);
+		ret = kvm_sev_es_mmio(vcpu, is_write, control->exit_info_1, len,
+				      svm->sev_es.ghcb_sa);
 		break;
 	}
 	case SVM_VMGEXIT_NMI_COMPLETE:
-- 
2.54.0


