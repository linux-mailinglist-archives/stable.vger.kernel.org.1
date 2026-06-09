Return-Path: <stable+bounces-262338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RfpVFFlCKGrLBAMAu9opvQ
	(envelope-from <stable+bounces-262338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 18:42:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA1A662847
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 18:42:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=k5xAJzkf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262338-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262338-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 095A430D871A
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 16:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6613F65EB;
	Tue,  9 Jun 2026 16:32:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB803B3C17
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 16:31:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022720; cv=none; b=ptXcz2Tlrycb6qK7Ig761pQumwYMAtGBuh7DVNG5iYR/vETd+GJ3YRCavZCSb15zDwSzpMGMwQbY6rC9WBpdyrL2zMig1WWwjUBdmYbefv0g57CTXNyk/vTu6bwCXK/SPIDDE7wB73Pj/p9j4SPqFRSUw0qCVPCGNsKHNVifOzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022720; c=relaxed/simple;
	bh=uFMk1jZpsqtQJeUv2lUeILt3cXF07gHRUuncT5eLn3E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hh6lEUMiR9TKjZxnvUrz6LTlq8x92IZ4jMmOw547EjHQENLlYFne4A/k2y5lbySI6r60Yur+DfUuoh9MOypip3nq7aISsSRo90MMc8irFrzF7KX+zOocL/EC/JrdvupIsarmdfoQLqfGYQ/RK10LVRTsrr4sFFMbWEh+NCZOwus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k5xAJzkf; arc=none smtp.client-ip=209.85.214.202
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c3315d31so62376715ad.3
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781022719; x=1781627519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1iK2GP3Rc5BEFQ81jZvOlP6jemB19dD+1/HetcsN7sU=;
        b=k5xAJzkfARY5ZNOj73G4aCzuaj0FCK8kgabwDI3HQoQU/YodxJU4SkAAMiLeCZPM6u
         z7Bwu9tG/QSAIYL/JBzU2dfIBjiten8hlF05Pc9zyUX91/6IlZqsXJEuGMHlAEIPuUJm
         aZBxtYG6JT1VJUbwodE1K04dDnoca5GFMQuArz4f43pkYR8iE1rEmgtmGYAkXzaiBoeW
         SQW/UvVT0eQGoWHxEUSszC2/WBuMIfWa6yFUBhfR/NwQtdoQb12gG2XWqJLAlviTCMzr
         MAzOPkiH4Iz5wJ9jzu4j5aa2Gqw4qtWDup0JL3Qy+4YsAoJNsdY1VOhddRqqJd9XpntA
         hP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022719; x=1781627519;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1iK2GP3Rc5BEFQ81jZvOlP6jemB19dD+1/HetcsN7sU=;
        b=Up08bJFDFLrlyQb0nxPkkawMccTN+0DMUrHfx2Ck3mgDgoOKrxPjUHnlsJ+tQy7J/m
         O6hX0fhYN35vn59UJI+EL9trVFby78fbEfyGtm4Ik89sxCCdjfyiNKDIE7SECPesw7vm
         c4zw9fzm9qR5ePiyCVZMlguUsYfT7j9Es9Z0y0/lOaS1Ye1QFQqF4Mdg3zynTdrdr2fp
         t9Ob/rHvnTuOpoD5zQtKD3keci8VtRXTnbnZXwP58OQMbWDXo7ghgiK5ZryZO2yGzCA7
         2TY/XpECjhLr4uC0vZcyMidNdcEKrZ/joeXNaOVPmoPEJeCrmRwPHJpBaxhPuhie50pL
         1Kiw==
X-Forwarded-Encrypted: i=1; AFNElJ+Kj/MluTLmr/aDt23yO+0l1oztyI5JOnKnbBqEORHDeqOyaYap3MGRm3MGlhNzPPrGAk++mTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YywYs+4VMiJ7I3otO7aGyJrsL9acHGw8TyZ+BcQAesUpPMoJeJV
	XvLfb9UQO7LgH5EoHCNy6r4XmoDgz2qLTBNOd45QkB0MEp7wODUH+gmpGKAvKixjNa9moOE8vUI
	4OWGsIg==
X-Received: from plcq4.prod.google.com ([2002:a17:902:e304:b0:2bf:2cd5:1d4a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecc8:b0:2c0:d097:51ba
 with SMTP id d9443c01a7336-2c1e810bd08mr256584395ad.26.1781022718467; Tue, 09
 Jun 2026 09:31:58 -0700 (PDT)
Date: Tue,  9 Jun 2026 09:31:32 -0700
In-Reply-To: <aiQyZIJtO-2Aj_xN@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aiQyZIJtO-2Aj_xN@v4bel>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <178102220971.2734517.14635903505526070729.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: hyper-v: Bound the bank index in hv_is_vp_in_sparse_set()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, vkuznets@redhat.com, pbonzini@redhat.com, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, Hyunwoo Kim <imv4bel@gmail.com>
Cc: kvm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:vkuznets@redhat.com,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:imv4bel@gmail.com,m:kvm@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[google.com,redhat.com,kernel.org,alien8.de,linux.intel.com,zytor.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262338-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BCA1A662847

On Sat, 06 Jun 2026 23:44:52 +0900, Hyunwoo Kim wrote:
> hv_is_vp_in_sparse_set() uses valid_bit_nr, i.e. vp_id divided by
> HV_VCPUS_PER_SPARSE_BANK, as the test_bit() index into
> valid_bank_mask. valid_bank_mask is a single u64 and a sparse vCPU
> set holds at most HV_MAX_SPARSE_VCPU_BANKS banks, so valid_bit_nr
> must be less than HV_MAX_SPARSE_VCPU_BANKS.
> 
> The caller in kvm_hv_send_ipi_to_many() passes kvm_hv_get_vpindex(),
> which is below KVM_MAX_VCPUS and therefore always within that bound.
> The L2 direct flush branch in kvm_hv_flush_tlb(), however, passes
> hv_v->nested.vp_id, copied verbatim from the enlightened VMCS
> without any bounds check, so valid_bit_nr can reach
> HV_MAX_SPARSE_VCPU_BANKS or more and test_bit() then reads beyond
> valid_bank_mask.
> 
> [...]

Applied to kvm-x86 misc, with a heavily massaged changelog and a KASAN
splat.  I also added a 

  BUILD_BUG_ON(BITS_PER_TYPE(valid_bank_mask) != HV_MAX_SPARSE_VCPU_BANKS);

to ensure we don't re-introduce the bug if HV_MAX_SPARSE_VCPU_BANKS ever
grows beyond 64.

Thanks!

[1/1] KVM: x86: hyper-v: Bound the bank index in hv_is_vp_in_sparse_set()
      https://github.com/kvm-x86/linux/commit/4721f8160f17

--
https://github.com/kvm-x86/linux/tree/next

