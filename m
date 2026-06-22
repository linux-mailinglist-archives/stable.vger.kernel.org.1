Return-Path: <stable+bounces-267612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pTgQAOLpOGockAcAu9opvQ
	(envelope-from <stable+bounces-267612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 09:53:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 446026AD6C9
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 09:53:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267612-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267612-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D9303038510
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 07:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9B0380FD7;
	Mon, 22 Jun 2026 07:51:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3623803E9;
	Mon, 22 Jun 2026 07:51:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782114680; cv=none; b=ALUasakVl+GkimY0SIPMmf/CyEgFIMLnKyM/nAdtpIOJfQ4swI/NFhKkFQ27nnlbrYkS5CJijyrnLDIzVXitjz+YafnFogUwnCF8ldScwdXuxeHawcz4paazIUCgnWuJ3+2OO/PupGojkAb/4lliFEQPs7akfTqJF/FR62uxoP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782114680; c=relaxed/simple;
	bh=GwVHIoZ7r/M8GteP9m8gN+gqChmMb7gtvlHqruMu3OY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eBRcCAQrM5sHWKYMmOomDgbBkX5whGMY301/6rG6HSbcdHCLLEOULEh37J7v3wUCW8+AhxMCtNkVUKRzfhHWEvLYEWWbP/DngOHKLk2rWcMJi5yTsHeeypCiORB0nAU/aTvfgqWLmci81Ljc107h3Lfznzqto5q+jsCYTD/VpaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 21bd73886e0f11f1aa26b74ffac11d73-20260622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:df1340d8-bad8-4902-a57c-bc94b27aad22,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:e7bac3a,CLOUDID:97fc9069a1c6fe1949f2f7a7b81d7275,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:1
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 21bd73886e0f11f1aa26b74ffac11d73-20260622
X-User: leixiang@kylinos.cn
Received: from ninol.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <leixiang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 972357421; Mon, 22 Jun 2026 15:51:09 +0800
From: leixiang <leixiang@kylinos.cn>
To: 
Cc: leixiang <leixiang@kylinos.cn>,
	stable@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paul Mackerras <paulus@ozlabs.org>,
	Suresh Warrier <warrier@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: Nullify irqfd->producer when add_producer() fails
Date: Mon, 22 Jun 2026 15:51:01 +0800
Message-ID: <20260622075103.35164-1-leixiang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	TAGGED_FROM(0.00)[bounces-267612-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leixiang@kylinos.cn,m:stable@vger.kernel.org,m:maddy@linux.ibm.com,m:npiggin@gmail.com,m:mpe@ellerman.id.au,m:chleroy@kernel.org,m:seanjc@google.com,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:paulus@ozlabs.org,m:warrier@linux.vnet.ibm.com,m:linuxppc-dev@lists.ozlabs.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[leixiang@kylinos.cn,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kylinos.cn,vger.kernel.org,linux.ibm.com,gmail.com,ellerman.id.au,kernel.org,google.com,redhat.com,alien8.de,linux.intel.com,zytor.com,ozlabs.org,linux.vnet.ibm.com,lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leixiang@kylinos.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,kylinos.cn:email,kylinos.cn:mid,kylinos.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 446026AD6C9

The x86 and powerpc add_producer() callbacks set irqfd->producer before the
fallible setup and never clear it on error.  The bypass manager doesn't
register a producer whose add_producer() failed -- producer->eventfd is
left NULL, so the later unregister early-returns and del_producer() is
never called -- so nothing ever drops the pointer.

For VFIO PCI the producer is embedded in struct vfio_pci_irq_ctx and freed
when the vector is disabled, after which a routing update dereferences the
dangling pointer via kvm_arch_update_irqfd_routing().

Nullify irqfd->producer on the error paths.

Fixes: 77e1b8332d1d ("KVM: x86: Decouple device assignment from IRQ bypass")
Fixes: c57875f5f9be ("KVM: PPC: Book3S HV: Enable IRQ bypass")
Cc: stable@vger.kernel.org
Signed-off-by: leixiang <leixiang@kylinos.cn>
---
 arch/powerpc/kvm/book3s_hv.c | 4 +++-
 arch/x86/kvm/irq.c           | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 61dbeea317f3..14919b76fb32 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6114,9 +6114,11 @@ static int kvmppc_irq_bypass_add_producer_hv(struct irq_bypass_consumer *cons,
 	irqfd->producer = prod;

 	ret = kvmppc_set_passthru_irq(irqfd->kvm, prod->irq, irqfd->gsi);
-	if (ret)
+	if (ret) {
 		pr_info("kvmppc_set_passthru_irq (irq %d, gsi %d) fails: %d\n",
 			prod->irq, irqfd->gsi, ret);
+		irqfd->producer = NULL;
+	}

 	return ret;
 }
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 8c62c6d4d5c1..cb8ac4b9b0d7 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -488,8 +488,10 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,

 	if (irqfd->irq_entry.type == KVM_IRQ_ROUTING_MSI) {
 		ret = kvm_pi_update_irte(irqfd, &irqfd->irq_entry);
-		if (ret)
+		if (ret) {
 			kvm->arch.nr_possible_bypass_irqs--;
+			irqfd->producer = NULL;
+		}
 	}
 	spin_unlock_irq(&kvm->irqfds.lock);

--
2.45.0

