Return-Path: <stable+bounces-242334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIRjM9WP9Gn/CAIAu9opvQ
	(envelope-from <stable+bounces-242334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:34:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F484AC12A
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF99330DA3D4
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB663A5E70;
	Fri,  1 May 2026 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZrRsFzwD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96413A4F22
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777634521; cv=none; b=KZkAji+786csQfheYhq0sZsLoIKUkBgv8jTUVLY+/FsVqx9IVxTz/9vOcQdPl4sXsdjKhS+/KwtD6o57gfRxylU80bcgGnY0MKx77QPI+7FRdDUqvKyTl7FAyzjo7/cnKL7OX9VTzWjaaj3SjEvVRs6UW6FAxVffJZtjHZSJFJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777634521; c=relaxed/simple;
	bh=wyLa8NKF6GhGuRRNf3zay2XeK8bwHhxV1DLSA58dF5s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XYucLNyMnY+QdtBBhzfJxhYhkMI/jQfcjAYgBNGDyrkbIdoi4mGkxN0mENWLrbbech/LfgRxOwZfe3rY0sohL4BzFR8rvR0SgybAA06tR4MORjjATqWE3CZEvsxeYG3zGmJ02gqoiRKU2bcRSN0gJ4mT/qlx4e+R6pjTrKGtB9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZrRsFzwD; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b9c1d1f7e5dso211994666b.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777634518; x=1778239318; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrLinQWyFKg2m6ErNGuwXnFHhW5qOEbX3IE7Ywix0YI=;
        b=ZrRsFzwDkdbpTMXXINE42nMk04kGzwdGWnJHcC4jxRd+lDrf+w9igpn0UXofiDlRMt
         oXRtcVt46nIpmS8+HFE51p+xTP+GKkg/0IHQwfZROocmCLIzj60OMsZ0akFq5fH9d7ze
         NGB5EWuzQvHiQxPS6D+uLZWoNErNZdAugaLFQ321n9uFYytC2Io+VYLc6RQiEgGj4CnD
         h6sjHGDvzLdb7wPo/nCT8ZYhLd95n9Pr1PKsosMahFKf4dxrnbPPEkwXOQWnRgkFxY0z
         Xjw3LnojpZnPcX01VUH9yLvO80TOYPJidfQCvrREzegIoMejkuQwG83mibLcgF89Pu9T
         9AoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777634518; x=1778239318;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrLinQWyFKg2m6ErNGuwXnFHhW5qOEbX3IE7Ywix0YI=;
        b=STI7NA8s67wTO9BJdPNImO9G5yGASAV/46bVhB4NnoaKzo9bSowbngfgKkWByYv/WB
         78w4E0ebGvexT80oYx6K2DrhJlPBEShJasISvxoaQUJIWPSC82k4s2C7Wo4VfzyNyuX7
         pXmYO1MgvBXsdVfPIGA+p+ILx2zOYvMpWwM+h2Bqbvi+EpU2+yqDmn8WGujEo/LTSstN
         Qlo4XIz4mr+bdJHE2oD5qSb99EJdQxxuTExsC5H4Bklf2qZ7xM6Rk/5XS9b73P9pPfPb
         MiIarH249JX0pJU29qlO2vXw5Uu9BG1dVt1zlXD7bQjlOqoN8VWU44IilePuezhO8NS+
         wy3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+PHUEwbIPW+Ncp6m986K9ApY12iqoojZWQTSejDn4jXUstxRRtq++eKK0QFLchyFD4QJ01AMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+M0RNMHwEHkxjC5xJTh+sJ6BLdooi9lXay11iTns4W642WkdF
	Ib6r+ViHKVSCrcfTkJJOCjv8LPwMH8DxdLDLyyLQ7wHEflCgLA+X7U7d4XqMImVsccOltMu34EN
	TCg==
X-Received: from ejcdn19.prod.google.com ([2002:a17:907:94d3:b0:b9c:aee9:a002])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:f588:b0:b9c:b069:8ab6
 with SMTP id a640c23a62f3a-bbac47d4717mr450739666b.7.1777634517844; Fri, 01
 May 2026 04:21:57 -0700 (PDT)
Date: Fri,  1 May 2026 12:21:49 +0100
In-Reply-To: <20260501112149.2824881-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260501112149.2824881-1-tabba@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501112149.2824881-7-tabba@google.com>
Subject: [PATCH v2 6/6] KVM: arm64: Pre-check vcpu memcache for host->guest donate
From: Fuad Tabba <tabba@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	qperret@google.com, vdonnefort@google.com, tabba@google.com, 
	catalin.marinas@arm.com, will@kernel.org, yaoyuan@linux.alibaba.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 68F484AC12A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242334-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

__pkvm_host_donate_guest() flips the host stage-2 PTE for the
donated page to a non-valid annotation via
host_stage2_set_owner_metadata_locked() and then calls
kvm_pgtable_stage2_map() to install the matching guest stage-2
mapping. The map's return value is wrapped in WARN_ON() and
otherwise discarded, asserting that the call cannot fail.

WARN_ON() at nVHE EL2 panics, so this assertion is only correct
if the call genuinely cannot fail. kvm_pgtable_stage2_map() can
fail with -ENOMEM even at PAGE_SIZE granularity: the donate path
verifies PKVM_NOPAGE for the guest IPA before the map, so the
walker must allocate fresh page-table pages from the vcpu
memcache, and the host controls the vcpu memcache via the topup
interface. An under-provisioned donation request would otherwise
turn a recoverable -ENOMEM into a fatal hyp panic.

Bound the worst-case walker allocation alongside the existing
__host_check_page_state_range() / __guest_check_page_state_range()
pre-checks, using the helper introduced for host->guest share. If
the vcpu memcache holds fewer pages than kvm_mmu_cache_min_pages(),
return -ENOMEM before any state mutation.

Fixes: 1e579adca177 ("KVM: arm64: Introduce __pkvm_host_donate_guest()")
Assisted-by: Gemini:gemini-3.1-pro review-prompts
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index e428304f94f2..c7f7149c4796 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1404,6 +1404,10 @@ int __pkvm_host_donate_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu)
 	if (ret)
 		goto unlock;
 
+	ret = __guest_check_pgtable_memcache(vcpu);
+	if (ret)
+		goto unlock;
+
 	meta = host_stage2_encode_gfn_meta(vm, gfn);
 	WARN_ON(host_stage2_set_owner_metadata_locked(phys, PAGE_SIZE,
 						      PKVM_ID_GUEST, meta));
-- 
2.54.0.545.g6539524ca2-goog


