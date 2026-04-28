Return-Path: <stable+bounces-241548-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NqQNMH6M8GlcUwEAu9opvQ
	(envelope-from <stable+bounces-241548-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:31:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF1A482AB1
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D1CD3017DA1
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648C13EDAAE;
	Tue, 28 Apr 2026 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IcxpIaqM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B7A3EF669
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372221; cv=none; b=uDtxFw45DFD4v3nTRWKrjzbCXTnvJGcBsbdo2aHl5J376aFtMg+m5X1fZErfKOYhk1SbyWuauHrUPmOEhB04wWseLrVKN8T5/pgS46XZqo0cJ2J88BqZbxPtTbjEQNNgRQGstAuk6EU6sMUbQdM0Ii3ePCsAI1azL+tPDADdISw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372221; c=relaxed/simple;
	bh=Kn1z2vYj7fovu9i0b/eXjuXPOoyK7xrPU6Ci1PU8424=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O6QrqFw8PHrjlFUQyd0WaCCf9rM9WA9QwJgP/R5vSsL4BK3ntnHvWUIsfGXW2Yq8KYNGwx3dakfI/M/rN7lxYZlv1d0/4ARUsZ5hvViwrbBFPe8/x2MUP6F3D3Y1nMjkVVNNysvsSQVPijRIJXqYn8NBvmQbmoqaGIOE5wKuUcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IcxpIaqM; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43d103e46c3so7798664f8f.3
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 03:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777372216; x=1777977016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBzgBVDAjOycqgcIzeu+4bme8jBbglGvTuoHc/CuC0c=;
        b=IcxpIaqMFowOy/eZe/evndXaWi3CfzLRByj8yFKega1WSRaCQ1rWf4DbxmaMwtETca
         ElVrnwAadN/QMWZBysrHAm9XY72PixtdY1b+nmiNQwqXoXMtaB5om0ApkInS0pAcRhF8
         qmM5nzFiZyy68xO9H/zBucET+N2TPK4MPXRTXnz+atJWjZM3i/STfwvxZKleKuSuuLs6
         Hk4YF1QyIg//7sRyT5d6nfRnE5gNPOnyiaXnlCxhL8PwoqWQOw6EdbZzyTiUFqIYX+QV
         zFZ6EGRQrqwv51Fi4vcQwjG+2e2ApJq4ynT1vnzj5cJg2hn7ip9gmlB7WnRB8F/vPbNT
         iZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777372216; x=1777977016;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YBzgBVDAjOycqgcIzeu+4bme8jBbglGvTuoHc/CuC0c=;
        b=YkO16iHYLM/GJrBYojQZB7DZMo/g5GQ11b4rho+x0fxSgrhVHKcpnFC+EZgEtIW8z5
         vqXzXk3lqyO/CkWRs6lDk87RQ4xl1nKQ7LCQ9Iv9FO8/o7Sre0SWynJYh9J0IyMCfLBe
         3P9buTfNykqYeqs75qcB7gMgPB43yxWdpgphmXG4exiandQnFt6CvafgqXizOOUiblvs
         VwI2Vj6Xhgp4Tg2QzUB7vVx2bK2bFMoNJb6tVyHqn7yiCjNpDXwmUr/zi8PHGmB5HvXY
         aWnQaq7jcIyrBtUMSrwv+Xm3j/Wv0MqejaJ4HoRN64vOlNj8Q4+KhBRmfwD5wRYcuF3M
         mv8g==
X-Forwarded-Encrypted: i=1; AFNElJ/FgvINTmafcJ2EprHsoRZJXZ8wssd4s+FOZyXSDUXT564MCZ5Yi286bMpGH8+to6sBCVHx7YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjRiZmXD6ac4ZNvzkIfqQQmCxzsFEiRmCYwhvFB6bJG4tOlcAQ
	dTBNWACiyHcl6zok91D8JZfFzqhn9n/W66d1rsLbq/cjMW66NCgKIEXOFkIpeWVbk2L4aLhAjFh
	P9A==
X-Received: from wrvw10.prod.google.com ([2002:a5d:544a:0:b0:43e:a8da:c95a])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:3109:b0:43d:7aa8:f64e
 with SMTP id ffacd0b85a97d-44649c995b6mr4775338f8f.32.1777372216035; Tue, 28
 Apr 2026 03:30:16 -0700 (PDT)
Date: Tue, 28 Apr 2026 11:30:06 +0100
In-Reply-To: <20260428103008.696141-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428103008.696141-1-tabba@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428103008.696141-7-tabba@google.com>
Subject: [PATCH 6/8] KVM: arm64: Propagate stage-2 map failure on host->guest donation
From: Fuad Tabba <tabba@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	qperret@google.com, vdonnefort@google.com, tabba@google.com, 
	catalin.marinas@arm.com, will@kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5FF1A482AB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241548-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

__pkvm_host_donate_guest() flips the host stage-2 PTE for the donated
page to a non-valid annotation (KVM_HOST_INVALID_PTE_TYPE_DONATION,
owner =3D PKVM_ID_GUEST) via host_stage2_set_owner_metadata_locked()
and then calls kvm_pgtable_stage2_map() to install the matching guest
stage-2 mapping. The map's return value was wrapped in WARN_ON() and
otherwise discarded.

At EL2 in nVHE/pKVM, WARN_ON() is not warn-and-continue: it expands
to a BRK that enters the invalid-host-el2 vector and branches to
hyp_panic(), declared __noreturn. WARN_ON of a reachable failure at
EL2 is a panic primitive, not a debug aid.

kvm_pgtable_stage2_map() can fail in reachable ways even at PAGE_SIZE
granularity: __pkvm_host_donate_guest() verifies PKVM_NOPAGE for the
guest IPA before the map, meaning no valid stage-2 entry exists. The
walker must allocate new page-table pages from the vcpu memcache to
install the mapping, returning -ENOMEM if exhausted. The host
controls the vcpu memcache via the topup interface, so an
under-provisioned donation request converts a recoverable error into
a fatal hyp panic.

Capture the stage-2 map return value and propagate it. The walker
may have installed partial leaf entries for the IPA before failing,
so unmap the range to clear them; otherwise the guest would retain
stage-2 access to a page the host is about to reclaim as
PKVM_PAGE_OWNED. Then roll back the host stage-2 mutation: the only
forward mutation is host_stage2_set_owner_metadata_locked() flipping
the host vmemmap from PKVM_PAGE_OWNED to PKVM_NOPAGE and the host
stage-2 PTE from idmap to invalid+annotation.
host_stage2_set_owner_locked(_, _, PKVM_ID_HOST) restores both.

The rollback calls host_stage2_set_owner_locked() under WARN_ON.
This is the correct use: host_stage2_set_owner_metadata_locked()
just wrote the host leaf PTE as an invalid+annotation entry, so the
reverse idmap rewrite cannot require new page-table allocation =E2=80=94 it
rewrites the leaf in-place. The WARN_ON asserts an impossible state
under correct EL2 execution, semantically distinct from the misuse
being fixed.

Fixes: 1e579adca177 ("KVM: arm64: Introduce __pkvm_host_donate_guest()")
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvh=
e/mem_protect.c
index 7044913a0758..b8c57a95e9bf 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1391,9 +1391,30 @@ int __pkvm_host_donate_guest(u64 pfn, u64 gfn, struc=
t pkvm_hyp_vcpu *vcpu)
 	meta =3D host_stage2_encode_gfn_meta(vm, gfn);
 	WARN_ON(host_stage2_set_owner_metadata_locked(phys, PAGE_SIZE,
 						      PKVM_ID_GUEST, meta));
-	WARN_ON(kvm_pgtable_stage2_map(&vm->pgt, ipa, PAGE_SIZE, phys,
-				       pkvm_mkstate(KVM_PGTABLE_PROT_RWX, PKVM_PAGE_OWNED),
-				       &vcpu->vcpu.arch.pkvm_memcache, 0));
+	ret =3D kvm_pgtable_stage2_map(&vm->pgt, ipa, PAGE_SIZE, phys,
+				     pkvm_mkstate(KVM_PGTABLE_PROT_RWX, PKVM_PAGE_OWNED),
+				     &vcpu->vcpu.arch.pkvm_memcache, 0);
+	if (ret) {
+		/*
+		 * Stage-2 map can fail mid-walk (e.g. -ENOMEM from the
+		 * memcache), leaving partial leaf entries installed in the
+		 * guest stage-2. Tear them down before rolling back the host
+		 * stage-2; otherwise the guest would retain access to a page
+		 * the host is about to reclaim as PKVM_PAGE_OWNED.
+		 */
+		kvm_pgtable_stage2_unmap(&vm->pgt, ipa, PAGE_SIZE);
+
+		/*
+		 * Roll back the donation annotation applied above by
+		 * host_stage2_set_owner_metadata_locked() (host vmemmap
+		 * PKVM_NOPAGE -> PKVM_PAGE_OWNED, host stage-2 PTE
+		 * invalid+annotation -> idmap). The leaf PTE was just
+		 * installed by the forward call, so reinstating the idmap
+		 * rewrites it without needing fresh page-table pages from
+		 * host_s2_pool.
+		 */
+		WARN_ON(host_stage2_set_owner_locked(phys, PAGE_SIZE, PKVM_ID_HOST));
+	}
=20
 unlock:
 	guest_unlock_component(vm);
--=20
2.54.0.545.g6539524ca2-goog


