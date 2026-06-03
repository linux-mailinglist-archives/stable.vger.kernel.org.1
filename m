Return-Path: <stable+bounces-259941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yBBwMMSSH2pcnQAAu9opvQ
	(envelope-from <stable+bounces-259941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 04:34:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70444633AA9
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 04:34:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259941-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-259941-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A35C303810D
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 02:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043C13DBD5B;
	Wed,  3 Jun 2026 02:34:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF7F346E6D;
	Wed,  3 Jun 2026 02:34:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780454076; cv=none; b=OMN6tOohVbgksj4zfLiWF5IVPP4TvDxWftuqRKJI9JX75QAKr98IrY8Q0I88Nhn+86YHVL+Jj98BekLwIPW2domkS/IBrB5KifvmCQsfibYrMxlxlEAiMwCYkWP+HoY2At6DYtLai+nSlW/B8M/N4m1RldVmGZBpoT/drrSbRf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780454076; c=relaxed/simple;
	bh=Iqh1YNObkmIR1qbVIWwRODYW5+nGM/+SWOeX5JKUIUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DXOPkEC68Ad8nv0HoaHGP7V0OHgQwl8GK5Oc9by3eFqojNOXVFRd24wwP1/aiPiXJZzMeW2WIvaV/xFw6OBo9oSUwlHAT2tJIvU9a4tWi8BeYxJW9w+K1ZsyB+654JJ098uEopVamOA/vK1oMgd5jhDBlsOixh9DrCIfvq4bYiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Bxt3i5kh9qbvsPAA--.19826S3;
	Wed, 03 Jun 2026 10:34:33 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxHMK4kh9qThaaAA--.29567S2;
	Wed, 03 Jun 2026 10:34:32 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] LoongArch: KVM: Fix FPU register width issue with user access API
Date: Wed,  3 Jun 2026 10:34:30 +0800
Message-Id: <20260603023430.1748197-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHMK4kh9qThaaAA--.29567S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259941-lists,stable=lfdr.de];
	DMARC_NA(0.00)[loongson.cn];
	FORGED_RECIPIENTS(0.00)[m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:kvm@vger.kernel.org,m:loongarch@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[maobibo@loongson.cn,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maobibo@loongson.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,loongson.cn:mid,loongson.cn:from_mime,loongson.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70444633AA9

At the beginning, only 64 bit FPU is supported. With FPU register
get interface, 64 bit FPU data is copied to user space, the same with
FPU set API. However with LSX and LASX supported in later, there should
be FPU data copied with bigger width. Here fixes this issue, copy the
whole 256 bit FPU data to user space.

Fixes: db1ecca22edf ("LoongArch: KVM: Add LSX (128bit SIMD) support")
Cc: stable@vger.kernel.org
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/vcpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index e28084c49e68..2e40386f8686 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1312,7 +1312,7 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	fpu->fcc = vcpu->arch.fpu.fcc;
 	fpu->fcsr = vcpu->arch.fpu.fcsr;
 	for (i = 0; i < NUM_FPU_REGS; i++)
-		memcpy(&fpu->fpr[i], &vcpu->arch.fpu.fpr[i], FPU_REG_WIDTH / 64);
+		memcpy(&fpu->fpr[i], &vcpu->arch.fpu.fpr[i], sizeof(union fpureg));
 
 	return 0;
 }
@@ -1324,7 +1324,7 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	vcpu->arch.fpu.fcc = fpu->fcc;
 	vcpu->arch.fpu.fcsr = fpu->fcsr;
 	for (i = 0; i < NUM_FPU_REGS; i++)
-		memcpy(&vcpu->arch.fpu.fpr[i], &fpu->fpr[i], FPU_REG_WIDTH / 64);
+		memcpy(&vcpu->arch.fpu.fpr[i], &fpu->fpr[i], sizeof(union fpureg));
 
 	return 0;
 }

base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
2.39.3


