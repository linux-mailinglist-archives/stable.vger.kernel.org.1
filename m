Return-Path: <stable+bounces-243925-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UH7SE20h+Wmz5wIAu9opvQ
	(envelope-from <stable+bounces-243925-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 00:45:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F02964C4865
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 00:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00A30305431E
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 22:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F2E388E76;
	Mon,  4 May 2026 22:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TVj5872W"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C614C3890E0
	for <stable@vger.kernel.org>; Mon,  4 May 2026 22:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934561; cv=none; b=V6gOmMJCwqtsK78DN1Bf+USIWHcdFL/6ygRSTCKagPst05IHAsdMYgpdejxpx4w+aUWyP1kIps0bjdPyeg9/+zkNlD4TelwHUGQGn2mLVnx+7ZfjwmZW5HYVLvIpLmXRuZjsm139qCLLWUxp36p1SpetvPYA49j+AKlxOc3MkNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934561; c=relaxed/simple;
	bh=/1xQMlHTpDPPKdx9q0rSMVLO6gl3M86K+ccnqA5gdNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bD5MDHSe3CqSaHIYoUXTHGBlNPgMTaGcF9ohmECoi2YwJe4t6jKypG/A81PhzpvF+9S4jxLtutIgLUyalx02P5Q7R9GVGVxU5qwQwSwd+PD7fL6yX7QGeKtT3yAgHeMg4x6/3h9fgFOyrtv+Ig9tDQj1Ts+Eafm49JXVYg501cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TVj5872W; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35fc22424d9so11316406a91.2
        for <stable@vger.kernel.org>; Mon, 04 May 2026 15:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777934559; x=1778539359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ua9DP8bxNVeP3OMgw66O02tdFbDSKg07QfaNr/ggdeQ=;
        b=TVj5872WcGbO5rkLygx+jdlTxLbs57qu3ge1RP8rRNjL09FJ1iCy1SRhb9gnfzMrzt
         bLLldOz6G3IFUpweOt/4QDTrU1V0LjluE3InA5sYuXSurrBpuo7ucviKjuVbzSfe7Yyj
         /srHsjmgOp4TLiunQBvEBBsX3DGMp5LgwKVxcJnpR0qHlpdCGlb8y5QSkPVKIqSPMb5H
         cGC/YPkxmWAkLs2axHIWk2t3nwB4kOygde++rosnAUlbgD72FYNTBw9cx5ktpRzRwJ7q
         ikIcf4QduCrz2zrDUUnXqUH688hsUzH6xb3QjgujRW33tlHXA6dPzYUjxvw+k6T/j43B
         kXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777934559; x=1778539359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ua9DP8bxNVeP3OMgw66O02tdFbDSKg07QfaNr/ggdeQ=;
        b=qWrxXmeF/LCTpbNzdmw7RMa7InDM7exG7obkfDjNYquKRUWaJVFrOkynA3wHAuP4To
         NKCPM1MEJbhpowJ3Rp6LeYBLbF6joEdwEGYUFSb7jhFtI3WTXu6pO25dJaJJJvhfO7XX
         3ECn2EsH5Ar1AGX9SbkVDgmRAXSezhXQMU+N8jaYGgRIzKQcOmgLGujbwZ/+GYRfXPxS
         s6Md5m+RsPtc4FD9lVsOabC6VVld6rpY5EDMptUVJsJeBg1CMsLNeZmBOcye79NSzF7U
         iFuNiyFv57rJGU3g052EvV7AXqxE8XbMFjaLSunVC+l81n6TS8Eg+EE2z55QlJkyAIiG
         rU6Q==
X-Forwarded-Encrypted: i=1; AFNElJ92dHjr5Knjw+4dFcsRkBcrqZHvNpp1ts6PdXo2URiNjZ/qNN5a37TqDTKZlxLihE8ZsEhXqeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHRVFGwoS+iOhj48AnluGPhVihgSIRJ3/SvMe2//l41l1MTl7T
	PbtqYvMCqb2/T+xSdFFedVwfmYH+RDzmgQrKVDgL39GGy8mJi2GnZfMY4oL9wb6CGWYTQ5UDN7D
	MDavdwLwDftmGiy5IKXH13w==
X-Received: from pgvh2.prod.google.com ([2002:a65:6382:0:b0:c79:81df:1175])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7e86:b0:3aa:3e4c:9182 with SMTP id adf61e73a8af0-3aa3e4c9385mr220269637.7.1777934558985;
 Mon, 04 May 2026 15:42:38 -0700 (PDT)
Date: Mon,  4 May 2026 22:42:09 +0000
In-Reply-To: <20260504224213.1049426-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504224213.1049426-1-jthoughton@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504224213.1049426-3-jthoughton@google.com>
Subject: [PATCH 2/5] KVM: loongarch: Grab MMU lock in kvm_arch_flush_shadow_all()
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Sean Christopherson <seanjc@google.com>, Gavin Shan <gshan@redhat.com>, 
	Shaoqin Huang <shahuang@redhat.com>, Ricardo Koller <ricarkol@google.com>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, James Hogan <jhogan@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Houghton <jthoughton@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: F02964C4865
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-243925-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jthoughton@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

kvm_arch_flush_shadow_all() may be called concurrently on the same
`kvm`. This could at least result in accounting mistakes (e.g.
underflows on `kvm->stat.*pages`).

Cc: stable@vger.kernel.org
Fixes: 752e2cd7b4fb ("LoongArch: KVM: Implement kvm mmu operations")
Signed-off-by: James Houghton <jthoughton@google.com>
---
Note: This is compile-tested only!

 arch/loongarch/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
index a7fa458e3360..5dbce9b18e1c 100644
--- a/arch/loongarch/kvm/mmu.c
+++ b/arch/loongarch/kvm/mmu.c
@@ -486,7 +486,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 
 void kvm_arch_flush_shadow_all(struct kvm *kvm)
 {
-	kvm_flush_range(kvm, 0, kvm->arch.gpa_size >> PAGE_SHIFT, 0);
+	kvm_flush_range(kvm, 0, kvm->arch.gpa_size >> PAGE_SHIFT, 1);
 }
 
 void kvm_arch_flush_shadow_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
-- 
2.54.0.545.g6539524ca2-goog


