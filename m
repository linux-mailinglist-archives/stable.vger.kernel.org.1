Return-Path: <stable+bounces-267982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MC6fOAG3OmrzEggAu9opvQ
	(envelope-from <stable+bounces-267982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 18:40:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4DB6B8C93
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 18:40:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b="ExT/Z7YP";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267982-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267982-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46910309919A
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 16:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83DF3195EF;
	Tue, 23 Jun 2026 16:38:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC0230F816;
	Tue, 23 Jun 2026 16:38:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232685; cv=none; b=f2IMCahCCESfovf1XQu5B/BhHp/FlJeNKGM4Kfdk9W+CLSeoNlPi9pOTy+aGRPjKV9WVNr3YWOQMBLqDQDoO7Ru84hzFKox0mkzLRkWNT2ZSWg+kxYxdvDAGET8hJISDxLZ3Z/OnpkYhEELQMCiurUx/i+v9W+EDsVkbGA4LN5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232685; c=relaxed/simple;
	bh=2aQ7BkU4NZeFpXLMc+Ibd+6a2ttSQ+izjF9vuC4rBsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eA6HyxUPkMj47G+uH2R0F1U8aUJaePG3Yk2hecfVVyJokDNUdHZmQ7rdMHA162lvF34bGYTCCfBz4O7JL3Hd3LGa2oMG9dKHfCxtqhK/sOPxYuX1wFQvFeocc3LBqyxAzQ4/Lc+3bEvVOqqssy2dYdRKxr+R2d0V6XnOIStXLs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=ExT/Z7YP; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782232682;
	bh=RdA+tt6udTEt4Fk49QJIhcJwNDLh2tJtFcBL+wwe0sQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ExT/Z7YP3YU2JyOSNY+wfEgfr1FclDxQhziKlNhcpUHbxY8mcWfOjjq4YzjPuHw5Y
	 hccwO75cxy5vP5bEMPwh1tBvMV53kOMb2b7y+DDGVcBnSDTpwJa61p5thIDifzVmov
	 nFS/JLf8aAZoIks+RfDfn3ZTcujMEOwvnyDRUPZs=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gl9jQ64Lwz110l;
	Tue, 23 Jun 2026 16:38:02 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gl9jP69RNz10xM;
	Tue, 23 Jun 2026 16:38:01 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Fuad Tabba <tabba@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Quentin Perret <qperret@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] KVM: arm64: top up pKVM mapping cache for permission faults
Date: Tue, 23 Jun 2026 16:37:56 +0000
Message-ID: <20260623163756.4591-2-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623163756.4591-1-include@grrlz.net>
References: <20260623160339.15143-1-include@grrlz.net>
 <20260623163756.4591-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[grrlz.net,reject];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-267982-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:maz@kernel.org,m:oupton@kernel.org,m:kvmarm@lists.linux.dev,m:tabba@google.com,m:joey.gouly@arm.com,m:seiden@linux.ibm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:qperret@google.com,m:vdonnefort@google.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:include@grrlz.net,m:stable@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[grrlz.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,grrlz.net:dkim,grrlz.net:email,grrlz.net:mid,grrlz.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F4DB6B8C93

Permission faults normally only relax an existing leaf, so the fault path
does not top up the memcache.

With pKVM, a permission fault can also replace page mappings with a
PMD mapping. That path needs a fresh pkvm_mapping object, and can
dereference a NULL cache->mapping if the cache was not topped up.

Allocate just that object for pKVM permission faults.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/all/20260623161545.EA08E1F000E9@smtp.kernel.org/ [1]

Fixes: db14091d8f75 ("KVM: arm64: Stage-2 huge mappings for np-guests")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
Changes in v2:
- New patch.

 arch/arm64/kvm/mmu.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 6c941aaa10c6..3f57f6825a33 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1177,17 +1177,26 @@ void free_hyp_memcache(struct kvm_hyp_memcache *mc)
 	__free_hyp_memcache(mc, hyp_mc_free_fn, kvm_host_va, mc);
 }
 
+static int topup_hyp_memcache_mapping(struct kvm_hyp_memcache *mc)
+{
+	if (mc->mapping)
+		return 0;
+
+	mc->mapping = kzalloc_obj(struct pkvm_mapping,
+				  GFP_KERNEL_ACCOUNT);
+	return mc->mapping ? 0 : -ENOMEM;
+}
+
 int topup_hyp_memcache(struct kvm_hyp_memcache *mc, unsigned long min_pages)
 {
+	int ret;
+
 	if (!is_protected_kvm_enabled())
 		return 0;
 
-	if (!mc->mapping) {
-		mc->mapping = kzalloc_obj(struct pkvm_mapping,
-					  GFP_KERNEL_ACCOUNT);
-		if (!mc->mapping)
-			return -ENOMEM;
-	}
+	ret = topup_hyp_memcache_mapping(mc);
+	if (ret)
+		return ret;
 
 	return __topup_hyp_memcache(mc, min_pages, hyp_mc_alloc_fn,
 				    kvm_host_pa, mc);
@@ -2113,7 +2122,9 @@ static int user_mem_abort(const struct kvm_s2_fault_desc *s2fd)
 	 * Permission faults just need to update the existing leaf entry,
 	 * and so normally don't require allocations from the memcache. The
 	 * only exception to this is when dirty logging is enabled at runtime
-	 * and a write fault needs to collapse a block entry into a table.
+	 * and a write fault needs to collapse a block entry into a table. With
+	 * pKVM, they may still need a fresh mapping object if the fault turns
+	 * page entries into a block entry.
 	 */
 	memcache = get_mmu_memcache(s2fd->vcpu);
 	if (!perm_fault || (memslot_is_logging(s2fd->memslot) &&
@@ -2121,6 +2132,10 @@ static int user_mem_abort(const struct kvm_s2_fault_desc *s2fd)
 		ret = topup_mmu_memcache(s2fd->vcpu, memcache);
 		if (ret)
 			return ret;
+	} else if (is_protected_kvm_enabled()) {
+		ret = topup_hyp_memcache_mapping(memcache);
+		if (ret)
+			return ret;
 	}
 
 	/*
-- 
2.53.0

