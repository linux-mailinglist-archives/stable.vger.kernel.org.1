Return-Path: <stable+bounces-259350-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLdPGsA9HGoVLwkAu9opvQ
	(envelope-from <stable+bounces-259350-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 15:55:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C631C61674A
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 15:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8966302BA41
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 13:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C996314B63;
	Sun, 31 May 2026 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cW8a3g25"
X-Original-To: stable@vger.kernel.org
Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B871131326C
	for <stable@vger.kernel.org>; Sun, 31 May 2026 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780235705; cv=none; b=pz9/3CiF96naapSafs2oBb2GqY/dFAtMYMPM8wFjs8NtdoegCSxVCli7CCkf70Glhu8G7PXx6JOVQdJJb81tdmJZtf6jFWaEvQ+qiLswaMGG8wbD4rhIOlqF0VlNPdDp4kt8MbqZdaBQYmnscfC9BK0MRe4GXTr3LlQsDeoZ80M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780235705; c=relaxed/simple;
	bh=IojkXEcJz24+YV46lTxMNSdcw1Ho81dQc8X790L5DqQ=;
	h=Content-Type:To:Subject:Date:In-Reply-To:Message-Id:Mime-Version:
	 Cc:From:References; b=Qc8OtQy6WL0i7njp/AI2PoDlInRXUbS5oBi5p2zlrVzs6M+VnAn3vd9pCbO89G9019Muz3K0qMG7fXcft67P8WZH4jmp0PCbKVewUBSQ+NZACeCxqJBxKJrHLwOBoGLAFK4Z6jyKQvHACpRx9EqgvUNKb4ZixSfNIcyTmb591Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cW8a3g25; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780235699; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=nR73VRGDGmpbNBrOPjjPEurTnZdfsMAaZGX1i2lVKd4=;
 b=cW8a3g25Ft9+kIauW9voF9Ods4xXgf7wRMSo/vFXmu9Wj23ci4eH7lufpp/3g9eouhpexy
 /NiGxz55nYB7enf0RUzHwzEYq/vR7sEE/tOvfUVqneQXCZkOuYG/3XtwjhSSiLBx3UyGBd
 BQE8AKqcOI2IEZbN7Bx+oKExJtJjAaFbunFvnRRmCsayVQf7MXxI1/srZ/SQUb7UOb7gr1
 6ekQQ99c90o6rgR8Xtbm8N5CugOy4wJodbM+AKjCKesS2j1jdoXX3AM6MtVMZYq1SmXexn
 erxUJP6z3GtOxexxV8bcl7BGDo93l6BTMCNcQFs/5/BEAHGLcU52EWpj+y3fng==
Content-Type: text/plain; charset=UTF-8
To: <harshpb@linux.ibm.com>, <zhaotianrui@loongson.cn>, 
	<maobibo@loongson.cn>, <chenhuacai@kernel.org>, <maddy@linux.ibm.com>, 
	<npiggin@gmail.com>, <sashiko-reviews@lists.linux.dev>, 
	<seanjc@google.com>, <pbonzini@redhat.com>
Subject: [v2 2/2] KVM: PPC: Validate irqchip index in MPIC routing
Date: Sun, 31 May 2026 21:53:26 +0800
In-Reply-To: <20260531135326.2238555-1-yanfei.xu@bytedance.com>
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
Message-Id: <20260531135326.2238555-3-yanfei.xu@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Cc: <kvm@vger.kernel.org>, <stable@vger.kernel.org>, 
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>, 
	<caixiangfeng@bytedance.com>, <fangying.tommy@bytedance.com>, 
	<yanfei.xu@bytedance.com>, <isyanfei.xu@gmail.com>, 
	"Sashiko" <sashiko-bot@kernel.org>
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
X-Lms-Return-Path: <lba+26a1c3db2+11c273+vger.kernel.org+yanfei.xu@bytedance.com>
References: <20260531135326.2238555-1-yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[linux.ibm.com,loongson.cn,kernel.org,gmail.com,lists.linux.dev,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259350-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanfei.xu@bytedance.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.ozlabs.org,bytedance.com,gmail.com,kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bytedance.com:email,bytedance.com:mid,bytedance.com:dkim]
X-Rspamd-Queue-Id: C631C61674A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko reported that the irqchip index is not validated for PowerPC.
Add validation and reject out-of-range irqchip indexes to avoid indexing
past the routing table's chip array.

Fixes: de9ba2f36368 ("KVM: PPC: Support irq routing and irqfd for in-kernel MPIC")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/kvm/20260525051714.485D51F000E9@smtp.kernel.org/
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
---
 arch/powerpc/kvm/mpic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/mpic.c b/arch/powerpc/kvm/mpic.c
index 3070f36d9fb8..fb5f9e65e02e 100644
--- a/arch/powerpc/kvm/mpic.c
+++ b/arch/powerpc/kvm/mpic.c
@@ -1833,7 +1833,8 @@ int kvm_set_routing_entry(struct kvm *kvm,
 		e->set = mpic_set_irq;
 		e->irqchip.irqchip = ue->u.irqchip.irqchip;
 		e->irqchip.pin = ue->u.irqchip.pin;
-		if (e->irqchip.pin >= KVM_IRQCHIP_NUM_PINS)
+		if (e->irqchip.pin >= KVM_IRQCHIP_NUM_PINS ||
+		    e->irqchip.irqchip >= KVM_NR_IRQCHIPS)
 			goto out;
 		break;
 	case KVM_IRQ_ROUTING_MSI:
-- 
2.20.1

