Return-Path: <stable+bounces-253700-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFp9IJ78D2qCSAYAu9opvQ
	(envelope-from <stable+bounces-253700-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 08:50:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A8E5AFAB0
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 08:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 742DF300BC96
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 06:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B78360ED6;
	Fri, 22 May 2026 06:49:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5897D23AB9D;
	Fri, 22 May 2026 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779432595; cv=none; b=oNMCJKTsT7OVA0eBNd+CIXrE45Tg9aOY+f2CUb1d1d6kiuumpV6MAvqoJHLSu23RQyGPI2qp44KdQLmmk5DzvPZPUCDNkVB98uQeqnwfvstULE2ipU/2zDlxslx7zY6e+0YK7UcnzLO9OQfWqUP7xyLz2jsklhlHGBXgrHs9yxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779432595; c=relaxed/simple;
	bh=xf2yltQCPL4KYbVDKfNIsg8mC4dPbeakx6my0quoUbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r5n+StEDp11NnxS6JDaShtVNdLWRnWMrP1ELM72Ugl2YIFLcJlvJoW14siEPGhoAL8G5RgfNnFx6TbfOi7+/tjiyQ4EtV1h/xy61McWF8BFmFm5JJ/JzmMOV5ny8ZE+sFsGBvOyEW7cnyMZVGT7RWtqHGwcqeqLrHPEsir9djog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxBOmP_A9qT0sMAA--.29718S3;
	Fri, 22 May 2026 14:49:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxpsCL_A9qKU6MAA--.34947S3;
	Fri, 22 May 2026 14:49:51 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 1/5] LoongArch: KVM: Check irq validility in kvm_vcpu_ioctl_interrupt()
Date: Fri, 22 May 2026 14:49:41 +0800
Message-Id: <20260522064945.614486-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260522064945.614486-1-maobibo@loongson.cn>
References: <20260522064945.614486-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxpsCL_A9qKU6MAA--.34947S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[loongson.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-253700-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[maobibo@loongson.cn,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,loongson.cn:mid,loongson.cn:email]
X-Rspamd-Queue-Id: D3A8E5AFAB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Function kvm_vcpu_ioctl_interrupt() can be called from userspace, here
add irq validility cheking in kvm_vcpu_ioctl_interrupt().

Fixes: f45ad5b8aa93 ("LoongArch: KVM: Implement vcpu interrupt operations")
Cc: stable@vger.kernel.org
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/vcpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index e28084c49e68..df5be9b265e8 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1487,6 +1487,11 @@ void kvm_lose_fpu(struct kvm_vcpu *vcpu)
 int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq)
 {
 	int intr = (int)irq->irq;
+	unsigned int vector;
+
+	vector = abs(intr);
+	if (vector >= EXCCODE_INT_NUM)
+		return -EINVAL;
 
 	if (intr > 0)
 		kvm_queue_irq(vcpu, intr);
-- 
2.39.3


