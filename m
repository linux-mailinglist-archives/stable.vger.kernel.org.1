Return-Path: <stable+bounces-242333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOiNJUiN9Gn/CAIAu9opvQ
	(envelope-from <stable+bounces-242333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:23:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 390A14ABFF0
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3EAAE3003D00
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1D43A5427;
	Fri,  1 May 2026 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GKNBNwlV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F1B3A3E8B
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777634520; cv=none; b=EyA1dG7am/mTTejx7lYSRMSZ5f13+bODuXbHkA1EXinG6/PfJUsOLhFITS/9nkHUNTnsMQgbVaSiTB6jTvlP0wG0n1yhBysywGC+HBk+rI6+rZm4zaGqUid66B4BRhqKI94fKXbdRMX1bN09Z1bk2p7xB5MJZjBCoCuAD9kS+tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777634520; c=relaxed/simple;
	bh=S7p3SvZAGgFaCzOgURZOrBYd5goc2tc8o7A1j2alrrE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aZSBHZI3e2PVe7Csp0/PgJmh0ff9kpn0uvLrSSZh1xLRWA9YCWTzSC3K9F0djWe3oJ1p9KzT1S0J8GONLwH3Ud1sb1n97AZCf0MCZfDrB0JQYsYgX7Rj5Nzm/fcBLAXIYgHZ4wGdb47hmGeI53nqrQakIFXMkVlPvfR+H0bAD1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GKNBNwlV; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b9c129099daso110586266b.2
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777634517; x=1778239317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hX/U36pu+btUiKMTGpxWXuvgYMFqfHpYvSZt+8MNmUg=;
        b=GKNBNwlVnskJovghLZWRS1maoQxUAu3c4kwFZfTSiiI5rFxeUjwsNrhotkG1MomwAb
         Sa3+q0DQnIb0e/W0uOPBj7yrOPhSm+SNkSelQE9hQMpsbEbnDWUoEKJlVQLCfT2NzWku
         m38jgGxwpqrphfHskS51Uygr4eNgJlKk+nHODeMUPMuBNMwcNWPbIH+tUSRk6dGQ+6mA
         +L82v1ttQWIQYmnmuzwbJnyhgrlcrZFqsa/fw2WhF4y2JQWSKPKeuvuXBc7OU8GdkFCo
         rq9oL3zqLOqowYckbLR5LJhQ/Ri7yVWBSPfkS4FE4kOwqYcMQ+M4AH3aIjOPCxQG1rle
         Y7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777634517; x=1778239317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hX/U36pu+btUiKMTGpxWXuvgYMFqfHpYvSZt+8MNmUg=;
        b=Q3V7ZWE6TT2T/XLgmlJk3+sDT19UkVWzKt/aY1sSaQJMqgd5+hXMJf+mBxqN/MV2Eb
         WT/g2Rcf2dNxtdA0HWhwrWrDdL9jQtcvRhgbaAkaXQDiAzF05UqzuqtV0cd4SUgp17Tb
         LjNfFnz6inzJhztYCBfpX95fNQeR3djQQbRI9PfXD4JUnNTk86VeEJwM48fT3fpzmvZK
         TO7YpjYKYir8R/+dwFMd6RWztlD2M990WdVlEmFsTVs4rbxILG1TYu94tgHpIJ4C+SRY
         rsypMOKPmczUYrzwfWQzDY8mv4zw/96iokuZiMcgwGU7EXClaQNKiIfNHgXc5aqEW1Hp
         sgUA==
X-Forwarded-Encrypted: i=1; AFNElJ8bu/Az76qBtsjCTpnon37xgtbiv2dC7e8S2DfgFg9SsA/UZFOnY2IB/khsleduB+s0QnUT0Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaWyO4H2hlUEWIHtB3cf1Um86t9WET27pnF16rIgzbaPlGetBy
	P1+ICSvPQB2ar2DXOYi0j2ePLEEvTIourX+H+rZL/0snS66z8hp0fBJ4O7vjsEPKTHgKLNT5SNv
	SsQ==
X-Received: from ejbwt14.prod.google.com ([2002:a17:906:ee8e:b0:b98:23e7:c41])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:f58e:b0:bb7:be6a:7671
 with SMTP id a640c23a62f3a-bbac5ac10c5mr381051166b.6.1777634516878; Fri, 01
 May 2026 04:21:56 -0700 (PDT)
Date: Fri,  1 May 2026 12:21:48 +0100
In-Reply-To: <20260501112149.2824881-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260501112149.2824881-1-tabba@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501112149.2824881-6-tabba@google.com>
Subject: [PATCH v2 5/6] KVM: arm64: Pre-check vcpu memcache for host->guest share
From: Fuad Tabba <tabba@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	qperret@google.com, vdonnefort@google.com, tabba@google.com, 
	catalin.marinas@arm.com, will@kernel.org, yaoyuan@linux.alibaba.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 390A14ABFF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242333-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

__pkvm_host_share_guest() ends with kvm_pgtable_stage2_map() to
install the guest stage-2 mapping, after a forward pass that mutates
the host vmemmap (sets PKVM_PAGE_SHARED_OWNED and increments
host_share_guest_count) for every page in the range. The map's
return value is wrapped in WARN_ON() and otherwise discarded,
asserting that the call cannot fail.

WARN_ON() at nVHE EL2 panics, so this assertion is only correct if
the call genuinely cannot fail. kvm_pgtable_stage2_map() can fail
with -ENOMEM when the stage-2 walker exhausts the caller's
memcache, and the host controls the vcpu memcache via the topup
interface, so an under-provisioned share request would otherwise
turn a recoverable -ENOMEM into a fatal hyp panic.

Bound the worst-case walker allocation in the existing pre-check
pass so that kvm_pgtable_stage2_map() cannot fail at the call
site, using kvm_mmu_cache_min_pages() -- the same bound host EL1
uses for its own stage-2 maps. If the vcpu memcache holds fewer
pages, return -ENOMEM before any state mutation.

Fixes: d0bd3e6570ae ("KVM: arm64: Introduce __pkvm_host_share_guest()")
Assisted-by: Gemini:gemini-3.1-pro review-prompts
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 28a471d1927c..e428304f94f2 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1369,6 +1369,22 @@ int __pkvm_host_reclaim_page_guest(u64 gfn, struct pkvm_hyp_vm *vm)
 	return ret && ret != -EHWPOISON ? ret : 0;
 }
 
+/*
+ * share/donate install at most one stage-2 leaf (PAGE_SIZE, or one
+ * KVM_PGTABLE_LAST_LEVEL - 1 block for share). kvm_mmu_cache_min_pages()
+ * bounds the worst-case allocation: exact for the PAGE_SIZE leaf,
+ * conservative by one for the block.
+ */
+static int __guest_check_pgtable_memcache(struct pkvm_hyp_vcpu *vcpu)
+{
+	struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
+
+	if (vcpu->vcpu.arch.pkvm_memcache.nr_pages < kvm_mmu_cache_min_pages(vm->pgt.mmu))
+		return -ENOMEM;
+
+	return 0;
+}
+
 int __pkvm_host_donate_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu)
 {
 	struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
@@ -1453,6 +1469,10 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, u64 nr_pages, struct pkvm_hyp_vcpu
 		}
 	}
 
+	ret = __guest_check_pgtable_memcache(vcpu);
+	if (ret)
+		goto unlock;
+
 	for_each_hyp_page(page, phys, size) {
 		set_host_state(page, PKVM_PAGE_SHARED_OWNED);
 		page->host_share_guest_count++;
-- 
2.54.0.545.g6539524ca2-goog


