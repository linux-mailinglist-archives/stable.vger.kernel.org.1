Return-Path: <stable+bounces-241547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAtzFcKM8GlcUwEAu9opvQ
	(envelope-from <stable+bounces-241547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:32:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E94A1482AFA
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A53730457C4
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4242B3F0768;
	Tue, 28 Apr 2026 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q9Ky5o3m"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D389D3EFD26
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372221; cv=none; b=pf24nbUWZ7tEl0PGoiIcP0XzbqQiSkKbRRBRraaFm+ikvY67vE0bHZoaxhKIjMdp/hBILOa2u19Vtes9mEvzNi4SJrGNu2Q/cuJ1t4AS6VUEaVutwec0hifVVYxaQtvj1I6SoIDp9SAessApzUaEU+aVg6ML2obtSXf5ZUiSlgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372221; c=relaxed/simple;
	bh=W+xyFXpoTcAVO81+t0rS/9kkHRryS/Ehmc0XpyAYi18=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tYuvS8karqT4TZ/T4Dt6ajx/Nbkxb/qmk35wbfO4kJbKmRWu7Mw/g/iECc4o92j6PV+7ARHjqAvj0wO2j3JuV84YdwpAq8nK2X/FVxrQEtY5VEozsRb93YbbP6pUKp7vVrGBRn7VhOVxLYTcCXaNCIaJx/rVIpuAoY66RLDZkbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q9Ky5o3m; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-43efc93e4f6so9107020f8f.3
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 03:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777372217; x=1777977017; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WeB2s/TMGphof+D0QG47UlxNIiB+La++tp7fDFhGihQ=;
        b=Q9Ky5o3mI4mPyn4KuWIfqaZXoUTaKCq5yygORGX7VcU1M7czDhCiS4d1tmHROyy7Q8
         JLDMWch/VXJ1OSX6BpS/cuPhxVquUi1BJb/5E3tymhpRwBxVQKZdu9UbFGuICDsALzB4
         J/cZWRFOeOD2/QPDx9xIsAnhPKnbNsul91mw6jXgUJwdJ9/V0gfeXCy5uplnUS/uTbEG
         N5sFb/+wpmhYxkLjlMml0WuvDtgxZXDiwg0HwFFYMxiogFXq1YHHETtDkoGzPIRno6Pn
         GCVhYSJU3Qj9s5u3YDZlEONBenHgTDcmd1RynTUtxVU+lq15+bUMYz+uBcXNPxgpI4FM
         ZHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777372217; x=1777977017;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WeB2s/TMGphof+D0QG47UlxNIiB+La++tp7fDFhGihQ=;
        b=av8dCimyviIcJ4srFWXQvjP8BrxfTjtGxGSOfLsA6SGAeP4Ws6Jk5eQFS44gjb0kt/
         J1bsyVIUxda2V8ud0XfM95qV3GwqUtd2RhjXRjt/M0TmOWLOuDLGD7BEXCpVjR/M9hSc
         d9sspgA2pQg736LCNq6hyzT+HPHJy9qwcqvBcgCT4Y5vWOJkN0Mms6SstAJIFdKo11uZ
         KZBC95Zoy+vSmmflCwTjZA4gtIKHmXotyzNoG8Ghvw1h+Dz/Q9W+cQhg270YMGGy7H9Q
         KKzt+BzmxguynoIKfVxxL3BtT/YSWHnkZeD7n6uDsDDfVilpgDCXkv07pYJRCThce/k+
         3kww==
X-Forwarded-Encrypted: i=1; AFNElJ8G4pCpqG3GhvXxX17YJ8YiuCYtwvXMIoImER9qXz1XG0pJ4DvzkGH0SHDW0fkn2iocxK3YV7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvmLxD/zj5rspRqNzYxQvoh2iy3HYt4oIjUP8Em4Neo1ydv3k5
	mhIa7F5vavOQHTXi6ipmtqAf7pJ8HDDsplOowLvOIDJ5N6s1scfjEeIWBxo5aO+MbS0uNIp7+D+
	0gw==
X-Received: from wrdf9.prod.google.com ([2002:a5d:58e9:0:b0:43f:e626:ada7])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1865:b0:43d:6e0:9458
 with SMTP id ffacd0b85a97d-4464aa09351mr4498102f8f.39.1777372217076; Tue, 28
 Apr 2026 03:30:17 -0700 (PDT)
Date: Tue, 28 Apr 2026 11:30:07 +0100
In-Reply-To: <20260428103008.696141-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428103008.696141-1-tabba@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428103008.696141-8-tabba@google.com>
Subject: [PATCH 7/8] KVM: arm64: Propagate stage-2 map failure on guest->host share
From: Fuad Tabba <tabba@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	qperret@google.com, vdonnefort@google.com, tabba@google.com, 
	catalin.marinas@arm.com, will@kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E94A1482AFA
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
	TAGGED_FROM(0.00)[bounces-241547-lists,stable=lfdr.de];
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

__pkvm_guest_share_host() updates the guest stage-2 PTE for a
guest-OWNED page to PKVM_PAGE_SHARED_OWNED via
kvm_pgtable_stage2_map() and then transitions the host vmemmap and
stage-2 PTE to PKVM_PAGE_SHARED_BORROWED. The map's return value was
wrapped in WARN_ON() and otherwise discarded.

At EL2 in nVHE/pKVM, WARN_ON() is not warn-and-continue: it expands
to a BRK that enters the invalid-host-el2 vector and branches to
hyp_panic(), declared __noreturn.

__pkvm_guest_share_host() calls get_valid_guest_pte() before the
map, which verifies that a valid last-level (PAGE_SIZE) leaf PTE
already exists for the IPA. Because the leaf and all intermediate
tables are in place, the subsequent kvm_pgtable_stage2_map()
replacing it cannot fail via -ENOMEM: no block to split, no new
tables to install. The failure path is not currently reachable.

Nevertheless, WARN_ON() on any fallible call is the wrong pattern at
EL2: if the get_valid_guest_pte() precondition were ever relaxed, or
the walker gained a new failure mode, the WARN_ON would convert a
recoverable error into a fatal hyp panic. Capture the return value
and propagate it. The unmap() is kept as a defensive guard for the
currently unreachable failure path; no host-side unwinding is needed
since the host vmemmap and stage-2 update is the next step and is
correctly skipped on error.

Fixes: 03313efed5e2 ("KVM: arm64: Implement the MEM_SHARE hypercall for protected VMs")
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index b8c57a95e9bf..6fb546af699f 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -979,10 +979,23 @@ int __pkvm_guest_share_host(struct pkvm_hyp_vcpu *vcpu, u64 gfn)
 	if (__host_check_page_state_range(phys, PAGE_SIZE, PKVM_NOPAGE))
 		goto unlock;
 
-	ret = 0;
-	WARN_ON(kvm_pgtable_stage2_map(&vm->pgt, ipa, PAGE_SIZE, phys,
-				       pkvm_mkstate(KVM_PGTABLE_PROT_RWX, PKVM_PAGE_SHARED_OWNED),
-				       &vcpu->vcpu.arch.pkvm_memcache, 0));
+	ret = kvm_pgtable_stage2_map(&vm->pgt, ipa, PAGE_SIZE, phys,
+				     pkvm_mkstate(KVM_PGTABLE_PROT_RWX, PKVM_PAGE_SHARED_OWNED),
+				     &vcpu->vcpu.arch.pkvm_memcache, 0);
+	if (ret) {
+		/*
+		 * Stage-2 map can fail mid-walk (e.g. -ENOMEM from the
+		 * memcache), leaving partial leaf entries in the guest
+		 * stage-2 transitioned to PKVM_PAGE_SHARED_OWNED. Tear
+		 * them down so the host does not see a partially-shared
+		 * mapping it has not yet acknowledged via the host
+		 * stage-2 update below. No host bookkeeping needs
+		 * unwinding here: the only mutation prior to the failed
+		 * map is the (now-discarded) guest stage-2 update itself.
+		 */
+		kvm_pgtable_stage2_unmap(&vm->pgt, ipa, PAGE_SIZE);
+		goto unlock;
+	}
 	WARN_ON(__host_set_page_state_range(phys, PAGE_SIZE, PKVM_PAGE_SHARED_BORROWED));
 unlock:
 	guest_unlock_component(vm);
-- 
2.54.0.545.g6539524ca2-goog


