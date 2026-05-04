Return-Path: <stable+bounces-243505-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKrvMISq+GnXxgIAu9opvQ
	(envelope-from <stable+bounces-243505-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:17:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 942704BEFE8
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 825FE3032F95
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0DA3DE43F;
	Mon,  4 May 2026 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dsU0rJHI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29623AA4F8;
	Mon,  4 May 2026 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904057; cv=none; b=jB3oK9IKa1cb/19yKgwT0gB+LbzVz/99IeWDUC7jzR8QdMZD8UTiwbFJfm5cmwGOUuZ+6hz2cewT5rpsaLGApMJJIScaH2A5Ti+NL/J9678s5anmTzHjezwW0jBHYJQLdbC5WaSczaFZyjDZzl+89IRKHC2S6wJH7dDcwO9JBeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904057; c=relaxed/simple;
	bh=PFBEPdGGFM1KnV+0skt1jKrBVkZ+2QQKSjoVzxo1t7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pr++Wp90ivgeVmQyJYMVpSdhUwsuKpe9M4fb9B1JQkWtSkRYmAmIen/rxvtqSAL0kbEEmNH0VMSLxevrtt/LMqg8SIaBBi5xZpHp3HZpGC6jsA603JCjVVoCVWv+mJalu0R97X5fjdZHXC5+LnvtUhMgR8NQuO6MbozAxtLWO4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dsU0rJHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794D6C2BCB8;
	Mon,  4 May 2026 14:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904056;
	bh=PFBEPdGGFM1KnV+0skt1jKrBVkZ+2QQKSjoVzxo1t7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dsU0rJHIWsLFYcrA+rTR1pI7bm7Rv+JxQV6HwYpIofNLGbAQ3RMVGRzStCbtmB0e3
	 y1KOxdlBiovcSv2QCzC4tvVSHgglO4q4pgojHLuSN9c+40QjSd0UVtuvu6fynMIetz
	 i3OOwy9RTyoRFmSXPVu9lWvF7E+HZDNSLyPA6I0E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bibo Mao <maobibo@loongson.cn>,
	Tao Cui <cuitao@kylinos.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.18 167/275] LoongArch: KVM: Use CSR_CRMD_PLV in kvm_arch_vcpu_in_kernel()
Date: Mon,  4 May 2026 15:51:47 +0200
Message-ID: <20260504135149.261607823@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 942704BEFE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243505-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,loongson.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tao Cui <cuitao@kylinos.cn>

commit da773ea3f59032f659bfc4c450ca86e384786168 upstream.

The function reads LOONGARCH_CSR_CRMD but uses CSR_PRMD_PPLV to
extract the privilege level. While both masks have the same value
(0x3), CSR_CRMD_PLV is the semantically correct constant for CRMD.

Cc: stable@vger.kernel.org
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kvm/vcpu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -375,7 +375,7 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_
 	val = gcsr_read(LOONGARCH_CSR_CRMD);
 	preempt_enable();
 
-	return (val & CSR_PRMD_PPLV) == PLV_KERN;
+	return (val & CSR_CRMD_PLV) == PLV_KERN;
 }
 
 #ifdef CONFIG_GUEST_PERF_EVENTS



