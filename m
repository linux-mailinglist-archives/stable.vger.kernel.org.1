Return-Path: <stable+bounces-241546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBN4KKeM8GlcUwEAu9opvQ
	(envelope-from <stable+bounces-241546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:32:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D7A482ACC
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A12230622BF
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76543EFD3F;
	Tue, 28 Apr 2026 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ys3e/gBW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32253EF647
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372219; cv=none; b=amEmhtiQCOP5EHQMQwInsYWB+C5xKqUuTK0s5hODXEU12mbcFvdSaWT1GSBY2h1z3owPu/z8QyE9VnwCGZUpnBa2mCx6ROtzZxU2oDIFPwuJm0AS/dv3eljHm+Ygtfx6T+nhCjbiPAOmf3Ya2i9ByBPc05OoZrnER+MrLenonSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372219; c=relaxed/simple;
	bh=7tTHLjAgEKGsBTyH0lVNois2KVPH84/6SrQTXYZUwfs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jBB/BM0H4zpNX5CcHGtQJ3Gn8fux2+zYt7wmofoIrpIkytt6CL3SNLj90WAWpXzml3ESr+gouJ0mcBjlT6/I/vYa+0zR9tD5DUBzE8WcY9I1STRuy2foEEaRrFEtZdOM0MhlilbHxKidpuLTT8oX6dupMmvfHlGB9I9d+ozZjGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ys3e/gBW; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-488dcaf2f2fso101742815e9.0
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 03:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777372215; x=1777977015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYUkAwnLJFRq1L2KWhPMCbl0fLNqeKRbzrqZSKodisQ=;
        b=Ys3e/gBWC2qFncrd+dQKPstgSIZW5+MrhnxoUEbj6APnNGSmKeDC7bpGyPbckC7kqg
         ierlz1W3pYTy7QAM3pAo4YYcyB54J4dJ9QUjUCHqY+DNOh7JB+VaD6yTsXM068Bo/1Ip
         D4gZ/rRgsgPC3AwS1nRxBqNV1S71xK/nHStSi+xSIRxVyEuEzx5vjZXEMKFhOwojXyz7
         PBlnaeprtUF6hico4N5WLQkThDTVC6zLQ7jq2Lmr1BzWxCFRwtBfVN9CTUS+BZr0Hctw
         VAmLBN7YiSPgxk8XZxqiL2DwmpqsqxPRRbjpC3AoOAfva29v+1eTrH+RS97aJKX8XwQ6
         Vcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777372215; x=1777977015;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYUkAwnLJFRq1L2KWhPMCbl0fLNqeKRbzrqZSKodisQ=;
        b=ZSZe0Jdk03y44OiONeqoHY94YHfp52cbUXp9+YBnfhkeBuQ/i7KGUc3/xEqPNqu1gK
         yvq12je3XymLtYLiRcxqLtYJKZCvrgobvxvZGMsD2Wa9SACz6ml6xgT4FHrTTOGkqqJ1
         T0EaCbZDZJrZlJGJ021a2dEza4ok7huvljvgvnERdN2ZjvwEd5pcNIV3iMAznU4VSRVb
         dYQRqXgFURm2xE6T28PjDATvuKBxvxSfWxUj/iWQenCTYceXd8WugGkDVzyIE5XY/DiR
         NtV5THX1iTRwV9FIsehjubo2tqYFdtYZ4Bl/d2b3ki2hflZWFrHS4vyB5iwyfF44+F6+
         6BCw==
X-Forwarded-Encrypted: i=1; AFNElJ8g5hXXdgKKX5JNdZ4gc9v7Z8gyU+dkrAcxl8BIvROhjlWpHnm9jQsbjlViIBhrcvZsJFSjmpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFPRDLsFEEHKn3BzA286yZeeuFJxo/dENX937iTD0v8Mrj7i5q
	ziWkKy6v1aHIWTYhvtcSrGm9U9Lq/39HL3kDB1QsK5qlios7bZ5SVhQLSnZ/zmkrM4xFcEF5fyM
	zFg==
X-Received: from wrou16.prod.google.com ([2002:adf:ed50:0:b0:445:adc5:751d])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b15:b0:489:1f3e:5f6f
 with SMTP id 5b1f17b1804b1-48a77ae5502mr42869535e9.12.1777372215150; Tue, 28
 Apr 2026 03:30:15 -0700 (PDT)
Date: Tue, 28 Apr 2026 11:30:05 +0100
In-Reply-To: <20260428103008.696141-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428103008.696141-1-tabba@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428103008.696141-6-tabba@google.com>
Subject: [PATCH 5/8] KVM: arm64: Propagate stage-2 map failure on host->guest share
From: Fuad Tabba <tabba@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	qperret@google.com, vdonnefort@google.com, tabba@google.com, 
	catalin.marinas@arm.com, will@kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 40D7A482ACC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241546-lists,stable=lfdr.de];
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

__pkvm_host_share_guest() mutates the host vmemmap for every page in
the range (sets PKVM_PAGE_SHARED_OWNED and increments
host_share_guest_count) and then calls kvm_pgtable_stage2_map() to
install the guest stage-2 mapping. The stage-2 map's return value was
wrapped in WARN_ON() and otherwise discarded.

At EL2 in nVHE/pKVM, WARN_ON() is not warn-and-continue: it expands
to a BRK that enters the invalid-host-el2 vector and branches to
hyp_panic(), declared __noreturn. WARN_ON of a reachable failure at
EL2 is a panic primitive, not a debug aid.

kvm_pgtable_stage2_map() can fail in reachable ways: the stage-2
walker requests fresh pages from the caller's memcache and returns
-ENOMEM when the memcache is exhausted mid-walk. The host controls
the vcpu memcache via the topup interface, so an under-provisioned
share request converts a recoverable error into a fatal hyp panic.

Capture the stage-2 map return value and propagate it. The walker
may have installed leaf entries for some pages in the IPA range
before failing, so unmap the range to clear any partial mappings;
otherwise the guest would retain stage-2 access to pages the host is
about to reclaim. Then roll back the host vmemmap mutations from the
forward pass: the forward pass increments the count by 1 on every
page, and the only forward state transition is OWNED -> SHARED_OWNED
(the count 0 -> 1 transition). The reverse pass decrements the count
and, if it drops back to zero, restores PKVM_PAGE_OWNED. Pages
already SHARED_OWNED with other sharers (count > 1 after the forward
pass) only need the count decremented.

Fixes: d0bd3e6570ae ("KVM: arm64: Introduce __pkvm_host_share_guest()")
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 30 ++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 28a471d1927c..7044913a0758 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1458,9 +1458,33 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, u64 nr_pages, struct pkvm_hyp_vcpu
 		page->host_share_guest_count++;
 	}
 
-	WARN_ON(kvm_pgtable_stage2_map(&vm->pgt, ipa, size, phys,
-				       pkvm_mkstate(prot, PKVM_PAGE_SHARED_BORROWED),
-				       &vcpu->vcpu.arch.pkvm_memcache, 0));
+	ret = kvm_pgtable_stage2_map(&vm->pgt, ipa, size, phys,
+				     pkvm_mkstate(prot, PKVM_PAGE_SHARED_BORROWED),
+				     &vcpu->vcpu.arch.pkvm_memcache, 0);
+	if (ret) {
+		/*
+		 * Stage-2 map can fail mid-walk (e.g. -ENOMEM from the
+		 * memcache), leaving partial leaf entries installed in the
+		 * guest stage-2. Tear them down before rolling back host
+		 * bookkeeping; otherwise the guest would retain access to
+		 * pages the host is about to reclaim as PKVM_PAGE_OWNED.
+		 */
+		kvm_pgtable_stage2_unmap(&vm->pgt, ipa, size);
+
+		/*
+		 * Roll back the host vmemmap mutations applied above. A page
+		 * whose host_share_guest_count is now 1 was PKVM_PAGE_OWNED
+		 * before this call (count 0->1, state OWNED->SHARED_OWNED);
+		 * undo both. A page with count > 1 was already
+		 * PKVM_PAGE_SHARED_OWNED with other sharers; only the count
+		 * needs to be decremented.
+		 */
+		for_each_hyp_page(page, phys, size) {
+			page->host_share_guest_count--;
+			if (!page->host_share_guest_count)
+				set_host_state(page, PKVM_PAGE_OWNED);
+		}
+	}
 
 unlock:
 	guest_unlock_component(vm);
-- 
2.54.0.545.g6539524ca2-goog


