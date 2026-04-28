Return-Path: <stable+bounces-241549-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNYQGuKM8GlcUwEAu9opvQ
	(envelope-from <stable+bounces-241549-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:33:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D007D482B27
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0D89304B120
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25A23F0A87;
	Tue, 28 Apr 2026 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ne6exxQs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3688E3F074B
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372222; cv=none; b=J7WBUsIFm4XTNGTlAX5CVIqKedL5S+Nw1aZ/GUh1dn451YOo72xnWzg82f0LTyN+NnRn6VluRaCwEc7UApC7bJYh2lekxDB3V5X9jjDR5IjYpEkim37Ol4QZVmvMCMaLG7jOijOy3J0AnvUr4ZiAkTZ/kEHU+DRkvdgYffnmzvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372222; c=relaxed/simple;
	bh=maNkTII608MzcF1ju87MQQ+KK6PcKFHw8+zyZf9QEJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JHSrnVBWzms8fsPiSJO0Oe0Bopx9RfHcMkZ6klOnIAbk69alLI78LGR9OdQcz4KPV6c7wvO4JQarBOgQYzadEVvidFS+mZScdseIAqQ7KIkwUw0YcVH5IwHGjXiwcWBXw+M4za6mSbVOkpyDZ9hz3TYPT8/H+BzC6A/E18tlaO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ne6exxQs; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43e52dc8a04so9743866f8f.3
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 03:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777372218; x=1777977018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBFwe+kQ1OqLHi9s19ESuOVx/rJg9xLwA9cXX3TmEmg=;
        b=Ne6exxQsW1AzSFQgtqiRUTruJVnx+Y5U5Qom9+VmeEQU1n3QA/dZpGuhP3sJQLQbZ5
         D/Kh7Wv6aVE0rtAx4+9/hGop2Oa6P0DmpnHlrCYrQ7+psbAS4XQkD1yPovw9GssfxCVV
         OXvNXm9ZC/GiXXLdAjjFWa4nnTi0b+wg/sZdwekl3YhGUfTMW9RLiF88jicrRSwpPAF5
         py6yk/KURGDcESGa/jXcK7E41wAPkJu4LLALiq8NsNkg4hh9Y28pezhrNshIllK/kKyE
         0TRWpGG06KnzX99qIyidlUnBjSMl0qt8AgiEiSq6eOUrlgaup5s6KHKKoNbzCDi9gJZp
         dhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777372218; x=1777977018;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZBFwe+kQ1OqLHi9s19ESuOVx/rJg9xLwA9cXX3TmEmg=;
        b=bm8GYbQ+zoP6tLfooQxTKh19WCwZAlUpxeFki27BtGd4eqY3EVXXMG+aCAtrQJqtG0
         rCWIwL5JYUB5BxSHe9CzmSKLs3rtq3maoDRb3iFghZCYAoEWO7z3iFwQlpWqUfGo5Qfz
         fq5kv5RMICYq7BN4kDJ+w2e1SHRPsggYNX7s823PsJGYupC5Hgjs0712l4LP+vqYmvWp
         9J4zLwC6GfxqU2f3eJZ57LB5TwD2wE4izOGfM6/AhT+T4/tuOJInqTHj1Fr8OXl/lW90
         iIV0iObW90KWFJi5BXiZIS6JjDNeOvneFNyvK6gR+mXiMIdlwqCVEVdoirmteH7kYvhM
         nnRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8+ELXkfFlWUPPyh1hd7ZbpQp2vBg9PnQaUbTvqwqt2VNVT5vq9ddYqYAuLGde996qZPWsue94=@vger.kernel.org
X-Gm-Message-State: AOJu0YywlywmYpMk8doCYswSd0iF0zgo+N7SgJMt5h5n5uXLkx0yoZhj
	jxKOWQUju+d5YaeirJB/3vjFU3WVnng/7P4J3quGkGeM9rqG0jwRkmCdGdps87k+0sqD6shouv7
	T4w==
X-Received: from wmbjp7.prod.google.com ([2002:a05:600c:5587:b0:488:a71c:cf48])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b90:b0:488:a639:b772
 with SMTP id 5b1f17b1804b1-48a77af5f04mr37827885e9.7.1777372218008; Tue, 28
 Apr 2026 03:30:18 -0700 (PDT)
Date: Tue, 28 Apr 2026 11:30:08 +0100
In-Reply-To: <20260428103008.696141-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428103008.696141-1-tabba@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428103008.696141-9-tabba@google.com>
Subject: [PATCH 8/8] KVM: arm64: Propagate stage-2 map failure on guest->host unshare
From: Fuad Tabba <tabba@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	qperret@google.com, vdonnefort@google.com, tabba@google.com, 
	catalin.marinas@arm.com, will@kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D007D482B27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241549-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

__pkvm_guest_unshare_host() re-acquires exclusive guest ownership of
a page by (i) annotating the host stage-2 PTE via
host_stage2_set_owner_metadata_locked(), (ii) mapping the page in
the guest stage-2 as PKVM_PAGE_OWNED via kvm_pgtable_stage2_map(),
and (iii) restoring host ownership via
host_stage2_set_owner_locked(). The map's return value was wrapped
in WARN_ON() and otherwise discarded.

At EL2 in nVHE/pKVM, WARN_ON() is not warn-and-continue: it expands
to a BRK that enters the invalid-host-el2 vector and branches to
hyp_panic(), declared __noreturn.

__pkvm_guest_unshare_host() calls get_valid_guest_pte() before the
map, which verifies that a valid last-level (PAGE_SIZE) leaf PTE
already exists for the IPA. Because the leaf and all intermediate
tables are in place, the subsequent kvm_pgtable_stage2_map()
replacing it cannot fail via -ENOMEM: no block to split, no new
tables to install. The failure path is not currently reachable.

Nevertheless, WARN_ON() on any fallible call is the wrong pattern at
EL2. Capture the return value and propagate it. The unmap() and
host-side rollback are kept as defensive guards for the currently
unreachable failure path. The rollback's
WARN_ON(__host_set_page_state_range()) asserts an impossible state:
the host leaf PTE was just written by
host_stage2_set_owner_metadata_locked(), so the reverse idmap
rewrite cannot require new page-table allocation from host_s2_pool.
This is the correct use of WARN_ON at EL2 =E2=80=94 an impossible-state
assertion, not a reachable error being ignored.

Fixes: 246c976c370d ("KVM: arm64: Implement the MEM_UNSHARE hypercall for p=
rotected VMs")
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 37 ++++++++++++++++++---------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvh=
e/mem_protect.c
index 6fb546af699f..12f3ea7a2d75 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -984,14 +984,10 @@ int __pkvm_guest_share_host(struct pkvm_hyp_vcpu *vcp=
u, u64 gfn)
 				     &vcpu->vcpu.arch.pkvm_memcache, 0);
 	if (ret) {
 		/*
-		 * Stage-2 map can fail mid-walk (e.g. -ENOMEM from the
-		 * memcache), leaving partial leaf entries in the guest
-		 * stage-2 transitioned to PKVM_PAGE_SHARED_OWNED. Tear
-		 * them down so the host does not see a partially-shared
-		 * mapping it has not yet acknowledged via the host
-		 * stage-2 update below. No host bookkeeping needs
-		 * unwinding here: the only mutation prior to the failed
-		 * map is the (now-discarded) guest stage-2 update itself.
+		 * Defensive: get_valid_guest_pte() guarantees a last-level
+		 * leaf PTE already exists, so stage-2 map() cannot currently
+		 * fail here. The unmap() restores the IPA to a clean state as
+		 * a guard should the precondition ever change.
 		 */
 		kvm_pgtable_stage2_unmap(&vm->pgt, ipa, PAGE_SIZE);
 		goto unlock;
@@ -1024,13 +1020,30 @@ int __pkvm_guest_unshare_host(struct pkvm_hyp_vcpu =
*vcpu, u64 gfn)
 	if (__host_check_page_state_range(phys, PAGE_SIZE, PKVM_PAGE_SHARED_BORRO=
WED))
 		goto unlock;
=20
-	ret =3D 0;
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
+		 * Defensive: get_valid_guest_pte() guarantees a last-level
+		 * leaf PTE already exists, so stage-2 map() cannot currently
+		 * fail here. The unmap() and host-side rollback below are
+		 * kept as guards should the precondition ever change.
+		 */
+		kvm_pgtable_stage2_unmap(&vm->pgt, ipa, PAGE_SIZE);
+
+		/*
+		 * Roll back the host stage-2 mutation above: the host leaf
+		 * PTE was just written by host_stage2_set_owner_metadata_locked(),
+		 * so __host_set_page_state_range() rewrites it in-place
+		 * without needing fresh page-table pages from host_s2_pool.
+		 */
+		WARN_ON(__host_set_page_state_range(phys, PAGE_SIZE,
+						    PKVM_PAGE_SHARED_BORROWED));
+	}
 unlock:
 	guest_unlock_component(vm);
 	host_unlock_component();
--=20
2.54.0.545.g6539524ca2-goog


